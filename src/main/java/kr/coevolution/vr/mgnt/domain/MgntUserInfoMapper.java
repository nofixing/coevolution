package kr.coevolution.vr.mgnt.domain;

import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.dto.EvMemberLoginRequestDto;
import kr.coevolution.vr.mgnt.dto.EvMgntMemberRequestDto;
import kr.coevolution.vr.mgnt.dto.EvMgntMemberResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

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

    /**
     * 중복체크
     * @param param
     * @return
     */
    public List<EvMgntMemberResponseDto> S03_DUP_CHK(EvMgntMemberRequestDto param);

    /**
     * 관리자 등록
     * @param param
     * @return
     */
    public int I01_MGNT_USER (Map<String, String> param);

    /**
     * 관리자정보 수정
     * @param param
     * @return
     */
    public int U01_MGNT_USER (Map<String, String> param);

    /**
     * 관리자 비밀번호 변경
     * @param param
     * @return
     */
    public int U01_MGNT_USER_PW (EvMgntMemberRequestDto param);

    /**
     * 관리자메뉴권한등록
     * @param param
     * @return
     */
    public int I02_MGNT_PRMS (Map<String, String> param);

    /**
     * 관지라메뉴삭제
     * @param param
     * @return
     */
    public int U02_MGNT_PRMS_DEL (Map<String, String> param);

    /**
     * 관리자메뉴조회
     * @param param
     * @return
     */
    public List<Map<String, String>> S04_MENU_LIST (Map<String, String> param);

    /**
     * 관리자 리스트
     * @param param
     * @return
     */
    public List<EvMgntMemberResponseDto> S05_MGNT_LIST (EvMgntMemberRequestDto param);

    /**
     * 관리자리스트 총 건수
     * @param param
     * @return
     */
    public List<EvMgntMemberResponseDto> S05_MGNT_LIST_COUNT (EvMgntMemberRequestDto param);

    /**
     * 관리자 상제정보
     * @param param
     * @return
     */
    public List<EvMgntMemberResponseDto> S06_MGNT_USER_INFO (EvMgntMemberRequestDto param);

    /**
     * 관리자-권한조회
     * @param param
     * @return
     */
    public List<Map<String, String>> S07_MGNT_PRMS_LIST (Map<String, String> param);

    /**
     * 관리자 메뉴 조회
     * @param param
     * @return
     */
    public List<Map<String, String>> S08_MGNT_MENU_LIST (Map<String, String> param);

    /**
     * 부스 현황 (뱃지, 즐겨찾기 현황등등)
     * @param param
     * @return
     */
    public List<EvMgntMemberResponseDto> S09_BOOTH_LIST(EvMgntMemberRequestDto param);

    /**
     * 부스 현황 건수 (뱃지, 즐겨찾기 현황등등)
     * @param param
     * @return
     */
    public List<EvMgntMemberResponseDto> S09_BOOTH_LIST_COUNT(EvMgntMemberRequestDto param);
}
