package kr.coevolution.vr.mypage.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMypageConsultMsgResponseDto {
    private Long consult_msg_id;
    private Long consult_time_id;
    private Long schedule_id;
    private String snd_cust_id;
    private String rcv_cust_id;
    private String message;
    private String rcv_yn;
    private String cust_id;
    private String cust_nm;
    private String ins_dtm;
    private String chat_cnt;
    private String consult_cnt;
    private String consult_time;
}
