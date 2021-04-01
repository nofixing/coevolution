package kr.coevolution.vr.config.auth;

import kr.coevolution.vr.domain.user.Role;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

@RequiredArgsConstructor
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final CustomOAuth2UserService customOAuth2UserService;

    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Bean
    public AuthenticationSuccessHandler successHandler() {
        return new MyCustomLoginSuccessHandler("/");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        logger.info("SecurityConfig configure is called");

        http
                .csrf().disable()
                .headers().frameOptions().disable()

                .and()
                .authorizeRequests()
                .antMatchers("/", "/index", "/index/*", "/css/**", "/images/**", "/image/**", "/js/**", "/h2/**", "/h2-console/**", "/assets/**", "/member/**").permitAll()
                .antMatchers("/vr/vr_login_form","/m.do","/email","/upload/**").permitAll()
                .antMatchers("/vr/vr_corp_sh").permitAll()
                .antMatchers("/google29c9c8f0fdf11de8.html").permitAll()
                .antMatchers("/vr/vr_coslt_form","/vr/vr_corp_form","/vr/conslt/delete","/vr/conslt/reply","/mail/send").permitAll() /* 테스트 후 삭제하기 */
                .antMatchers("/mypage/**").permitAll() /* 테스트 후 삭제하기 */
                .antMatchers("/api/v1/**").hasRole(Role.USER.name())
                .anyRequest().authenticated()

                .and()
                .logout().logoutSuccessUrl("/")

                .and()
                .oauth2Login().userInfoEndpoint().userService(customOAuth2UserService)
                .and()
                .successHandler(successHandler());

    }

}
