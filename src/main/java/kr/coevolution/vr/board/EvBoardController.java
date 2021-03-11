package kr.coevolution.vr.board;

import kr.coevolution.vr.board.dto.EvBoardRequestDto;
import kr.coevolution.vr.board.service.EvBoardService;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@NoArgsConstructor
@Controller
public class EvBoardController {

    @Autowired
    private EvBoardService evBoardService;

    @PostMapping("/board/reg")
    @ResponseBody
    public Map<String,Object> insert (@RequestPart List<MultipartFile> files, EvBoardRequestDto evBoardRequestDto) {

        Map resposeResult = new HashMap();

        log.debug("evBoardRequestDto => " + evBoardRequestDto);

        try {
            /* 첨부파일 오류 시 게시판 rollback 안됨.. */
            int return_code = evBoardService.insert(evBoardRequestDto, files);

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
