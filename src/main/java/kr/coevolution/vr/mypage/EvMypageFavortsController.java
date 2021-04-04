package kr.coevolution.vr.mypage;

import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.dto.EvMemberLoginRequestDto;
import kr.coevolution.vr.member.dto.EvMemberResposeDto;
import kr.coevolution.vr.member.dto.EvMemberSearchDto;
import kr.coevolution.vr.member.service.EvMemberService;
import kr.coevolution.vr.mypage.dto.EvMypageFavortsRequestDto;
import kr.coevolution.vr.mypage.dto.EvMypageFavortsResponseDto;
import kr.coevolution.vr.mypage.service.EvMypageFavoritsService;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
public class EvMypageFavortsController {

    @Autowired
    private EvMypageFavoritsService evMypageFavoritsService;

    @Autowired
    private EvMemberService evMemberService;

    @RequestMapping("/mypage/favorts")
    public String mypage_favorts (EvMypageFavortsRequestDto evMypageFavortsRequestDto, HttpServletRequest request, Model model) {
        Map resposeResult = new HashMap();
        String returnUrl = "/mypage/myp01";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/member/login_form";
                return returnUrl;
            }

            evMypageFavortsRequestDto.setCust_id(loginInfoDto.getCust_id());

            /* row 개수 */
            evMypageFavortsRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMypageFavortsRequestDto.getPage_current());
            evMypageFavortsRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMypageFavortsRequestDto.getPage_current(),""))) {
                evMypageFavortsRequestDto.setPage_current(1L);
            }

            model.addAttribute("page_current", String.valueOf(evMypageFavortsRequestDto.getPage_current()));  /* 현재페이지 */

            /* 즐겨찾기 리스트 조회 */
            List<EvMypageFavortsResponseDto> list = evMypageFavoritsService.mypage_favorits_list(evMypageFavortsRequestDto);
            List<EvMypageFavortsResponseDto> listCnt = evMypageFavoritsService.mypage_favorits_list_count(evMypageFavortsRequestDto);

            Long row_count = listCnt.get(0).getRow_count();
            Long page_row_cnt = StringUtils.page_tot(row_count);

            model.addAttribute("page_clsf", "myp01");
            model.addAttribute("list", list);

            model.addAttribute("row_count", row_count); /* 총 개수 */
            model.addAttribute("page_row_cnt", evMypageFavortsRequestDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMypageFavortsRequestDto.getPage_current());    /* 현재페이지 */

            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    @RequestMapping("/mypage/favortscorp")
    public String mypage_favorts_corp (EvMypageFavortsRequestDto evMypageFavortsRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mypage/myc02";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/member/login_form";
                return returnUrl;
            }

            evMypageFavortsRequestDto.setCust_id(loginInfoDto.getCust_id());

            /* row 개수 */
            evMypageFavortsRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMypageFavortsRequestDto.getPage_current());
            evMypageFavortsRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMypageFavortsRequestDto.getPage_current(),""))) {
                evMypageFavortsRequestDto.setPage_current(1L);
            }

            model.addAttribute("page_current", String.valueOf(evMypageFavortsRequestDto.getPage_current()));  /* 현재페이지 */

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();

            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evMypageFavortsRequestDto.getFavorts_ins_fr(),""))) {
                Date ftDt = StringUtils.addMonth(nDt,-1);
                String strDt = sf.format(ftDt);
                evMypageFavortsRequestDto.setFavorts_ins_fr(strDt);
            }

            if("".equals(StringUtils.nvl(evMypageFavortsRequestDto.getFavorts_ins_to(),""))) {
                String strDt = sf.format(nDt);
                evMypageFavortsRequestDto.setFavorts_ins_to(strDt);
            }

            /* 즐겨찾기 리스트 조회 */
            List<EvMypageFavortsResponseDto> list = evMypageFavoritsService.mypage_favorits_list2(evMypageFavortsRequestDto);
            List<EvMypageFavortsResponseDto> listCnt = evMypageFavoritsService.mypage_favorits_list_count2(evMypageFavortsRequestDto);

            /* 바로가기 조회 */
            EvMemberSearchDto evMemberSearchDto = new EvMemberSearchDto();
            evMemberSearchDto.setCust_id(loginInfoDto.getCust_id());
            List<EvMemberResposeDto> custInfo = evMemberService.search_cust_info(evMemberSearchDto);
            model.addAttribute("shortcut_url", custInfo.get(0).getCategory1_value());

            Long row_count = listCnt.get(0).getRow_count();

            model.addAttribute("page_clsf", "myc02");
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총 개수 */
            model.addAttribute("page_row_cnt", evMypageFavortsRequestDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMypageFavortsRequestDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("favorts_ins_fr", evMypageFavortsRequestDto.getFavorts_ins_fr());
            model.addAttribute("favorts_ins_to", evMypageFavortsRequestDto.getFavorts_ins_to());

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
     * VR 즐겨찾기 조회
     * @param evMypageFavortsRequestDto
     * @return
     */
    @ResponseBody
    @PostMapping("/vr/favorts")
    public Map<String,Object> vr_favorts (@RequestBody EvMypageFavortsRequestDto evMypageFavortsRequestDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            evMypageFavortsRequestDto.setCust_id(loginInfoDto.getCust_id());
            evMypageFavortsRequestDto.setUser_id(loginInfoDto.getCust_id());

            /* 즐겨찾기 리스트 조회 */
            List<EvMypageFavortsResponseDto> list = evMypageFavoritsService.vr_favorits(evMypageFavortsRequestDto);

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
     * VR 즐겨찾기 입력
     * @param evMypageFavortsRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/vr/favorts/insert")
    public Map<String,Object> vr_favorts_insert (@RequestBody EvMypageFavortsRequestDto evMypageFavortsRequestDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                resposeResult.put("result_code", "-999");
                resposeResult.put("result_msg", "로그인 후 사용 할 수 있습니다.!!");

            } else {
                evMypageFavortsRequestDto.setCust_id(loginInfoDto.getCust_id());
                evMypageFavortsRequestDto.setUser_id(loginInfoDto.getCust_id());

                int return_code = evMypageFavoritsService.vr_favorits_save(evMypageFavortsRequestDto);

                /* 즐겨찾기 리스트 조회 */
                List<EvMypageFavortsResponseDto> list = evMypageFavoritsService.vr_favorits(evMypageFavortsRequestDto);

                String favorit_yn = "";
                if(list.size() > 0) {
                    favorit_yn = "Y";
                } else {
                    favorit_yn = "N";
                }

                resposeResult.put("favorit_yn", favorit_yn);
                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }
}
