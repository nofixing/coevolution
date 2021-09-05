package kr.coevolution.vr.board.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvBoardResponseDto {

    private String rn;    /* 번호 */

    /* 게시판ID */
    private Long board_id;
    /* 게시판순번_답변 */
    private Long board_res_id;
    /* 게시판구분 */
    private String board_clsf_cd;
    /* 게시판구분상세 */
    private String board_clsf_dtl_cd;
    /* 등록일자 */
    private String reg_dt;
    /* 제목 */
    private String board_subject;
    /* 내용 */
    private String board_content;

    private String board_content2;

    /* url */
    private String ref_url;
    /* 참여자 */
    private String evnt_pticpt;
    /* 대상자 */
    private String evnt_target;
    /* 장소 */
    private String evnt_place;
    /* 이벤트기간 */
    private String evnt_prod_dt;
    /* 이벤트시작일자 */
    private String evnt_fr_dt;
    /* 이벤트종료일자 */
    private String evnt_to_dt;
    /* 신청시작일자 */
    private String req_fr_dt;
    /* 신청시작일시 */
    private String req_fr_hhmm;
    /* 신청종료일자 */
    private String req_to_dt;
    /* 신청종료일시 */
    private String req_to_hhmm;
    /* 사용여부 */
    private String use_yn;
    /* 삭제여부 */
    private String del_yn;
    /* 상태 */
    private String board_stat_cd;
    /* 요청자ID */
    private String reg_user_id;
    /* 1:1문의업체ID */
    private String conslt_cust_id;
    /* 1:1문의답변자 */
    private String conslt_user_id;
    /* 사용자ID */
    private String user_id;
    /* 리플등록여부 */
    private String reply_yn;

    private String ins_user;

    private String ins_dtm;

    private Long row_count; /* 조회된 row 개수 */

    private Long board_cnt; /* 게시판 조회수 */

    private String event_alert;

    private String event_show_clsf;
}
