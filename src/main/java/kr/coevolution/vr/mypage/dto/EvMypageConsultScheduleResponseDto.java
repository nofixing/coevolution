package kr.coevolution.vr.mypage.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMypageConsultScheduleResponseDto {

    private Long ev_expo_id;
    private Long schedule_id;
    private Long consult_time_id;
    private String consult_dt;
    private String consult_time_cd;
    private String consult_time_nm;
    private String consult_rsv_cust_id;
    private String consult_rsv_cust_nm;
    private String consult_avail_yn;
    private String user_id;
    private String cust_id;
    private String cust_nm;
    private String consult_rsv_stat_cd;
    private String tel_no;
    private String consult_cust_id;
    private String consult_cust_nm;
    private String del_yn;

}
