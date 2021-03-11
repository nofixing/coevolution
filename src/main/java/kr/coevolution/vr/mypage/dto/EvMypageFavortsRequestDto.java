package kr.coevolution.vr.mypage.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EvMypageFavortsRequestDto {
    private String cust_id;
    private String favorts_cust_id;
    private String user_id;
    private Long page_row_start;    /* 조회 시작 row */
    private Long page_row_cnt;      /* 조회 할 개수 */
    private Long page_current;      /* 현재페이지 */
}
