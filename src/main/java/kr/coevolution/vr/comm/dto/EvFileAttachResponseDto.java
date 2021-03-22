package kr.coevolution.vr.comm.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvFileAttachResponseDto {
    private Long attach_id;
    private Long board_id;
    private int board_seq;
    private String file_clsf_cd;
    private String file_clsf_dtl_cd;
    private String file_name;
    private String org_file_name;
    private String file_size;
    private String file_path;
}
