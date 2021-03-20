package kr.coevolution.vr.home;

import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.config.auth.LoginUser;
import kr.coevolution.vr.config.auth.dto.SessionUser;
import kr.coevolution.vr.home.dto.EvMemberJoinForm3;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.LocaleResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Locale;

@Slf4j
@Controller
public class EvHomeController {

    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    MessageSource messageSource;

    @Autowired
    LocaleResolver localeResolver;

    @RequestMapping({"/", "/index"})
    public String index(Model model, @LoginUser SessionUser user) {

        if(user != null) {
            logger.info("userName:"+user.getName());
            model.addAttribute("userName", user.getName());
            model.addAttribute("userImg", user.getPicture());
        } else {
            logger.info("user is null");
        }

        return "index";
    }

    /**
     * 로그인
     * @param model
     * @return
     */
    @RequestMapping("/member/login_form")
    public String login_form(Model model) {

        return "/member/login_form";
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
     * 아이디찾기결과
     * @param model
     * @return
     */
    @RequestMapping("/member/id_sh_form2")
    public String id_sh_form2(Model model) {

        return "/member/id_sh_form2";
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

        request.getSession().setAttribute("url_prior_login", "/member/join_form2");

        return "/member/join_form1";
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

        SessionUser user = (SessionUser)session.getAttribute("user");

        if(user != null) {
            logger.info("user email:" + user.getEmail());
        }

        return "/member/join_form2";
    }

    /**
     * 회원가입
     * @param evMemberJoinForm3
     * @param model
     * @return
     */
    @RequestMapping("/member/join_form3")
    public String join_form3(EvMemberJoinForm3 evMemberJoinForm3, Model model) {

        String agree_1 = StringUtils.nvl(evMemberJoinForm3.getAgree_1(),"N");
        String agree_2 = StringUtils.nvl(evMemberJoinForm3.getAgree_2(),"N");
        String agree_3 = StringUtils.nvl(evMemberJoinForm3.getAgree_3(),"N");

        /* 필수약관동의가 'N'인 경우 */
        if("N".equals(agree_1) || "N".equals(agree_2)) {
            model.addAttribute("agree_yn", "N");
            return "/member/join_form2";
        } else {
            model.addAttribute("agree_1", agree_1);
            model.addAttribute("agree_2", agree_2);
            model.addAttribute("agree_3", agree_3);

            return "/member/join_form3";
        }
    }

    /**
     * 참가등록
     * @param model
     * @return
     */
    @RequestMapping("/member/join_form4")
    public String join_for4(Model model) {

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
    public String vr_corp_form(Model model) {

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
    public String vr_coslt_form(Model model) {

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

        return "/mypage/myp031";
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

        return "/mypage/myc041";
    }    

    /**
     * 정보수정
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp04")
    public String myp04(Model model) {

        return "/mypage/myp04";
    }

    /**
     * 비밀번호변경
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp05")
    public String myp05(Model model) {

        return "/mypage/myp05";
    }

    /**
     * 개인정보 재동의
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp06")
    public String myp06(Model model) {

        return "/mypage/myp06";
    }

    /**
     * 회원탈퇴
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp07")
    public String myp07(Model model) {

        return "/mypage/myp07";
    }

    /**
     * 마이페이지 - 참가 내부스정보등록
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myc01")
    public String myc01(Model model) {

        return "/mypage/myc01";
    }

    /**
     * 마이페이지 - 참가 즐겨찾기내역
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myc02")
    public String myc02(Model model) {

        return "/mypage/myc02";
    }

    /**
     * 마이페이지 - 참가 상담문의 내역
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myc03")
    public String myc03(Model model) {

        return "/mypage/myc03";
    }

    /**
     * 마이페이지 - 참가 상담문의 내역 상세
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myc031")
    public String myc031(Model model) {

        return "/mypage/myc031";
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

        // RequestMapingHandler로 부터 받은 Locale 객체를 출력해 봅니다.
        model.addAttribute("clientLocale", locale);

        // localeResolver 로부터 Locale 을 출력해 봅니다.
        model.addAttribute("sessionLocale", localeResolver.resolveLocale(request));

        // JSP 페이지에서 EL 을 사용해서 arguments 를 넣을 수 있도록 값을 보낸다.
        //model.addAttribute("siteCount", messageSource.getMessage("msg.first", null, locale));

        return "index";
    }

}
