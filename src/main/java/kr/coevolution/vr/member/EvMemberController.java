package kr.coevolution.vr.member;

import kr.coevolution.vr.comm.dto.EvCommCodeRequestDto;
import kr.coevolution.vr.comm.dto.EvCommCodeResponseDto;
import kr.coevolution.vr.comm.service.EvCommCodeService;
import kr.coevolution.vr.comm.util.SecureUtils;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.config.auth.dto.SessionUser;
import kr.coevolution.vr.email.dto.EvMailSndRequestDto;
import kr.coevolution.vr.email.dto.EvMailSndResposeDto;
import kr.coevolution.vr.email.service.EvMailSndService;
import kr.coevolution.vr.member.dto.*;
import kr.coevolution.vr.member.service.EmailService;
import kr.coevolution.vr.member.service.EvMemberService;
import kr.coevolution.vr.mgnt.service.EvMgntService;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

@Slf4j
@NoArgsConstructor
@RestController
public class EvMemberController {

    @Autowired
    private EvMemberService evMemberService;

    @Autowired
    private EmailService emailService;

    @Autowired
    private EvMailSndService mailSndService;

    @Autowired
    private EvCommCodeService evCommCodeService;

    @Autowired
    AuthenticationManager authenticationManager;

    @Autowired
    private EvMgntService evMgntService;

    @Value("${mail.sender}")
    private String sender;

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

        logger.info("member insert post start");

        log.debug(map.toString());

        try {

            int result_code = evMemberService.member_insert(map);

            resposeResult.put("result_code", result_code);
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

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
    @PostMapping("/member/insert_social")
    public Map<String,Object> member_insert_social(@RequestBody Map map) {

        logger.info("insert_social post start");

        Map resposeResult = new HashMap();

        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession(true);

        SessionUser user = (SessionUser)session.getAttribute("user");

        if(user != null) {
            logger.info("insert_social user is not null => user:"+map.toString());

            StringBuffer temp = new StringBuffer();
            Random rnd = new Random();
            for (int i = 0; i < 10; i++) {
                int rIndex = rnd.nextInt(3);
                switch (rIndex) {
                    case 0:
                        // a-z
                        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
                        break;
                    case 1:
                        // A-Z
                        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
                        break;
                    case 2:
                        // 0-9
                        temp.append((rnd.nextInt(10)));
                        break;
                }
            }

            //logger.info("\nRandom Password: "+temp.toString());

            map.put("cust_id", user.getEmail());
            map.put("cust_pw", temp.toString());
            map.put("cust_pw2", temp.toString());
            map.put("cust_origin", "nkfg");

            if ("google".equals(user.getProvider())) {
                map.put("google_email", user.getEmail());
                map.put("reg_provider", "google");
            } else if ("naver".equals(user.getProvider())) {
                map.put("naver_email", user.getEmail());
                map.put("reg_provider", "naver");
            } else if ("kakao".equals(user.getProvider())) {
                map.put("kakao_email", user.getEmail());
                map.put("reg_provider", "kakao");
            } else if ("facebook".equals(user.getProvider())) {
                map.put("facebook_email", user.getEmail());
                map.put("reg_provider", "facebook");
            }

            try {
                logger.info("insert_social evMemberService.member_insert before");
                int result_code = evMemberService.member_insert(map);

                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");

            } catch (Exception e) {

                resposeResult.put("result_code", "-99");
                resposeResult.put("result_msg", "입력실패!!");

                e.printStackTrace();
            }
        } else {
            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");
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
    public Map<String,Object> member_login(@RequestBody EvMemberLoginRequestDto evMemberLoginRequestDto, HttpSession session, HttpServletRequest request) {
        Map resposeResult = new HashMap();
        String msg = "";

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

                UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(evMemberLoginRequestDto.getCust_nm(), userPw);

                // Authenticate the user
                Authentication authentication = authenticationManager.authenticate(authRequest);
                SecurityContext securityContext = SecurityContextHolder.getContext();
                securityContext.setAuthentication(authentication);

                // Create a new session and add the security context.
                session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);

                //로그인했을경우 url_prior_login = "" 셋팅
                session.setAttribute("url_prior_login", "");

                resposeResult.put("cust_clsf_cd", evMemberLoginInfoDtoList.get(0).getCust_clsf_cd());
                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");
            } else {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "로그인정보가 정확하지 않습니다.");
            }

        } catch (Exception e) {
            msg = e.toString();
            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }finally {
            try {

                String ip = StringUtils.getRemoteIP(request);

                Map<String, String> map = new HashMap<String, String>();
                map.put("cust_id", evMemberLoginRequestDto.getUser_id());
                map.put("ip", ip);
                map.put("rmk", String.valueOf(resposeResult.get("result_code")) + " : " + String.valueOf(resposeResult.get("result_msg")) + "\r\n"+msg);

                evMgntService.login_log(map);

            } catch (Exception e2){}

        }

        return resposeResult;
    }

    /**
     * 아이디 찾기
     * @param evMemberLoginRequestDto
     * @return
     */
    @PostMapping("/member/search_id")
    public Map<String,Object> search_id(@RequestBody EvMemberLoginRequestDto evMemberLoginRequestDto) {
        Map resposeResult = new HashMap();

        logger.info("search_id post start");

        try {
            List<EvMemberLoginInfoDto> evMemberLoginInfoDtoList = evMemberService.search_id(evMemberLoginRequestDto);

            if(evMemberLoginInfoDtoList.size() == 1) {

                resposeResult.put("cust_id", evMemberLoginInfoDtoList.get(0).getCust_id());
                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");
            } else {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "입력정보가 정확하지 않습니다.");
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 비밀번호 찾기
     * @param evMemberLoginRequestDto
     * @return
     */
    @PostMapping("/member/passwd_init")
    public Map<String,Object> passwd_init(@RequestBody EvMemberLoginRequestDto evMemberLoginRequestDto)
            throws UnsupportedEncodingException, MessagingException {

        Map resposeResult = new HashMap();

        logger.info("passwd_init post start");

        evMemberLoginRequestDto.setCust_id(evMemberLoginRequestDto.getCust_id_pw());
        evMemberLoginRequestDto.setCust_nm(evMemberLoginRequestDto.getCust_nm_pw());
        evMemberLoginRequestDto.setEmail_id(evMemberLoginRequestDto.getEmail_id_pw());

        try {
            EvMailSndRequestDto evMailSndRequestDto = new EvMailSndRequestDto();
            List<EvMemberLoginInfoDto> evMemberLoginInfoDtoList = evMemberService.search_pw(evMemberLoginRequestDto);

            if (evMemberLoginInfoDtoList == null || evMemberLoginInfoDtoList.size() != 1) {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "입력정보가 정확하지 않습니다.");
            } else {
                try {

                    StringBuffer temp = new StringBuffer();
                    Random rnd = new Random();
                    for (int i = 0; i < 10; i++) {
                        int rIndex = rnd.nextInt(3);
                        switch (rIndex) {
                            case 0:
                                // a-z
                                temp.append((char) ((int) (rnd.nextInt(26)) + 97));
                                break;
                            case 1:
                                // A-Z
                                temp.append((char) ((int) (rnd.nextInt(26)) + 65));
                                break;
                            case 2:
                                // 0-9
                                temp.append((rnd.nextInt(10)));
                                break;
                        }
                    }

                    /* 이메일 내용 조회 */
                    evMailSndRequestDto.setEmail_form_id(1);
                    List<EvMailSndResposeDto> formList = mailSndService.searchMailForm(evMailSndRequestDto);

                    String content = formList.get(0).getEmail_form();
                    content = content.replace("#passwd#", temp.toString());

                    String title = "임시비밀번호 안내";
                    //String content = "회원님의 임시비밀번호는 "+temp.toString()+" 입니다.\n";
                    //content += "임시비밀번호로 로그인 하신후 보안을 위해 비밀번호를 변경하시기를 바랍니다.\n";
                    //content += "감사합니다.";

                    String receiver = evMemberLoginRequestDto.getEmail_id();
                    EmailDto email = new EmailDto(title, content, sender, receiver);

                    String sndYn = "";
                    try {
                        emailService.send(email);
                        sndYn = "Y";
                    }catch (Exception e) {
                        logger.error("email send error: "+e.toString());
                        sndYn = "N";
                    }finally {
                        /* 이메일로그생성 */
                        evMailSndRequestDto.setRcv_snd_yn(sndYn);
                        evMailSndRequestDto.setUser_id(evMemberLoginRequestDto.getCust_id());
                        evMailSndRequestDto.setCust_id(evMemberLoginRequestDto.getCust_id());
                        evMailSndRequestDto.setRcv_email_id(receiver);
                        evMailSndRequestDto.setRcv_title_nm(title);
                        evMailSndRequestDto.setRcv_email_conts(content);

                        mailSndService.eMailsendLog (evMailSndRequestDto);
                    }

                    String userPw = SecureUtils.getSecurePassword(temp.toString());
                    evMemberLoginRequestDto.setUser_change_pw1(userPw);


                    evMemberService.member_passwd_init(evMemberLoginRequestDto);

                    resposeResult.put("result_code", "0");
                    resposeResult.put("result_msg", "성공!!");

                    logger.info("passwd_init post end");

                } catch (Exception e) {

                    resposeResult.put("result_code", "-99");
                    resposeResult.put("result_msg", "입력실패!!");

                    e.printStackTrace();
                }
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        logger.info("passwd_init post end resposeResult: "+resposeResult.get("result_code"));

        return resposeResult;
    }

    /**
     * 회원가입 폼 공통코드 조회
     * @param evMemberLoginRequestDto
     * @return
     */
    @PostMapping("/member/search_join_com_code")
    public Map<String,Object> search_join_code(@RequestBody EvMemberLoginRequestDto evMemberLoginRequestDto) {
        
        Map resposeResult = new HashMap();

        try {
            /* 국가코드조회 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("212000");
            evCommCodeRequestDto.setUse_yn("Y");
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

            resposeResult.put("countrylist", countrylist);
            resposeResult.put("list1", list1);
            resposeResult.put("list2", list2);
            resposeResult.put("list3", list3);
            resposeResult.put("list4", list4);
            resposeResult.put("list5", list5);

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
     * 참여기업 검색 팝업
     * @param evMemberSearchDto
     * @return
     */
    @PostMapping("/member/search_corp_search")
    public Map<String,Object> search_corp_search(@RequestBody EvMemberSearchDto evMemberSearchDto, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto != null && !"".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                evMemberSearchDto.setUser_id(loginInfoDto.getCust_id());
                evMemberSearchDto.setCust_id(loginInfoDto.getCust_id());
            } else {
                evMemberSearchDto.setUser_id("");
                evMemberSearchDto.setCust_id("");
            }

            /* row 개수 */
            evMemberSearchDto.setPage_row_cnt((long) StringUtils.page_row_corp_cnt);
            Long page_row_start = StringUtils.page_start_row(evMemberSearchDto.getPage_current(), StringUtils.page_row_corp_cnt);
            evMemberSearchDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMemberSearchDto.getPage_current(),""))) {
                evMemberSearchDto.setPage_current(1L);
            }

            List<EvMemberCorpResposeDto> list = evMemberService.search_corp_search(evMemberSearchDto);
            List<EvMemberCorpResposeDto> listCount = evMemberService.search_corp_search_count(evMemberSearchDto);

            /* zoom 리스트 조회 */
            List<EvMemberZoomResposeDto> zoomList = evMemberService.search_zoom_search(evMemberSearchDto);

            resposeResult.put("row_count", listCount.get(0).getRow_count());            /* 총 건수 */
            resposeResult.put("page_row_cnt", evMemberSearchDto.getPage_row_cnt());     /* 페이지 row 개수 */
            resposeResult.put("page_current", evMemberSearchDto.getPage_current());     /* 현재페이지 */

            resposeResult.put("corpList", list);
            resposeResult.put("zoomList", zoomList);
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
