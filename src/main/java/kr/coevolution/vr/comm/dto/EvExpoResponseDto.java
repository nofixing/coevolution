package kr.coevolution.vr.comm.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class EvExpoResponseDto implements Serializable  {

    private static final long serialVersionUID = 1496161285068609734L;

    private int ev_expo_id;
    private String ev_expo_nm;
    private String apct_prod_from_dt;
    private String apct_prod_to_dt;
    //private String expo_from_dt;
    //private String expo_to_dt;
    private String expo_consult_from_dt;
    private String expo_consult_to_dt;
    private String use_yn;
    private Long cnt;
    private String sunday;
}
