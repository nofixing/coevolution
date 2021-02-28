package kr.coevolution.vr.config.auth;

import kr.coevolution.vr.domain.user.Role;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@RequiredArgsConstructor
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final CustomOAuth2UserService customOAuth2UserService;

    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        logger.info("SecurityConfig configure is called");

        http
                .csrf().disable()
                .headers().frameOptions().disable()

                .and()
                .authorizeRequests()
                .antMatchers("/", "/css/**", "/images/**", "/js/**", "/h2/**", "/h2-console/**").permitAll()
                .antMatchers("/api/v1/**").hasRole(Role.USER.name())
                .anyRequest().authenticated()

                .and()
                .logout().logoutSuccessUrl("/")

                .and()
                .oauth2Login().userInfoEndpoint().userService(customOAuth2UserService);

    }

}