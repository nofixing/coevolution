package kr.coevolution.vr.mgnt.service;

import kr.coevolution.vr.comm.util.SecureUtils;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.domain.EvMemberMapper;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.dto.EvMemberLoginRequestDto;
import kr.coevolution.vr.mgnt.domain.MgntEventMapper;
import kr.coevolution.vr.mgnt.domain.MgntUserInfoMapper;
import kr.coevolution.vr.mgnt.dto.*;
import kr.coevolution.vr.mypage.dto.EvMypageBadgeRequestDto;
import kr.coevolution.vr.mypage.dto.EvMypageBadgeResponseDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Service
@Transactional(rollbackFor = {RuntimeException.class, Exception.class})
public class EvMgntEventService {

    @Autowired
    private MgntUserInfoMapper mgntUserInfoMapper;

    @Autowired
    private MgntEventMapper mgntEventMapper; /* 뱃지 Mapper */

    public List<EvMgntEventDto> search_person_list(EvMgntEventDto evMgntEventDto) {
        return mgntEventMapper.search_person_list(evMgntEventDto);
    }

    public List<EvMgntEventDto> search_person_list_count(EvMgntEventDto evMgntEventDto) {
        return mgntEventMapper.search_person_list_count(evMgntEventDto);
    }

    public List<EvMgntEventDto> search_stock_list(EvMgntEventDto evMgntEventDto) {
        return mgntEventMapper.search_stock_list(evMgntEventDto);
    }

    public List<EvMgntEventDto> search_stock_list_count(EvMgntEventDto evMgntEventDto) {
        return mgntEventMapper.search_stock_list_count(evMgntEventDto);
    }
}
