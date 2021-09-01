package kr.coevolution.vr;

import kr.coevolution.vr.config.auth.LoginUserArgumentResolver;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import java.util.Locale;

@RequiredArgsConstructor
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    private final LoginUserArgumentResolver loginUserArgumentResolver;

    /* SecurityConfig 사용으로 주석처리
    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
        argumentResolvers.add(loginUserArgumentResolver);
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new CoevolutionLoginInterceptor())
                .addPathPatterns("/mypage/**") // 해당 경로에 접근하기 전에 인터셉터가 가로챈다. /member/*
                //.addPathPatterns("/vr/**")
                .excludePathPatterns("/member/login") // 해당 경로는 인터셉터가 가로채지 않는다.
                .excludePathPatterns("/member/dup")
                .excludePathPatterns("/vr/vr_login_form")
                .excludePathPatterns("/mypage/*")
        ;
    }
    */


    /**
     * 다국어 지원
     * @return
     */
    @Bean
    public ReloadableResourceBundleMessageSource messageSource() {

        ReloadableResourceBundleMessageSource source = new ReloadableResourceBundleMessageSource();

        // 메세지 프로퍼티파일의 위치와 이름을 지정한다.
        source.setBasename("classpath:/messages/message");

        // 기본 인코딩을 지정한다.
        source.setDefaultEncoding("UTF-8");

        // 프로퍼티 파일의 변경을 감지할 시간 간격을 지정한다.
        source.setCacheSeconds(60);

        // 없는 메세지일 경우 예외를 발생시키는 대신 코드를 기본 메세지로 한다.
        source.setUseCodeAsDefaultMessage(true);

        return source;

    }

    /**
     * 변경된 언어 정보를 기억할 로케일 리졸버를 생성한다.
     * 여기서는 세션에 저장하는 방식을 사용한다.
     * @return
     */
    @Bean
    public LocaleResolver localeResolver() {
        final SessionLocaleResolver localeResolver = new SessionLocaleResolver();
        localeResolver.setDefaultLocale(Locale.KOREAN);
        return localeResolver;
    }

    /**
     * 언어 변경을 위한 인터셉터를 생성한다.
     */
    @Bean
    public LocaleChangeInterceptor localeChangeInterceptor() {
        LocaleChangeInterceptor interceptor = new LocaleChangeInterceptor();
        interceptor.setParamName("lang");
        return interceptor;
    }

    /**
     * 인터셉터를 등록한다.
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        registry.addInterceptor(localeChangeInterceptor());

        /* 접속로그 */
        registry.addInterceptor(coevolutionLogInterceptor())
                .excludePathPatterns("/assets/**")
                .excludePathPatterns("/js/**")
                .excludePathPatterns("/img/**")
                .excludePathPatterns("/images/**")
        ;
    }

    @Bean
    public CoevolutionLogInterceptor coevolutionLogInterceptor() {
        CoevolutionLogInterceptor interceptor = new CoevolutionLogInterceptor();
        return interceptor;
    }

    /**
     * 이미지 절대경로를 상대경로로 매핑한다.
     */
    @Value("${file.upload.resource}") String resource;
    @Value("${vr.resource}") String resource2;
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
                .addResourceHandler("/files/**")
                .addResourceLocations(resource);

        registry
                .addResourceHandler("/vr21/**")
                .addResourceLocations(resource2);
    }
}
