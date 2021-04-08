package kr.coevolution.vr.mgnt;

import kr.coevolution.vr.board.dto.EvBoardConsltResponseDto;
import kr.coevolution.vr.board.dto.EvBoardSearchDto;
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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

}
