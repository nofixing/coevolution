package kr.coevolution.vr.mypage;

import kr.coevolution.vr.comm.util.SecureUtils;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.dto.EvMemberLoginRequestDto;
import kr.coevolution.vr.member.dto.EvMemberResposeDto;
import kr.coevolution.vr.member.dto.EvMemberSearchDto;
import kr.coevolution.vr.member.service.EvMemberService;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@NoArgsConstructor
@RestController
public class EvMypageMemberController {

    @Autowired
    private EvMemberService evMemberService;

    /**
     * 회원정보 수정
     * @param map
     * @param request
     * @return
     */
    @PostMapping("/mypage/member/update")
    public Map<String,Object> member_update(@RequestBody Map map, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
        map.put("cust_id", loginInfoDto.getCust_id());
        map.put("user_id", loginInfoDto.getCust_id());

        try {

            int result_code = evMemberService.member_update(map);

            if(result_code < 0) {
                throw new RuntimeException();
            }

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
     * 비밀번호 변경
     * @param evMemberLoginRequestDto
     * @param request
     * @return
     */
    @PostMapping("/mypage/member/passwd")
    public Map<String,Object> member_passwd_change(@RequestBody EvMemberLoginRequestDto evMemberLoginRequestDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
        evMemberLoginRequestDto.setUser_id(loginInfoDto.getCust_id());
        evMemberLoginRequestDto.setCust_id(loginInfoDto.getCust_id());

        try {
            int errCd = 0;
            String errMsg = "";

            /* 패스워드를 암호화하여 비교한다. */
            String userCurrentPw = evMemberLoginRequestDto.getUser_current_pw();
            userCurrentPw = SecureUtils.getSecurePassword(userCurrentPw);
            evMemberLoginRequestDto.setUser_pw(userCurrentPw);

            List<EvMemberLoginInfoDto> evMemberLoginInfoDtoList = evMemberService.search_login(evMemberLoginRequestDto);

            if(evMemberLoginInfoDtoList.size() == 1) {
                if(evMemberLoginRequestDto.getUser_change_pw1().equals(evMemberLoginRequestDto.getUser_change_pw2())) {

                    String pw = SecureUtils.getSecurePassword(evMemberLoginRequestDto.getUser_change_pw1());
                    evMemberLoginRequestDto.setUser_change_pw1(pw);

                } else {
                    errCd = 2;
                    errMsg = "새 비밀번호가 같지 않습니다.";
                }
            } else {
                errCd = 1;
                errMsg = "현재 비밀번호가 맞지 않습니다.";
            }
            
            /* 자리수 체크 - 수정필요
            int rtnValue = StringUtils.pwdRegularExpressionChk(evMemberLoginRequestDto.getUser_change_pw1(), evMemberLoginRequestDto.getUser_current_pw(), loginInfoDto.getCust_id());

            if(rtnValue == 1) {
                errCd = 3;
                errMsg = "현재 비밀번호와 다른 비밀번호를 사용하세요.";
            } else if(rtnValue == 2) {
                errCd = 4;
                errMsg = "비밀번호는 영문, 숫자, 특수문자를 혼용하여 6~12자 이내로 입력해주세요.";
            }
            */
            if(errCd == 0) {
                int result_code = evMemberService.member_passwd(evMemberLoginRequestDto);

                if(result_code < 0) {
                    throw new RuntimeException();
                } else {
                    resposeResult.put("result_code", "0");
                    resposeResult.put("result_msg", "성공!!");
                }
            } else {
                resposeResult.put("result_code", errCd);
                resposeResult.put("result_msg", errMsg);
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "현재!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 재동의 조회
     * @param evMemberSearchDto
     * @param request
     * @return
     */
    @PostMapping("/mypage/member/agree_search")
    public Map<String,Object> agree_search(@RequestBody EvMemberSearchDto evMemberSearchDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
        evMemberSearchDto.setUser_id(loginInfoDto.getCust_id());
        evMemberSearchDto.setCust_id(loginInfoDto.getCust_id());

        try {
            List<EvMemberResposeDto> memberResposeDto = evMemberService.search_cust_info(evMemberSearchDto);

            Map<String, String> pMap = new HashMap<String, String>();
            pMap.put("cust_id", loginInfoDto.getCust_id());

            List<Map<String, String>> agreeList = evMemberService.search_cust_agree(pMap);

            resposeResult.put("data", memberResposeDto);
            resposeResult.put("agreeList", agreeList);
            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "현재!!");

            e.printStackTrace();
        }

        return resposeResult;
    }
    
    /**
     * 재동의
     * @param evMemberLoginRequestDto
     * @param request
     * @return
     */
    @PostMapping("/mypage/member/agree_update")
    public Map<String,Object> agree_update(@RequestBody EvMemberLoginRequestDto evMemberLoginRequestDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
        evMemberLoginRequestDto.setUser_id(loginInfoDto.getCust_id());
        evMemberLoginRequestDto.setCust_id(loginInfoDto.getCust_id());

        try {
            int result_code = evMemberService.member_agree(evMemberLoginRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "현재!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 회원탈퇴
     * @param evMemberLoginRequestDto
     * @param request
     * @return
     */
    @PostMapping("/mypage/member/wdrwal")
    public Map<String,Object> member_wdrwal(@RequestBody EvMemberLoginRequestDto evMemberLoginRequestDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
        evMemberLoginRequestDto.setUser_id(loginInfoDto.getCust_id());
        evMemberLoginRequestDto.setCust_id(loginInfoDto.getCust_id());

        try {
            int result_code = evMemberService.member_wdral(evMemberLoginRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "현재!!");

            e.printStackTrace();
        }

        return resposeResult;
    }    

}
