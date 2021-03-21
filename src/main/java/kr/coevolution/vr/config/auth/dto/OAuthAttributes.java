package kr.coevolution.vr.config.auth.dto;

import kr.coevolution.vr.domain.user.Role;
import kr.coevolution.vr.domain.user.User;
import lombok.Builder;
import lombok.Getter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;

@Getter
public class OAuthAttributes {

    private Map<String, Object> attributes;
    private String nameAttributeKey, name, email, provider, picture;

    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Builder
    public OAuthAttributes(Map<String, Object> attributes,
                           String nameAttributeKey,
                           String name, String email, String provider, String picture) {
        this.attributes = attributes;
        this.nameAttributeKey = nameAttributeKey;
        this.name = name;
        this.email = email;
        this.provider = provider;
        this.picture = picture;
    }

    public static OAuthAttributes of(String registrationId, String userNameAttributeName, Map<String, Object> attributes) {
        if("naver".equals(registrationId)) {
            return ofNaver("id", attributes);
        }

        if("facebook".equals(registrationId)) {
            return ofFacebook("id", attributes);
        }

        if("kakao".equals(registrationId)) {
            return ofKakao("id", attributes);
        }

        return ofGoogle(userNameAttributeName, attributes);
    }

    public static OAuthAttributes ofGoogle(String userNameAttributeName,
                                           Map<String, Object> attributes) {
        return OAuthAttributes.builder()
                .name((String) attributes.get("name"))
                .email((String) attributes.get("email"))
                .provider("google")
                .picture((String) attributes.get("picture"))
                .attributes(attributes)
                .nameAttributeKey(userNameAttributeName)
                .build();
    }

    private static OAuthAttributes ofNaver(String userNameAttributeName, Map<String, Object> attributes) {
        Map<String, Object> response = (Map<String, Object>) attributes.get("response");

        return OAuthAttributes.builder()
                .name((String) response.get("name"))
                .email((String) response.get("email"))
                .provider("naver")
                .picture((String) response.get("profile_image"))
                .attributes(response)
                .nameAttributeKey(userNameAttributeName)
                .build();
    }

    private static OAuthAttributes ofFacebook(String userNameAttributeName, Map<String, Object> attributes) {
        System.out.println("ofFacebook attributes:"+attributes.toString());
        //Map<String, Object> response = (Map<String, Object>) attributes.get("response");

        return OAuthAttributes.builder()
                .name((String) attributes.get("name"))
                .email((String) attributes.get("email"))
                .provider("facebook")
                .attributes(attributes)
                .nameAttributeKey(userNameAttributeName)
                .build();
    }

    private static OAuthAttributes ofKakao(String userNameAttributeName, Map<String, Object> attributes) {
        Map<String,Object> response = (Map<String, Object>)attributes.get("kakao_account");
        Map<String, Object> profile = (Map<String, Object>) response.get("profile");
        return OAuthAttributes.builder()
                .name((String)profile.get("nickname"))
                .email((String)response.get("email"))
                .provider("kakao")
                .picture((String)profile.get("profile_image_url"))
                .attributes(attributes)
                .nameAttributeKey(userNameAttributeName)
                .build();
    }

    public User toEntity() {
        return User.builder()
                .name(name)
                .email(email)
                .provider(provider)
                .picture(picture)
                .role(Role.GUEST)
                .build();
    }
}