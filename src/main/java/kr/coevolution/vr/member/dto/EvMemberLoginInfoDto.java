package kr.coevolution.vr.member.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EvMemberLoginInfoDto {
    private Long cust_seq;
    private String cust_id;
    private String user_id;
    private String cust_nm;
    private String email_id;
    private String cust_clsf_cd;
    private String mgnt_id;
    private String mgnt_nm;
}
