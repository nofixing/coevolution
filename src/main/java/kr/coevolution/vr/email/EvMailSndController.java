package kr.coevolution.vr.email;

import kr.coevolution.vr.email.dto.EvMailSndRequestDto;
import kr.coevolution.vr.email.dto.EvMailSndResposeDto;
import kr.coevolution.vr.email.service.EvMailSndService;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@NoArgsConstructor
@RestController
public class EvMailSndController {

    @Autowired
    private EvMailSndService evMailSndService;

    @PostMapping("/mail/search")
    public List<EvMailSndResposeDto> search (@RequestBody EvMailSndRequestDto evMailSndRequestDto) {
        return evMailSndService.search(evMailSndRequestDto);
    }

    @PostMapping("/mail/send")
    public Map<String,Object> send (@RequestBody EvMailSndRequestDto evMailSndRequestDto) {

        Map resposeResult = new HashMap();

        try {

            int return_code = evMailSndService.send(evMailSndRequestDto);

            if (return_code == 0) {
                resposeResult.put("result_code", return_code);
                resposeResult.put("result_msg", "입력성공!!");
            } else {
                resposeResult.put("result_code", return_code);
                resposeResult.put("result_msg", "입력실패!!");
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        resposeResult.put("data", evMailSndRequestDto);

        return resposeResult;

    }
}
