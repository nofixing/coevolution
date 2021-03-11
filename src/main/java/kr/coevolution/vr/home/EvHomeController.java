package kr.coevolution.vr.home;

import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.home.dto.EvMemberJoinForm3;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
public class EvHomeController {

    @RequestMapping({"/", "/index"})
    public String index(Model model) {

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
     * 참관등록
     * @param model
     * @return
     */
    @RequestMapping("/member/join_form1")
    public String join_form1(Model model) {

        return "/member/join_form1";
    }

    /**
     * 참관신청
     * @param model
     * @return
     */
    @RequestMapping("/member/join_form2")
    public String join_form2(Model model) {

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
}
