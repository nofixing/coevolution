package kr.coevolution.vr.comm.service;

import kr.coevolution.vr.comm.domain.EvCommCodeMapper;
import kr.coevolution.vr.comm.dto.EvCommCodeRequestDto;
import kr.coevolution.vr.comm.dto.EvCommCodeResponseDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class EvCommCodeService {

    @Autowired
    private EvCommCodeMapper evCommCodeMapper;

    /**
     * 공통코드조회
     * @param evCommCodeRequestDto
     * @return
     * @throws Exception
     */
    public List<EvCommCodeResponseDto> comm_code_search (EvCommCodeRequestDto evCommCodeRequestDto) {
        List<EvCommCodeResponseDto> commCodeList = evCommCodeMapper.S01_COMM_CD(evCommCodeRequestDto);
        return commCodeList;
    }

}
