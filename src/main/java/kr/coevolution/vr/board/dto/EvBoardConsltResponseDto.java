package kr.coevolution.vr.board.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvBoardConsltResponseDto {

    private String rn;    /* 번호 */
    private Long board_id;  /* 게시판ID */
    private Long board_res_id; /* 게시판ID_답변 */
    private String board_clsf_cd; /* 게시판구분(이벤트관리,1:1문의,공지사항, FAQ, 갤러리,개인정보처리방침,이용약관) */
    private String board_clsf_dtl_cd; /* 게시판구분상세(FAQ : 회원, 뱃지,전시관람,프로그램,기타) */
    private String board_subject;   /* 제목 */
    private String board_content;   /* 내용 */
    private String board_reply_content;   /* 답변 */
    private String conslt_cust_id;  /* 1:1 상담 업체 ID */
    private String conslt_cust_nm;  /* 1:1 상담 업체명 / 부스명 */
    private String reg_dt;          /* 1:1 상담 등록 */
    private String board_stat_cd;   /* 1:1 상담 상태 */
    private String board_stat_nm;   /* 1:1 상담 상태명 */
    private String board_reply_ins_dtm; /* 1:1 상담 답변 일시 */
    private String reg_user_id; /* 요청자ID (1:1문의문의자) */
    private String reg_user_nm; /* 요청자명 (1:1문의문의자) */

    private Long row_count; /* 조회된 row 개수 */
}
