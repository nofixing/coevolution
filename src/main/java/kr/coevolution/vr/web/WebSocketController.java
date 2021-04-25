package kr.coevolution.vr.web;

import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.mgnt.dto.EvMgntMemberResponseDto;
import kr.coevolution.vr.mgnt.dto.EvMgntZoomRequestDto;
import kr.coevolution.vr.mgnt.dto.EvMgntZoomResposeDto;
import kr.coevolution.vr.mgnt.service.EvMgntService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class WebSocketController  {

    @Autowired
    private EvMgntService evMgntService;

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

}
