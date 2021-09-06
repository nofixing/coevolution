package  kr.coevolution.vr.mgnt;

import kr.coevolution.vr.board.service.EvBoardService;
import kr.coevolution.vr.comm.service.EvCommCodeService;
import kr.coevolution.vr.comm.service.EvExpoService;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.service.EvMemberService;
import kr.coevolution.vr.mgnt.dto.EvMgntEventDto;
import kr.coevolution.vr.mgnt.service.EvMgntConsultService;
import kr.coevolution.vr.mgnt.service.EvMgntEventService;
import kr.coevolution.vr.mgnt.service.EvMgntService;
import kr.coevolution.vr.mypage.service.EvMypageBoardConsltService;
import kr.coevolution.vr.mypage.service.EvMypageCustCorpInfoService;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Slf4j
@NoArgsConstructor
@Controller
public class EvMgntEventController {

    @Autowired
    private EvMgntService evMgntService;

    @Autowired
    private EvMemberService evMemberService;

    @Autowired
    private EvCommCodeService evCommCodeService;

    @Autowired
    private EvMypageCustCorpInfoService evMypageCustCorpInfoService;

    @Autowired
    private EvMypageBoardConsltService evMypageBoardConsltService;

    @Autowired
    private EvBoardService evBoardService;

    @Autowired
    private EvExpoService evExpoService;

    @Autowired
    private EvMgntConsultService evMgntConsultService;

    @Autowired
    private EvMgntEventService evMgntEventService;



    @Autowired
    AuthenticationManager authenticationManager;

    Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * 이벤트당첨자
     *
     * @param evMgntEventDto
     * @param request
     * @return
     */
    @RequestMapping("/mgnt/eventperson")
    public String eventperson(EvMgntEventDto evMgntEventDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt13";

        try {

            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto) httpSession.getAttribute(StringUtils.login_mgnt_session);

            /* row 개수 */
            evMgntEventDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMgntEventDto.getPage_current(), StringUtils.page_row_cnt);
            evMgntEventDto.setPage_row_start(page_row_start);

            if ("".equals(StringUtils.nvl(evMgntEventDto.getPage_current(), ""))) {
                evMgntEventDto.setPage_current(1L);
            }

            model.addAttribute("page_current", String.valueOf(evMgntEventDto.getPage_current()));

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();

            /* 최초 날짜가 null 인경우 */
            if ("".equals(StringUtils.nvl(evMgntEventDto.getIns_dt_fr(), ""))) {
                Date ftDt = StringUtils.addMonth(nDt, -1);
                String strDt = sf.format(ftDt);
                evMgntEventDto.setIns_dt_fr(strDt);
            }

            if ("".equals(StringUtils.nvl(evMgntEventDto.getIns_dt_to(), ""))) {
                String strDt = sf.format(nDt);
                evMgntEventDto.setIns_dt_to(strDt);
            }

            List<EvMgntEventDto> list = evMgntEventService.search_person_list(evMgntEventDto);
            List<EvMgntEventDto> listCnt = evMgntEventService.search_person_list_count(evMgntEventDto);



            Long row_count = 0L;

            if (listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count(); /* 총건수 */
            }

            Long page_row_cnt = StringUtils.page_tot(row_count);

            model.addAttribute("page_clsf", "mgnt13");
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총건수 */
            model.addAttribute("page_row_cnt", evMgntEventDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMgntEventDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("ins_dt_fr", evMgntEventDto.getIns_dt_fr());
            model.addAttribute("ins_dt_to", evMgntEventDto.getIns_dt_to());
            model.addAttribute("keyword", evMgntEventDto.getKeyword());

            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 이벤트 주식 현황
     *
     * @param evMgntEventDto
     * @param request
     * @return
     */
    @RequestMapping("/mgnt/stockholdings")
    public String stockholdings(EvMgntEventDto evMgntEventDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt14";

        try {

            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto) httpSession.getAttribute(StringUtils.login_mgnt_session);

            /* row 개수 */
            evMgntEventDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMgntEventDto.getPage_current(), StringUtils.page_row_cnt);
            evMgntEventDto.setPage_row_start(page_row_start);

            if ("".equals(StringUtils.nvl(evMgntEventDto.getPage_current(), ""))) {
                evMgntEventDto.setPage_current(1L);
            }

            model.addAttribute("page_current", String.valueOf(evMgntEventDto.getPage_current()));

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();

            /* 최초 날짜가 null 인경우 */
            if ("".equals(StringUtils.nvl(evMgntEventDto.getIns_dt_fr(), ""))) {
                Date ftDt = StringUtils.addMonth(nDt, -1);
                String strDt = sf.format(ftDt);
                evMgntEventDto.setIns_dt_fr(strDt);
            }

            if ("".equals(StringUtils.nvl(evMgntEventDto.getIns_dt_to(), ""))) {
                String strDt = sf.format(nDt);
                evMgntEventDto.setIns_dt_to(strDt);
            }

            List<EvMgntEventDto> list = evMgntEventService.search_stock_list(evMgntEventDto);
            List<EvMgntEventDto> listCnt = evMgntEventService.search_stock_list_count(evMgntEventDto);



            Long row_count = 0L;

            if (listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count(); /* 총건수 */
            }

            Long page_row_cnt = StringUtils.page_tot(row_count);

            model.addAttribute("page_clsf", "mgnt14");
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총건수 */
            model.addAttribute("page_row_cnt", evMgntEventDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMgntEventDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("ins_dt_fr", evMgntEventDto.getIns_dt_fr());
            model.addAttribute("ins_dt_to", evMgntEventDto.getIns_dt_to());
            model.addAttribute("keyword", evMgntEventDto.getKeyword());

            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }






}