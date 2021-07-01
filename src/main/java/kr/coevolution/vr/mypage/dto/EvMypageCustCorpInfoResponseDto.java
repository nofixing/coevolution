package kr.coevolution.vr.mypage.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMypageCustCorpInfoResponseDto {
    private Long info_id;
    private Long cust_seq;
    private Long rn;
    private String cust_id;
    private String cust_nm;
    private String homepage_url;
    private String about_company_kor;
    private String about_company_eng;
    private String video_url;
    private String promtn_url;
    private String scan_3d_url;
    private String comrce_url;
    private Long consult_time_id;
    private int ev_expo_id;
}

