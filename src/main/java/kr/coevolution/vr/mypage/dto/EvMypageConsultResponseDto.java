package kr.coevolution.vr.mypage.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMypageConsultResponseDto {
    private Long consult_time_id;
    private int ev_expo_id;
    private String cust_id;
    private String consult_from_dt;
    private String consult_to_dt;
    private String tiemzone_cd;
    private String consult_from_time;
    private String consult_to_time;
    private String mod_user;
    private String consult_from_time_org;
    private String consult_to_time_org;
    private String timezone_hhmm_fr;
    private String timezone_hhmm_to;
    private String sunday;
    private String sunday_fm;
}
