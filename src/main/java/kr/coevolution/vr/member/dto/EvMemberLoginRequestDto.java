package kr.coevolution.vr.member.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EvMemberLoginRequestDto {
    private String user_id;
    private String cust_id;
    private String user_pw;
    private String user_current_pw;
    private String user_change_pw1;
    private String user_change_pw2;
}
