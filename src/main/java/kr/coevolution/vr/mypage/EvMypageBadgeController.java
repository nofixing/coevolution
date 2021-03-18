package kr.coevolution.vr.mypage;

import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.dto.EvMemberBadgeRequestDto;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.mypage.dto.EvMypageBadgeRequestDto;
import kr.coevolution.vr.mypage.dto.EvMypageBadgeResponseDto;
import kr.coevolution.vr.mypage.service.EvMypageBadgeService;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@NoArgsConstructor
@Controller
public class EvMypageBadgeController {

    @Autowired
    private EvMypageBadgeService evMypageBadgeService;

    /**
     * 마이페이지 뱃지 리스트
     * @param evMypageBadgeRequestDto
     * @param request
     * @return
     */
    @RequestMapping("/mypage/badge")
    public String mypage_badge (EvMypageBadgeRequestDto evMypageBadgeRequestDto, HttpServletRequest request, Model model) {

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            evMypageBadgeRequestDto.setUser_id(loginInfoDto.getCust_id());
            evMypageBadgeRequestDto.setCust_id(loginInfoDto.getCust_id());

            /* row 개수 */
            evMypageBadgeRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMypageBadgeRequestDto.getPage_current());
            evMypageBadgeRequestDto.setPage_row_start(page_row_start);

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();


            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evMypageBadgeRequestDto.getIns_dt_fr(),""))) {
                Date ftDt = StringUtils.addMonth(nDt,-1);
                String strDt = sf.format(ftDt);
                evMypageBadgeRequestDto.setIns_dt_fr(strDt);
            }

            if("".equals(StringUtils.nvl(evMypageBadgeRequestDto.getIns_dt_to(),""))) {
                String strDt = sf.format(nDt);
                evMypageBadgeRequestDto.setIns_dt_to(strDt);
            }

            /* 뱃지 리스트 조회 */
            List<EvMypageBadgeResponseDto> list = evMypageBadgeService.mypage_badge_list(evMypageBadgeRequestDto);
            List<EvMypageBadgeResponseDto> listCnt = evMypageBadgeService.mypage_badge_list_count(evMypageBadgeRequestDto);

            Long row_count = 0L;
            int tot_badge = 0;

            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count();
                tot_badge = listCnt.get(0).getTot_badge(); /* 관심뱃지 */
            }

            Long page_row_cnt = StringUtils.page_tot(row_count);
            Long page_next = StringUtils.page_next(evMypageBadgeRequestDto.getPage_current(), row_count, "N");
            Long page_priv = StringUtils.page_priv(evMypageBadgeRequestDto.getPage_current());
            Long page_end = StringUtils.page_next(evMypageBadgeRequestDto.getPage_current(), row_count, "Y");

            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count);
            model.addAttribute("tot_badge", tot_badge); /* 관심뱃지 총 개수 */
            model.addAttribute("page_row_cnt", String.valueOf(page_row_cnt));    /* 페이지 row 개수 */
            model.addAttribute("page_next", String.valueOf(page_next));  /* 다음페이지 */
            model.addAttribute("page_priv", String.valueOf(page_priv));  /* 이전페이지 */
            model.addAttribute("page_end", String.valueOf(page_end));   /* 마지막페이지 */

            /* 검색조건 */
            model.addAttribute("ins_dt_fr", evMypageBadgeRequestDto.getIns_dt_fr());
            model.addAttribute("ins_dt_to", evMypageBadgeRequestDto.getIns_dt_to());
            model.addAttribute("slt_badge_clsf", evMypageBadgeRequestDto.getSlt_badge_clsf());

            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return "/mypage/myp02";
    }

    /**
     * vr 기업정보 뱃지 표시
     * @param evMemberBadgeRequestDto
     * @param request
     * @return
     */
    @PostMapping("/vr/badge")
    public Map<String,Object> vr_badge (@RequestBody EvMemberBadgeRequestDto evMemberBadgeRequestDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            evMemberBadgeRequestDto.setCust_id(loginInfoDto.getCust_id());
            evMemberBadgeRequestDto.setUser_id(loginInfoDto.getCust_id());

            /* 뱃지 리스트 조회 sum_badge_cnt : 0 이면 뱃지 없음 */
            List<EvMypageBadgeResponseDto> list = evMypageBadgeService.vr_badge(evMemberBadgeRequestDto);

            resposeResult.put("data", list);
            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * VR 뱃지 선택 시 부여 또는 회수 한다.
     * @param evMemberBadgeRequestDto
     * @param request
     * @return
     */
    @PostMapping("/vr/badge/insert")
    public Map<String,Object> vr_badge_insert (@RequestBody EvMemberBadgeRequestDto evMemberBadgeRequestDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            evMemberBadgeRequestDto.setUser_id(loginInfoDto.getCust_id());
            evMemberBadgeRequestDto.setCust_id(loginInfoDto.getCust_id());

            int return_code = evMypageBadgeService.vr_badge_save(evMemberBadgeRequestDto);

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
