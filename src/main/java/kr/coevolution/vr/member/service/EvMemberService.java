package kr.coevolution.vr.member.service;

import kr.coevolution.vr.comm.domain.EvCommCodeMapper;
import kr.coevolution.vr.comm.dto.EvCommCodeRequestDto;
import kr.coevolution.vr.comm.dto.EvCommCodeResponseDto;
import kr.coevolution.vr.comm.util.SecureUtils;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.domain.EvMemberMapper;
import kr.coevolution.vr.member.dto.*;
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
public class EvMemberService {

    @Autowired
    private EvMemberMapper evMemberMapper;

    @Autowired
    private EvCommCodeMapper evCommCodeMapper;

    /**
     * id중복체크
     * @param evMemberSearchDto
     * @return
     */
    public List<EvMemberResposeDto> search_dup(EvMemberSearchDto evMemberSearchDto) {
        return evMemberMapper.S01_CUST(evMemberSearchDto);
    }

    /**
     * 로그인정보조회
     * @param evMemberLoginRequestDto
     * @return
     */
    public List<EvMemberLoginInfoDto> search_login(EvMemberLoginRequestDto evMemberLoginRequestDto) {
        return evMemberMapper.S02_CUST(evMemberLoginRequestDto);
    }

    /**
     * 아이디 찾기
     * @param evMemberLoginRequestDto
     * @return
     */
    public List<EvMemberLoginInfoDto> search_id(EvMemberLoginRequestDto evMemberLoginRequestDto) {
        return evMemberMapper.S02_CUST_ID_FIND(evMemberLoginRequestDto);
    }

    /**
     * 비밀번호 찾기
     * @param evMemberLoginRequestDto
     * @return
     */
    public List<EvMemberLoginInfoDto> search_pw(EvMemberLoginRequestDto evMemberLoginRequestDto) {
        return evMemberMapper.S02_CUST_PW_FIND(evMemberLoginRequestDto);
    }

    /**
     * 로그인정보조회 소셜
     * @param evMemberLoginRequestDto
     * @return
     */
    public List<EvMemberLoginInfoDto> search_login_social(EvMemberLoginRequestDto evMemberLoginRequestDto) {
        return evMemberMapper.S02_CUST_SOCIAL(evMemberLoginRequestDto);
    }

    /**
     * 로그인정보조회 소셜
     * @param evMemberLoginRequestDto
     * @return
     */
    public List<EvMemberLoginInfoDto> search_login_email_check(EvMemberLoginRequestDto evMemberLoginRequestDto) {
        return evMemberMapper.S02_CUST_EMAIL_CHECK(evMemberLoginRequestDto);
    }

    /**
     * 회원정보조회
     * @param evMemberSearchDto
     * @return
     */
    public List<EvMemberResposeDto> search_cust_info(EvMemberSearchDto evMemberSearchDto) {
        return evMemberMapper.S03_CUST(evMemberSearchDto);
    }

    /**
     * 회원정보-관심분야
     * @param evMemberSearchDto
     * @return
     */
    public List<Map<String, Object>> search_cust_intrst(EvMemberSearchDto evMemberSearchDto) {
        return evMemberMapper.S06_INTRST(evMemberSearchDto);
    }

    /**
     * 고객개인정보동의내역을 조회한다.
     * @param param
     * @return
     */
    public List<Map<String, String>> search_cust_agree(Map param) {
        return evMemberMapper.S04_AGREE_LIST(param);
    }

    /**
     * 회원정보입력
     * @param param
     * @return
     */
    public int member_insert(Map param) throws Exception{

        int return_code = 0;
        EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();

        /* 공통코드리턴 */
        List<EvCommCodeResponseDto> listCommCd = null;

        /* 비밀번호 암호화 */
        String cust_pw = String.valueOf(param.get("cust_pw"));
        cust_pw = SecureUtils.getSecurePassword(cust_pw);
        param.put("cust_pw", cust_pw);
        param.put("user_id", String.valueOf(param.get("cust_id")));
        param.put("cust_id", String.valueOf(param.get("cust_id")));

        param.put("cust_sts_cd", "105001"); // 회원상태: 정상

        /* 회원정보입력 */
        evMemberMapper.I01_CUST(param);

        /* 회원로그입력 */
        evMemberMapper.I03_CUST_LOG(param);

        /* 관심사항입력 */
        setInterst(param);

        /* clear */
        evCommCodeRequestDto.setUpper_cd_id("");

        /* 개인뱃지 최초 지급 개수 조회(103001) */
        evCommCodeRequestDto.setCd_id("103001");
        listCommCd = evCommCodeMapper.S01_COMM_CD(evCommCodeRequestDto);
        String MemberBadgeCnt = listCommCd.get(0).getCd_val1();
        listCommCd.clear();

        /* 개인뱃지 추천인 지급 개수 조회(103002) */
        evCommCodeRequestDto.setCd_id("103002");
        listCommCd = evCommCodeMapper.S01_COMM_CD(evCommCodeRequestDto);
        String GiveBadgeCnt = listCommCd.get(0).getCd_val1();
        listCommCd.clear();

        /* 뱃지등록 (회원) */
        EvMemberBadgeRequestDto evMemberBadgeRequestDto = new EvMemberBadgeRequestDto();
        evMemberBadgeRequestDto.setCust_id(String.valueOf(param.get("cust_id"))); //회원가입자
        evMemberBadgeRequestDto.setUser_id(String.valueOf(param.get("cust_id")));
        evMemberBadgeRequestDto.setBadge_clsf_cd("211001"); //211001 : 회원가입
        evMemberBadgeRequestDto.setGive_cust_id(""); //추천인
        evMemberBadgeRequestDto.setBadge_cnt(MemberBadgeCnt); //뱃지개수

        evMemberMapper.I01_BADGE(evMemberBadgeRequestDto);

        /* 뱃지등록 (회원, 추천인) */
        if(!"".equals(StringUtils.nvl(param.get("rcmder_cust_id"),""))) {
            evMemberBadgeRequestDto.setCust_id(String.valueOf(param.get("cust_id"))); //회원가입자
            evMemberBadgeRequestDto.setUser_id(String.valueOf(param.get("cust_id")));
            evMemberBadgeRequestDto.setBadge_clsf_cd("211002"); //211002 : 추천인
            evMemberBadgeRequestDto.setGive_cust_id(String.valueOf(param.get("rcmder_cust_id"))); //추천인
            evMemberBadgeRequestDto.setBadge_cnt(GiveBadgeCnt); //뱃지개수

            evMemberMapper.I01_BADGE(evMemberBadgeRequestDto);

            //추천인
            evMemberBadgeRequestDto.setCust_id(String.valueOf(param.get("rcmder_cust_id"))); //추천인
            evMemberBadgeRequestDto.setUser_id(String.valueOf(param.get("cust_id")));
            evMemberBadgeRequestDto.setBadge_clsf_cd("211002"); //211002 : 추천인
            evMemberBadgeRequestDto.setGive_cust_id(String.valueOf(param.get("cust_id"))); //회원가입자
            evMemberBadgeRequestDto.setBadge_cnt(GiveBadgeCnt); //뱃지개수

            evMemberMapper.I01_BADGE(evMemberBadgeRequestDto);
        }

        return return_code;

    }

    /**
     * 관심사항 입력
     * @param param
     */
    private void setInterst(Map param) throws Exception {

        /* 공통코드리턴 */
        List<EvCommCodeResponseDto> listCommCd = null;
        EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();

        /* 관심사항 항목 조회 206000 : 관심분야, 207000 : 종사분야, 208000, 업무(구매)권한, 209000 : 방문목적, 210000 : 인지경로 */
        String[] custIntrstArry = {"206000","207000","208000","209000","210000"};

        for(String custIntrstCd : custIntrstArry) {
            /* 회원관심사항 등록  */
            evCommCodeRequestDto.setUpper_cd_id(custIntrstCd);
            listCommCd = evCommCodeMapper.S01_COMM_CD(evCommCodeRequestDto);

            /* 항목별 데이터 입력 */
            for (EvCommCodeResponseDto evCommCodeResponseDto : listCommCd) {
                String intrst_cd = evCommCodeResponseDto.getCd_id();
                if("Y".equals(StringUtils.nvl(param.get("chk_"+intrst_cd),"N"))) {
                    param.put("intrst_cd", intrst_cd);
                    evMemberMapper.I02_CUST(param);
                }
            }

            listCommCd.clear();
        }        
    }

    /**
     * 회원정보수정
     * @param param
     * @return
     */
    public int member_update(Map param) throws Exception {

        int return_code = 0;

        /* 회원정보수정 */
        evMemberMapper.U01_CUST(param);

        /* 회원관심사항 삭제 */
        evMemberMapper.U02_CUST(param);

        /* 회원로그입력 */
        evMemberMapper.I03_CUST_LOG(param);

        /* 회원관심사항 입력 */
        setInterst(param);

        return return_code;
    }

    /**
     * 비밀번호 변경
     * @param evMemberLoginRequestDto
     * @return
     * @throws Exception
     */
    public int member_passwd(EvMemberLoginRequestDto evMemberLoginRequestDto) throws Exception {

        int return_code = 0;

        /* 비밃번호 변경 */
        evMemberMapper.U03_CUST(evMemberLoginRequestDto);

        /* 회원로그입력 */
        Map<String, String> param = new HashMap();
        param.put("cust_id", evMemberLoginRequestDto.getCust_id());

        evMemberMapper.I03_CUST_LOG(param);
        
        return return_code;
    }

    /**
     * 임시 비밀번호 저장
     * @param evMemberLoginRequestDto
     * @return
     * @throws Exception
     */
    public int member_passwd_init(EvMemberLoginRequestDto evMemberLoginRequestDto) throws Exception {

        int return_code = 0;

        /* 임시 비밀번호 저장 */
        evMemberMapper.U03_CUST_PW_INIT(evMemberLoginRequestDto);

        /* 회원로그입력 */
        Map<String, String> param = new HashMap();
        param.put("cust_id", evMemberLoginRequestDto.getCust_id());

        evMemberMapper.I03_CUST_LOG(param);

        return return_code;
    }

    /**
     * 재동의
     * @param evMemberLoginRequestDto
     * @return
     * @throws Exception
     */
    public int member_agree(EvMemberLoginRequestDto evMemberLoginRequestDto) throws Exception {

        int return_code = 0;

        /* 재동의 */
        evMemberMapper.U04_AGREE(evMemberLoginRequestDto);

        /* 회원로그입력 */
        Map<String, String> param = new HashMap();
        param.put("cust_id", evMemberLoginRequestDto.getCust_id());

        evMemberMapper.I03_CUST_LOG(param);

        return return_code;
    }

    /**
     * 회원탈퇴
     * @param evMemberLoginRequestDto
     * @return
     * @throws Exception
     */
    public int member_wdral(EvMemberLoginRequestDto evMemberLoginRequestDto) throws Exception {

        int return_code = 0;

        /* 재동의 */
        evMemberMapper.U05_WDRAL(evMemberLoginRequestDto);

        /* 회원로그입력 */
        Map<String, String> param = new HashMap();
        param.put("cust_id", evMemberLoginRequestDto.getCust_id());

        evMemberMapper.I03_CUST_LOG(param);

        return return_code;
    }
}
