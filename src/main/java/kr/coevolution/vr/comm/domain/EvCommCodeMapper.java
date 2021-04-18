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

    /**
     * 공통코드 수정
     * @param param
     * @return
     */
    public int U01_COMM_CD(Map<String, String> param);

    /**
     * 공통코드 입력
     * @param param
     * @return
     */
    public int I02_COMM_CD(EvCommCodeRequestDto param);

    /**
     * 공통코드 삭제
     * @param param
     * @return
     */
    public int D01_COMM_CD(EvCommCodeRequestDto param);

    /**
     * 공통코드로그
     * @param param
     * @return
     */
    public int I02_COMM_CD_LOG(EvCommCodeRequestDto param);

}
