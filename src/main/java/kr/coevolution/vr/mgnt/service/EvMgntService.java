package kr.coevolution.vr.mgnt.service;

import kr.coevolution.vr.member.domain.EvMemberMapper;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.dto.EvMemberLoginRequestDto;
import kr.coevolution.vr.mgnt.domain.MgntUserInfoMapper;
import kr.coevolution.vr.mgnt.dto.EvMgntMemberRequestDto;
import kr.coevolution.vr.mgnt.dto.EvMgntMemberResponseDto;
import kr.coevolution.vr.mypage.dto.EvMypageBadgeRequestDto;
import kr.coevolution.vr.mypage.dto.EvMypageBadgeResponseDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Service
@Transactional(rollbackFor = {RuntimeException.class, Exception.class})
public class EvMgntService {

    @Autowired
    private MgntUserInfoMapper mgntUserInfoMapper;

    @Autowired
    private EvMemberMapper evMemberMapper; /* 뱃지 Mapper */

    /**
     * 관리자로그인체크
     * @param evMemberLoginRequestDto
     * @return
     */
    public List<EvMemberLoginInfoDto> search_login(EvMemberLoginRequestDto evMemberLoginRequestDto) {
        return mgntUserInfoMapper.S01_LOGIN(evMemberLoginRequestDto);
    }

    /**
     * 로그인로그
     * @param pMap
     * @return
     */
    public int login_log(Map<String, String> pMap) {
        return evMemberMapper.I04_LOGIN_LOG(pMap);
    }

    /**
     * 관리자페이지 부스 뱃지 내역
     * @param evMypageBadgeRequestDto
     * @return
     */
    public List<EvMypageBadgeResponseDto> mgnt_badge_list (EvMypageBadgeRequestDto evMypageBadgeRequestDto) {
        return evMemberMapper.S06_BADGE_SH1(evMypageBadgeRequestDto);
    }

    /**
     * 관리자페이지 부스 뱃지 내역 건수
     * @param evMypageBadgeRequestDto
     * @return
     */
    public List<EvMypageBadgeResponseDto> mgnt_badge_list_count (EvMypageBadgeRequestDto evMypageBadgeRequestDto) {
        return evMemberMapper.S07_BADGE_SH1(evMypageBadgeRequestDto);
    }

    /**
     * 관리자페이지 참관고객, 참가고객조회
     * @param evMgntMemberRequestDto
     * @return
     */
    public List<EvMgntMemberResponseDto> search_member_list(EvMgntMemberRequestDto evMgntMemberRequestDto) {
        return mgntUserInfoMapper.S02_MEMBER_LIST(evMgntMemberRequestDto);
    }

    /**
     * 관리자페이지 참관고객, 참가고객조회 총건수
     * @param evMgntMemberRequestDto
     * @return
     */
    public List<EvMgntMemberResponseDto> search_member_list_count(EvMgntMemberRequestDto evMgntMemberRequestDto) {
        return mgntUserInfoMapper.S02_MEMBER_LIST_COUNT(evMgntMemberRequestDto);
    }

}
