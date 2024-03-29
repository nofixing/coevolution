package kr.coevolution.vr.mgnt.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMgntMemberRequestDto {
    private String mgnt_id;
    private String mgnt_nm;
    private String cust_id;
    private String cust_nm;
    private String user_id;
    private String user_pw;
    private String ins_dt_fr;
    private String ins_dt_to;
    private String keyword;
    private String category1;
    private String cust_clsf_cd;
    private Long page_row_start;    /* 조회 시작 row */
    private Long page_row_cnt;      /* 조회 할 개수 */
    private Long page_current;      /* 현재페이지 */
    private String mode;    /* insert, update 구분 */
    private String mgnt_id_sh;
    private String mgnt_nm_sh;
    private String mgnt_passwd1;
    private String mgnt_passwd2;
    private String mgnt_pw;
    private String access_id;
    private String access_nm;
    private int ev_expo_id;
    private String tot_period;
    private String bf_user_pw;
    private String tobe_passwd1;
    private String tobe_passwd2;
    private String cls; /*10302 개인회원, 10303 SNS회원, 10304 휴면회원, 10305 탈퇴회원*/
}
