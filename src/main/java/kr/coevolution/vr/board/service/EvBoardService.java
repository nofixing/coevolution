package kr.coevolution.vr.board.service;

import kr.coevolution.vr.board.domain.EvBoardMapper;
import kr.coevolution.vr.board.dto.EvBoardRequestDto;
import kr.coevolution.vr.board.dto.EvBoardResponseDto;
import kr.coevolution.vr.board.dto.EvBoardSearchDto;
import kr.coevolution.vr.board.dto.EvBoardTermsResponseDto;
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
        fileMap.put("user_id", evBoardRequestDto.getUser_id());
        fileMap.put("board_clsf_cd", evBoardRequestDto.getBoard_clsf_cd());
        fileMap.put("board_clsf_dtl_cd", evBoardRequestDto.getBoard_clsf_dtl_cd());

        int rtnValue = evFileAttachService.fileInsert(fileMap);

        return return_code;

    }

    /**
     * 파일업로드 없음
     * @param evBoardRequestDto
     * @return
     * @throws Exception
     */
    public int insert (EvBoardRequestDto evBoardRequestDto) {

        int return_code = 0;

        /* 게시판 입력 */
        return_code = evBoardMapper.I01_BOARD(evBoardRequestDto);

        return return_code;
    }

    public int update (EvBoardRequestDto evBoardRequestDto) {

        int return_code = 0;

        /* 게시판 입력 */
        return_code = evBoardMapper.U01_BOARD(evBoardRequestDto);

        return return_code;
    }

    /**
     * 개인정보처리방침,이용약관,마케팅동의 리스트
     * @param evBoardSearchDto
     * @return
     * @throws Exception
     */
    public List<EvBoardTermsResponseDto> terms_list  (EvBoardSearchDto evBoardSearchDto) {
        return evBoardMapper.S06_TERMS_LIST(evBoardSearchDto);
    }

    /**
     * 개인정보처리방침,이용약관,마케팅동의 리스트 건수
     * @param evBoardSearchDto
     * @return
     * @throws Exception
     */
    public List<EvBoardTermsResponseDto> terms_list_count  (EvBoardSearchDto evBoardSearchDto) {
        return evBoardMapper.S06_TERMS_LIST_COUNT(evBoardSearchDto);
    }

    /**
     * 개인정보처리방침,이용약관,마케팅동의 상세조회
     * @param evBoardSearchDto
     * @return
     */
    public List<EvBoardTermsResponseDto> terms_detail  (EvBoardSearchDto evBoardSearchDto) {
        return evBoardMapper.S07_TERMS_DTL(evBoardSearchDto);
    }

    /**
     * 게시판 조회 (공통)
     * @param evBoardSearchDto
     * @return
     */
    public List<EvBoardResponseDto> board_list  (EvBoardSearchDto evBoardSearchDto) {
        return evBoardMapper.S08_LIST(evBoardSearchDto);
    }

    /**
     * 파일업로드 없음
     * @param evBoardRequestDto
     * @return
     * @throws Exception
     */
    public int search_cnt_add (EvBoardRequestDto evBoardRequestDto) {

        int return_code = 0;

        /* 게시판 입력 */
        return_code = evBoardMapper.U04_BOARD_CNT(evBoardRequestDto);

        return return_code;
    }

    /**
     * 게시판 상세(공통)
     * @param evBoardSearchDto
     * @return
     */
    public List<EvBoardResponseDto> board_dtl  (EvBoardSearchDto evBoardSearchDto) {
        return evBoardMapper.S08_DTL(evBoardSearchDto);
    }

    /**
     * 현재이벤트조회
     * @return
     */
    public List<EvBoardResponseDto> now_evnt () {
        return evBoardMapper.S08_ENENT();
    }
}
