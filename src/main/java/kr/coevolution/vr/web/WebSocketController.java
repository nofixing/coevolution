package kr.coevolution.vr.web;

import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.mgnt.dto.EvMgntMemberResponseDto;
import kr.coevolution.vr.mgnt.dto.EvMgntZoomRequestDto;
import kr.coevolution.vr.mgnt.dto.EvMgntZoomResposeDto;
import kr.coevolution.vr.mgnt.service.EvMgntService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class WebSocketController  {

    @Autowired
    private EvMgntService evMgntService;

    Logger logger = LoggerFactory.getLogger(this.getClass());
    /**
     * 줌 상담 가능여부 설정
     * @param chatMessage
     * @return
     */
    @MessageMapping("/zoom_use_yn")
    @SendTo("/topic/zoom_use_yn")
    public Map<String, String> sendMessage(Map<String, String> chatMessage) {

        EvMgntZoomRequestDto evMgntZoomRequestDto = new EvMgntZoomRequestDto();
        evMgntZoomRequestDto.setCust_id(chatMessage.get("cust_id"));
        evMgntZoomRequestDto.setUser_id(chatMessage.get("user_id"));

        /* 줌 사용설정 */
        List<EvMgntZoomResposeDto> list = evMgntService.mgnt_zoom_list(evMgntZoomRequestDto);
        evMgntZoomRequestDto.setZoom_url(StringUtils.nvl(chatMessage.get("zoom_url"),""));

        if("".equals(StringUtils.nvl(chatMessage.get("zoom_mgnt_id"),""))) {
            evMgntZoomRequestDto.setUse_yn("Y");
            evMgntService.mgnt_zoom_insert(evMgntZoomRequestDto);
        } else {
            evMgntZoomRequestDto.setZoom_mgnt_id(Long.parseLong(StringUtils.nvl(chatMessage.get("zoom_mgnt_id"),"0")));
            evMgntZoomRequestDto.setUse_yn("N");
            evMgntService.mgnt_zoom_update(evMgntZoomRequestDto);
        }

        return chatMessage;
    }

    /**
     * 상담메시지를 브로드케스팅한다.
     * @param chatMessage
     * @return
     */
    @MessageMapping("/msg")
    @SendTo("/topic/msg")
    public Map<String, String> sendMessage2(Map<String, String> chatMessage) {

        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        logger.info("snd_cust_id => " + chatMessage.get("snd_cust_id"));
        logger.info("rcv_cust_id => " + chatMessage.get("rcv_cust_id"));
        logger.info("message => " + chatMessage.get("message"));

        chatMessage.put("ins_dtm", sf.format(new Date()));

        return chatMessage;
    }

}
