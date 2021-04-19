package kr.coevolution.vr;

import kr.coevolution.vr.comm.service.EvCommCodeService;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@Slf4j
public class CoevolutionLogInterceptor implements HandlerInterceptor {

    @Resource
    private EvCommCodeService evCommCodeService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession httpSession = request.getSession();

        try {
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            Map<String, String> vMap = new HashMap<String, String>();

            if(loginInfoDto != null && !"".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                vMap.put("access_user", loginInfoDto.getCust_id());
            }

            String ip = StringUtils.getRemoteIP(request);

            vMap.put("access_ip", ip);
            vMap.put("access_info", request.getRequestURI());

            evCommCodeService.access_log_insert(vMap);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
