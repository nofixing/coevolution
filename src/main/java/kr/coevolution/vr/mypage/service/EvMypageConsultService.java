package kr.coevolution.vr.mypage.service;

import kr.coevolution.vr.mypage.domain.EvMypageConsultMapper;
import kr.coevolution.vr.mypage.dto.*;
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
public class EvMypageConsultService {

    @Autowired
    private EvMypageConsultMapper evMypageConsultMapper;

    /**
     * 참가기업 상담 시간 설정
     * @param evMypageConsultRequestDto
     * @return
     */
    public int consult_settime_insert (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        int insertCnt  = evMypageConsultMapper.I01_SET_TIME(evMypageConsultRequestDto);

        //참가업체 상담 시간 입력
        evMypageConsultMapper.I02_CONSULT_SCHEDULE1(evMypageConsultRequestDto);

        return insertCnt;
    }

    /**
     * 참가기업 상담 시간 설정 수정
     * @param evMypageConsultRequestDto
     * @return
     */
    public int consult_settime_update (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        int insertCnt  = evMypageConsultMapper.U01_SET_TIME(evMypageConsultRequestDto);

        //참가업체 상담 시간 입력
        evMypageConsultMapper.I02_CONSULT_SCHEDULE1(evMypageConsultRequestDto);

        return insertCnt;
    }

    /**
     * 참가기업 상담 시간 설정 수정
     * @param evMypageConsultRequestDto
     * @return
     */
    public int consult_settime_update2 (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        int insertCnt  = evMypageConsultMapper.U01_SET_TIMEZONE(evMypageConsultRequestDto);
        return insertCnt;
    }

    /**
     * 참가기업 상담시간 조회
     * @param evMypageConsultRequestDto
     * @return
     */
    public List<EvMypageConsultResponseDto> consult_settime_select (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        List<EvMypageConsultResponseDto> list = evMypageConsultMapper.S01_SET_TIME(evMypageConsultRequestDto);
        return list;
    }

    /**
     * 참가기업 상담시간 설정기 기본 상담정보를 입력한다 (시간)
     * @param evMypageConsultRequestDto
     * @return
     */
    public int consult_shedule_init_insert (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        int insertCnt  = evMypageConsultMapper.I02_CONSULT_SCHEDULE1(evMypageConsultRequestDto);
        return insertCnt;
    }

    /**
     * 참가기업 상담 시간 변경 - 입력
     * @param evMypageConsultRequestDto
     * @return
     */
    public int consult_shedule_insert (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        int insertCnt  = evMypageConsultMapper.I02_CONSULT_SCHEDULE2(evMypageConsultRequestDto);
        return insertCnt;
    }

    /**
     * 참가업체 상담시간 변경 - 기존 상담시간 삭제처리
     * @param evMypageConsultRequestDto
     * @return
     */
    public int consult_shedule_delete (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        int insertCnt  = evMypageConsultMapper.U02_CONSULT_SCHEDULE(evMypageConsultRequestDto);
        return insertCnt;
    }

    /**
     * 참가업체 상담시간 조회
     * @param evMypageConsultRequestDto
     * @return
     */
    public List<EvMypageConsultScheduleResponseDto> consult_shedule_search (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        List<EvMypageConsultScheduleResponseDto> list  = evMypageConsultMapper.S01_CONSULT_SCHEDULE(evMypageConsultRequestDto);
        return list;
    }

    /**
     * 예약자조회
     * @param evMypageConsultRequestDto
     * @return
     */
    public List<EvMypageConsultScheduleResponseDto> consult_rsv_info_search (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        List<EvMypageConsultScheduleResponseDto> list  = evMypageConsultMapper.S02_RSV_INFO(evMypageConsultRequestDto);
        return list;
    }

    /**
     * 상담내용입력
     * @param evMypageConsultMsgRequestDto
     * @return
     */
    public int consult_msg_insert (EvMypageConsultMsgRequestDto evMypageConsultMsgRequestDto) {
        int insertCnt  = evMypageConsultMapper.I03_MSG(evMypageConsultMsgRequestDto);
        return insertCnt;
    }

    /**
     * 상담내용조회
     * @param evMypageConsultMsgRequestDto
     * @return
     */
    public List<EvMypageConsultMsgResponseDto> consult_msg_search (EvMypageConsultMsgRequestDto evMypageConsultMsgRequestDto) {
        List<EvMypageConsultMsgResponseDto> list  = evMypageConsultMapper.S03_MSG_LIST(evMypageConsultMsgRequestDto);
        return list;
    }

    /**
     * 상담고객조회
     * @param evMypageConsultMsgRequestDto
     * @return
     */
    public List<EvMypageConsultMsgResponseDto> consult_cust_msg_search (EvMypageConsultMsgRequestDto evMypageConsultMsgRequestDto) {
        List<EvMypageConsultMsgResponseDto> list  = evMypageConsultMapper.S03_MSG_CUST_LIST(evMypageConsultMsgRequestDto);
        return list;
    }

    /**
     * 상담건수
     * @param evMypageConsultMsgRequestDto
     * @return
     */
    public List<EvMypageConsultMsgResponseDto> consult_count (EvMypageConsultMsgRequestDto evMypageConsultMsgRequestDto) {
        List<EvMypageConsultMsgResponseDto> list  = evMypageConsultMapper.S03_MSG_CNT(evMypageConsultMsgRequestDto);
        return list;
    }

    /**
     * 참관 상담시간 조회
     * @param evMypageConsultRequestDto
     * @return
     */
    public List<EvMypageConsultResponseDto> consult_cust_settime_select (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        List<EvMypageConsultResponseDto> list = evMypageConsultMapper.S04_CUST_SET_TIME(evMypageConsultRequestDto);
        return list;
    }

    /**
     * 참관 상담시간 조회
     * @param evMypageConsultRequestDto
     * @return
     */
    public List<EvMypageConsultScheduleResponseDto> consult_cust_shedule_search (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        List<EvMypageConsultScheduleResponseDto> list = evMypageConsultMapper.S04_CONSULT_SCHEDULE(evMypageConsultRequestDto);
        return list;
    }

    /**
     * 상담 참가기업 정보조회
     * @param evMypageConsultRequestDto
     * @return
     */
    public List<EvMypageConsultScheduleResponseDto> consult_cust_rsv_info_search (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        List<EvMypageConsultScheduleResponseDto> list  = evMypageConsultMapper.S04_CONSULT_RSV_INFO(evMypageConsultRequestDto);
        return list;
    }

    /**
     * 참관 상담고객조회
     * @param evMypageConsultMsgRequestDto
     * @return
     */
    public List<EvMypageConsultMsgResponseDto> consult_cust_msg_search2 (EvMypageConsultMsgRequestDto evMypageConsultMsgRequestDto) {
        List<EvMypageConsultMsgResponseDto> list  = evMypageConsultMapper.S05_MSG_CUST_LIST(evMypageConsultMsgRequestDto);
        return list;
    }

    /**
     * 참관 상담내용조회
     * @param evMypageConsultMsgRequestDto
     * @return
     */
    public List<EvMypageConsultMsgResponseDto> consult_msg_search2 (EvMypageConsultMsgRequestDto evMypageConsultMsgRequestDto) {
        List<EvMypageConsultMsgResponseDto> list  = evMypageConsultMapper.S05_MSG_LIST(evMypageConsultMsgRequestDto);
        return list;
    }

    /**
     * 참관상담건수
     * @param evMypageConsultMsgRequestDto
     * @return
     */
    public List<EvMypageConsultMsgResponseDto> consult_count2 (EvMypageConsultMsgRequestDto evMypageConsultMsgRequestDto) {
        List<EvMypageConsultMsgResponseDto> list  = evMypageConsultMapper.S05_MSG_CNT(evMypageConsultMsgRequestDto);
        return list;
    }

    /**
     * 참관 상담시간 조회 - 상담신청
     * @param evMypageConsultRequestDto
     * @return
     */
    public List<EvMypageConsultScheduleResponseDto> consult_cust_shedule_search2 (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        List<EvMypageConsultScheduleResponseDto> list = evMypageConsultMapper.S06_CONSULT_SCHEDULE(evMypageConsultRequestDto);
        return list;
    }

    /**
     * 참관스케줄정보
     * @param evMypageConsultRequestDto
     * @return
     */
    public List<EvMypageConsultScheduleResponseDto> consult_shedule (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        List<EvMypageConsultScheduleResponseDto> list = evMypageConsultMapper.S07_CONSULT_SCHEDULE(evMypageConsultRequestDto);
        return list;
    }

    /**
     * 참기업체 상담 리스트
     * @param evMypageConsultRequestDto
     * @return
     */
    public List<EvMypageConsultScheduleResponseDto> consult_participation_list (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        List<EvMypageConsultScheduleResponseDto> list = evMypageConsultMapper.S08_CONSULT_LIST(evMypageConsultRequestDto);
        return list;
    }

    /**
     * 참기업체 상담 리스트
     * @param evMypageConsultRequestDto
     * @return
     */
    public List<EvMypageConsultScheduleResponseDto> consult_participation_list_count (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        List<EvMypageConsultScheduleResponseDto> list = evMypageConsultMapper.S08_CONSULT_LIST_COUNT(evMypageConsultRequestDto);
        return list;
    }

    /**
     * 참기업체 상담 리스트
     * @param evMypageConsultRequestDto
     * @return
     */
    public List<EvMypageConsultScheduleResponseDto> consult_visit_list (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        List<EvMypageConsultScheduleResponseDto> list = evMypageConsultMapper.S09_CONSULT_LIST(evMypageConsultRequestDto);
        return list;
    }

    /**
     * 참기업체 상담 리스트
     * @param evMypageConsultRequestDto
     * @return
     */
    public List<EvMypageConsultScheduleResponseDto> consult_visit_list_count (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        List<EvMypageConsultScheduleResponseDto> list = evMypageConsultMapper.S09_CONSULT_LIST_COUNT(evMypageConsultRequestDto);
        return list;
    }

    /**
     * 바로가기콤보
     * @param evMypageConsultRequestDto
     * @return
     */
    public List<EvMypageConsultResponseDto> consult_sunday_list (EvMypageConsultRequestDto evMypageConsultRequestDto) {
        List<EvMypageConsultResponseDto> list = evMypageConsultMapper.S10_CONSULT_DT(evMypageConsultRequestDto);
        return list;
    }
}
