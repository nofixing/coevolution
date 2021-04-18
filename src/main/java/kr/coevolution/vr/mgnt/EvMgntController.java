package kr.coevolution.vr.mgnt;

import kr.coevolution.vr.board.dto.EvBoardConsltResponseDto;
import kr.coevolution.vr.board.dto.EvBoardSearchDto;
import kr.coevolution.vr.board.dto.EvBoardTermsResponseDto;
import kr.coevolution.vr.board.service.EvBoardService;
import kr.coevolution.vr.comm.dto.EvCommCodeRequestDto;
import kr.coevolution.vr.comm.dto.EvCommCodeResponseDto;
import kr.coevolution.vr.comm.service.EvCommCodeService;
import kr.coevolution.vr.comm.util.SecureUtils;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.dto.EvMemberLoginRequestDto;
import kr.coevolution.vr.member.dto.EvMemberResposeDto;
import kr.coevolution.vr.member.dto.EvMemberSearchDto;
import kr.coevolution.vr.member.service.EvMemberService;
import kr.coevolution.vr.mgnt.dto.EvMgntMemberRequestDto;
import kr.coevolution.vr.mgnt.dto.EvMgntMemberResponseDto;
import kr.coevolution.vr.mgnt.service.EvMgntService;
import kr.coevolution.vr.mypage.EvMypageMemberController;
import kr.coevolution.vr.mypage.dto.EvMypageBadgeRequestDto;
import kr.coevolution.vr.mypage.dto.EvMypageBadgeResponseDto;
import kr.coevolution.vr.mypage.dto.EvMypageCustCorpInfoRequestDto;
import kr.coevolution.vr.mypage.service.EvMypageBoardConsltService;
import kr.coevolution.vr.mypage.service.EvMypageCustCorpInfoService;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@NoArgsConstructor
@Controller
public class EvMgntController {

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
    AuthenticationManager authenticationManager;

    Logger logger = LoggerFactory.getLogger(this.getClass());

    @ResponseBody
    @PostMapping("/mgnt/login")
    public Map<String,Object> mgnt_login(@RequestBody EvMemberLoginRequestDto evMemberLoginRequestDto, HttpSession session) {
        Map resposeResult = new HashMap();

        logger.info("member_login post start");
        String msg = "";
        try {
            /* 패스워드를 암호화하여 비교한다. */
            String userPw = evMemberLoginRequestDto.getUser_pw();
            userPw = SecureUtils.getSecurePassword(userPw);
            evMemberLoginRequestDto.setUser_pw(userPw);

            List<EvMemberLoginInfoDto> evMemberLoginInfoDtoList = evMgntService.search_login(evMemberLoginRequestDto);

            if(evMemberLoginInfoDtoList.size() == 1) {

                /* sesstion 정보 입력 */
                session.setAttribute(StringUtils.login_session, evMemberLoginInfoDtoList.get(0));

                UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(evMemberLoginRequestDto.getCust_nm(), userPw);

                // Authenticate the user
                Authentication authentication = authenticationManager.authenticate(authRequest);
                SecurityContext securityContext = SecurityContextHolder.getContext();
                securityContext.setAuthentication(authentication);

                // Create a new session and add the security context.
                session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);

                //관리자 메뉴 리스트 조회
                Map<String, String> pMap = new HashMap<String, String>();
                pMap.put("mgnt_id", evMemberLoginInfoDtoList.get(0).getMgnt_id());
                pMap.put("menu_lvel", "1"); //메뉴레벨1
                List<Map<String, String>> userMenuList1 = evMgntService.mgnt_user_menu_list(pMap);
                session.setAttribute("MGNT_MENU_LEVL1", userMenuList1);

                pMap.put("menu_lvel", "2"); //메뉴레벨2
                List<Map<String, String>> userMenuList2 = evMgntService.mgnt_user_menu_list(pMap);
                session.setAttribute("MGNT_MENU_LEVL2", userMenuList2);

                resposeResult.put("cust_clsf_cd", evMemberLoginInfoDtoList.get(0).getCust_clsf_cd());
                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");
            } else {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "로그인정보가 정확하지 않습니다.");
            }

        } catch (Exception e) {
            msg = e.toString();
            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        } finally {
            try {
                InetAddress local = InetAddress.getLocalHost();
                String ip = local.getHostAddress();

                Map<String, String> map = new HashMap<String, String>();
                map.put("cust_id", evMemberLoginRequestDto.getUser_id());
                map.put("ip", ip);
                map.put("rmk", String.valueOf(resposeResult.get("result_code")) + " : " + String.valueOf(resposeResult.get("result_msg")) + "\r\n"+msg);

                evMgntService.login_log(map);

            } catch (Exception e2){}

        }

        return resposeResult;
    }

    /**
     * 관리자 뱃지관리
     * @param evMypageBadgeRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/badge")
    public String mgnt_badge_list(EvMypageBadgeRequestDto evMypageBadgeRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt01";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            evMypageBadgeRequestDto.setUser_id(loginInfoDto.getCust_id());
            evMypageBadgeRequestDto.setCust_id(loginInfoDto.getCust_id());
            
            /* 공통코드조회 - 부스 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("106000");
            evCommCodeRequestDto.setUse_yn("Y");
            List<EvCommCodeResponseDto> category = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            model.addAttribute("category", category);

            /* row 개수 */
            evMypageBadgeRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMypageBadgeRequestDto.getPage_current(), StringUtils.page_row_cnt);
            evMypageBadgeRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMypageBadgeRequestDto.getPage_current(),""))) {
                evMypageBadgeRequestDto.setPage_current(1L);
            }

            /* 참관/참가 구분 */
            if("".equals(StringUtils.nvl(evMypageBadgeRequestDto.getCust_clsf_sh(),""))) {
                evMypageBadgeRequestDto.setCust_clsf_sh("202001");
            }

            model.addAttribute("page_current", String.valueOf(evMypageBadgeRequestDto.getPage_current()));  /* 현재페이지 */

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
            List<EvMypageBadgeResponseDto> list = null;
            List<EvMypageBadgeResponseDto> listCnt = null;

            if("202001".equals(evMypageBadgeRequestDto.getCust_clsf_sh())) {
                list = evMgntService.mgnt_badge_list(evMypageBadgeRequestDto);
                listCnt = evMgntService.mgnt_badge_list_count(evMypageBadgeRequestDto);
            } else {
                list = evMgntService.mgnt_badge_list2(evMypageBadgeRequestDto);
                listCnt = evMgntService.mgnt_badge_list2_count(evMypageBadgeRequestDto);
            }

            Long row_count = 0L;

            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count();
            }

            model.addAttribute("page_clsf", "mgnt01");
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총 개수 */
            model.addAttribute("page_row_cnt", evMypageBadgeRequestDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMypageBadgeRequestDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("ins_dt_fr", evMypageBadgeRequestDto.getIns_dt_fr());
            model.addAttribute("ins_dt_to", evMypageBadgeRequestDto.getIns_dt_to());
            model.addAttribute("cust_clsf_sh", evMypageBadgeRequestDto.getCust_clsf_sh());
            model.addAttribute("category_sh", evMypageBadgeRequestDto.getCategory_sh());
            model.addAttribute("category_nm_sh", evMypageBadgeRequestDto.getCategory_nm_sh());

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
     * 관리자 상담문의내역
     * @param evBoardSearchDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/conslt")
    public String mgnt_conslt_list(EvBoardSearchDto evBoardSearchDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt02";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();


            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evBoardSearchDto.getIns_dt_fr(),""))) {
                Date ftDt = StringUtils.addMonth(nDt,-1);
                String strDt = sf.format(ftDt);
                evBoardSearchDto.setIns_dt_fr(strDt);
            }

            if("".equals(StringUtils.nvl(evBoardSearchDto.getIns_dt_to(),""))) {
                String strDt = sf.format(nDt);
                evBoardSearchDto.setIns_dt_to(strDt);
            }

            /* row 개수 */
            evBoardSearchDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evBoardSearchDto.getPage_current());
            evBoardSearchDto.setPage_row_start(page_row_start);

            List<EvBoardConsltResponseDto> list = evMypageBoardConsltService.mgnt_conslt_list(evBoardSearchDto);
            List<EvBoardConsltResponseDto> listCnt = evMypageBoardConsltService.mgnt_conslt_list_count(evBoardSearchDto);

            Long row_count = 0L;
            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count();
            }

            if("".equals(StringUtils.nvl(evBoardSearchDto.getPage_current(),""))) {
                evBoardSearchDto.setPage_current(1L);
            }

            model.addAttribute("page_clsf", "mgnt02");
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총 개수 */
            model.addAttribute("page_row_cnt", evBoardSearchDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evBoardSearchDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("board_stat_cd", evBoardSearchDto.getBoard_stat_cd());
            model.addAttribute("keyword_clsf_cd", evBoardSearchDto.getKeyword_clsf_cd());
            model.addAttribute("keyword", evBoardSearchDto.getKeyword());
            model.addAttribute("ins_dt_fr", evBoardSearchDto.getIns_dt_fr());
            model.addAttribute("ins_dt_to", evBoardSearchDto.getIns_dt_to());

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;

    }

    /**
     * 상담상세내용
     * @param evBoardSearchDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/conslt_dtl")
    public String mgnt_conslt_dtl(EvBoardSearchDto evBoardSearchDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt021";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            model.addAttribute("board_id", evBoardSearchDto.getBoard_id());
            model.addAttribute("page_clsf", "mgnt02");
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
     * 참가고개정 정보 조회
     * @param evMgntMemberRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/m_corp_search")
    public String mgnt_member_corp_search(EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0301";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            evMgntMemberRequestDto.setUser_id(loginInfoDto.getCust_id());
            evMgntMemberRequestDto.setCust_id(loginInfoDto.getCust_id());
            evMgntMemberRequestDto.setCust_clsf_cd("202002"); //참가

            /* row 개수 */
            evMgntMemberRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMgntMemberRequestDto.getPage_current());
            evMgntMemberRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getPage_current(),""))) {
                evMgntMemberRequestDto.setPage_current(1L);
            }

            model.addAttribute("page_current", String.valueOf(evMgntMemberRequestDto.getPage_current()));  /* 현재페이지 */

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();


            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_fr(),""))) {
                Date ftDt = StringUtils.addMonth(nDt,-1);
                String strDt = sf.format(ftDt);
                evMgntMemberRequestDto.setIns_dt_fr(strDt);
            }

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_to(),""))) {
                String strDt = sf.format(nDt);
                evMgntMemberRequestDto.setIns_dt_to(strDt);
            }

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getKeyword(),""))) {
                evMgntMemberRequestDto.setKeyword("");
            }

            /* 뱃지 리스트 조회 */
            List<EvMgntMemberResponseDto> list = evMgntService.search_member_list(evMgntMemberRequestDto);
            List<EvMgntMemberResponseDto> listCnt = evMgntService.search_member_list_count(evMgntMemberRequestDto);

            Long row_count = 0L;

            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count(); /* 총건수 */
            }

            Long page_row_cnt = StringUtils.page_tot(row_count);

            model.addAttribute("page_clsf", "mgnt0301");
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총건수 */
            model.addAttribute("page_row_cnt", String.valueOf(page_row_cnt));    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMgntMemberRequestDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("ins_dt_fr", evMgntMemberRequestDto.getIns_dt_fr());
            model.addAttribute("ins_dt_to", evMgntMemberRequestDto.getIns_dt_to());
            model.addAttribute("keyword", evMgntMemberRequestDto.getKeyword());

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
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/m_corp_user_form")
    public String mgnt_member_corp_user_form(HttpServletRequest request, Model model) {
        String returnUrl = "/mgnt/mgnt0302";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            model.addAttribute("page_clsf", "mgnt0301");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 상세내역이동
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/m_corp_detail")
    public String mgnt_member_corp_detail(HttpServletRequest request, Model model) {
        String returnUrl = "/mgnt/mgnt0303";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            model.addAttribute("page_clsf", "mgnt0301");
            model.addAttribute("cust_id", request.getParameter("cust_id"));

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }


    /**
     * 관리자-기업정보조회
     * @param map
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/m_corp_custinfo")
    public Map<String,Object> mgnt_member_corp_custinfo(@RequestBody Map map, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),"")) || !"202003".equals(loginInfoDto.getCust_clsf_cd())) {
            httpSession.removeAttribute(StringUtils.login_session);
            resposeResult.put("session_yn", "N");
            resposeResult.put("result_code", "-9999");
            resposeResult.put("result_msg", "세션정보없음");
            return resposeResult;
        } else {
            resposeResult.put("session_yn", "Y");
        }

        try {
            EvMypageMemberController memberController = new EvMypageMemberController();

            EvMemberSearchDto evMemberSearchDto = new EvMemberSearchDto();
            evMemberSearchDto.setUser_id(String.valueOf(map.get("cust_id")));
            evMemberSearchDto.setCust_id(String.valueOf(map.get("cust_id")));

            /* 고객정보조회 */
            List<EvMemberResposeDto> custInfo = evMemberService.search_cust_info(evMemberSearchDto);

            /* 국가코드조회 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("212000");
            evCommCodeRequestDto.setUse_yn("Y");
            List<EvCommCodeResponseDto> countrylist = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 카테고리 */
            evCommCodeRequestDto.setUpper_cd_id("106000");
            List<EvCommCodeResponseDto> category1 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            resposeResult.put("custInfo", custInfo);
            resposeResult.put("countrylist", countrylist);
            resposeResult.put("category1", category1);

            /* vr-기업정보 url */
            Long base62Encode = custInfo.get(0).getCust_seq() * SecureUtils.vr_cust_seq_const;
            String vr_corpinfo_url = SecureUtils.base62Encoding(base62Encode);
            resposeResult.put("vr_corpinfo_url", "/vr/vr_corp_form?c="+vr_corpinfo_url);
            resposeResult.put("vr_corpcoslt_url", "/vr/vr_coslt_form?c="+vr_corpinfo_url);

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
     * 관리자-기업정보수정
     * @param map
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/m_corp_custupdate")
    public Map<String,Object> mgnt_member_corp_custupdate(@RequestBody Map map, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),"")) || !"202003".equals(loginInfoDto.getCust_clsf_cd())) {
            httpSession.removeAttribute(StringUtils.login_session);
            resposeResult.put("session_yn", "N");
            resposeResult.put("result_code", "-9999");
            resposeResult.put("result_msg", "세션정보없음");
            return resposeResult;
        } else {
            resposeResult.put("session_yn", "Y");
        }

        try {
            map.put("cust_id", map.get("cust_id"));
            map.put("user_id", loginInfoDto.getCust_id());

            int result_code = evMemberService.member_update(map);

            if(result_code < 0) {
                throw new RuntimeException();
            }

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
     * 내부스정보-첨부파일 저당
     * @param evMypageCustCorpInfoRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/m_corp_attach")
    public Map<String,Object> mgnt_corpattach (EvMypageCustCorpInfoRequestDto evMypageCustCorpInfoRequestDto, @RequestPart List<MultipartFile> files, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            EvMemberSearchDto evMemberSearchDto = new EvMemberSearchDto();
            evMemberSearchDto.setCust_id(evMypageCustCorpInfoRequestDto.getFile_cust_id());

            /* 고객정보조회 */
            List<EvMemberResposeDto> custInfo = evMemberService.search_cust_info(evMemberSearchDto);

            evMypageCustCorpInfoRequestDto.setBoard_id(custInfo.get(0).getCust_seq());
            evMypageCustCorpInfoRequestDto.setCust_id(evMypageCustCorpInfoRequestDto.getFile_cust_id());
            evMypageCustCorpInfoRequestDto.setUser_id(loginInfoDto.getCust_id());

            /* 내 부스정보 첨부파일 업로드 */
            int return_code = evMypageCustCorpInfoService.mypage_cust_corp_file(evMypageCustCorpInfoRequestDto, files);

            if(return_code != 0) {
                new RuntimeException("-1");
            } else {
                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "업로드실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 비밀번호를 초기화한다.
     * @param pMap
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/m_corp_pwreset")
    public Map<String,Object> mgnt_corppwreset (@RequestBody Map<String, String> pMap, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            EvMemberLoginRequestDto evMemberLoginRequestDto = new EvMemberLoginRequestDto();

            /* cust_id를 비밀번호로 변경한다 - 초기화 */
            String userCurrentPw = pMap.get("cust_id");

            userCurrentPw = SecureUtils.getSecurePassword(pMap.get("cust_id"));
            evMemberLoginRequestDto.setUser_change_pw1(userCurrentPw);
            evMemberLoginRequestDto.setUser_id(loginInfoDto.getCust_id());
            evMemberLoginRequestDto.setCust_id(pMap.get("cust_id"));

            int result_code = evMemberService.member_passwd(evMemberLoginRequestDto);

            if(result_code != 0) {
                new RuntimeException("-1");
            } else {
                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "업로드실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 참관고객조회
     * @param evMgntMemberRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/m_member_search")
    public String mgnt_member_search(EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0401";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            evMgntMemberRequestDto.setUser_id(loginInfoDto.getCust_id());
            evMgntMemberRequestDto.setCust_id(loginInfoDto.getCust_id());
            evMgntMemberRequestDto.setCust_clsf_cd("202001"); //참관

            /* row 개수 */
            evMgntMemberRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMgntMemberRequestDto.getPage_current());
            evMgntMemberRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getPage_current(),""))) {
                evMgntMemberRequestDto.setPage_current(1L);
            }

            model.addAttribute("page_current", String.valueOf(evMgntMemberRequestDto.getPage_current()));  /* 현재페이지 */

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();


            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_fr(),""))) {
                Date ftDt = StringUtils.addMonth(nDt,-1);
                String strDt = sf.format(ftDt);
                evMgntMemberRequestDto.setIns_dt_fr(strDt);
            }

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_to(),""))) {
                String strDt = sf.format(nDt);
                evMgntMemberRequestDto.setIns_dt_to(strDt);
            }

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getKeyword(),""))) {
                evMgntMemberRequestDto.setKeyword("");
            }

            /* 뱃지 리스트 조회 */
            List<EvMgntMemberResponseDto> list = evMgntService.search_member_list(evMgntMemberRequestDto);
            List<EvMgntMemberResponseDto> listCnt = evMgntService.search_member_list_count(evMgntMemberRequestDto);

            Long row_count = 0L;

            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count(); /* 총건수 */
            }

            Long page_row_cnt = StringUtils.page_tot(row_count);

            model.addAttribute("page_clsf", "mgnt0401");
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총건수 */
            model.addAttribute("page_row_cnt", String.valueOf(page_row_cnt));    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMgntMemberRequestDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("ins_dt_fr", evMgntMemberRequestDto.getIns_dt_fr());
            model.addAttribute("ins_dt_to", evMgntMemberRequestDto.getIns_dt_to());
            model.addAttribute("keyword", evMgntMemberRequestDto.getKeyword());

            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    @RequestMapping("/mgnt/m_member_form")
    public String m_member_form(EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0402";

        try {
            model.addAttribute("cust_id", evMgntMemberRequestDto.getCust_id());
            model.addAttribute("page_clsf", "mgnt0401");
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
     * 관리자페이지 조회
     * @param map
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/m_member_search_dtl")
    public Map<String,Object> m_member_search_dtl(@RequestBody Map map, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        try {
            EvMemberSearchDto evMemberSearchDto = new EvMemberSearchDto();
            evMemberSearchDto.setUser_id(loginInfoDto.getCust_id());
            evMemberSearchDto.setCust_id(StringUtils.nvl(map.get("cust_id"),""));

            /* 고객정보조회 */
            List<EvMemberResposeDto> custInfo = evMemberService.search_cust_info(evMemberSearchDto);

            /* 선택항목조회 (관심분야, 종사분야, 업무(구매)권한, 방문목적) */
            List<Map<String, Object>> custIntrst = evMemberService.search_cust_intrst(evMemberSearchDto);

            /* 국가코드조회 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("212000");
            evCommCodeRequestDto.setUse_yn("Y");
            List<EvCommCodeResponseDto> countrylist = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 관심분야 */
            evCommCodeRequestDto.setUpper_cd_id("206000");
            List<EvCommCodeResponseDto> list1 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 종사분야 */
            evCommCodeRequestDto.setUpper_cd_id("207000");
            List<EvCommCodeResponseDto> list2 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 업무(구매)권한 */
            evCommCodeRequestDto.setUpper_cd_id("208000");
            List<EvCommCodeResponseDto> list3 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 방문목적 */
            evCommCodeRequestDto.setUpper_cd_id("209000");
            List<EvCommCodeResponseDto> list4 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 인지경로 */
            evCommCodeRequestDto.setUpper_cd_id("210000");
            List<EvCommCodeResponseDto> list5 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 카테고리 */
            evCommCodeRequestDto.setUpper_cd_id("106000");
            List<EvCommCodeResponseDto> category1 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            resposeResult.put("custInfo", custInfo);
            resposeResult.put("custIntrst", custIntrst);
            resposeResult.put("countrylist", countrylist);
            resposeResult.put("list1", list1);
            resposeResult.put("list2", list2);
            resposeResult.put("list3", list3);
            resposeResult.put("list4", list4);
            resposeResult.put("list5", list5);
            resposeResult.put("category1", category1);

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
     * 관리자 리스트
     * @param evMgntMemberRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/user")
    public String m_member_user_list(EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0501";
        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            evMgntMemberRequestDto.setUser_id(loginInfoDto.getCust_id());
            evMgntMemberRequestDto.setCust_id(loginInfoDto.getCust_id());

            /* row 개수 */
            evMgntMemberRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMgntMemberRequestDto.getPage_current());
            evMgntMemberRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getPage_current(),""))) {
                evMgntMemberRequestDto.setPage_current(1L);
            }

            model.addAttribute("page_current", String.valueOf(evMgntMemberRequestDto.getPage_current()));  /* 현재페이지 */

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getMgnt_id(),""))) {
                evMgntMemberRequestDto.setMgnt_id("");
            }

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getMgnt_nm(),""))) {
                evMgntMemberRequestDto.setMgnt_nm("");
            }

            /* 뱃지 리스트 조회 */
            List<EvMgntMemberResponseDto> list = evMgntService.search_mgnt_user_list(evMgntMemberRequestDto);
            List<EvMgntMemberResponseDto> listCnt = evMgntService.search_mgnt_user_list_count(evMgntMemberRequestDto);

            Long row_count = 0L;

            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count(); /* 총건수 */
            }

            Long page_row_cnt = StringUtils.page_tot(row_count);

            model.addAttribute("page_clsf", "mgnt05");
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총건수 */
            model.addAttribute("page_row_cnt", String.valueOf(page_row_cnt));    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMgntMemberRequestDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("mgnt_id_sh", evMgntMemberRequestDto.getMgnt_id_sh());
            model.addAttribute("mgnt_nm_sh", evMgntMemberRequestDto.getMgnt_nm_sh());

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
     * 관리자페이지 - 관리자입력 폼
     * @param evMgntMemberRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/user_form")
    public String m_member_user_form(EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0502";

        try {

            if("U".equals(evMgntMemberRequestDto.getMode())) {
                returnUrl = "/mgnt/mgnt0503";
                
                //관리자정보조회
                List<EvMgntMemberResponseDto> mgntInfo = evMgntService.search_mgnt_user_info(evMgntMemberRequestDto);
                model.addAttribute("mgnt_id", mgntInfo.get(0).getMgnt_id());
                model.addAttribute("mgnt_nm", mgntInfo.get(0).getMgnt_nm());
                model.addAttribute("email_id", mgntInfo.get(0).getEmail_id());
                model.addAttribute("hp_no", mgntInfo.get(0).getHp_no());
                model.addAttribute("dept_nm", mgntInfo.get(0).getDept_nm());
                model.addAttribute("use_yn", mgntInfo.get(0).getUse_yn());

                //권한
                Map<String, String> pMap = new HashMap<String, String>();
                pMap.put("mgnt_id", evMgntMemberRequestDto.getMgnt_id());
                List<Map<String,String>> listPrms = evMgntService.search_mgnt_prms_list(pMap);

                for(int i = 0; i < listPrms.size(); i++) {
                    model.addAttribute("S"+listPrms.get(i).get("menu_id"), listPrms.get(i).get("use_yn"));
                }
            }

            model.addAttribute("mgnt_id", evMgntMemberRequestDto.getMgnt_id());
            model.addAttribute("page_clsf", "mgnt05");
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
     * 관리자 중복체크
     * @param evMgntMemberRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/user_dup")
    public Map<String,Object> mgnt_user_dup(@RequestBody EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        try {

            List<EvMgntMemberResponseDto> list = evMgntService.search_mgnt_dup_chk(evMgntMemberRequestDto);

            String dup_yn = "N";
            if(0 < list.get(0).getDup_cnt()) {
                dup_yn = "Y";
            }

            resposeResult.put("dup_yn", dup_yn);
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
     * 관리자를 등록한다.
     * @param pMap
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/insert")
    public Map<String,Object> mgnt_user_insert(@RequestBody Map<String, String> pMap, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        try {
            /* 등록자 입력 */
            pMap.put("user_id", loginInfoDto.getMgnt_id());

            evMgntService.mgnt_user_insert(pMap);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            if("-1".equals(e.getMessage())) {
                resposeResult.put("result_code", e.getMessage());
                resposeResult.put("result_msg", "ID중복 오류");
            } else {
                resposeResult.put("result_code", "-99");
                resposeResult.put("result_msg", "입력실패!!");
            }

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 관리자 정보를 수정한다.
     * @param pMap
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/update")
    public Map<String,Object> mgnt_user_update(@RequestBody Map<String, String> pMap, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        try {
            /* 등록자 입력 */
            pMap.put("user_id", loginInfoDto.getMgnt_id());

            evMgntService.mgnt_user_update(pMap);

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
     * 비밀번호변경
     * @param evMgntMemberRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/pwChange")
    public Map<String,Object> mgnt_user_password_chagne(@RequestBody EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        try {
            if(!evMgntMemberRequestDto.getMgnt_passwd1().equals(evMgntMemberRequestDto.getMgnt_passwd2())) {
                throw new RuntimeException("-1");
            }

            /* 비밀번호 암호화 */
            String mgnt_pw = String.valueOf(evMgntMemberRequestDto.getMgnt_passwd1());
            mgnt_pw = SecureUtils.getSecurePassword(mgnt_pw);
            evMgntMemberRequestDto.setMgnt_pw(mgnt_pw);
            evMgntMemberRequestDto.setUser_id(loginInfoDto.getMgnt_id());

            evMgntService.mgnt_user_passwd_change(evMgntMemberRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {
            if("-1".equals(e.getMessage())) {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "비밀번호 오류!!");
            } else {
                resposeResult.put("result_code", "-99");
                resposeResult.put("result_msg", "입력실패!!");
            }

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 공콩코드 form
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/code")
    public String mgnt_code (Model model) {

        String returnUrl = "/mgnt/mgnt0601";
        model.addAttribute("page_clsf", "mgnt06");

        return returnUrl;
    }

    /**
     * 공콩코드 form
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/codeList")
    public String mgnt_codeList (EvCommCodeRequestDto evCommCodeRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0601";
        
        /* 검색조건셋팅 */
        if(!"".equals(StringUtils.nvl(evCommCodeRequestDto.getCode_clsf3(),""))) {
            evCommCodeRequestDto.setCd_id(evCommCodeRequestDto.getCode_clsf3());
        } else if(!"".equals(StringUtils.nvl(evCommCodeRequestDto.getCode_clsf2(),""))) {
            evCommCodeRequestDto.setUpper_cd_id(evCommCodeRequestDto.getCode_clsf2());
        } else if(!"".equals(StringUtils.nvl(evCommCodeRequestDto.getCode_clsf1(),""))) {
            evCommCodeRequestDto.setUpper_cd_id(evCommCodeRequestDto.getCode_clsf1());
        }

        List<EvCommCodeResponseDto> list = evCommCodeService.comm_code_search(evCommCodeRequestDto);

        model.addAttribute("codelist", list);

        /* 검색조건 */
        model.addAttribute("code_clsf1", evCommCodeRequestDto.getCode_clsf1());

        evCommCodeRequestDto.setUpper_cd_id("000000");
        evCommCodeRequestDto.setCd_id(null);
        list = evCommCodeService.comm_code_search(evCommCodeRequestDto);
        model.addAttribute("code_clsf1_list", list);

        model.addAttribute("code_clsf2", evCommCodeRequestDto.getCode_clsf2());

        if(!"".equals(evCommCodeRequestDto.getCode_clsf1())) {
            evCommCodeRequestDto.setUpper_cd_id(evCommCodeRequestDto.getCode_clsf1());
            list = evCommCodeService.comm_code_search(evCommCodeRequestDto);
            model.addAttribute("code_clsf2_list", list);
        }

        model.addAttribute("code_clsf3", evCommCodeRequestDto.getCode_clsf3());

        if(!"".equals(evCommCodeRequestDto.getCode_clsf2())) {
            evCommCodeRequestDto.setUpper_cd_id(evCommCodeRequestDto.getCode_clsf2());
            list = evCommCodeService.comm_code_search(evCommCodeRequestDto);
            model.addAttribute("code_clsf3_list", list);
        }

        model.addAttribute("page_clsf", "mgnt06");

        return returnUrl;
    }

    /**
     * 공통코드 수정
     * @param pMap
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/codeSave")
    public Map<String,Object> mgnt_code_save(@RequestBody Map<String, String> pMap, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        try {
            String[] vField = new String[]{"cd_nm", "upper_cd_id", "cd_val1", "cd_val2", "cd_val3", "priority", "use_yn"};

            /* List 만들기 */
            List list = new ArrayList();
            for(int i = 0; i < 8; i++) {
                Map<String, String> vMap = new HashMap<String, String>();
                String cdId = pMap.get("cd_id_"+i);
                vMap.put("cd_id", cdId);
                vMap.put("user_id", loginInfoDto.getCust_id());

                for(int j = 0; j < vField.length; j++) {
                    vMap.put(vField[j], pMap.get(vField[j] + "_"+ cdId));
                }

                list.add(vMap);
            }

            /* 공통코드 수정 */
            evCommCodeService.comm_cd_update(list);
            
            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {
            if("-1".equals(e.getMessage())) {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "비밀번호 오류!!");
            } else {
                resposeResult.put("result_code", "-99");
                resposeResult.put("result_msg", "입력실패!!");
            }

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 공통코드 신규저장
     * @param evCommCodeRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/codeInsert")
    public Map<String,Object> mgnt_code_insert(@RequestBody EvCommCodeRequestDto evCommCodeRequestDto, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        try {
            /* 공통코드 수정 */
            evCommCodeRequestDto.setUser_id(loginInfoDto.getCust_id());
            evCommCodeService.comm_cd_insert(evCommCodeRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {
            if("-1".equals(e.getMessage())) {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "비밀번호 오류!!");
            } else {
                resposeResult.put("result_code", "-99");
                resposeResult.put("result_msg", "입력실패!!");
            }

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 공콩코드 form
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/terms_list")
    public String mgnt_terms_list (EvBoardSearchDto evBoardSearchDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0701";

        evBoardSearchDto.setBoard_clsf_cd(evBoardSearchDto.getT());

        evBoardSearchDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
        Long page_row_start = StringUtils.page_start_row(evBoardSearchDto.getPage_current());
        evBoardSearchDto.setPage_row_start(page_row_start);

        List<EvBoardTermsResponseDto> list = evBoardService.terms_list(evBoardSearchDto);
        List<EvBoardTermsResponseDto> listCnt = evBoardService.terms_list_count(evBoardSearchDto);

        Long row_count = 0L;
        if(listCnt != null && listCnt.size() > 0) {
            row_count = listCnt.get(0).getRow_count();
        }

        if("".equals(StringUtils.nvl(evBoardSearchDto.getPage_current(),""))) {
            evBoardSearchDto.setPage_current(1L);
        }

        model.addAttribute("termslist", list);
        model.addAttribute("row_count", row_count); /* 총 개수 */
        model.addAttribute("page_row_cnt", evBoardSearchDto.getPage_row_cnt());    /* 페이지 row 개수 */
        model.addAttribute("page_current", evBoardSearchDto.getPage_current());    /* 현재페이지 */

        model.addAttribute("board_clsf_cd",  evBoardSearchDto.getT()); //구분

        if("101006".equals(evBoardSearchDto.getT())) {
            model.addAttribute("page_clsf", "mgnt071"); //개인정보처리방침
            model.addAttribute("page_clsf_nm", "개인정보처리방침"); //개인정보처리방침
        } else if("101007".equals(evBoardSearchDto.getT())) {
            model.addAttribute("page_clsf", "mgnt072"); //이용약관
            model.addAttribute("page_clsf_nm", "이용약관"); //이용약관
        } else if("101009".equals(evBoardSearchDto.getT())) {
            model.addAttribute("page_clsf", "mgnt073"); //마케팅활용동의
            model.addAttribute("page_clsf_nm", "마케팅활용동의"); //마케팅활용동의
        }

        return returnUrl;
    }

    /**
     * 약관상세
     * @param evBoardSearchDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/terms_form")
    public String mgnt_terms_form (EvBoardSearchDto evBoardSearchDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0702";
        model.addAttribute("board_clsf_cd",  evBoardSearchDto.getBoard_clsf_cd()); //구분

        if("101006".equals(evBoardSearchDto.getBoard_clsf_cd())) {
            model.addAttribute("page_clsf", "mgnt071"); //개인정보처리방침
            model.addAttribute("page_clsf_nm", "개인정보처리방침"); //개인정보처리방침
        } else if("101007".equals(evBoardSearchDto.getBoard_clsf_cd())) {
            model.addAttribute("page_clsf", "mgnt072"); //이용약관
            model.addAttribute("page_clsf_nm", "이용약관"); //이용약관
        } else if("101009".equals(evBoardSearchDto.getBoard_clsf_cd())) {
            model.addAttribute("page_clsf", "mgnt073"); //마케팅활용동의
            model.addAttribute("page_clsf_nm", "마케팅활용동의"); //마케팅활용동의
        }

        return returnUrl;
    }

    /**
     * 공통코드 신규저장
     * @param evBoardSearchDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/terms_detail")
    public Map<String,Object> mgnt_terms_detail(@RequestBody EvBoardSearchDto evBoardSearchDto, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        try {
            List<EvBoardTermsResponseDto> list = evBoardService.terms_detail(evBoardSearchDto);
            resposeResult.put("data", list);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {
            if("-1".equals(e.getMessage())) {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "비밀번호 오류!!");
            } else {
                resposeResult.put("result_code", "-99");
                resposeResult.put("result_msg", "입력실패!!");
            }

            e.printStackTrace();
        }

        return resposeResult;
    }

}
