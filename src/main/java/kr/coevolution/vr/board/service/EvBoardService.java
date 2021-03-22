package kr.coevolution.vr.board.service;

import kr.coevolution.vr.board.domain.EvBoardMapper;
import kr.coevolution.vr.board.dto.EvBoardRequestDto;
import kr.coevolution.vr.comm.domain.EvFileAttachMapper;
import kr.coevolution.vr.comm.service.EvFileAttachService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Service
@Transactional(rollbackFor = {RuntimeException.class, Exception.class})
public class EvBoardService {

    @Autowired
    private EvBoardMapper evBoardMapper;

    @Autowired
    private EvFileAttachMapper evFileAttachMapper;

    @Autowired
    private EvFileAttachService evFileAttachService;

    /**
     * 통합게시판입력
     * @param evBoardRequestDto
     * @param files
     * @return
     */
    public int insert (EvBoardRequestDto evBoardRequestDto, List<MultipartFile> files) throws Exception {

        int return_code = 0;

        /* 파일업로드 */
        List<Map<String, String>> fileList = evFileAttachService.fileUpload(files);

        /* 게시판 입력 */
        return_code = evBoardMapper.I01_BOARD(evBoardRequestDto);

        /* 파일 입력 */
        Map<String, Object> fileMap = new HashMap<>();
        fileMap.put("fileList", fileList);
        fileMap.put("board_id", evBoardRequestDto.getBoard_id());
        fileMap.put("board_clsf_cd", evBoardRequestDto.getBoard_clsf_cd());
        fileMap.put("board_clsf_dtl_cd", evBoardRequestDto.getBoard_clsf_dtl_cd());

        int rtnValue = evFileAttachService.fileInsert(fileMap);

        return return_code;

    }
}
