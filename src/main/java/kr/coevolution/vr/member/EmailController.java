package kr.coevolution.vr.member;

import kr.coevolution.vr.member.dto.EmailDto;
import kr.coevolution.vr.member.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.mail.MessagingException;
import java.io.UnsupportedEncodingException;

@RestController
public class EmailController {

    @Autowired
    private EmailService emailService;


    @RequestMapping("/email")
    public String emailSender(@RequestParam("title") String title, @RequestParam("content") String content, @RequestParam("sender")String sender,
                              @RequestParam("receiver")String receiver) throws UnsupportedEncodingException, MessagingException {
        EmailDto email = new EmailDto(title, content, sender, receiver);

        try {
            emailService.send(email);
        }catch (Exception e) {
            System.out.println(e);
        }

        return "Sending Email is success, Please Check your Email.";
    }
}
