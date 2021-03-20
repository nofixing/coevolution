package kr.coevolution.vr.mypage.service;

import kr.coevolution.vr.board.domain.EvBoardMapper;
import kr.coevolution.vr.board.dto.EvBoardConsltResponseDto;
import kr.coevolution.vr.board.dto.EvBoardRequestDto;
import kr.coevolution.vr.board.dto.EvBoardSearchDto;
import kr.coevolution.vr.comm.util.StringUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Service
@Transactional(rollbackFor = {RuntimeException.class, Exception.class})
public class EvMypageBoardConsltService {

    @Autowired
    private EvBoardMapper evBoardMapper; /* 통합게시판 Mapper */

    /**
     * 마이페이지 - 상당내역 리스트
     * @param evBoardSearchDto
     * @return
     */
    public List<EvBoardConsltResponseDto> mypage_conslt_list (EvBoardSearchDto evBoardSearchDto) {
        return evBoardMapper.S01_CONSLT_LIST(evBoardSearchDto);
    }

    /**
     * 마이페이지 - 상당내역 리스트 총 건수
     * @param evBoardSearchDto
     * @return
     */
    public List<EvBoardConsltResponseDto> mypage_conslt_list_count (EvBoardSearchDto evBoardSearchDto) {
        return evBoardMapper.S02_CONSLT_LIST_CNT(evBoardSearchDto);
    }

    /**
     * 마이페이지 - 상당내역 상세
     * @param evBoardSearchDto
     * @return
     */
    public List<EvBoardConsltResponseDto> mypage_conslt_dtl (EvBoardSearchDto evBoardSearchDto) {
        return evBoardMapper.S03_CONSLT_DTL(evBoardSearchDto);
    }

    /**
     * VR 상담 입력, Mypage 상담 답변 입력
     * @param evBoardRequestDto
     * @return
     */
    public int vr_conslt_insert (EvBoardRequestDto evBoardRequestDto) {

        /* board_id가 수정되므로 미리 변수에 받는다. */
        Long boardId = evBoardRequestDto.getBoard_id();
        log.debug("board_id 1 : " + boardId);

        String reply_board_id = "";
        /* 문의 답글 입력 */
        if("104002".equals(evBoardRequestDto.getBoard_stat_cd())) {
            /* 해당 내역을 조회하여 변경이 필요없는 항목을 입력한다. */
            EvBoardSearchDto evBoardSearchDto = new EvBoardSearchDto();
            evBoardSearchDto.setBoard_id(boardId);
            List<Map> list = evBoardMapper.S04_BOARD_ALL(evBoardSearchDto);

            evBoardRequestDto.setBoard_subject("[답글]" + StringUtils.nvl(list.get(0).get("board_subject"), ""));
            evBoardRequestDto.setReg_user_id(StringUtils.nvl(list.get(0).get("reg_user_id"), ""));
            evBoardRequestDto.setConslt_cust_id(StringUtils.nvl(list.get(0).get("conslt_cust_id"), ""));
            evBoardRequestDto.setConslt_user_id(evBoardRequestDto.getUser_id());

            /* 답글이 입력되어있으면 답글의 board_id를 입력한다. */
            reply_board_id = StringUtils.nvl(list.get(0).get("reply_board_id"), "");
        }

        int return_code = 0;

        if("".equals(reply_board_id)) {
            return_code = evBoardMapper.I01_BOARD(evBoardRequestDto);
            log.debug("board_id 2 : " + evBoardRequestDto.getBoard_id());

            /* 문의 답글상태 업데이트 */
            if("104002".equals(evBoardRequestDto.getBoard_stat_cd())) {
                evBoardRequestDto.setBoard_id(boardId);
                return_code = evBoardMapper.U03_BOARD(evBoardRequestDto);
            }

        } else {
            //이미 답글등록 완료 - 답글업데이트
            evBoardRequestDto.setBoard_id(Long.parseLong(reply_board_id));
            evBoardRequestDto.setReply_yn("Y");
            return_code = evBoardMapper.U03_BOARD(evBoardRequestDto);
        }

        return return_code;
    }

    /**
     * mypage 상담내용 수정
     * @param evBoardRequestDto
     * @return
     */
    public int mypage_conslt_update (EvBoardRequestDto evBoardRequestDto) {
        return evBoardMapper.U01_BOARD(evBoardRequestDto);
    }

    /**
     * 상담내용삭제
     * @param evBoardRequestDto
     * @return
     */
    public int mypage_conslt_del (EvBoardRequestDto evBoardRequestDto) {
        return evBoardMapper.U02_BOARD(evBoardRequestDto);
    }

    /**
     * 상담내용 상태 변경
     * @param evBoardRequestDto
     * @return
     */
    public int mypage_conslt_stat (EvBoardRequestDto evBoardRequestDto) {
        return evBoardMapper.U03_BOARD(evBoardRequestDto);
    }

}
