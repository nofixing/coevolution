package kr.coevolution.vr.comm.service;

import kr.coevolution.vr.comm.domain.EvFileAttachMapper;
import kr.coevolution.vr.comm.dto.EvFileAttachRequestDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Service
public class EvFileAttachService {

    @Autowired
    private EvFileAttachMapper evFileAttachMapper;

    @Value("${file.upload.location}") String fileDir;
    public List<Map<String,String>> fileUpload(List<MultipartFile> files) throws Exception {

        List<Map<String,String>> list = new ArrayList<>();
        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
        String nowDt = sf.format(new Date());
        String realFileDir = fileDir + nowDt + "/";

        /* 날짜별폴더생성 */
        File chkDir = new File(realFileDir);
        if(!chkDir.isDirectory()) {
            chkDir.mkdirs();
        }

        /* 실제파일명 */
        String realFileNm = "";

        for (MultipartFile file : files) {
            Map vMap = new HashMap();

            String originalfileName = file.getOriginalFilename();
            long size = file.getSize();

            Date fileCrateTime = new Date();
            double dValue = Math.random();
            realFileNm = String.valueOf(fileCrateTime.getTime()) + "_" + String.valueOf((int)(dValue * 100));

            String ext = originalfileName.substring(originalfileName.lastIndexOf("."),originalfileName.length());

            vMap.put("org_file_name", originalfileName);
            vMap.put("file_size", size);
            vMap.put("file_name", realFileNm);
            vMap.put("file_path", realFileDir + realFileNm + ext);

            log.debug("file list : " + vMap.toString());

            File dest = new File(realFileDir + realFileNm + ext);
            file.transferTo(dest);

            list.add(vMap);
        }

        return list;

    }

    /**
     * 업로드 파일 입력
     * @param fileMap
     * @return
     * @throws Exception
     */
    @Transactional
    public int fileInsert(Map<String, Object> fileMap)  throws Exception {

        int return_code = 0;

        try {
            List<Map<String, String>> fileList = (ArrayList)fileMap.get("fileList");

            EvFileAttachRequestDto evFileAttachRequestDto = null;

            for(Map<String, String> vMap : fileList) {

                evFileAttachRequestDto = new EvFileAttachRequestDto();
                evFileAttachRequestDto.setBoard_id(Long.parseLong(String.valueOf(fileMap.get("board_id"))));
                evFileAttachRequestDto.setFile_clsf_cd(String.valueOf(fileMap.get("board_clsf_cd")));
                evFileAttachRequestDto.setFile_clsf_dtl_cd(String.valueOf(fileMap.get("board_clsf_dtl_cd")));
                evFileAttachRequestDto.setFile_name(String.valueOf(vMap.get("file_name")));
                evFileAttachRequestDto.setOrg_file_name(String.valueOf(vMap.get("org_file_name")));
                evFileAttachRequestDto.setFile_size(String.valueOf(vMap.get("file_size")));
                evFileAttachRequestDto.setFile_path(String.valueOf(vMap.get("file_path")));
                evFileAttachRequestDto.setUser_id(String.valueOf(vMap.get("user_id")));

                evFileAttachMapper.I01_FILE(evFileAttachRequestDto);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }

        return return_code;
    }

}
