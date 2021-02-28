package kr.coevolution.vr.email.service;

import kr.coevolution.vr.email.domain.EvMailSndRepository;
import kr.coevolution.vr.email.dto.EvMailSndRequestDto;
import kr.coevolution.vr.email.dto.EvMailSndResposeDto;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Message.RecipientType;
import java.util.List;

@RequiredArgsConstructor
@Service
@Transactional
public class EvMailSndService {

    @Autowired
    private EvMailSndRepository evMailSndRepository;

    @Autowired
    private JavaMailSenderImpl javaMailSender;

    @Transactional
    public List<EvMailSndResposeDto> search(EvMailSndRequestDto evMailSndRequestDto) {
        return evMailSndRepository.S01(evMailSndRequestDto);
    }

    @Transactional
    public int send(EvMailSndRequestDto evMailSndRequestDto) {

        int return_code = 0;

        try {
            //return_code = sendTextMail(evMailSndRequestDto);
            return_code = sendMimeMail(evMailSndRequestDto);

            if(return_code == 0) {
                evMailSndRequestDto.setRcv_snd_yn("Y");
            } else {
                evMailSndRequestDto.setRcv_snd_yn("N");
            }

            evMailSndRepository.I01(evMailSndRequestDto);

            //강제오류 발생하여 rollback;
            //throw new RuntimeException();

        } catch(Exception e) {
            return_code = -1;
            e.printStackTrace();
            throw e;
        } finally {
            return return_code;
        }
    }

    /**
     * 메일발송 - text
     * @param evMailSndRequestDto
     * @return
     */
    private int sendTextMail(EvMailSndRequestDto evMailSndRequestDto) throws Exception {

        SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
        simpleMailMessage.setFrom("deut0605@live.co.kr");
        simpleMailMessage.setTo(evMailSndRequestDto.getRcv_email_id());
        simpleMailMessage.setSubject(evMailSndRequestDto.getRcv_title_nm());
        simpleMailMessage.setText(evMailSndRequestDto.getRcv_email_conts());

        javaMailSender.send(simpleMailMessage);

        return 0;
    }

    /**
     * 메일발송 - html
     * @param evMailSndRequestDto
     * @return
     * @throws Exception
     */
    private int sendMimeMail(EvMailSndRequestDto evMailSndRequestDto) throws Exception {

        MimeMessage mimeMailMessage = javaMailSender.createMimeMessage();
        mimeMailMessage.setFrom(new InternetAddress("deut0605@live.co.kr"));
        mimeMailMessage.addRecipients(RecipientType.TO, evMailSndRequestDto.getRcv_email_id());
        mimeMailMessage.setSubject(evMailSndRequestDto.getRcv_title_nm());
        mimeMailMessage.setText(evMailSndRequestDto.getRcv_email_conts(), "UTF-8", "html");

        javaMailSender.send(mimeMailMessage);

        return 0;
    }
}
