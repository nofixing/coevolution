package kr.coevolution.vr.board.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvBoardTermsResponseDto {

    private String rn;    /* 번호 */
    private Long board_id;  /* 게시판ID */
    private String board_clsf_cd; /* 게시판구분(개인정보처리방침,이용약관,마케팅동의) */
    private String board_content;   /* 내용 */
    private String board_content2;   /* 내용 */
    private String ins_user;
    private String ins_dtm;
    private Long row_count; /* 조회된 row 개수 */
    
}
