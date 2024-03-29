package kr.coevolution.vr.email.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EvMailSndResposeDto {

    private Long mail_id;
    private Long cust_id;
    private String snd_dt;
    private String rcv_email_id;
    private String rcv_title_nm;
    private String rcv_email_conts;
    private String rcv_snd_yn;
    private String rcv_snd_msg;
    private int email_form_id;
    private String email_form_nm;
    private String email_form;

}
