package kr.coevolution.vr.comm.domain;

import kr.coevolution.vr.comm.dto.EvCommCodeRequestDto;
import kr.coevolution.vr.comm.dto.EvCommCodeResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface EvCommCodeMapper {

    /**
     * 공통코드조회
     * @param param
     * @return
     */
    public List<EvCommCodeResponseDto> S01_COMM_CD(EvCommCodeRequestDto param);

    /**
     * 접속로그
     * @return
     */
    public int I01_ACCESS_LOG(Map<String, String> param);
}
