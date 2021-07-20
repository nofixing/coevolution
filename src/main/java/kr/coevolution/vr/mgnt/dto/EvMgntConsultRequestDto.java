package kr.coevolution.vr.mgnt.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMgntConsultRequestDto {

    private String exhibitors_cust_nm;
    private String consult_rsv_cust_nm;
    private String consult_dt_fr;
    private String consult_dt_to;
    private String user_id;
    private String cust_id;
    private int ev_expo_id;

    private Long page_row_start;    /* 조회 시작 row */
    private Long page_row_cnt;      /* 조회 할 개수 */
    private Long page_current;      /* 현재페이지 */

}
