package kr.coevolution.vr.mgnt.domain;

import kr.coevolution.vr.mgnt.dto.EvMgntConsultRequestDto;
import kr.coevolution.vr.mgnt.dto.EvMgntConsultResposeDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MgntConsultMapper {

    public List<EvMgntConsultResposeDto> S01_CONSULT_LIST(EvMgntConsultRequestDto param);

    public List<EvMgntConsultResposeDto> S01_CONSULT_LIST_COUNT(EvMgntConsultRequestDto param);

}
