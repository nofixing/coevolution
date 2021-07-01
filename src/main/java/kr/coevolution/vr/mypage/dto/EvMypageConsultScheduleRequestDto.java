package kr.coevolution.vr.mypage.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMypageConsultScheduleRequestDto {
    private Long schedule_id;
    private Long consult_time_id;
    private String consult_dt;
    private String consult_time_cd;
    private String consult_rsv_cust_id;
    private String consult_avail_yn;
    private String remarks;
    private String del_yn;
    private String user_id;
    private int ev_expo_id;
}
