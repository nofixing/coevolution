package kr.coevolution.vr.mypage.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMypageCustCorpInfoRequestDto {
    private String cust_id;
    private String homepage_url;
    private String about_company_kor;
    private String about_company_eng;
    private String video_url;
    private String promtn_url;
    private String scan_3d_url;
    private String comrce_url;
    private String user_id;
    private Long board_id; //첨부파일
    private Long attach_id; //첨부파일id
    private String file_clsf_cd;
    private String file_clsf_dtl_cd;
    private String file_cust_id;
    private String m_yn;
    private String use_yn;
    private Long zoom_mgnt_id;
    private String zoom_url;
    private String consultCustNm; //업체조회 팝업 (검색어)
    private String search_yn;
}
