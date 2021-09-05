package kr.coevolution.vr.event.dto;


import lombok.Getter;
import lombok.Setter;


@Setter
@Getter
public class EvEventDto {

    public int maximum;
    private int sumStockCnt;  /* 주식 총 개수 */
    private String evEventDay;
    private int evIdx;
    private String evStockCode;
    private String evStockCodeName;
    private int evStockWinningOri;
    private int evStockWinning;
    private String evEventUpdate;
    public int minimum;
    public String evIdxs;
    private String epCustId;
    private Long epCustSeq;
    private String evEventAfterDay;
    private String evPersonName;


    private String stockCode;
    private String stockCodeName;
    private String custid;
    private String custseq;
    private String hp;
    private String eventday;
    private String stockidx;
    private String boardId;
    private int iboardId;




    private Long page_row_start;    /* 조회 시작 row */
    private Long page_row_cnt;      /* 조회 할 개수 */
    private Long page_current;      /* 현재페이지 */



}
