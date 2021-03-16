package kr.coevolution.vr.member;

import kr.coevolution.vr.comm.util.SecureUtils;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.dto.EvMemberLoginRequestDto;
import kr.coevolution.vr.member.dto.EvMemberResposeDto;
import kr.coevolution.vr.member.dto.EvMemberSearchDto;
import kr.coevolution.vr.member.service.EvMemberService;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@NoArgsConstructor
@RestController
public class EvMemberController {

    @Autowired
    private EvMemberService evMemberService;

    Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * 회원중복체크
     * @param evMemberSearchDto
     * @return
     */
    @PostMapping("/member/dup")
    public Map<String,Object> member_dup_chk(@RequestBody EvMemberSearchDto evMemberSearchDto) {
        Map resposeResult = new HashMap();

        try {
            if ("".equals(StringUtils.nvl(evMemberSearchDto.getCust_id(), ""))) {

                resposeResult.put("dup_yn", "Y");
                resposeResult.put("result_code", "-98");
                resposeResult.put("result_msg", "ID없음!!");

            } else {
                List<EvMemberResposeDto> evMemberResposeDtoList = evMemberService.search_dup(evMemberSearchDto);

                EvMemberResposeDto evMemberResposeDto = evMemberResposeDtoList.get(0);
                int cnt = evMemberResposeDto.getCnt();

                if (cnt > 0) {
                    resposeResult.put("dup_yn", "Y");
                } else {
                    resposeResult.put("dup_yn", "N");
                }

                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");
            }

        } catch (Exception e) {

            resposeResult.put("dup_yn", "Y");
            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }


        return resposeResult;
    }

    /**
     * 회원가입
     * @param map
     * @return
     */
    @PostMapping("/member/insert")
    public Map<String,Object> member_insert(@RequestBody Map map) {

        Map resposeResult = new HashMap();

        log.debug(map.toString());

        try {

            int result_code = evMemberService.member_insert(map);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 로그인
     * @param evMemberLoginRequestDto
     * @param session
     * @return
     */
    @PostMapping("/member/login")
    public Map<String,Object> member_login(@RequestBody EvMemberLoginRequestDto evMemberLoginRequestDto, HttpSession session) {
        Map resposeResult = new HashMap();

        /*
            (개발) 로그인 후 접속 시 제어 필요
         */

        logger.info("member_login post start");

        try {
            /* 패스워드를 암호화하여 비교한다. */
            String userPw = evMemberLoginRequestDto.getUser_pw();
            userPw = SecureUtils.getSecurePassword(userPw);
            evMemberLoginRequestDto.setUser_pw(userPw);

            logger.info("member_login password secure end");

            List<EvMemberLoginInfoDto> evMemberLoginInfoDtoList = evMemberService.search_login(evMemberLoginRequestDto);

            logger.info("member_login search_login end");

            if(evMemberLoginInfoDtoList.size() == 1) {

                /* sesstion 정보 입력 */
                session.setAttribute(StringUtils.login_session, evMemberLoginInfoDtoList.get(0));

                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");
            } else {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "로그인정보가 정확하지 않습니다.");
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }
}
