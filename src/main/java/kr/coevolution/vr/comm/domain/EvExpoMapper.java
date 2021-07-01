package kr.coevolution.vr.comm.domain;

import kr.coevolution.vr.comm.dto.EvExpoResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EvExpoMapper {
    public List<EvExpoResponseDto> S01_EXPO();
}
