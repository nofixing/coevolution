package kr.coevolution.vr.member.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMemberZoomResposeDto {

    private Long zoom_mgnt_id;
    private String zoom_id;
    private String cust_id;
    private String zoom_url;
    private String use_fr_dtm;
    private String use_to_dtm;
    private String use_yn;

}
