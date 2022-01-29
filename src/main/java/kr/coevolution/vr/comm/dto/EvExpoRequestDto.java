package kr.coevolution.vr.comm.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EvExpoRequestDto {

    private String cust_id;
    private String tiemzone_cd;
    private String cust_clsf_cd;
    private int ev_expo_id;
}
