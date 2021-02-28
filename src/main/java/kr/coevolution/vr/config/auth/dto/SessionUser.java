package kr.coevolution.vr.config.auth.dto;

import kr.coevolution.vr.domain.user.User;
import lombok.Getter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.Serializable;

/**
 * 세션에 저장하려면 직렬화를 해야 하는데
 * User 엔티티는 추후 변경사항이 있을 수 있기 때문에
 * 직렬화를 하기 위한 별도의 SessionUser 클래스 생성
 */

@Getter
public class SessionUser implements Serializable {

    private String name, email, picture;

    public SessionUser(){} //없으면 null 값으로 처리해서 fail to instantiate 에러를 뿜어낸다.

    Logger logger = LoggerFactory.getLogger(this.getClass());

    public SessionUser(User user) {
        logger.info("userName:"+user.getName());
        this.name = user.getName();
        this.email = user.getEmail();
        this.picture = user.getPicture();
    }
}