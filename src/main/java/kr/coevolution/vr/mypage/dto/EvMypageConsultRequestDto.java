package kr.coevolution.vr.mypage.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMypageConsultRequestDto {

    private Long schedule_id;
    private Long consult_time_id;
    private int ev_expo_id;
    private String cust_id;
    private String cust_nm;
    private String tel_no;
    private String consult_from_dt;
    private String consult_to_dt;
    private String tiemzone_cd;
    private String consult_from_time;
    private String consult_to_time;
    private String user_id;
    //private String expo_from_dt;
    //private String expo_to_dt;
    private String sunday;
    private String consult_avail_yn;
    private String consult_rsv_stat_cd;
    private String consult_rsv_cust_id;
    private String remarks;
    private String consultCustId;
    private String consultCustNm;
    private String timezone_hhmm_fr;
    private String timezone_hhmm_to;
    private String expo_consult_from_dt;
    private String expo_consult_to_dt;
    private String page_clsf;
    private String sh_cls_cd; /* 상담시간설정 전주, 다음주 구분 */
}
