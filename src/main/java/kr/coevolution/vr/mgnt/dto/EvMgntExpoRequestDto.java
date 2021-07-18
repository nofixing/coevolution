package kr.coevolution.vr.mgnt.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMgntExpoRequestDto {
    private int ev_expo_id;
    private String ev_expo_nm;
    private String apct_prod_from_dt;
    private String apct_prod_to_dt;
    private String expo_from_dt;
    private String expo_from_hrm;
    private String expo_from_hh;
    private String expo_from_mm;
    private String expo_to_dt;
    private String expo_to_hrm;
    private String expo_to_hh;
    private String expo_to_mm;
    private String use_yn;
    private String user_id;
    private String expo_dt_fr;
    private String expo_dt_to;
    private String cust_id;
    private Long page_row_start;    /* 조회 시작 row */
    private Long page_row_cnt;      /* 조회 할 개수 */
    private Long page_current;      /* 현재페이지 */
}
