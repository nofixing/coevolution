package kr.coevolution.vr.mypage.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMypageBadgeRequestDto {
    private String cust_id;
    private String give_cust_id;
    private String user_id;
    private String ins_dt_fr;
    private String ins_dt_to;
    private String slt_badge_clsf;
    private String category_sh;         /* 관리자 뱃지조회 - 부스 */
    private String category_nm_sh;      /* 관리자 뱃지조회 - 부스 명 */
    private String cust_clsf_sh;        /* 고객구분 */
    private String lang;                /* 언어구분 */
    private Long page_row_start;    /* 조회 시작 row */
    private Long page_row_cnt;      /* 조회 할 개수 */
    private Long page_current;      /* 현재페이지 */
}
