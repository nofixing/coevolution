package kr.coevolution.vr;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@EnableJpaAuditing
@SpringBootApplication
public class CoevolutionApplication {

	public static void main(String[] args) {
		SpringApplication.run(CoevolutionApplication.class, args);
	}

}
