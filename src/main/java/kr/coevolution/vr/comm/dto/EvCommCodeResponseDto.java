package kr.coevolution.vr.comm.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EvCommCodeResponseDto {
    private String cd_id;
    private String cd_nm;
    private String cd_nm_en;
    private String upper_cd_id;
    private String cd_val1;
    private String cd_val2;
    private String cd_val3;
    private String cd_val4;
    private String cd_val5;
    private int priority;
    private String use_yn;
}
