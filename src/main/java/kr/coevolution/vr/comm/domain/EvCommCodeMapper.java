package kr.coevolution.vr.comm.domain;

import kr.coevolution.vr.comm.dto.EvCommCodeRequestDto;
import kr.coevolution.vr.comm.dto.EvCommCodeResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EvCommCodeMapper {
    public List<EvCommCodeResponseDto> S01_COMM_CD(EvCommCodeRequestDto param);
}
