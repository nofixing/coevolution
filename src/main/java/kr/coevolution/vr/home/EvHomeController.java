package kr.coevolution.vr.home;

import kr.coevolution.vr.board.dto.EvBoardSearchDto;
import kr.coevolution.vr.board.dto.EvBoardTermsResponseDto;
import kr.coevolution.vr.board.service.EvBoardService;
import kr.coevolution.vr.comm.dto.*;
import kr.coevolution.vr.comm.service.EvCommCodeService;
import kr.coevolution.vr.comm.service.EvFileAttachService;
import kr.coevolution.vr.comm.util.SecureUtils;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.config.auth.dto.SessionUser;
import kr.coevolution.vr.email.dto.EvMailSndRequestDto;
import kr.coevolution.vr.email.dto.EvMailSndResposeDto;
import kr.coevolution.vr.email.service.EvMailSndService;
import kr.coevolution.vr.home.dto.EvMemberJoinForm3;
import kr.coevolution.vr.member.dto.EvMemberBadgeRequestDto;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.dto.EvMemberResposeDto;
import kr.coevolution.vr.member.dto.EvMemberSearchDto;
import kr.coevolution.vr.member.service.EvMemberService;
import kr.coevolution.vr.mypage.dto.*;
import kr.coevolution.vr.mypage.service.EvMypageBadgeService;
import kr.coevolution.vr.mypage.service.EvMypageCustCorpInfoService;
import kr.coevolution.vr.mypage.service.EvMypageFavoritsService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.LocaleResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Slf4j
@Controller
public class EvHomeController {

    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    MessageSource messageSource;

    @Autowired
    LocaleResolver localeResolver;

    @Autowired
    private EvMailSndService mailSndService;

    @Autowired
    private EvCommCodeService evCommCodeService;

    @Autowired
    private EvMemberService evMemberService;

    @Autowired
    private EvMypageCustCorpInfoService evMypageCustCorpInfoService;

    @Autowired
    private EvFileAttachService evFileAttachService;

    @Autowired
    private EvMypageBadgeService evMypageBadgeService;

    @Autowired
    private EvMypageFavoritsService evMypageFavoritsService;

    @Autowired
    private EvBoardService evBoardService;


    @RequestMapping({"/", "/index"})
    public String index(Model model) {

        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession(true);

        SessionUser user = (SessionUser)session.getAttribute("user");

        if(user != null) {
            logger.info("user info:" + user.toString());
        } else {
            logger.info("user is null");
        }

        EvMemberLoginInfoDto cust = (EvMemberLoginInfoDto)session.getAttribute(StringUtils.login_session);

        if(cust != null) {
            logger.info("cust info:" + cust.toString());
            model.addAttribute("userName", cust.getCust_nm());
        } else {
            logger.info("cust is null");
        }

        return "index";
    }

    /**
     * 이용약관
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/index/terms")
    public String terms(Model model, HttpServletRequest request) {
        String return_url = "/terms";

        HttpSession httpSession = request.getSession();
        String lang = String.valueOf(httpSession.getAttribute("LANG"));

        if(lang.equals("en")) {
            return_url = "/termsEn";
        }

        return return_url;
    }

    /**
     * 개인정보처리방침
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/index/pirvatePolicy")
    public String pirvatePolicy(Model model, HttpServletRequest request) {

        String return_url = "/pirvatePolicy";
        HttpSession httpSession = request.getSession();
        String lang = String.valueOf(httpSession.getAttribute("LANG"));

        if(lang.equals("en")) {
            return_url = "/pirvatePolicyEn";
        }

        return return_url;
    }
    
    /**
     * 오시는 길
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/index/map")
    public String map(Model model, HttpServletRequest request) {

        return "/map";
    }


    /**
     * 버추얼전시관
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/index/ieve2021")
    public String ieve2021(Model model, HttpServletRequest request) {
        String return_url = "/ieve2021";

        return return_url;
    }

    /**
     * 버추얼전시관
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/index/ieve2021test")
    public String ieve2021test(Model model, HttpServletRequest request) {
        String return_url = "/ieve2021test";

        return return_url;
    }

    /**
     * 버추얼전시관
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/ieve2021")
    public String index_ieve2021(Model model, HttpServletRequest request) {
        String return_url = "/index2021";

        return return_url;
    }

    /**
     * 로그인
     * @param model
     * @return
     */
    @RequestMapping("/member/login_form")
    public String login_form(Model model, HttpServletRequest request) {

        String return_url = "/member/login_form";

        String url_prior_login = (String)request.getSession().getAttribute("url_prior_login");
        request.getSession().setAttribute("url_prior_login", return_url);

        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
        
        /* 로그인정보가 있을 경우 마이페이지로 이동 */
        if(loginInfoDto != null && !"".equals(StringUtils.nvl(loginInfoDto.getCust_clsf_cd(),""))) {
            if("202001".equals(loginInfoDto.getCust_clsf_cd())) {
                return_url = "redirect:/mypage/favorts";
            } else if("202002".equals(loginInfoDto.getCust_clsf_cd())) {
                return_url = "redirect:/mypage/myc01";
            } else if("202003".equals(loginInfoDto.getCust_clsf_cd())) {
                return_url = "redirect:/mgnt/badge";
            }
        }

        return return_url;
    }

    /**
     * 아이디찾기
     * @param model
     * @return
     */
    @RequestMapping("/member/id_sh_form1")
    public String id_sh_form1(Model model) {

        return "/member/id_sh_form1";
    }

    /**
     * 아이디찾기 결과
     * @param model
     * @return
     */
    @RequestMapping("/member/id_sh_form2")
    public String id_sh_form2(Model model, HttpServletRequest request) {

        String cust_id = request.getParameter("id");
        model.addAttribute("cust_id", cust_id);

        return "/member/id_sh_form2";
    }

    /**
     * 비밀번호찾기 결과
     * @param model
     * @return
     */
    @RequestMapping("/member/id_sh_form3")
    public String id_sh_form3(Model model, HttpServletRequest request) {

        return "/member/id_sh_form3";
    }

    /**
     * 패스워드찾기
     * @param model
     * @return
     */
    @RequestMapping("/member/pw_sh_form1")
    public String pw_sh_form1(Model model) {

        return "/member/pw_sh_form1";
    }

    /**
     * 패스워드찾기결과
     * @param model
     * @return
     */
    @RequestMapping("/member/pw_sh_form2")
    public String pw_sh_form2(Model model) {

        return "/member/pw_sh_form2";
    }

    /**
     * 참관등록
     * @param model
     * @return
     */
    @RequestMapping("/member/join_form1")
    public String join_form1(Model model, HttpServletRequest request) {

        String return_url = "/member/join_form1";
        request.getSession().setAttribute("url_prior_login", "/member/join_form2");

        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        /* 로그인정보가 있을 경우 마이페이지로 이동 */
        if(loginInfoDto != null && !"".equals(StringUtils.nvl(loginInfoDto.getCust_clsf_cd(),""))) {
            if("202001".equals(loginInfoDto.getCust_clsf_cd())) {
                return_url = "redirect:/mypage/favorts";
            } else if("202002".equals(loginInfoDto.getCust_clsf_cd())) {
                return_url = "redirect:/mypage/myc01";
            } else if("202003".equals(loginInfoDto.getCust_clsf_cd())) {
                return_url = "redirect:/mgnt/badge";
            }
        }

        return return_url;
    }

    /**
     * 참관신청
     * @param model
     * @return
     */
    @RequestMapping("/member/join_form2")
    public String join_form2(Model model) {

        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession(true);

        if ("dup_email".equals(session.getAttribute("email_check"))) {
            model.addAttribute("email_check", "dup_email");
            session.setAttribute("url_prior_login", "/member/join_form2");
            return "/member/join_form1";
        } else {

            /* 이용약관 */
            EvBoardSearchDto evBoardSearchDto = new EvBoardSearchDto();
            evBoardSearchDto.setBoard_clsf_cd("101007");
            List <EvBoardTermsResponseDto> formList = evBoardService.terms_detail(evBoardSearchDto);
            String agree1 = formList.get(0).getBoard_content();
            String agree1en = formList.get(0).getBoard_content2();

            /* 개인정보처리방침 */
            evBoardSearchDto.setBoard_clsf_cd("101006");
            formList = evBoardService.terms_detail(evBoardSearchDto);
            String agree2 = formList.get(0).getBoard_content();
            String agree2en = formList.get(0).getBoard_content2();

            /* 개인정보 마케팅 활용 동의(선택) */
            evBoardSearchDto.setBoard_clsf_cd("101009");
            formList = evBoardService.terms_detail(evBoardSearchDto);
            String agree3 = formList.get(0).getBoard_content();
            String agree3en = formList.get(0).getBoard_content2();

            model.addAttribute("agree1_contents", agree1);
            model.addAttribute("agree2_contents", agree2);
            model.addAttribute("agree3_contents", agree3);

            model.addAttribute("agree1_contents_en", agree1en);
            model.addAttribute("agree2_contents_en", agree2en);
            model.addAttribute("agree3_contents_en", agree3en);

            return "/member/join_form2";

        }

    }

    /**
     * 회원가입
     * @param evMemberJoinForm3
     * @param model
     * @return
     */
    @RequestMapping("/member/join_form3")
    public String join_form3(EvMemberJoinForm3 evMemberJoinForm3, Model model) {

        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession(true);

        SessionUser user = (SessionUser)session.getAttribute("user");

        if(user != null) {
            logger.info("user info:" + user.toString());
        }

        String agree_1 = StringUtils.nvl(evMemberJoinForm3.getAgree_1(),"N");
        String agree_2 = StringUtils.nvl(evMemberJoinForm3.getAgree_2(),"N");
        String agree_3 = StringUtils.nvl(evMemberJoinForm3.getAgree_3(),"N");

        /* 연령대 */
        EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
        evCommCodeRequestDto.setUpper_cd_id("204000");
        List<EvCommCodeResponseDto> ageList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

        model.addAttribute("ageList", ageList);

        /* 방문목적 */
        evCommCodeRequestDto = new EvCommCodeRequestDto();
        evCommCodeRequestDto.setUpper_cd_id("205000");
        List<EvCommCodeResponseDto> visitPupsList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

        model.addAttribute("visitPupsList", visitPupsList);

        /* 필수약관동의가 'N'인 경우 */
        if("N".equals(agree_1) || "N".equals(agree_2)) {
            model.addAttribute("agree_yn", "N");
            return "/member/join_form2";
        } else {
            model.addAttribute("agree_1", agree_1);
            model.addAttribute("agree_2", agree_2);
            model.addAttribute("agree_3", agree_3);

            if(user != null) {
                String[] email_id = user.getEmail().split("@");
                model.addAttribute("email_id1", email_id[0]);
                model.addAttribute("email_id2", email_id[1]);
                return "/member/join_form31";
            } else {
                return "/member/join_form3";
            }
        }
    }

    /**
     * 참가등록
     * @param model
     * @return
     */
    @RequestMapping("/member/join_form4")
    public String join_for4(Model model) {

        EvMailSndRequestDto evMailSndRequestDto = new EvMailSndRequestDto();

        /* 이용약관 */
        evMailSndRequestDto.setEmail_form_id(2);
        List<EvMailSndResposeDto> formList = mailSndService.searchMailForm(evMailSndRequestDto);
        String agree1 = formList.get(0).getEmail_form();

        /* 개인정보처리방침 */
        evMailSndRequestDto.setEmail_form_id(3);
        formList = mailSndService.searchMailForm(evMailSndRequestDto);
        String agree2 = formList.get(0).getEmail_form();

        /* 개인정보 마케팅 활용 동의(선택) */
        evMailSndRequestDto.setEmail_form_id(4);
        formList = mailSndService.searchMailForm(evMailSndRequestDto);
        String agree3 = formList.get(0).getEmail_form();

        model.addAttribute("agree1_contents", agree1);
        model.addAttribute("agree2_contents", agree2);
        model.addAttribute("agree3_contents", agree3);

        return "/member/join_form4";
    }

    /**
     * 참가 - 회원가입
     * @param evMemberJoinForm3
     * @param model
     * @return
     */
    @RequestMapping("/member/join_form5")
    public String join_form5(EvMemberJoinForm3 evMemberJoinForm3, Model model) {

        String agree_1 = StringUtils.nvl(evMemberJoinForm3.getAgree_1(),"N");
        String agree_2 = StringUtils.nvl(evMemberJoinForm3.getAgree_2(),"N");
        String agree_3 = StringUtils.nvl(evMemberJoinForm3.getAgree_3(),"N");

        /* 필수약관동의가 'N'인 경우 */
        if("N".equals(agree_1) || "N".equals(agree_2)) {
            model.addAttribute("agree_yn", "N");
            return "/member/join_form4";
        } else {
            model.addAttribute("agree_1", agree_1);
            model.addAttribute("agree_2", agree_2);
            model.addAttribute("agree_3", agree_3);

            return "/member/join_form5";
        }
    }

    /**
     * VR 기업정보
     * @param model
     * @return
     */
    @RequestMapping("/vr/vr_corp_form")
    public String vr_corp_form(HttpServletRequest request, Model model) {

        String returnUrl = "/vr/vr_corp_form";
        returnUrl = request.getRequestURL().append('?').append(request.getQueryString()).toString();
        logger.info("returnUrl:"+returnUrl);
        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
            request.getSession().setAttribute("url_prior_login", returnUrl);
            //임시주석
            //return "redirect:/vr/vr_login_form";
        }

        try {
            /* 기업정보 조회 */
            String cust_seq_str = request.getParameter("c");
            Long cust_seq = SecureUtils.base62Decoding(cust_seq_str) / SecureUtils.vr_cust_seq_const;

            EvMemberSearchDto evMemberSearchDto = new EvMemberSearchDto();
            evMemberSearchDto.setCust_seq(cust_seq);
            List<EvMemberResposeDto> list = evMemberService.search_cust_info_seq(evMemberSearchDto);

            model.addAttribute("custInfo", list.get(0));

            /* 뱃지정보조회 */
            /* 뱃지 리스트 조회 sum_badge_cnt : 0 이면 뱃지 없음 */
            EvMemberBadgeRequestDto evMemberBadgeRequestDto = new EvMemberBadgeRequestDto();
            evMemberBadgeRequestDto.setGive_cust_id(list.get(0).getCust_id());

            if(loginInfoDto != null && loginInfoDto.getCust_id() != null) {
                evMemberBadgeRequestDto.setCust_id(loginInfoDto.getCust_id());
            } else {
                evMemberBadgeRequestDto.setCust_id("");
            }

            List<EvMypageBadgeResponseDto> badgeList = evMypageBadgeService.vr_badge(evMemberBadgeRequestDto);

            String badge_yn = "N";
            int badgeCnt = 0;

            if(badgeList.size() > 0) {

                if (badgeList.get(0).getSum_badge_cnt() > 0) {
                    badge_yn = "Y";
                } else {
                    badge_yn = "N";
                }

                badgeCnt = badgeList.get(0).getTot_badge();

            }

            model.addAttribute("badge_yn", badge_yn);
            model.addAttribute("tot_badge", badgeCnt); /* 기업에 대한 전체 뱃지 */

            /* 즐겨찾기정보조회 */
            EvMypageFavortsRequestDto evMypageFavortsRequestDto = new EvMypageFavortsRequestDto();
            evMypageFavortsRequestDto.setFavorts_cust_id(list.get(0).getCust_id());

            if(loginInfoDto != null && loginInfoDto.getCust_id() != null) {
                evMypageFavortsRequestDto.setCust_id(loginInfoDto.getCust_id());
            } else {
                evMypageFavortsRequestDto.setCust_id("");
            }

            List<EvMypageFavortsResponseDto> favoritsList = evMypageFavoritsService.vr_favorits(evMypageFavortsRequestDto);

            String favorit_yn = "";
            if(favoritsList.size() > 0) {
                favorit_yn = "Y";
            } else {
                favorit_yn = "N";
            }

            model.addAttribute("favorit_yn", favorit_yn);

            /* 부스정보 */
            EvMypageCustCorpInfoRequestDto evMypageCustCorpInfoRequestDto = new EvMypageCustCorpInfoRequestDto();
            evMypageCustCorpInfoRequestDto.setCust_id(list.get(0).getCust_id());
            List<EvMypageCustCorpInfoResponseDto> boothList = evMypageCustCorpInfoService.mypage_cust_corp_info(evMypageCustCorpInfoRequestDto);

            List<EvFileAttachResponseDto> attachList = null;
            List<EvFileAttachResponseDto> prodList = new ArrayList<EvFileAttachResponseDto>();
            List<EvFileAttachResponseDto> galleryList = new ArrayList<EvFileAttachResponseDto>();

            String ciImage = "";
            if (boothList.size() > 0) {

                /* 내 부스정보 첨부파일 조회 */
                EvFileAttachRequestDto evFileAttachRequestDto = new EvFileAttachRequestDto();
                evFileAttachRequestDto.setBoard_id(boothList.get(0).getCust_seq());

                attachList = evFileAttachService.file_attach_list(evFileAttachRequestDto);

                for(int i = 0; i < attachList.size(); i++) {

                    if(attachList.get(i).getFile_clsf_dtl_cd().equals("102006")) {
                        //ci
                        ciImage = "/files"+attachList.get(i).getFile_path();
                    } else if(attachList.get(i).getFile_clsf_dtl_cd().equals("102009")) {
                        //제품소개
                        prodList.add(attachList.get(i));
                    } else if(attachList.get(i).getFile_clsf_dtl_cd().equals("102010")) {
                        //갤러리
                        galleryList.add(attachList.get(i));
                    }
                }
            }

            /* 관심뱃지조회 */
            model.addAttribute("c", cust_seq_str);
            model.addAttribute("boothInfo", boothList.get(0));
            model.addAttribute("ci_image", ciImage);
            model.addAttribute("prodList", prodList);
            model.addAttribute("galleryList", galleryList);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "/vr/vr_corp_form";
    }

    /**
     * VR 기업정보 조회
     * @param model
     * @return
     */
    @RequestMapping("/vr/vr_corp_sh")
    public String vr_corp_sh(Model model) {

        return "/vr/vr_corp_sh";
    }
    

    /**
     * PDF Viewer
     * @param model
     * @return
     */
    @RequestMapping("/js/pdfjs/viewer")
    public String viewer(Model model) {

        return "/js/pdfjs/viewer";
    }

    /**
     * VR 로그인
     * @param model
     * @return
     */
    @RequestMapping("/vr/vr_login_form")
    public String vr_login_form(Model model) {

        return "/vr/vr_login_form";
    }

    /**
     * VR상담
     * @param model
     * @return
     */
    @RequestMapping("/vr/vr_coslt_form")
    public String vr_coslt_form(HttpServletRequest request, Model model) {

        String returnUrl = "/vr/vr_coslt_form";
        returnUrl = request.getRequestURL().append('?').append(request.getQueryString()).toString();
        logger.info("returnUrl:"+returnUrl);
        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
            request.getSession().setAttribute("url_prior_login", returnUrl);
            //임시주석처리
            //return "redirect:/vr/vr_login_form";
        }

        try {
            /* 기업명조회 */
            String cust_seq_str = request.getParameter("c");
            Long cust_seq = SecureUtils.base62Decoding(cust_seq_str) / SecureUtils.vr_cust_seq_const;

            EvMemberSearchDto evMemberSearchDto = new EvMemberSearchDto();
            evMemberSearchDto.setCust_seq(cust_seq);
            List<EvMemberResposeDto> list = evMemberService.search_cust_info_seq(evMemberSearchDto);

            model.addAttribute("c", cust_seq_str);
            model.addAttribute("custInfo", list.get(0));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "/vr/vr_coslt_form";
    }

    /**
     * 마이페이지 - 참관 - 즐겨찾기
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp01")
    public String myp01(Model model) {

        return "/mypage/myp01";
    }

    /**
     * 관심 뱃지 내역
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp02")
    public String myp02(Model model) {

        return "/mypage/myp02";
    }

    /**
     * 삼담문의 내역
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp03")
    public String myp03(Model model) {

        return "/mypage/myp03";
    }

    /**
     * 삼담문의 내역 상세
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp031")
    public String myp031(@RequestParam("board_id") String board_id, Model model) {

        model.addAttribute("board_id", board_id);
        model.addAttribute("page_clsf", "myp03");

        return "/mypage/myp031";
    }

    /**
     * 개인정보동의 이동
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp061")
    public String myp061(Model model) {

        EvMailSndRequestDto evMailSndRequestDto = new EvMailSndRequestDto();

        /* 이용약관 */
        EvBoardSearchDto evBoardSearchDto = new EvBoardSearchDto();
        evBoardSearchDto.setBoard_clsf_cd("101007");
        List <EvBoardTermsResponseDto> formList = evBoardService.terms_detail(evBoardSearchDto);
        String agree1 = formList.get(0).getBoard_content();
        String agree1en = formList.get(0).getBoard_content2();

        /* 개인정보처리방침 */
        evBoardSearchDto.setBoard_clsf_cd("101006");
        formList = evBoardService.terms_detail(evBoardSearchDto);
        String agree2 = formList.get(0).getBoard_content();
        String agree2en = formList.get(0).getBoard_content2();

        model.addAttribute("agree1_contents", agree1);
        model.addAttribute("agree2_contents", agree2);

        model.addAttribute("agree1_contents_en", agree1en);
        model.addAttribute("agree2_contents_en", agree2en);

        model.addAttribute("page_clsf", "myp06");

        return "/mypage/myp061";
    }

    /**
     * 상담문의내역 - 기업 참가
     * @param board_id
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myc041")
    public String myc041(@RequestParam("board_id") String board_id, Model model) {

        model.addAttribute("board_id", board_id);
        model.addAttribute("page_clsf", "myc04");

        return "/mypage/myc041";
    }    

    /**
     * 정보수정
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp04")
    public String myp04(HttpServletRequest request, Model model) {

        String returnUrl = "/mypage/myp04";
        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        /* 연령대 */
        EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
        evCommCodeRequestDto.setUpper_cd_id("204000");
        List<EvCommCodeResponseDto> ageList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

        model.addAttribute("ageList", ageList);

        /* 방문목적 */
        evCommCodeRequestDto = new EvCommCodeRequestDto();
        evCommCodeRequestDto.setUpper_cd_id("205000");
        List<EvCommCodeResponseDto> visitPupsList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

        model.addAttribute("visitPupsList", visitPupsList);

        if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
            returnUrl = "/member/login_form";
            return returnUrl;
        }

        model.addAttribute("page_clsf", "myp04");
        return returnUrl;
    }

    /**
     * 비밀번호변경
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp05")
    public String myp05(Model model) {

        model.addAttribute("page_clsf", "myp05");
        return "/mypage/myp05";
    }

    /**
     * 개인정보 재동의
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp06")
    public String myp06(Model model) {

        model.addAttribute("page_clsf", "myp06");
        return "/mypage/myp06";
    }

    /**
     * 회원탈퇴
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp07")
    public String myp07(Model model) {

        model.addAttribute("page_clsf", "myp07");
        return "/mypage/myp07";
    }

    /**
     * 마이페이지 - 참가 내부스정보등록
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myc01")
    public String myc01(Model model) {

        model.addAttribute("page_clsf", "myc01");
        return "/mypage/myc01";
    }

    /**
     * 마이페이지 - 참가 즐겨찾기내역
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myc02")
    public String myc02(Model model) {

        model.addAttribute("page_clsf", "myc02");
        return "/mypage/myc02";
    }

    /**
     * 마이페이지 - 참가 상담문의 내역
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myc03")
    public String myc03(Model model) {

        model.addAttribute("page_clsf", "myc03");
        return "/mypage/myc03";
    }

    /**
     * 마이페이지 - 참가 상담문의 내역 상세
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myc031")
    public String myc031(Model model) {

        model.addAttribute("page_clsf", "myc03");
        return "/mypage/myc031";
    }

    /**
     * 마이페이지-참가 내정보수정
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myc05")
    public String myc05(Model model) {

        model.addAttribute("page_clsf", "myc05");
        return "/mypage/myc05";
    }

    @RequestMapping("/m.do")
    public String mgny_log(Model model) {

        return "/mgnt/login";
    }

    /**
     * 다국어 변경
     * @param locale
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/index/lang", method = RequestMethod.GET)
    public String lang(Locale locale, HttpServletRequest request, Model model) {

        HttpSession httpSession = request.getSession();
        httpSession.setAttribute("LANG", request.getParameter("lang"));

        // RequestMapingHandler로 부터 받은 Locale 객체를 출력해 봅니다.
        model.addAttribute("clientLocale", locale);

        // localeResolver 로부터 Locale 을 출력해 봅니다.
        model.addAttribute("sessionLocale", localeResolver.resolveLocale(request));

        // JSP 페이지에서 EL 을 사용해서 arguments 를 넣을 수 있도록 값을 보낸다.
        //model.addAttribute("siteCount", messageSource.getMessage("msg.first", null, locale));

        return "index";
    }

    /**
     * 공통코드를 조회한다.
     * @return
     */
    @ResponseBody
    @PostMapping("/member/com_cd")
    public Map<String, Object> comm_code(@RequestBody Map<String, String> param) {
        Map resposeResult = new HashMap();

        try {
            /* 카테고리조회 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id(param.get("UPPER_CD"));
            evCommCodeRequestDto.setUse_yn("Y");
            List<EvCommCodeResponseDto> category = evCommCodeService.comm_code_search(evCommCodeRequestDto);
            resposeResult.put("C"+param.get("UPPER_CD"), category);

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
     * 가이드
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/index/guide")
    public String guide(Model model, HttpServletRequest request) {

        String return_url = "/guide";
        HttpSession httpSession = request.getSession();
        String lang = String.valueOf(httpSession.getAttribute("LANG"));

        if(lang.equals("en")) {
            return_url = "/guideEn";
        }

        model.addAttribute("c", StringUtils.nvl(request.getParameter("c"),"guide"));

        return return_url;
    }

    @RequestMapping("/index/test")
    public String ieve2021testtest(Model model, HttpServletRequest request) {
        String return_url = "/test";

        return return_url;
    }

    /**
     * 메뉴에 클릭 시 로그 입력
     * @param evAccessMenuRequestDto
     * @param session
     * @return
     */
    @ResponseBody
    @PostMapping("/index/loginsert")
    public Map<String, Object> loginsertpost(@RequestBody EvAccessMenuRequestDto evAccessMenuRequestDto, HttpSession session) {
        Map resposeResult = new HashMap();

        try {
            EvMemberLoginInfoDto cust = (EvMemberLoginInfoDto)session.getAttribute(StringUtils.login_session);

            if(cust != null) {
                evAccessMenuRequestDto.setAccess_cust_id(StringUtils.nvl(cust.getCust_id(),""));
            } else {
                evAccessMenuRequestDto.setAccess_cust_id("");
            }

            evAccessMenuRequestDto.setAccess_menu_cd(evAccessMenuRequestDto.getCd());

            /* 고객순번 */
            String c = evAccessMenuRequestDto.getC();
            Long cust_seq = SecureUtils.base62Decoding(c) / SecureUtils.vr_cust_seq_const;
            evAccessMenuRequestDto.setPtcp_cust_seq(cust_seq);

            /* 메뉴접속로그입력 */
            evCommCodeService.menu_access_log_insert(evAccessMenuRequestDto);

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
     * VR 로그인팝업
     * @param model
     * @return
     */
    @RequestMapping("/vr/login_popup")
    public String vr_login_popup(Model model, HttpServletRequest request) {

        String returnUrl = "/vr/login_popup";
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
            model.addAttribute("login_id", "");
            model.addAttribute("login", request.getParameter("login"));
            request.getSession().setAttribute("url_prior_login", returnUrl);
        } else {
            model.addAttribute("login", "");
            model.addAttribute("login_id", loginInfoDto.getCust_id());
        }

        return "/vr/vr_login_popup";
    }

}
