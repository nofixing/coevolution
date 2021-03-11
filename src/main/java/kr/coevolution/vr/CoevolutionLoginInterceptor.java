package kr.coevolution.vr;

import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Slf4j
@Component
public class CoevolutionLoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession httpSession = request.getSession();

        log.info("CoevolutionLoginInterceptor --> start!!");

        /* 로그인정보 */
        EvMemberLoginInfoDto evMemberLoginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        if(evMemberLoginInfoDto == null || "".equals(StringUtils.nvl(evMemberLoginInfoDto.getUser_id(),""))) {
            log.info("로그인정보 없음.");
            response.getOutputStream().println("login_fails");
            //response.sendRedirect("/login");

            return false;

        } else {
            log.info("로그인 : " + StringUtils.nvl(evMemberLoginInfoDto.getCust_id(),""));
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
