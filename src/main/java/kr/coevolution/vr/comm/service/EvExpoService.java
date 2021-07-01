package kr.coevolution.vr.comm.service;

import kr.coevolution.vr.comm.domain.EvCommCodeMapper;
import kr.coevolution.vr.comm.domain.EvExpoMapper;
import kr.coevolution.vr.comm.dto.EvCommCodeRequestDto;
import kr.coevolution.vr.comm.dto.EvCommCodeResponseDto;
import kr.coevolution.vr.comm.dto.EvExpoResponseDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class EvExpoService {

    @Autowired
    private EvExpoMapper evExpoMapper;

    /**
     * EXPO 정보를 조회한다.
     * @return
     */
    public List<EvExpoResponseDto> expo_info_search () {
        List<EvExpoResponseDto> expoInfo = evExpoMapper.S01_EXPO();
        return expoInfo;
    }
}
