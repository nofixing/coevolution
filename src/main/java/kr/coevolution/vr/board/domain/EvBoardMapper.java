package kr.coevolution.vr.board.domain;

import kr.coevolution.vr.board.dto.EvBoardConsltResponseDto;
import kr.coevolution.vr.board.dto.EvBoardRequestDto;
import kr.coevolution.vr.board.dto.EvBoardSearchDto;
import kr.coevolution.vr.board.dto.EvBoardTermsResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface EvBoardMapper {
    /**
     * 통합게시판입력
     * @param param
     * @return
     */
    public int I01_BOARD(EvBoardRequestDto param);

    /**
     * 통합게시판수정
     * @param param
     * @return
     */
    public int U01_BOARD(EvBoardRequestDto param);

    /**
     * 통합게시판삭제
     * @param param
     * @return
     */
    public int U02_BOARD(EvBoardRequestDto param);

    /**
     * 통합게시판 상태 변경
     * @param param
     * @return
     */
    public int U03_BOARD(EvBoardRequestDto param);

    /**
     * 상태업데이트
     * @param param
     * @return
     */
    public int U03_BOARD_STAT(EvBoardRequestDto param);
    /**
     * 1:1 문의 (마이페이지 상담-리스트)
     * @param param
     * @return
     */
    public List<EvBoardConsltResponseDto> S01_CONSLT_LIST (EvBoardSearchDto param);

    /**
     * 1:1 문의 건수 (마이페이지 상담-리스트)
     * @param param
     * @return
     */
    public List<EvBoardConsltResponseDto> S02_CONSLT_LIST_CNT (EvBoardSearchDto param);

    /**
     * 1:1 문의 (마이페이지 상담-상세)
     * @param param
     * @return
     */
    public List<EvBoardConsltResponseDto> S03_CONSLT_DTL (EvBoardSearchDto param);

    /**
     * 모든 필드 조회
     * @param param
     * @return
     */
    public List<Map> S04_BOARD_ALL (EvBoardSearchDto param);

    /**
     * 1:1 문의 (관리자 상담-리스트)
     * @param param
     * @return
     */
    public List<EvBoardConsltResponseDto> S05_CONSLT_LIST (EvBoardSearchDto param);

    /**
     * 1:1 문의 건수 (관리자 상담-리스트)
     * @param param
     * @return
     */
    public List<EvBoardConsltResponseDto> S05_CONSLT_LIST_CNT (EvBoardSearchDto param);

    /**
     * 개인정보처리방침,이용약관,마케팅동의 (관리자 상담-리스트)
     * @param param
     * @return
     */
    public List<EvBoardTermsResponseDto> S06_TERMS_LIST (EvBoardSearchDto param);

    /**
     * 개인정보처리방침,이용약관,마케팅동의 건수 (관리자 상담-리스트)
     * @param param
     * @return
     */
    public List<EvBoardTermsResponseDto> S06_TERMS_LIST_COUNT (EvBoardSearchDto param);

    /**
     * 개인정보처리방침,이용약관,마케팅동의  상세조회
     * @param param
     * @return
     */
    public List<EvBoardTermsResponseDto> S07_TERMS_DTL (EvBoardSearchDto param);
    
}
