package kr.coevolution.vr.comm;

import kr.coevolution.vr.comm.dto.EvCommCodeRequestDto;
import kr.coevolution.vr.comm.dto.EvCommCodeResponseDto;
import kr.coevolution.vr.comm.service.EvCommCodeService;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@NoArgsConstructor
@Controller
public class EvCommCdController {

    @Autowired
    private EvCommCodeService evCommCodeService;

    @ResponseBody
    @PostMapping("/comm/code")
    public Map<String,Object> comm_code(@RequestBody EvCommCodeRequestDto evCommCodeRequestDto, HttpSession session) {

        Map resposeResult = new HashMap();

        String msg = "";

        try {
            List<EvCommCodeResponseDto> list =  evCommCodeService.comm_code_search(evCommCodeRequestDto);

            resposeResult.put("codeList", list);
            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {
            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

}
