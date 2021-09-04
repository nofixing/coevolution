package kr.coevolution.vr.mgnt.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMgntExpoResponseDto {
    private int ev_expo_id;
    private int rn;
    private Long row_count;
    private String ev_expo_nm;
    private String apct_prod_from_dt;
    private String apct_prod_to_dt;
    private String expo_from_dt;
    private String expo_from_hrm;
    private String expo_to_dt;
    private String expo_to_hrm;
    private String expo_from_hh;
    private String expo_from_mm;
    private String expo_from_dtm;
    private String expo_to_dtm;
    private String expo_to_hh;
    private String expo_to_mm;
    private String use_yn;
    private String cust_id;
    private String cust_nm;
    private String reg_stat;
    private String consult_time_stat;
}
