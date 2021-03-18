package kr.coevolution.vr.member.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMemberSearchDto {
    /* 고객id/로그인id */
    private String cust_id;
    /* 패스워드 */
    private String cust_pw;

    private String user_id;
}
