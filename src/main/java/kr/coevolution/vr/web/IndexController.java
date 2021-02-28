package kr.coevolution.vr.web;

import kr.coevolution.vr.config.auth.LoginUser;
import kr.coevolution.vr.config.auth.dto.SessionUser;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@RequiredArgsConstructor
@Controller
public class IndexController {

    private final HttpSession httpSession;

    Logger logger = LoggerFactory.getLogger(this.getClass());

    @GetMapping("/")
    public String index(Model model, @LoginUser SessionUser user) {
        // .............

        if(user != null) {
            logger.info("userName:"+user.getName());
            model.addAttribute("userName", user.getName());
            model.addAttribute("userImg", user.getPicture());
        } else {
            logger.info("user is null");
        }

        return "index";
    }

    // ..................

}