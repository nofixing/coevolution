package kr.coevolution.vr.mgnt.service;

import kr.coevolution.vr.comm.util.SecureUtils;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.domain.EvMemberMapper;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.dto.EvMemberLoginRequestDto;
import kr.coevolution.vr.mgnt.domain.MgntUserInfoMapper;
import kr.coevolution.vr.mgnt.dto.EvMgntMemberRequestDto;
import kr.coevolution.vr.mgnt.dto.EvMgntMemberResponseDto;
import kr.coevolution.vr.mgnt.dto.EvMgntZoomRequestDto;
import kr.coevolution.vr.mgnt.dto.EvMgntZoomResposeDto;
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
        return evMemberMapper.S06_BADGE_SH1_COUNT(evMypageBadgeRequestDto);
    }

    /**
     * 관리자페이지 부스 뱃지 내역
     * @param evMypageBadgeRequestDto
     * @return
     */
    public List<EvMypageBadgeResponseDto> mgnt_badge_list2 (EvMypageBadgeRequestDto evMypageBadgeRequestDto) {
        return evMemberMapper.S06_BADGE_SH2(evMypageBadgeRequestDto);
    }

    /**
     * 관리자페이지 부스 뱃지 내역 건수
     * @param evMypageBadgeRequestDto
     * @return
     */
    public List<EvMypageBadgeResponseDto> mgnt_badge_list2_count (EvMypageBadgeRequestDto evMypageBadgeRequestDto) {
        return evMemberMapper.S06_BADGE_SH2_COUNT(evMypageBadgeRequestDto);
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

    /**
     * 중복체크
     * @param evMgntMemberRequestDto
     * @return
     */
    public List<EvMgntMemberResponseDto> search_mgnt_dup_chk(EvMgntMemberRequestDto evMgntMemberRequestDto) {
        return mgntUserInfoMapper.S03_DUP_CHK(evMgntMemberRequestDto);
    }

    /**
     * 관리자 리스트
     * @param evMgntMemberRequestDto
     * @return
     */
    public List<EvMgntMemberResponseDto> search_mgnt_user_list(EvMgntMemberRequestDto evMgntMemberRequestDto) {
        return mgntUserInfoMapper.S05_MGNT_LIST(evMgntMemberRequestDto);
    }

    /**
     * 관리지자 리스트 총 건수
     * @param evMgntMemberRequestDto
     * @return
     */
    public List<EvMgntMemberResponseDto> search_mgnt_user_list_count(EvMgntMemberRequestDto evMgntMemberRequestDto) {
        return mgntUserInfoMapper.S05_MGNT_LIST_COUNT(evMgntMemberRequestDto);
    }

    /**
     * 관리자 상세조회
     * @param evMgntMemberRequestDto
     * @return
     */
    public List<EvMgntMemberResponseDto> search_mgnt_user_info(EvMgntMemberRequestDto evMgntMemberRequestDto) {
        return mgntUserInfoMapper.S06_MGNT_USER_INFO(evMgntMemberRequestDto);
    }

    public List<Map<String, String>> search_mgnt_prms_list(Map<String, String> pMap) {
        return mgntUserInfoMapper.S07_MGNT_PRMS_LIST(pMap);
    }

    /**
     * 관리자 정보를 입력한다
     * @param param
     * @return
     */
    public int mgnt_user_insert(Map<String, String> param) {
        int return_code = 0;

        /* 비밀번호 암호화 */
        String mgnt_pw = String.valueOf(param.get("mgnt_pw"));
        mgnt_pw = SecureUtils.getSecurePassword(mgnt_pw);
        param.put("mgnt_pw", mgnt_pw);

        /* 관리자ID가 등록되었는지 체크 */
        EvMgntMemberRequestDto evMgntMemberRequestDto = new EvMgntMemberRequestDto();
        evMgntMemberRequestDto.setMgnt_id(param.get("mgnt_id"));

        List<EvMgntMemberResponseDto> duplist = mgntUserInfoMapper.S03_DUP_CHK(evMgntMemberRequestDto);

        if(0 < duplist.get(0).getDup_cnt()) {
            throw new RuntimeException("-1");
        }
        
        /* 관리자 입력 */
        mgntUserInfoMapper.I01_MGNT_USER(param);

        /* 관리자 권한 입력 */
        mgnt_prms_save (param);

        return return_code;
    }

    /**
     * 관리자 정보를 수정한다.
     * @param param
     * @return
     */
    public int mgnt_user_update(Map<String, String> param) {
        int return_code = 0;

        /* 관리자ID가 등록되었는지 체크 */
        EvMgntMemberRequestDto evMgntMemberRequestDto = new EvMgntMemberRequestDto();
        evMgntMemberRequestDto.setMgnt_id(param.get("mgnt_id"));

        /* 관리자 입력 */
        mgntUserInfoMapper.U01_MGNT_USER(param);

        /* 관리자 권한 입력 */
        mgnt_prms_save (param);

        return return_code;
    }

    /**
     * 관리자 메뉴 권한입력
     * @param param
     */
    private void mgnt_prms_save (Map<String, String> param) {
        /* 관리자 메뉴 리스트 조회 */
        List<Map<String, String>> menuList = mgntUserInfoMapper.S04_MENU_LIST(param);
        Map<String, String> vMap = null;

        /* 메뉴권한 삭제처리 */
        mgntUserInfoMapper.U02_MGNT_PRMS_DEL(param);

        for(int i = 0; i < menuList.size(); i++) {

            vMap = new HashMap<String, String>();

            String menuId = StringUtils.nvl(menuList.get(i).get("menu_id"),"");

            vMap.put("menu_id", menuId);
            vMap.put("mgnt_id", param.get("mgnt_id"));
            vMap.put("user_id", param.get("user_id"));
            vMap.put("use_yn", StringUtils.nvl(param.get("S"+menuId),"N"));

            /* 메뉴권한입력 */
            mgntUserInfoMapper.I02_MGNT_PRMS(vMap);

        }
    }

    /**
     * 관리자 비밀번호 변경
     * @param evMgntMemberRequestDto
     * @return
     */
    public int mgnt_user_passwd_change(EvMgntMemberRequestDto evMgntMemberRequestDto) {
        return mgntUserInfoMapper.U01_MGNT_USER_PW(evMgntMemberRequestDto);
    }

    /**
     * 관리자 메뉴리스트
     * @param param
     * @return
     */
    public List<Map<String, String>> mgnt_user_menu_list (Map<String, String> param) {
        return mgntUserInfoMapper.S08_MGNT_MENU_LIST(param);
    }

    /**
     * 부스 현황 (뱃지, 즐겨찾기 현황등등)
     * @param evMgntMemberRequestDto
     * @return
     */
    public List<EvMgntMemberResponseDto> mgnt_booth_list (EvMgntMemberRequestDto evMgntMemberRequestDto) {
        return mgntUserInfoMapper.S09_BOOTH_LIST(evMgntMemberRequestDto);
    }

    /**
     * 부스 현황 건수 (뱃지, 즐겨찾기 현황등등)
     * @param evMgntMemberRequestDto
     * @return
     */
    public List<EvMgntMemberResponseDto> mgnt_booth_list_count (EvMgntMemberRequestDto evMgntMemberRequestDto) {
        return mgntUserInfoMapper.S09_BOOTH_LIST_COUNT(evMgntMemberRequestDto);
    }

    /**
     * 접속로그리스트
     * @param evMgntMemberRequestDto
     * @return
     */
    public List<EvMgntMemberResponseDto> mgnt_access_log_list (EvMgntMemberRequestDto evMgntMemberRequestDto) {
        return mgntUserInfoMapper.S10_ACCESS_LOG_LIST(evMgntMemberRequestDto);
    }

    /**
     * 접속로그건수
     * @param evMgntMemberRequestDto
     * @return
     */
    public List<EvMgntMemberResponseDto> mgnt_access_log_list_count (EvMgntMemberRequestDto evMgntMemberRequestDto) {
        return mgntUserInfoMapper.S10_ACCESS_LOG_LIST_COUNT(evMgntMemberRequestDto);
    }

    /**
     * 줌 사용설정 입력
     * @param pMap
     * @return
     */
    public int mgnt_zoom_insert(EvMgntZoomRequestDto pMap) {
        return mgntUserInfoMapper.I03_MGNT_ZOOM(pMap);
    }

    /**
     * 줌 사용설정 수정
     * @param pMap
     * @return
     */
    public int mgnt_zoom_update(EvMgntZoomRequestDto pMap) {
        return mgntUserInfoMapper.U03_MGNT_ZOOM(pMap);
    }

    /**
     * 줌 사용 건수
     * @param evMgntZoomRequestDto
     * @return
     */
    public List<EvMgntZoomResposeDto> mgnt_zoom_list (EvMgntZoomRequestDto evMgntZoomRequestDto) {
        return mgntUserInfoMapper.S11_MGNT_ZOOM(evMgntZoomRequestDto);
    }
}
