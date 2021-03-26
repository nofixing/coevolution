package kr.coevolution.vr.email.domain;

import kr.coevolution.vr.email.dto.EvMailSndRequestDto;
import kr.coevolution.vr.email.dto.EvMailSndResposeDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EvMailSndRepository {
    public List<EvMailSndResposeDto> S01(EvMailSndRequestDto param);
    public List<EvMailSndResposeDto> S02_MAIL_FORM(EvMailSndRequestDto param);

    public int I01(EvMailSndRequestDto param);
}
