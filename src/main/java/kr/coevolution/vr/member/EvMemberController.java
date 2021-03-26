package kr.coevolution.vr.member;

import kr.coevolution.vr.comm.util.SecureUtils;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.config.auth.dto.SessionUser;
import kr.coevolution.vr.email.domain.EvMailSndRepository;
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
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
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
     * 회원가입
     * @param map
     * @return
     */
    @PostMapping("/member/insert_social")
    public Map<String,Object> member_insert_social(@RequestBody Map map) {

        Map resposeResult = new HashMap();

        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession(true);

        SessionUser user = (SessionUser)session.getAttribute("user");

        if(user != null) {
            logger.info(map.toString());

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

                resposeResult.put("cust_clsf_cd", evMemberLoginInfoDtoList.get(0).getCust_clsf_cd());
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

}
