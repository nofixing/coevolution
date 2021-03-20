package kr.coevolution.vr.mypage.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EvMypageBadgeResponseDto {
    private String rn;
    private String cust_id;
    private String cust_nm;
    private Long badge_id;
    private String give_cust_id;
    private String badge_clsf_nm;
    private String badge_conts;
    private int badge_recv_cnt; /* 받은개수*/
    private int badge_use_cnt; /* 사용개수 */
    private String ins_dt;
    private Long row_count; /* 조회된 row 개수 */
    private int tot_badge;  /* 개인이 보유하고 있는 뱃지 개수 */
    private int sum_badge_cnt; /* 기업에서 받은 뱃지 개수 */
}
