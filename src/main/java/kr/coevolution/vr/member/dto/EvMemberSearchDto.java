package kr.coevolution.vr.member.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMemberSearchDto {
    /* 고객id/로그인id */
    private String cust_id;
    private Long cust_seq;

    /* 패스워드 */
    private String cust_pw;
    private String user_id;
    
    /* 참여기업 검색 */
    private String category;
    private String keyword;
    private Long page_row_start;    /* 조회 시작 row */
    private Long page_row_cnt;      /* 조회 할 개수 */
    private Long page_current;      /* 현재페이지 */
}
