package kr.coevolution.vr.mgnt.service;

import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.dto.EvMemberLoginRequestDto;
import kr.coevolution.vr.mgnt.domain.MgntConsultMapper;
import kr.coevolution.vr.mgnt.dto.EvMgntConsultRequestDto;
import kr.coevolution.vr.mgnt.dto.EvMgntConsultResposeDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
@Transactional(rollbackFor = {RuntimeException.class, Exception.class})
public class EvMgntConsultService {

    @Autowired
    private MgntConsultMapper mgntConsultMapper;

    /**
     * 상담현황
     * @param evMgntConsultRequestDto
     * @return
     */
    public List<EvMgntConsultResposeDto> consult_list (EvMgntConsultRequestDto evMgntConsultRequestDto) {
        return mgntConsultMapper.S01_CONSULT_LIST(evMgntConsultRequestDto);
    }

    /**
     * 상담현황건수
     * @param evMgntConsultRequestDto
     * @return
     */
    public List<EvMgntConsultResposeDto> consult_list_count (EvMgntConsultRequestDto evMgntConsultRequestDto) {
        return mgntConsultMapper.S01_CONSULT_LIST_COUNT(evMgntConsultRequestDto);
    }
}
