package kr.coevolution.vr.config.auth;

import kr.coevolution.vr.comm.dto.EvExpoResponseDto;
import kr.coevolution.vr.comm.service.EvExpoService;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.config.auth.dto.OAuthAttributes;
import kr.coevolution.vr.config.auth.dto.SessionUser;
import kr.coevolution.vr.domain.user.User;
import kr.coevolution.vr.domain.user.UserRepository;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.dto.EvMemberLoginRequestDto;
import kr.coevolution.vr.member.service.EvMemberService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.Collections;
import java.util.List;

@RequiredArgsConstructor
@Service
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {

    @Autowired
    private EvMemberService evMemberService;

    @Autowired
    private EvExpoService evExpoService;

    private final UserRepository userRepository;
    private final HttpSession httpSession;

    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        logger.info("CustomOAuth2UserService loadUser is called");

        OAuth2UserService<OAuth2UserRequest, OAuth2User> delegate = new DefaultOAuth2UserService();
        OAuth2User oAuth2User = delegate.loadUser(userRequest);

        // 현재 로그인 진행 중인 서비스를 구분하는 코드
        String registrationId = userRequest
                .getClientRegistration()
                .getRegistrationId();

        // oauth2 로그인 진행 시 키가 되는 필드값
        String userNameAttributeName = userRequest.getClientRegistration()
                .getProviderDetails()
                .getUserInfoEndpoint()
                .getUserNameAttributeName();

        // OAuthAttributes: attribute를 담을 클래스 (개발자가 생성)
        OAuthAttributes attributes = OAuthAttributes
                .of(registrationId, userNameAttributeName, oAuth2User.getAttributes());

        User user = saveOrUpdate(attributes);

        // SessioUser: 세션에 사용자 정보를 저장하기 위한 DTO 클래스 (개발자가 생성)
        httpSession.setAttribute("user", new SessionUser(user));

        logger.info("url_prior_login:"+httpSession.getAttribute("url_prior_login"));

        EvMemberLoginRequestDto evMemberLoginRequestDto = new EvMemberLoginRequestDto();

        if ("/member/join_form2".equals(httpSession.getAttribute("url_prior_login"))) {
            evMemberLoginRequestDto.setCust_id(user.getEmail());
            List<EvMemberLoginInfoDto> evMemberLoginInfoDtoList = evMemberService.search_login_email_check(evMemberLoginRequestDto);
            if(evMemberLoginInfoDtoList.size() == 1) {
                httpSession.setAttribute("email_check", "dup_email");
            }
        } else {
            evMemberLoginRequestDto.setReg_provider(user.getProvider());
            if ("google".equals(user.getProvider())) {
                evMemberLoginRequestDto.setGoogle_email(user.getEmail());
            } else if ("naver".equals(user.getProvider())) {
                evMemberLoginRequestDto.setNaver_email(user.getEmail());
            } else if ("kakao".equals(user.getProvider())) {
                evMemberLoginRequestDto.setKakao_email(user.getEmail());
            } else if ("facebook".equals(user.getProvider())) {
                evMemberLoginRequestDto.setFacebook_email(user.getEmail());
            }

            List<EvMemberLoginInfoDto> evMemberLoginInfoDtoList = evMemberService.search_login_social(evMemberLoginRequestDto);

            if (evMemberLoginInfoDtoList.size() == 1) {
                logger.info("소셜 로그인으로 회원가입한 회원의 회원정보 세션 저장");
                httpSession.setAttribute("social_login_yn", "Y");
                httpSession.setAttribute(StringUtils.login_session, evMemberLoginInfoDtoList.get(0));

                /* sesstion 정보 입력 expo 정보 */
                List<EvExpoResponseDto> expoInfoList =  evExpoService.expo_info_search();
                httpSession.setAttribute(StringUtils.expo_info_session, expoInfoList.get(0));

            } else {
                logger.info("소셜 로그인정보 없음");
                httpSession.setAttribute("social_login_yn", "N");
            }
        }

        return new DefaultOAuth2User(
                Collections.singleton(new SimpleGrantedAuthority(user.getRoleKey())),
                attributes.getAttributes(),
                attributes.getNameAttributeKey()
        );
    }

    private User saveOrUpdate(OAuthAttributes attributes) {

        logger.info("CustomOAuth2UserService saveOrUpdate is called");

        User user = userRepository.findByEmailAndProvider(attributes.getEmail(), attributes.getProvider())
                .map(entity -> entity.update(attributes.getName(), attributes.getPicture()))
                .orElse(attributes.toEntity());

        return userRepository.save(user);
    }

}