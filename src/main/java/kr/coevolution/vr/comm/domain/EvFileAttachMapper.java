package kr.coevolution.vr.comm.domain;

import kr.coevolution.vr.comm.dto.EvFileAttachRequestDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EvFileAttachMapper {
    public int I01_FILE(EvFileAttachRequestDto param);
}
