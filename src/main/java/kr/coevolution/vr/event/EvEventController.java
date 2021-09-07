package kr.coevolution.vr.event;

import kr.coevolution.vr.member.dto.EvMemberBadgeRequestDto;
import kr.coevolution.vr.board.service.EvBoardService;
import kr.coevolution.vr.comm.service.EvCommCodeService;
import kr.coevolution.vr.comm.service.EvFileAttachService;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.email.service.EvMailSndService;
import kr.coevolution.vr.event.dto.*;
import kr.coevolution.vr.event.service.*;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.service.EvMemberService;
import kr.coevolution.vr.mypage.service.EvMypageBadgeService;
import kr.coevolution.vr.mypage.service.EvMypageCustCorpInfoService;
import kr.coevolution.vr.mypage.service.EvMypageFavoritsService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.LocaleResolver;
import java.util.Calendar;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Slf4j
@Controller
public class EvEventController {

    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    MessageSource messageSource;

    @Autowired
    LocaleResolver localeResolver;

    @Autowired
    private EvMailSndService mailSndService;

    @Autowired
    private EvCommCodeService evCommCodeService;

    @Autowired
    private EvMemberService evMemberService;

    @Autowired
    private EvMypageCustCorpInfoService evMypageCustCorpInfoService;

    @Autowired
    private EvFileAttachService evFileAttachService;

    @Autowired
    private EvMypageBadgeService evMypageBadgeService;

    @Autowired
    private EvMypageFavoritsService evMypageFavoritsService;

    @Autowired
    private EvBoardService evBoardService;


    @Autowired
    private EvEventService evEventService;

    /**
     * 이벤트 주식 발행
     *
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping("/event/stockissuance")
    public  Map<String,Object> stockissuance(@RequestBody Map map, HttpServletRequest request) {

        Map resposeResult = new HashMap();
        String userId = "";
        String cust_id = "";
        long cust_seq =0;
        String hp_no = "";

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto) httpSession.getAttribute(StringUtils.login_session);


        if(loginInfoDto == null) {
            httpSession.removeAttribute(StringUtils.login_session);
            resposeResult.put("session_yn", "N");
            resposeResult.put("result_code", "-9999");
            resposeResult.put("result_msg", "세션정보없음");
            //return resposeResult;
        } else {
            EvMemberBadgeRequestDto evMemberBadgeRequestDto = new EvMemberBadgeRequestDto();
            userId = loginInfoDto.getCust_id();
            evMemberBadgeRequestDto.setCust_id(userId);
            cust_id = loginInfoDto.getCust_id();
            cust_seq = loginInfoDto.getCust_seq();
            hp_no = loginInfoDto.getHp_no();

            int badgeCnt = evMypageBadgeService.intBadgeCnt(evMemberBadgeRequestDto);
            resposeResult.put("badgeCnt", badgeCnt);
            resposeResult.put("session_yn", "Y");
        }





        try{
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar c1 = Calendar.getInstance();
            java.util.Date dDate = new java.util.Date();
            long lCurTime = dDate.getTime();
            dDate = new java.util.Date(lCurTime+(1000*60*60*24*+1));
            String strToday = sdf.format(c1.getTime());
            String afterToday = sdf.format(dDate);
            System.out.println("strToday" + strToday + "afterToday"  + afterToday);

            EvEventDto evEventDto = new EvEventDto();
            String toDay = "2021-09-07";
            evEventDto.setEvEventDay(strToday); // 이벤트 진행시 strToday 로 교체

            evEventDto.setEpCustSeq(loginInfoDto.getCust_seq());
            evEventDto.setEpCustId(loginInfoDto.getCust_id());
            evEventDto.setEvPersonName(loginInfoDto.getCust_nm());
            evEventDto.setHp(loginInfoDto.getHp_no());

            int personStockCnt  = evEventService.personStockCnt(evEventDto);
            System.out.println("personStockCnt" +personStockCnt);
            if(personStockCnt > 0) {
                resposeResult.put("result_code", "100");
                resposeResult.put("result_msg", "ok");
            } else {
                int personTodayStockCnt = evEventService.personTodayStockCnt(evEventDto); // 1일 3000주
                int totalStockCnt = evEventService.totalStockCnt(); // 전체 주식 발행 수
                System.out.println("personTodayStockCnt" +personTodayStockCnt);
                System.out.println("totalStockCnt" +totalStockCnt);
                int todayStockCnt = 0;

                switch(strToday){
                    case "2021-09-07":
                        todayStockCnt = 3000;
                        break;
                    case "2021-09-08":
                        todayStockCnt = 1801;
                        break;
                    case "2021-09-09":
                        todayStockCnt = 1500;
                        break;
                    case "2021-09-10":
                        todayStockCnt = 1002;
                        break;
                    case "2021-09-11":
                        todayStockCnt = 1001;
                        break;
                    case "2021-09-12":
                        todayStockCnt = 1001;
                        break;
                    case "2021-09-13":
                        todayStockCnt = 600;
                        break;
                    default:
                        todayStockCnt = 3000;
                        break;
                }


                // 1일 주식 3000주 미만
                if(personTodayStockCnt < todayStockCnt) {
                    List<EvEventDto> miniMaxnum = evEventService.miniMaxnum(evEventDto);
                    List<Integer> cards = new ArrayList<Integer>();
                    int miniNum = 0;
                    int maxiMum = 0;
                    int ran = 0;
                    if (miniMaxnum != null) {
                        for (int j = 0; j < miniMaxnum.size(); j++) {
                            int rn = miniMaxnum.get(j).getEvIdx();
                            cards.add(rn);
                        }
                        // System.out.println(cards);
                        Collections.shuffle(cards);
                        if(cards.size() > 0 ) {
                            ran = cards.get(0);
                        }else{
                            resposeResult.put("result_code", "-88");
                            resposeResult.put("result_msg", "ok");
                            return resposeResult;
                        }
                        evEventDto.setEvIdx(ran);
                        List<EvEventDto> stockCodeInfo = evEventService.stockCodeInfo(evEventDto);
                        if (stockCodeInfo != null) {
                            String stockCode = stockCodeInfo.get(0).getEvStockCode();
                            String stockCodeName = stockCodeInfo.get(0).getEvStockCodeName();
                            System.out.println("stockCode==>" + stockCode + "stockCodeName==>" + stockCodeName);
                            resposeResult.put("stockCode", stockCode);
                            resposeResult.put("stockCodeName", stockCodeName);
                            resposeResult.put("cust_id", loginInfoDto.getCust_id());
                            resposeResult.put("cust_seq", loginInfoDto.getCust_seq());
                            resposeResult.put("hp_no", loginInfoDto.getHp_no());
                            resposeResult.put("event_day", strToday); // 이벤트 진행시 strToday  교체
                            resposeResult.put("stockidx", ran); //  주식 테이블 stockidx  교체
                            resposeResult.put("evPersonName", loginInfoDto.getCust_nm());

                            evEventDto.setStockCode(stockCode);
                            evEventDto.setStockCodeName(stockCodeName);
                            evEventDto.setCustid(loginInfoDto.getCust_id());
                            Long iCustSeq = loginInfoDto.getCust_seq();
                            String sCustSeq = String.valueOf(iCustSeq);
                            evEventDto.setCustseq(sCustSeq);
                            evEventDto.setHp(loginInfoDto.getHp_no());
                            evEventDto.setEventday(strToday);
                            int ranStock = ran;
                            evEventDto.setStockidx(Integer.toString(ranStock));
                            evEventDto.setIboardId(1);
                            evEventDto.setEvIdx(ranStock);
                            evEventDto.setEvPersonName(loginInfoDto.getCust_nm());
                            int resultCode = evEventService.saveEvent(evEventDto);
                            int resultStckCode = evEventService.updateEventStock(evEventDto);


                        }
                        System.out.println("miniNum==>" + miniNum + "maxiMum==>" + maxiMum + " ran=>" + ran);

                        resposeResult.put("result_code", "0");
                        resposeResult.put("result_msg", "ok");
                    }
                }else{
                    String afterDay= "2021-09-08";
                    evEventDto.setEvEventAfterDay(afterToday); //이벤트 진행시 afterToday  로 교체
                    List<EvEventDto> miniMaxnum = evEventService.miniMaxnumAfer(evEventDto);
                    List<Integer> cards = new ArrayList<Integer>();
                    int miniNum = 0;
                    int maxiMum = 0;
                    int ran = 0;
                    if (miniMaxnum != null) {
                        for (int j = 0; j < miniMaxnum.size(); j++) {
                            int rn = miniMaxnum.get(j).getEvIdx();
                            cards.add(rn);
                        }
                        System.out.println(cards);
                        Collections.shuffle(cards);
                        ran = cards.get(0);
                        evEventDto.setEvIdx(ran);
                        List<EvEventDto> stockCodeInfo = evEventService.stockCodeInfo(evEventDto);
                        if (stockCodeInfo != null) {
                            String stockCode = stockCodeInfo.get(0).getEvStockCode();
                            String stockCodeName = stockCodeInfo.get(0).getEvStockCodeName();
                            System.out.println("stockCode==>" + stockCode + "stockCodeName==>" + stockCodeName);
                            resposeResult.put("stockCode", stockCode);
                            resposeResult.put("stockCodeName", stockCodeName);
                            resposeResult.put("cust_id", loginInfoDto.getCust_id());
                            resposeResult.put("cust_seq", loginInfoDto.getCust_seq());
                            resposeResult.put("hp_no", loginInfoDto.getHp_no());
                            resposeResult.put("event_day", strToday); // 이벤트 진행시 strToday  교체
                            resposeResult.put("stockidx", ran);
                            resposeResult.put("evPersonName", loginInfoDto.getCust_nm());

                            evEventDto.setStockCode(stockCode);
                            evEventDto.setStockCodeName(stockCodeName);
                            evEventDto.setCustid(loginInfoDto.getCust_id());
                            Long iCustSeq = loginInfoDto.getCust_seq();
                            String sCustSeq = String.valueOf(iCustSeq);
                            evEventDto.setCustseq(sCustSeq);
                            evEventDto.setHp(loginInfoDto.getHp_no());
                            evEventDto.setEventday(strToday);
                            int ranStock = ran;
                            evEventDto.setStockidx(Integer.toString(ranStock));
                            evEventDto.setIboardId(1);
                            evEventDto.setEvIdx(ranStock);
                            evEventDto.setEvPersonName(loginInfoDto.getCust_nm());
                            int resultCode = evEventService.saveEvent(evEventDto);
                            int resultStckCode = evEventService.updateEventStock(evEventDto);
                        }
                        System.out.println("miniNum==>" + miniNum + "maxiMum==>" + maxiMum + " ran=>" + ran);

                        resposeResult.put("result_code", "0");
                        resposeResult.put("result_msg", "ok");
                    }
                }
            }
        }catch (Exception e) {
            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "error");
            e.printStackTrace();

        }


        return resposeResult;
    }

    /**
     * 이벤트 당첨자 저장
     *
     * @param model
     * @return
     */
    @ResponseBody
    @PostMapping("/event/stockprocess")
    public  Map<String,Object> stockprocess(@RequestBody EvEventDto evEventDto, HttpServletRequest request) {

        Map resposeResult = new HashMap();
        /*
        stockCode, stockCodeName, custid, custseq, hp,eventday, stockidx;
        */

        String stockCode = evEventDto.getStockCode();
        String stockCodeName = evEventDto.getStockCodeName();
        String custid = evEventDto.getCustid();
        String custseq = evEventDto.getCustseq();
        String hp = evEventDto.getHp();
        String eventday = evEventDto.getEventday();
        String stockidx = evEventDto.getStockidx();
        String boardId = evEventDto.getBoardId();
        String evPersonName = evEventDto.getEvPersonName();
        int outboardId = Integer.parseInt(boardId);
        int outstockidx = Integer.parseInt(stockidx);



        System.out.println("====>" + stockCode +"|" + stockCodeName+"|" + custid +"|" + custseq+"|" + hp +"|" + eventday+"|" + stockidx+"|" + outboardId +"|" );

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto) httpSession.getAttribute(StringUtils.login_session);

        if(loginInfoDto == null) {
            httpSession.removeAttribute(StringUtils.login_session);
            resposeResult.put("session_yn", "N");
            resposeResult.put("result_code", "-9999");
            resposeResult.put("result_msg", "세션정보없음");
            return resposeResult;
        } else {
            resposeResult.put("session_yn", "Y");
        }

        try{
            /*
            stockCode, stockCodeName, custid, custseq, hp,eventday, stockidx;
            */
            /* 20210907 전단계 저장 */
            /*
            evEventDto.setStockCode(stockCode);
            evEventDto.setStockCodeName(stockCodeName);
            evEventDto.setCustid(custid);
            evEventDto.setCustseq(custseq);
            evEventDto.setHp(hp);
            evEventDto.setEventday(eventday);
            evEventDto.setStockidx(stockidx);
            evEventDto.setIboardId(outboardId);
            evEventDto.setEvIdx(outstockidx);
            evEventDto.setEvPersonName(evPersonName);
            int resultCode = evEventService.saveEvent(evEventDto);
            int resultStckCode = evEventService.updateEventStock(evEventDto);
            */
            resposeResult.put("result_code", "100");
            resposeResult.put("result_msg", "ok");

        }catch (Exception e) {
            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "error");
            e.printStackTrace();

        }


        return resposeResult;
    }

}
