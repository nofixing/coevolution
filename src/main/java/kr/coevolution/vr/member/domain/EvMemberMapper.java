package kr.coevolution.vr.member.domain;

import kr.coevolution.vr.member.dto.*;
import kr.coevolution.vr.mypage.dto.EvMypageBadgeRequestDto;
import kr.coevolution.vr.mypage.dto.EvMypageBadgeResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface EvMemberMapper {
    /**
     * 회원중복체크
     * @param param
     * @return
     */
    public List<EvMemberResposeDto> S01_CUST(EvMemberSearchDto param);

    /**
     * 회원로그인-정보조회
     * @param param
     * @return
     */
    public List<EvMemberLoginInfoDto> S02_CUST(EvMemberLoginRequestDto param);

    /**
     * 회원정보조회
     * @param param
     * @return
     */
    public List<EvMemberResposeDto> S03_CUST(EvMemberSearchDto param);
    
    /**
     * 회원정보를 입력한다.
     * @param param
     * @return
     */
    public int I01_CUST(Map param);

    /**
     * 회원정보 수정
     * @param param
     * @return
     */
    public int U01_CUST(Map param);

    /**
     * 회원관심사항을 입력한다.
     * @param param
     * @return
     */
    public int I02_CUST(Map param);

    /**
     * 회원관심사항 삭제
     * @param param
     * @return
     */
    public int U02_CUST(Map param);

    /**
     * 비밃번호변경
     * @EvMemberLoginRequestDto evMemberLoginRequestDto
     * @return
     */
    public int U03_CUST(EvMemberLoginRequestDto evMemberLoginRequestDto);

    /**
     * 재동의
     * @param evMemberLoginRequestDto
     * @return
     */
    public int U04_AGREE(EvMemberLoginRequestDto evMemberLoginRequestDto);

    /**
     * 회원탈퇴
     * @param evMemberLoginRequestDto
     * @return
     */
    public int U05_WDRAL(EvMemberLoginRequestDto evMemberLoginRequestDto);

    /**
     * 회원뱃지입력
     * @param evMemberBadgeRequestDto
     * @return
     */
    public int I01_BADGE(EvMemberBadgeRequestDto evMemberBadgeRequestDto);

    /**
     * 회원뱃지내역조회
     * @param evMypageBadgeRequestDto
     * @return
     */
    public List<EvMypageBadgeResponseDto> S01_BADGE(EvMypageBadgeRequestDto evMypageBadgeRequestDto);

    /**
     * 회원뱃지조회 건수 및 뱃지 건수
     * @param evMypageBadgeRequestDto
     * @return
     */
    public List<EvMypageBadgeResponseDto> S02_BADGE(EvMypageBadgeRequestDto evMypageBadgeRequestDto);

    /**
     * VR뱃지등록여부 체크
     * @param evMemberBadgeRequestDto
     * @return
     */
    public List<EvMypageBadgeResponseDto> S03_BADGE(EvMemberBadgeRequestDto evMemberBadgeRequestDto);

    /**
     * 회원뱃지내역조회-기업참가
     * @param evMypageBadgeRequestDto
     * @return
     */
    public List<EvMypageBadgeResponseDto> S04_BADGE(EvMypageBadgeRequestDto evMypageBadgeRequestDto);

    /**
     * 회원뱃지조회 건수 및 뱃지 건수-기업참가
     * @param evMypageBadgeRequestDto
     * @return
     */
    public List<EvMypageBadgeResponseDto> S05_BADGE(EvMypageBadgeRequestDto evMypageBadgeRequestDto);    
}
