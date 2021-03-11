package kr.coevolution.vr.member.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EvMemberBadgeRequestDto {
    private Long badge_id;
    private String cust_id;
    private String give_cust_id;
    private String badge_clsf_cd;
    private String badge_cnt;
    private String user_id;
}
