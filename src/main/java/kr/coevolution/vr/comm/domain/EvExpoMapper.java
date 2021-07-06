package kr.coevolution.vr.comm.domain;

import kr.coevolution.vr.comm.dto.EvExpoRequestDto;
import kr.coevolution.vr.comm.dto.EvExpoResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EvExpoMapper {

    /**
     * 참가기업조회
     * @param evExpoRequestDtoDto
     * @return
     */
    public List<EvExpoResponseDto> S01_EXPO(EvExpoRequestDto evExpoRequestDtoDto);

    /**
     * 참관조회
     * @param evExpoRequestDtoDto
     * @return
     */
    public List<EvExpoResponseDto> S01_EXPO_CUST(EvExpoRequestDto evExpoRequestDtoDto);
}
