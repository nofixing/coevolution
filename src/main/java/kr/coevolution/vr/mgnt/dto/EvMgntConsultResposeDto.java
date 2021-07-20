package kr.coevolution.vr.mgnt.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMgntConsultResposeDto {
    private Long rn;
    private Long row_count;
    private Long ev_expo_id;
    private Long consult_time_id;
    private String exhibitors_cust_id;
    private String consult_rsv_cust_id;
    private String exhibitors_cust_nm;
    private String consult_rsv_cust_nm;
    private Long s215001_cnt;
    private Long s215002_cnt;
    private Long s215003_cnt;
    private Long s215004_cnt;
}
