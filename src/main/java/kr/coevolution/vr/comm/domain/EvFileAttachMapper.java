package kr.coevolution.vr.comm.domain;

import kr.coevolution.vr.comm.dto.EvFileAttachRequestDto;
import kr.coevolution.vr.comm.dto.EvFileAttachResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EvFileAttachMapper {
    /**
     * 첨부파일입력
     * @param param
     * @return
     */
    public int I01_FILE(EvFileAttachRequestDto param);

    /**
     * 첨부파일조회
     * @param param
     * @return
     */
    public List<EvFileAttachResponseDto> S01_FILE(EvFileAttachRequestDto param);
}
