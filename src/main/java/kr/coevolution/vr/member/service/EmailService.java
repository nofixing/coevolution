package kr.coevolution.vr.member.service;

import kr.coevolution.vr.member.dto.EmailDto;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

@Service
public class EmailService {

    @Value("${aws.ses.port}")
    private String smtpPort;

    @Value("${aws.ses.host}")
    private String sesHost;

    @Value("${aws.ses.username}")
    private String sesUsername;

    @Value("${aws.ses.password}")
    private String sesPassword;


    public void send(EmailDto email) throws MessagingException, UnsupportedEncodingException {


        Properties props = System.getProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.port", smtpPort);
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");

        Session session = Session.getDefaultInstance(props);


        System.out.println(email.getSender());
        MimeMessage msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(email.getSender(),"<EMAIL_SENDER_NICKNAME>"));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(email.getReceiver()));
        msg.setSubject(email.getTitle());
        msg.setContent(email.getContent(),"text/html");

        //msg.setHeader("X-SES-CONFIGURATION-SET", "ConfigSet");

        Transport transport = session.getTransport();

        try{
            transport.connect(sesHost, sesUsername, sesPassword);
            transport.sendMessage(msg, msg.getAllRecipients());

        }
        catch (Exception ex) {
            System.out.println("Error message: " + ex.getMessage());
        }
        finally{
            transport.close();
        }
    }
}
