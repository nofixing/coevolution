package kr.coevolution.vr.mypage;

import kr.coevolution.vr.comm.dto.EvCommCodeRequestDto;
import kr.coevolution.vr.comm.dto.EvCommCodeResponseDto;
import kr.coevolution.vr.comm.service.EvCommCodeService;
import kr.coevolution.vr.comm.util.SecureUtils;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.email.dto.EvMailSndRequestDto;
import kr.coevolution.vr.email.dto.EvMailSndResposeDto;
import kr.coevolution.vr.email.service.EvMailSndService;
import kr.coevolution.vr.member.dto.*;
import kr.coevolution.vr.member.service.EmailService;
import kr.coevolution.vr.member.service.EvMemberService;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@NoArgsConstructor
@RestController
public class EvMypageMemberController {

    @Autowired
    private EvMemberService evMemberService;

    @Autowired
    private EvCommCodeService evCommCodeService;

    @Autowired
    private EvMailSndService mailSndService;

    @Autowired
    private EmailService emailService;

    @Value("${mail.sender}")
    private String sender;

    Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * 마이페이지 조회
     * @param map
     * @param request
     * @return
     */
    @PostMapping("/mypage/member/search")
    public Map<String,Object> member_search(@RequestBody Map map, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

        if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
            resposeResult.put("session_yn", "N");
            resposeResult.put("result_code", "-9999");
            resposeResult.put("result_msg", "세션정보없음");
            return resposeResult;
        } else {
            resposeResult.put("session_yn", "Y");
        }

        map.put("cust_id", loginInfoDto.getCust_id());
        map.put("user_id", loginInfoDto.getCust_id());

        try {
            EvMemberSearchDto evMemberSearchDto = new EvMemberSearchDto();
            evMemberSearchDto.setUser_id(loginInfoDto.getCust_id());
            evMemberSearchDto.setCust_id(loginInfoDto.getCust_id());
            evMemberSearchDto.setLang(StringUtils.nvl(httpSession.getAttribute("LANG"),"ko"));

            /* 고객정보조회 */
            List<EvMemberResposeDto> custInfo = evMemberService.search_cust_info(evMemberSearchDto);

            /* 선택항목조회 (관심분야, 종사분야, 업무(구매)권한, 방문목적) */
            List<Map<String, Object>> custIntrst = evMemberService.search_cust_intrst(evMemberSearchDto);

            /* 국가코드조회 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("212000");
            List<EvCommCodeResponseDto> countrylist = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 관심분야 */
            evCommCodeRequestDto.setUpper_cd_id("206000");
            List<EvCommCodeResponseDto> list1 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 종사분야 */
            evCommCodeRequestDto.setUpper_cd_id("207000");
            List<EvCommCodeResponseDto> list2 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 업무(구매)권한 */
            evCommCodeRequestDto.setUpper_cd_id("208000");
            List<EvCommCodeResponseDto> list3 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 방문목적 */
            evCommCodeRequestDto.setUpper_cd_id("209000");
            List<EvCommCodeResponseDto> list4 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 인지경로 */
            evCommCodeRequestDto.setUpper_cd_id("210000");
            List<EvCommCodeResponseDto> list5 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 카테고리 */
            evCommCodeRequestDto.setUpper_cd_id("106000");
            List<EvCommCodeResponseDto> category1 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            resposeResult.put("custInfo", custInfo);
            resposeResult.put("custIntrst", custIntrst);
            resposeResult.put("countrylist", countrylist);
            resposeResult.put("list1", list1);
            resposeResult.put("list2", list2);
            resposeResult.put("list3", list3);
            resposeResult.put("list4", list4);
            resposeResult.put("list5", list5);
            resposeResult.put("category1", category1);
            
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

        /* 관리자 화면에서 수정인 경우 */
        if("Y".equals(StringUtils.nvl(map.get("m_yn"),""))) {
            //cust_id map에 있음.
            loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);
            map.put("user_id", loginInfoDto.getCust_id());
        } else {
            map.put("cust_id", loginInfoDto.getCust_id());
            map.put("user_id", loginInfoDto.getCust_id());
        }

        if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
            resposeResult.put("session_yn", "N");
            resposeResult.put("result_code", "-9999");
            resposeResult.put("result_msg", "세션정보없음");
            return resposeResult;
        } else {
            resposeResult.put("session_yn", "Y");
        }

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
                    errCd = 6;
                    errMsg = "새 비밀번호가 같지 않습니다.";
                }
            } else {
                errCd = 7;
                errMsg = "현재 비밀번호가 맞지 않습니다.";
            }

            if(errCd == 0) {
                /* 비밀번호체크 */
                errCd = StringUtils.pwdRegularExpressionChk(evMemberLoginRequestDto.getUser_change_pw2(), "", loginInfoDto.getCust_id());
            }

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
            evMemberSearchDto.setLang(StringUtils.nvl(httpSession.getAttribute("LANG"),"ko"));
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

        String custId = loginInfoDto.getCust_id();
        String custNm = loginInfoDto.getCust_nm();
        String emailId = loginInfoDto.getEmail_id();

        try {
            int result_code = evMemberService.member_wdral(evMemberLoginRequestDto);

            /* 세션제거 */
            httpSession.invalidate();

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");


            /* 회원탈퇴 이메일 내용 조회 */
            EvMailSndRequestDto evMailSndRequestDto = new EvMailSndRequestDto();
            evMailSndRequestDto.setEmail_form_id(6);

            String sndYn = "";
            EvMemberResposeDto evMemberResposeDto = null;
            String content = "";
            String title = "";
            String receiver = "";

            try {
                List<EvMailSndResposeDto> formList = mailSndService.searchMailForm(evMailSndRequestDto);

                SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
                String nDt = sf.format(new Date());

                content = formList.get(0).getEmail_form();
                content = content.replace("#cust_nm#", custNm);
                content = content.replace("#YYYY#", nDt.substring(0,4));
                content = content.replace("#MM#", nDt.substring(4,6));
                content = content.replace("#DD#", nDt.substring(6,8));

                title = "버추얼아일랜드 탈퇴 안내";

                receiver = emailId;
                EmailDto email = new EmailDto(title, content, sender, receiver);

                emailService.send(email);
                sndYn = "Y";

            }catch (Exception e1) {
                logger.error("email send error: "+e1.toString());
                sndYn = "N";
                e1.printStackTrace();
            }finally {
                try {
                    /* 이메일로그생성 */
                    evMailSndRequestDto.setRcv_snd_yn(sndYn);
                    evMailSndRequestDto.setUser_id(custId);
                    evMailSndRequestDto.setCust_id(custId);
                    evMailSndRequestDto.setRcv_email_id(receiver);
                    evMailSndRequestDto.setRcv_title_nm(title);
                    evMailSndRequestDto.setRcv_email_conts(content);

                    mailSndService.eMailsendLog(evMailSndRequestDto);
                } catch (Exception e1) {
                    logger.error("email 이메일로그생성 error: " + e1.toString());
                    e1.printStackTrace();
                }
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "현재!!");

            e.printStackTrace();
        }

        return resposeResult;
    }    

}
