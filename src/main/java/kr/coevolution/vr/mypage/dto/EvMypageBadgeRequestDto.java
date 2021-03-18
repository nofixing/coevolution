package kr.coevolution.vr.mypage.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMypageBadgeRequestDto {
    private String cust_id;
    private String user_id;
    private String ins_dt_fr;
    private String ins_dt_to;
    private String slt_badge_clsf;
    private Long page_row_start;    /* 조회 시작 row */
    private Long page_row_cnt;      /* 조회 할 개수 */
    private Long page_current;      /* 현재페이지 */
}
