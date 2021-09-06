package kr.coevolution.vr.mgnt.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class EvMgntEventDto {
    private int epId;
    private int epEvtId;
    private String epPersonName;
    private String epHp;
    private String epEmail;
    private String epEmail2;
    private String epPostcode;
    private String epAddr1;
    private String epAddr2;
    private String epStockCode;
    private String epStockCodeName;
    private String epStockDay;
    private String epTemp1;
    private String epTemp2;
    private String epTemp3;
    private String epTemp4;
    private String epTemp5;
    private String epTemp6;
    private String epTemp7;
    private String epTemp8;
    private String epTemp9;
    private String epTemp10;
    private String epCustId;
    private String epCustSeq;


    private Long rn;
    private Long row_count;
    private String regDt;
    private int evEvtId;           /* 순차 */
    private String evEvtSubject;   /* 제목 */
    private String evStartdt;     /* 시작일 */
    private String evEnddt;      /* 종료일 */
    private String evContents;   /* 내용*/
    private String evCheck;      /* 노출여부 */
    private String evRegdt;     /* 등록일 */
    private String evTemp1;     /* 여분필드1 */
    private String evTemp2;     /* 여분필드2 */
    private String evTemp3;     /* 여분필드3 */
    private String evTemp4;     /* 여분필드4 */
    private String evTemp5;     /* 여분필드5 */
    private String evEvtRegistid;  /* 등록자아이디 */
    private String evEvtRegistname; /* 등록자명 */
    private int  evEvtViewcnt;      /*  조회수 */
    private int  evEvtperctn;       /* 참여자 */
    private String evEvtGubun;      /* 이벤트구분 */
    private String evEvtAppStartdt;  /*  이벤트시작일 */
    private String evEvtAppEnddt;    /* 이벤트종료일 */
    private String evEvtappEnddtSi;   /* 이벤트시작시간 */
    private String evEvtAppStartdtSi;  /* 이벤트종료시간 */
    private Long page_row_start;    /* 조회 시작 row */
    private Long page_row_cnt;      /* 조회 할 개수 */
    private Long page_current;      /* 현재페이지 */
    private String ins_dt_fr;
    private String ins_dt_to;
    private String keyword;

    private String evStockCode;
    private String evStockCodeName;
    private int evStockWinningOri;
    private int evStockWinning;
    private String evEventDay;

}
