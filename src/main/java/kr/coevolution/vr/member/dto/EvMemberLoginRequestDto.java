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
    private String agree_1;
    private String agree_2;
    private String member_wdrwl_rsn;
    private String google_email;
    private String naver_email;
    private String kakao_email;
    private String facebook_email;
    private String reg_provider;
}
