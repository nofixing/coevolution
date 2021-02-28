package kr.coevolution.vr.comm;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ResposeResult {

    private String result_cd;
    private String result_msg;
    private Object result_data;

}
