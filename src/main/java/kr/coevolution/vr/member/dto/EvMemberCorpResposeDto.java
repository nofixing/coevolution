package kr.coevolution.vr.member.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMemberCorpResposeDto {
    private String cust_id;
    private String cust_nm;
    private String category1;
    private String category1_nm;
    private String category2;
    private String category3;
    private String vr_shortcut_url;
    private String favorts_yn;
    private String badge_yn;
    private String ci_url;
    private int badge_sum;
    private Long row_count;     /* 총 row  */
}
