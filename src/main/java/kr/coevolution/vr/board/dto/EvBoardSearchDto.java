package kr.coevolution.vr.board.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EvBoardSearchDto {

    /* 게시판id */
    private Long board_id;
    /* 게시판구분 */
    private String board_clsf_cd;
    /* 게시판상세구분 */
    private String board_clsf_dtl_cd;
    /* 등록일자 시작 */
    private String reg_st_dt;
    /* 등록일자 종료 */
    private String reg_to_dt;
    /* 키워드 구분 */
    private String keyword_clsf_cd;
    /* 키워드 */
    private String keyword;
    /* 제목 */
    private String board_subject;
    /* 내용 */
    private String board_content;
    /* 상태 */
    private String board_stat_cd;
    /* 입력자명 */
    private String reg_user_nm;
    /* 사용여부 */
    private String use_yn;
    /* 답변여부 */
    private String answer_yn;
    /* 참관자 ID */
    private String reg_user_id;
    /* 참가기업ID*/
    private String conslt_cust_id;
    /* 조회 시작 row */
    private Long page_row_start;
    /* 조회 할 개수 */
    private Long page_row_cnt;
    /* 현재페이지 */
    private Long page_current;
    /* 구분코드 101006 개인정보처리방침, 101007 이용약관, 101009 개인정보 마케팅 활용 동의 */
    private String t;

    private String ins_dt_fr;
    private String ins_dt_to;

    private String ev_expo_id;

}
