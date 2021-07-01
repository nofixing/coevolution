package kr.coevolution.vr.mypage.service;

import kr.coevolution.vr.board.dto.EvBoardRequestDto;
import kr.coevolution.vr.comm.dto.EvFileAttachRequestDto;
import kr.coevolution.vr.comm.service.EvFileAttachService;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.mgnt.dto.EvMgntZoomRequestDto;
import kr.coevolution.vr.mgnt.service.EvMgntService;
import kr.coevolution.vr.mypage.domain.EvMypageCustCorpInfoMapper;
import kr.coevolution.vr.mypage.dto.EvMypageCustCorpInfoRequestDto;
import kr.coevolution.vr.mypage.dto.EvMypageCustCorpInfoResponseDto;
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
public class EvMypageCustCorpInfoService {

    @Autowired
    private EvMypageCustCorpInfoMapper evMypageCustCorpInfoMapper;

    @Autowired
    private EvFileAttachService evFileAttachService;

    @Autowired
    private EvMgntService evMgntService;

    /**
     * 내부스정보
     * @param evMypageCustCorpInfoRequestDto
     * @return
     */
    public List<EvMypageCustCorpInfoResponseDto> mypage_cust_corp_info (EvMypageCustCorpInfoRequestDto evMypageCustCorpInfoRequestDto) {
        return evMypageCustCorpInfoMapper.S01_CORP_INFO(evMypageCustCorpInfoRequestDto);
    }

    /**
     * 내부스정보입력 - 첨부파일입력
     * @param evMypageCustCorpInfoRequestDto
     * @param files
     * @return
     * @throws Exception
     */

    public int mypage_cust_corp_file  (EvMypageCustCorpInfoRequestDto evMypageCustCorpInfoRequestDto, List<MultipartFile> files) throws Exception {

        int return_code = 0;

        /* 파일업로드 */
        List<Map<String, String>> fileList = evFileAttachService.fileUpload(files);

        /* 파일 입력 */
        Map<String, Object> fileMap = new HashMap<>();
        fileMap.put("fileList", fileList);
        fileMap.put("board_id", evMypageCustCorpInfoRequestDto.getBoard_id());
        fileMap.put("board_clsf_cd", evMypageCustCorpInfoRequestDto.getFile_clsf_cd());
        fileMap.put("board_clsf_dtl_cd", evMypageCustCorpInfoRequestDto.getFile_clsf_dtl_cd());
        fileMap.put("user_id", evMypageCustCorpInfoRequestDto.getUser_id());

        /* 첨부파일입력 */
        int rtnValue = evFileAttachService.fileInsert(fileMap);

        /* 부스정보입력체크 */
        List<EvMypageCustCorpInfoResponseDto> list = evMypageCustCorpInfoMapper.S01_CORP_INFO(evMypageCustCorpInfoRequestDto);

        if(list.size() <= 0) {
            /* 내부스정보입력 : 팝업창에서 파일업로드시 고객의 정보가 없을 수 있으므로 데이터를 생성한다.*/
            rtnValue = evMypageCustCorpInfoMapper.I01_CORP_INFO(evMypageCustCorpInfoRequestDto);
        }

        return return_code;
    }

    /**
     * 첨부파일삭제
     * @param evMypageCustCorpInfoRequestDto
     * @return
     */
    public int mypage_cust_corp_file_del (EvMypageCustCorpInfoRequestDto evMypageCustCorpInfoRequestDto) {

        EvFileAttachRequestDto evFileAttachRequestDto = new EvFileAttachRequestDto();
        evFileAttachRequestDto.setAttach_id(evMypageCustCorpInfoRequestDto.getAttach_id());
        evFileAttachRequestDto.setUser_id(evMypageCustCorpInfoRequestDto.getUser_id());

        return evFileAttachService.file_attach_del(evFileAttachRequestDto);
    }

    /**
     * 내부스정보입력
     * @param evMypageCustCorpInfoRequestDto
     * @return
     * @throws Exception
     */
    public int mypage_cust_corp_save  (EvMypageCustCorpInfoRequestDto evMypageCustCorpInfoRequestDto) throws Exception {

        int return_code = 0;

        /* 부스정보입력체크 */
        List<EvMypageCustCorpInfoResponseDto> list = evMypageCustCorpInfoMapper.S01_CORP_INFO(evMypageCustCorpInfoRequestDto);

        int rtnValue = 0;

        if(list.size() <= 0) {
            /* 내부스정보입력 */
            rtnValue = evMypageCustCorpInfoMapper.I01_CORP_INFO(evMypageCustCorpInfoRequestDto);
        } else {
            /* 내부스정보수정 */
            rtnValue = evMypageCustCorpInfoMapper.U01_CORP_INFO(evMypageCustCorpInfoRequestDto);
        }

        /* 줌 URL 저장 */
        EvMgntZoomRequestDto evMgntZoomRequestDto = new EvMgntZoomRequestDto();
        evMgntZoomRequestDto.setCust_id(evMypageCustCorpInfoRequestDto.getCust_id());
        evMgntZoomRequestDto.setUser_id(evMypageCustCorpInfoRequestDto.getCust_id());
        evMgntZoomRequestDto.setZoom_url(evMypageCustCorpInfoRequestDto.getZoom_url());
        evMgntZoomRequestDto.setUse_yn(StringUtils.nvl(evMypageCustCorpInfoRequestDto.getUse_yn(),"Y"));

        /* 줌 URL 저장 */
        if("".equals(StringUtils.nvl(evMypageCustCorpInfoRequestDto.getZoom_mgnt_id(), ""))) {
            evMgntService.mgnt_zoom_insert(evMgntZoomRequestDto);
        } else {
            evMgntService.mgnt_zoom_update(evMgntZoomRequestDto);
        }

        return return_code;
    }

    /**
     * 참가업체 조회 - 팝업
     * @param evMypageCustCorpInfoRequestDto
     * @return
     */
    public List<EvMypageCustCorpInfoResponseDto> mypage_cust_corp_info_popup (EvMypageCustCorpInfoRequestDto evMypageCustCorpInfoRequestDto) {
        return evMypageCustCorpInfoMapper.S02_CORP_INFO(evMypageCustCorpInfoRequestDto);
    }

}
