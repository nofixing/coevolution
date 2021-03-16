package kr.coevolution.vr.mypage.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EvMypageFavortsResponseDto {
    public Long favorts_id;
    public Long rn;
    private String cust_id;
    private String favorts_cust_id;
    private String favorts_cust_nm;
    private String shortcut_url;
    private Long row_count;     /* 총 row  */
}
