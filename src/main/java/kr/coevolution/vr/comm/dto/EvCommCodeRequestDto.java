package kr.coevolution.vr.comm.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EvCommCodeRequestDto {
    private String cd_id;
    private String cd_nm;
    private String cd_nm_en;
    private String upper_cd_id;
    private String cd_val1;
    private String cd_val2;
    private String cd_val3;
    private String cd_val4;
    private String cd_val5;
    private String priority;
    private String use_yn;
    private String del_yn;
    private String user_id;
    private String code_clsf1;
    private String code_clsf2;
    private String code_clsf3;
    private String levl;
    private String order_by;
}
