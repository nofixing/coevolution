package kr.coevolution.vr.mypage;

import kr.coevolution.vr.board.dto.EvBoardConsltResponseDto;
import kr.coevolution.vr.board.dto.EvBoardRequestDto;
import kr.coevolution.vr.board.dto.EvBoardSearchDto;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.mypage.service.EvMypageBoardConsltService;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@NoArgsConstructor
@RestController
public class EvMypageConsltController {

    @Autowired
    private EvMypageBoardConsltService evMypageBoardConsltService;


    /*

    중복답글 처리 필요....

     */


    /**
     * 마이페이지 상담문의 조회
     * @param evBoardSearchDto
     * @param request
     * @return
     */
    @PostMapping("/mypage/conslt_list")
    public Map<String,Object> mypage_conslt_list (@RequestBody EvBoardSearchDto evBoardSearchDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if("202001".equals(loginInfoDto.getCust_clsf_cd())) {
                /* 참관고객 */
                evBoardSearchDto.setReg_user_id(loginInfoDto.getCust_id());
                evBoardSearchDto.setConslt_cust_id("");
            } else {
                /* 참가고객 */
                evBoardSearchDto.setReg_user_id("");
                evBoardSearchDto.setConslt_cust_id(loginInfoDto.getCust_id());
            }

            /* row 개수 */
            evBoardSearchDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evBoardSearchDto.getPage_current());
            evBoardSearchDto.setPage_row_start(page_row_start);

            List<EvBoardConsltResponseDto> list = evMypageBoardConsltService.mypage_conslt_list(evBoardSearchDto);
            List<EvBoardConsltResponseDto> listCnt = evMypageBoardConsltService.mypage_conslt_list_count(evBoardSearchDto);

            Long row_count = 0L;
            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count();
            }

            Long page_row_cnt = StringUtils.page_tot(row_count);
            Long page_next = StringUtils.page_next(evBoardSearchDto.getPage_current(), row_count, "N");
            Long page_priv = StringUtils.page_priv(evBoardSearchDto.getPage_current());
            Long page_end = StringUtils.page_next(evBoardSearchDto.getPage_current(), row_count, "Y");

            resposeResult.put("data", list);
            resposeResult.put("row_count", row_count);
            resposeResult.put("page_row_cnt", String.valueOf(page_row_cnt));    /* 페이지 row 개수 */
            resposeResult.put("page_next", String.valueOf(page_next));  /* 다음페이지 */
            resposeResult.put("page_priv", String.valueOf(page_priv));  /* 이전페이지 */
            resposeResult.put("page_end", String.valueOf(page_end));   /* 마지막페이지 */

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 마이페이지 상담문의 상세
     * @param evBoardSearchDto
     * @param request
     * @return
     */
    @PostMapping("/mypage/conslt_dtl")
    public Map<String,Object> mypage_conslt_dtl (@RequestBody EvBoardSearchDto evBoardSearchDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            if("".equals(StringUtils.nvl(evBoardSearchDto.getBoard_id(),""))) {
                throw new RuntimeException("ID없음");
            }

            List<EvBoardConsltResponseDto> list = evMypageBoardConsltService.mypage_conslt_dtl(evBoardSearchDto);
            resposeResult.put("data", list);

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * VR문의사항 입력
     * @param evBoardRequestDto
     * @param request
     * @return
     */
    @PostMapping("/vr/conslt/insert")
    public Map<String,Object> vr_conslt_insert (@RequestBody EvBoardRequestDto evBoardRequestDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            evBoardRequestDto.setReg_user_id(loginInfoDto.getUser_id());
            evBoardRequestDto.setUser_id(loginInfoDto.getUser_id());
            evBoardRequestDto.setBoard_clsf_cd("101002"); /* 1:1 문의게시판 */
            evBoardRequestDto.setBoard_stat_cd("104001"); /* 답변대기 */
            evBoardRequestDto.setBoard_res_id(0L); /* 게시판ID_답변 */

            int return_code = evMypageBoardConsltService.vr_conslt_insert(evBoardRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    @PostMapping("/vr/conslt/reply")
    public Map<String,Object> vr_conslt_reply (@RequestBody EvBoardRequestDto evBoardRequestDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if("".equals(StringUtils.nvl(evBoardRequestDto.getBoard_id(),""))) {
                throw new RuntimeException("ID없음");
            }

            evBoardRequestDto.setUser_id(loginInfoDto.getUser_id());
            evBoardRequestDto.setConslt_user_id(loginInfoDto.getUser_id()); /* 답변자 */
            evBoardRequestDto.setBoard_clsf_cd("101002"); /* 1:1 문의게시판 */
            evBoardRequestDto.setBoard_stat_cd("104002"); /* 답변완료 */
            evBoardRequestDto.setBoard_res_id(evBoardRequestDto.getBoard_id()); /* 게시판ID_답변 */

            /* 답변입력 */
            int return_code = evMypageBoardConsltService.vr_conslt_insert(evBoardRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    @PostMapping("/vr/conslt/delete")
    public Map<String,Object> vr_conslt_delete (@RequestBody EvBoardRequestDto evBoardRequestDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            evBoardRequestDto.setUser_id(loginInfoDto.getUser_id());

            if("".equals(StringUtils.nvl(evBoardRequestDto.getBoard_id(),""))) {
                throw new RuntimeException("ID없음");
            }

            /* 삭제처리 */
            evBoardRequestDto.setDel_yn("Y");
            int return_code = evMypageBoardConsltService.mypage_conslt_del(evBoardRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }
    
}
