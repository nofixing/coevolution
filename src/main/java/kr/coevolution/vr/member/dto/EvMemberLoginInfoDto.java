package kr.coevolution.vr.member.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class EvMemberLoginInfoDto implements Serializable {

    private static final long serialVersionUID = 1496061285068609733L;

    private Long cust_seq;
    private String cust_id;
    private String user_id;
    private String cust_nm;
    private String email_id;
    private String cust_clsf_cd;
    private String mgnt_id;
    private String mgnt_nm;

    public String toString() {
        String userString = "\ncust_id: "+cust_id+"\n";
        userString += "cust_nm: "+cust_nm;

        return userString;
    }
}
