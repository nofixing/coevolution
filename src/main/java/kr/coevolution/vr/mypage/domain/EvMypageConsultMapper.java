package kr.coevolution.vr.mypage.domain;

import kr.coevolution.vr.mypage.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EvMypageConsultMapper {

    /* 참가업체 상담시간설정 */
    public int I01_SET_TIME(EvMypageConsultRequestDto param);

    /* 참가업체 상담시간설정 수정 */
    public int U01_SET_TIME(EvMypageConsultRequestDto param);

    /* 참가업체 상담시간설정 - 타임존 수정 */
    public int U01_SET_TIMEZONE(EvMypageConsultRequestDto param);

    /* 참가업체 상담시간설정 조회 */
    public List<EvMypageConsultResponseDto> S01_SET_TIME(EvMypageConsultRequestDto param);

    /* 참가업체 상담시간 입력 */
    public int I02_CONSULT_SCHEDULE1(EvMypageConsultRequestDto param);

    /* 참가업체 상담시간 입력 - 건별(수정) */
    public int I02_CONSULT_SCHEDULE2(EvMypageConsultRequestDto param);

    /* 참가업체 상담시간 입력 - 건별(수정) - 이전내역 삭제처리 */
    public int U02_CONSULT_SCHEDULE(EvMypageConsultRequestDto param);

    /* 참가업체 상담스케줄 조회 */
    public List<EvMypageConsultScheduleResponseDto> S01_CONSULT_SCHEDULE(EvMypageConsultRequestDto param);

    /* 참가업체 예약자 조회 */
    public List<EvMypageConsultScheduleResponseDto> S02_RSV_INFO(EvMypageConsultRequestDto param);

    /* 상담내용전송 */
    public int I03_MSG(EvMypageConsultMsgRequestDto param);

    /* 상담리스트 */
    public List<EvMypageConsultMsgResponseDto> S03_MSG_LIST(EvMypageConsultMsgRequestDto param);

    /* 상담 고객 리스트 */
    public List<EvMypageConsultMsgResponseDto> S03_MSG_CUST_LIST(EvMypageConsultMsgRequestDto param);

    /* 상담 건수 */
    public List<EvMypageConsultMsgResponseDto> S03_MSG_CNT(EvMypageConsultMsgRequestDto param);

    /* 참관업체 상담시간설정 조회 */
    public List<EvMypageConsultResponseDto> S04_CUST_SET_TIME(EvMypageConsultRequestDto param);

    /* 참관 상담스케줄 조회 */
    public List<EvMypageConsultScheduleResponseDto> S04_CONSULT_SCHEDULE(EvMypageConsultRequestDto param);

    /* 참가업체 정보 조회 */
    public List<EvMypageConsultScheduleResponseDto> S04_CONSULT_RSV_INFO(EvMypageConsultRequestDto param);

    /* 참관 상담리스트 */
    public List<EvMypageConsultMsgResponseDto> S05_MSG_CUST_LIST(EvMypageConsultMsgRequestDto param);

    /* 참관 상담리스트 */
    public List<EvMypageConsultMsgResponseDto> S05_MSG_LIST(EvMypageConsultMsgRequestDto param);

    /* 참관 상담 건수 */
    public List<EvMypageConsultMsgResponseDto> S05_MSG_CNT(EvMypageConsultMsgRequestDto param);

    /* 참관 상담스케줄 조회 - 상담신청 */
    public List<EvMypageConsultScheduleResponseDto> S06_CONSULT_SCHEDULE(EvMypageConsultRequestDto param);

    /* 참관 스케줄 정보 */
    public List<EvMypageConsultScheduleResponseDto> S07_CONSULT_SCHEDULE(EvMypageConsultRequestDto param);

    /* 참가업체 상담리스트 */
    public List<EvMypageConsultScheduleResponseDto> S08_CONSULT_LIST(EvMypageConsultRequestDto param);

    /* 참가업체 상담리스트 건수 */
    public List<EvMypageConsultScheduleResponseDto> S08_CONSULT_LIST_COUNT(EvMypageConsultRequestDto param);




}
