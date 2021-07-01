package kr.coevolution.vr.mypage.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMypageConsultMsgRequestDto {

    private Long consult_msg_id;
    private Long consult_time_id;
    private Long schedule_id;
    private String snd_cust_id;
    private String rcv_cust_id;
    private String message;
    private String rcv_yn;
    private String cust_id;
    private int ev_expo_id;
}
