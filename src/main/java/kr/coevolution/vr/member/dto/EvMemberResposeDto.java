package kr.coevolution.vr.member.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMemberResposeDto {
    private Long cust_seq;
    private String cust_id;
    private String user_id;
    private String cust_pw;
    private String cust_clsf_cd;
    private String cust_nm;
    private String company_nm;
    private String dept_nm;
    private String rep_nm;
    private String posn_nm;
    private String gender_cd;
    private String age_cd;
    private String hp_no;
    private String tel_no;
    private String email_id;
    private String country_cd;
    private String city_nm;
    private String zip_code;
    private String addr_1;
    private String addr_2;
    private String visit_pups_cd;
    private String rcmder_cust_id;
    private String agree_1;
    private String agree_dtm_1;
    private String agree1_dtm_fm;
    private String agree1_dt_end;
    private String agree1_dt_expr;
    private String agree_2;
    private String agree_dtm_2;
    private String agree_3;
    private String agree_dtm_3;
    private String google_email;
    private String naver_email;
    private String kakao_email;
    private String facebook_email;
    private String reg_provider;
    private String cust_sts_cd;
    private String cust_sts_nm;
    private String ins_dt;
    private String category1;
    private String category1_value;
    private String category2;
    private String category3;
    private int cnt;
}
