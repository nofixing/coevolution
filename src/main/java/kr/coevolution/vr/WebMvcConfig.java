package kr.coevolution.vr;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new CoevolutionLoginInterceptor())
                .addPathPatterns("/mypage/**") // 해당 경로에 접근하기 전에 인터셉터가 가로챈다. /member/*
                .addPathPatterns("/vr/**")
                .excludePathPatterns("/member/login") // 해당 경로는 인터셉터가 가로채지 않는다.
                .excludePathPatterns("/member/dup")
        ;
    }
}
