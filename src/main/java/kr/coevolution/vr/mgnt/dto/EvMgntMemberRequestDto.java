package kr.coevolution.vr.mgnt.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMgntMemberRequestDto {
    private String cust_id;
    private String user_id;
    private String ins_dt_fr;
    private String ins_dt_to;
    private String keyword;
    private String cust_clsf_cd;
    private Long page_row_start;    /* 조회 시작 row */
    private Long page_row_cnt;      /* 조회 할 개수 */
    private Long page_current;      /* 현재페이지 */
}
