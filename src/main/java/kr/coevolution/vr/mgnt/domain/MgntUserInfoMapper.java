package kr.coevolution.vr.mgnt.domain;

import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.dto.EvMemberLoginRequestDto;
import kr.coevolution.vr.mgnt.dto.EvMgntMemberRequestDto;
import kr.coevolution.vr.mgnt.dto.EvMgntMemberResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MgntUserInfoMapper {

    /**
     * 관리자 로그인 체크
     * @param param
     * @return
     */
    public List<EvMemberLoginInfoDto> S01_LOGIN(EvMemberLoginRequestDto param);

    /**
     * 참관회원, 참가회원조회
     * @param param
     * @return
     */
    public List<EvMgntMemberResponseDto> S02_MEMBER_LIST(EvMgntMemberRequestDto param);

    /**
     * 참관회원, 참가회원 총건수
     * @param param
     * @return
     */
    public List<EvMgntMemberResponseDto> S02_MEMBER_LIST_COUNT(EvMgntMemberRequestDto param);
}
