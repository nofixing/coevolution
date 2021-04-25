package kr.coevolution.vr;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

/**
 * 웹소켓 설정
 * @EnableWebSocketMessageBroker : websocket 서버를 사용한다는 설정이다.
 * WebSocketMessageBrokerConfigurer : websocket 연결 속성을 설정
 * registerStompEndpoints : 클라이언트에서 websocket에 접속하는 endpoint를 등록
 * withSockJS()를 이용시에는 브라우져에서 websocket을 지원하지 않을 경우 fallback 옵션을 활성화 하는데 사용됩니다.
 * STOMP(Simple Text Oriented Messaging Protocol) : 스프링프레임워크의 STOMP 구현체를 사용
 * configureMessageBroker는 한 클라이언트에서 다른 클라이언트로 메시지를 라우팅 할 때 사용하는 브로커를 구성한다.
 * /app로 시작하는 메시지만 메시지 헨들러로 라우팅한다고 정의한다.
 * /topic로 시작하는 주제를 가진 메시지를 핸들러로 라우팅하여 해당 주제에 가입한 모든 클라이언트에게 메시지를 방송한다 *
 *
 */
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/ws").withSockJS();
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.enableSimpleBroker("/topic");
        registry.setApplicationDestinationPrefixes("/app");
    }
}
