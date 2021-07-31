package kr.coevolution.vr.comm.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EvAccessMenuRequestDto {
    private String c;   /* 고객순번-base62 */
    private String cd;  /* 공통코드-로그구분 */
    private String access_menu_cd;
    private Long ptcp_cust_seq;
    private String remarks;
    private String access_cust_id;
}
