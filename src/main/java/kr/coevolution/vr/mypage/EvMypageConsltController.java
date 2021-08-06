package kr.coevolution.vr.mypage;

import kr.coevolution.vr.board.dto.EvBoardConsltResponseDto;
import kr.coevolution.vr.board.dto.EvBoardRequestDto;
import kr.coevolution.vr.board.dto.EvBoardSearchDto;
import kr.coevolution.vr.comm.dto.EvCommCodeRequestDto;
import kr.coevolution.vr.comm.dto.EvCommCodeResponseDto;
import kr.coevolution.vr.comm.dto.EvExpoRequestDto;
import kr.coevolution.vr.comm.dto.EvExpoResponseDto;
import kr.coevolution.vr.comm.service.EvCommCodeService;
import kr.coevolution.vr.comm.service.EvExpoService;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.dto.EvMemberLoginRequestDto;
import kr.coevolution.vr.member.dto.EvMemberResposeDto;
import kr.coevolution.vr.member.dto.EvMemberSearchDto;
import kr.coevolution.vr.member.service.EvMemberService;
import kr.coevolution.vr.mypage.dto.*;
import kr.coevolution.vr.mypage.service.EvMypageBoardConsltService;
import kr.coevolution.vr.mypage.service.EvMypageConsultService;
import kr.coevolution.vr.mypage.service.EvMypageCustCorpInfoService;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;

@Slf4j
@NoArgsConstructor
@Controller
public class EvMypageConsltController {

    @Autowired
    private EvMypageBoardConsltService evMypageBoardConsltService;

    @Autowired
    private EvCommCodeService evCommCodeService;

    @Autowired
    private EvExpoService evExpoService;

    @Autowired
    private EvMypageConsultService evMypageConsultService;

    @Autowired
    private EvMypageCustCorpInfoService evMypageCustCorpInfoService;

    @Autowired
    private EvMemberService evMemberService;


    /**
     * 마이페이지 상담문의 조회
     * @param evBoardSearchDto
     * @param request
     * @return
     */
    @RequestMapping("/mypage/conslt_list")
    public String mypage_conslt_list (EvBoardSearchDto evBoardSearchDto, HttpServletRequest request, Model model) {

        String returnUrl = "";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/member/login_form";
                return returnUrl;
            }

            if("202001".equals(loginInfoDto.getCust_clsf_cd())) {
                /* 참관고객 */
                evBoardSearchDto.setReg_user_id(loginInfoDto.getCust_id());
                evBoardSearchDto.setConslt_cust_id("");

                returnUrl = "/mypage/myp03";
                model.addAttribute("page_clsf", "myp03");

            } else {
                /* 참가고객 */
                evBoardSearchDto.setReg_user_id("");
                evBoardSearchDto.setConslt_cust_id(loginInfoDto.getCust_id());

                returnUrl = "/mypage/myc04";
                model.addAttribute("page_clsf", "myc04");
            }

            /* row 개수 */
            evBoardSearchDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evBoardSearchDto.getPage_current());
            evBoardSearchDto.setPage_row_start(page_row_start);

            List<EvBoardConsltResponseDto> list = evMypageBoardConsltService.mypage_conslt_list(evBoardSearchDto);
            List<EvBoardConsltResponseDto> listCnt = evMypageBoardConsltService.mypage_conslt_list_count(evBoardSearchDto);

            Long row_count = 0L;
            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count();
            }

            if("".equals(StringUtils.nvl(evBoardSearchDto.getPage_current(),""))) {
                evBoardSearchDto.setPage_current(1L);
            }

            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총 개수 */
            model.addAttribute("page_row_cnt", evBoardSearchDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evBoardSearchDto.getPage_current());    /* 현재페이지 */
            
            /* 검색조건 */
            model.addAttribute("board_stat_cd", evBoardSearchDto.getBoard_stat_cd());
            model.addAttribute("keyword_clsf_cd", evBoardSearchDto.getKeyword_clsf_cd());
            model.addAttribute("keyword", evBoardSearchDto.getKeyword());

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 마이페이지 상담문의 상세
     * @param evBoardSearchDto
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/mypage/conslt_dtl")
    public Map<String,Object> mypage_conslt_dtl (@RequestBody EvBoardSearchDto evBoardSearchDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            if("".equals(StringUtils.nvl(evBoardSearchDto.getBoard_id(),""))) {
                throw new RuntimeException("ID없음");
            }

            List<EvBoardConsltResponseDto> list = evMypageBoardConsltService.mypage_conslt_dtl(evBoardSearchDto);
            resposeResult.put("data", list);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * VR문의사항 입력
     * @param evBoardRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/vr/conslt/insert")
    public Map<String,Object> vr_conslt_insert (@RequestBody EvBoardRequestDto evBoardRequestDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            evBoardRequestDto.setReg_user_id(loginInfoDto.getUser_id());
            evBoardRequestDto.setUser_id(loginInfoDto.getUser_id());
            evBoardRequestDto.setBoard_clsf_cd("101002"); /* 1:1 문의게시판 */
            evBoardRequestDto.setBoard_stat_cd("104001"); /* 답변대기 */
            evBoardRequestDto.setBoard_res_id(0L); /* 게시판ID_답변 */

            int return_code = evMypageBoardConsltService.vr_conslt_insert(evBoardRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    @ResponseBody
    @PostMapping("/vr/conslt/reply")
    public Map<String,Object> vr_conslt_reply (@RequestBody EvBoardRequestDto evBoardRequestDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if("".equals(StringUtils.nvl(evBoardRequestDto.getBoard_id(),""))) {
                throw new RuntimeException("ID없음");
            }

            evBoardRequestDto.setUser_id(loginInfoDto.getUser_id());
            evBoardRequestDto.setConslt_user_id(loginInfoDto.getUser_id()); /* 답변자 */
            evBoardRequestDto.setBoard_clsf_cd("101002"); /* 1:1 문의게시판 */
            evBoardRequestDto.setBoard_stat_cd("104002"); /* 답변완료 */
            evBoardRequestDto.setBoard_res_id(evBoardRequestDto.getBoard_id()); /* 게시판ID_답변 */


            /* 답변입력 */
            int return_code = evMypageBoardConsltService.vr_conslt_insert(evBoardRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    @ResponseBody
    @PostMapping("/vr/conslt/delete")
    public Map<String,Object> vr_conslt_delete (@RequestBody EvBoardRequestDto evBoardRequestDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            evBoardRequestDto.setUser_id(loginInfoDto.getUser_id());

            if("".equals(StringUtils.nvl(evBoardRequestDto.getBoard_id(),""))) {
                throw new RuntimeException("ID없음");
            }

            /* 삭제처리 */
            evBoardRequestDto.setDel_yn("Y");
            int return_code = evMypageBoardConsltService.mypage_conslt_del(evBoardRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 상담설정-코드조회
     * @param evMypageConsultRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mypage/consltset")
    public String mypage_conslt_set (EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/member/login_form";
                return returnUrl;
            } else {
                returnUrl = "/mypage/myc06";
            }

            /* 타임존 조회 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("213000");
            List<EvCommCodeResponseDto> timezoneList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* Expo 정보조회 (예약가능일자조회) */
            EvExpoRequestDto evExpoRequestDtoDto = new EvExpoRequestDto();
            evExpoRequestDtoDto.setCust_id(loginInfoDto.getCust_id());
            List<EvExpoResponseDto> expoInfo = evExpoService.expo_info_search(evExpoRequestDtoDto);
            String consultFromDt = "";
            String consultToDt = "";
            String sunday = "";
            int evExpoId = 0;

            if(expoInfo != null && expoInfo.size() == 1) {
                consultFromDt = expoInfo.get(0).getExpo_consult_from_dt();
                consultToDt = expoInfo.get(0).getExpo_consult_to_dt();
                evExpoId = expoInfo.get(0).getEv_expo_id();
                sunday = expoInfo.get(0).getSunday();
            }

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

            /* 전주(left), 다음주(right) 구분 */
            if("left".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_cls_cd(),""))) {
                Date leftDt = sf.parse(evMypageConsultRequestDto.getSunday());
                long leftTime = leftDt.getTime() - (1000 * 60 * 60 * 24 * 7);
                leftDt.setTime(leftTime);
                sunday = sf.format(leftDt);
            } else if("right".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_cls_cd(),""))) {
                Date rightDt = sf.parse(evMypageConsultRequestDto.getSunday());
                long leftTime = rightDt.getTime() + (1000 * 60 * 60 * 24 * 7);
                rightDt.setTime(leftTime);
                sunday = sf.format(rightDt);
            } else if("now".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_cls_cd(),""))) {
                sunday = evMypageConsultRequestDto.getSunday();
            }

            evMypageConsultRequestDto.setCust_id(loginInfoDto.getCust_id());
            evMypageConsultRequestDto.setEv_expo_id(evExpoId);

            /* 상담-설정조회 */
            List<EvMypageConsultResponseDto> consultSetting = evMypageConsultService.consult_settime_select(evMypageConsultRequestDto);

            Long consultTimeId = 0L; String tiemzone_cd = "213001", consult_from_time = "", consult_to_time = "", timezone_hhmm_fr = "", timezone_hhmm_to = "";

            if(consultSetting != null && consultSetting.size() == 1) {
                consultTimeId = consultSetting.get(0).getConsult_time_id();
                tiemzone_cd = consultSetting.get(0).getTiemzone_cd();
                consult_from_time = consultSetting.get(0).getConsult_from_time();
                consult_to_time = consultSetting.get(0).getConsult_to_time();

                /* 타이존시간 00:00, 00:30 ... */
                timezone_hhmm_fr = consultSetting.get(0).getTimezone_hhmm_fr();
                timezone_hhmm_to = consultSetting.get(0).getTimezone_hhmm_to();
            }

            /* 예약시간 조회 한국:cd_nm, 중국상하이:cd_val1, 영국런던:cd_val2, 미국뉴욕:cd_val3*/
            evCommCodeRequestDto.setUpper_cd_id("214000");
            List<EvCommCodeResponseDto> timeList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 상담가능기간 체크 */
            evMypageConsultRequestDto.setExpo_consult_from_dt(consultFromDt);
            evMypageConsultRequestDto.setExpo_consult_to_dt(consultToDt);
            evMypageConsultRequestDto.setConsult_time_id(consultTimeId);
            evMypageConsultRequestDto.setEv_expo_id(evExpoId);
            evMypageConsultRequestDto.setSunday(sunday); //요일을 일요일부터 표시한다.
            evMypageConsultRequestDto.setConsult_from_time(consult_from_time);
            evMypageConsultRequestDto.setConsult_to_time(consult_to_time);
            evMypageConsultRequestDto.setTiemzone_cd(tiemzone_cd);
            evMypageConsultRequestDto.setTimezone_hhmm_fr(timezone_hhmm_fr);
            evMypageConsultRequestDto.setTimezone_hhmm_to(timezone_hhmm_to);
            evMypageConsultRequestDto.setPage_clsf("consltset");

            /* 시간별 상담내역 */
            Map<String,Object> consultMap = new HashMap<>();
            if(consultSetting != null && consultSetting.size() == 1) {
                consultMap = getTimeList(evMypageConsultRequestDto);
            }

            model.addAttribute("page_clsf", "myc06");
            model.addAttribute("timezoneList", timezoneList);
            model.addAttribute("consult_from_dt", consultFromDt);
            model.addAttribute("consult_to_dt", consultToDt);
            model.addAttribute("timeList", timeList);

            /* 시간별 상담내역 - 헤더건수 */
            model.addAttribute("header_cnt", consultMap.get("period"));

            /* 시간별 상담내역 */
            model.addAttribute("consultList", consultMap.get("newList"));

            /* 상담-설정조회 */
            model.addAttribute("consult_time_id", consultTimeId);
            model.addAttribute("tiemzone_cd", tiemzone_cd);
            model.addAttribute("consult_from_time", consult_from_time);
            model.addAttribute("consult_to_time", consult_to_time);

            /* 상담 일요일 */
            model.addAttribute("sunday", sunday);

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 상담시간설정
     * @param evMypageConsultRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mypage/consult_settime")
    public Map<String,Object> mypage_consult_settime (@RequestBody EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request) {

        Map<String,Object> resposeResult = new HashMap<String,Object>();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            evMypageConsultRequestDto.setCust_id(loginInfoDto.getUser_id());
            evMypageConsultRequestDto.setUser_id(loginInfoDto.getUser_id());

            SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
            String ndt = sf.format(new Date());

            /* 상담가능기간 체크 */
            EvExpoResponseDto evExpoResponseDto = (EvExpoResponseDto)request.getSession().getAttribute(StringUtils.expo_info_session);
            evMypageConsultRequestDto.setExpo_consult_from_dt(evExpoResponseDto.getExpo_consult_from_dt());
            evMypageConsultRequestDto.setExpo_consult_to_dt(evExpoResponseDto.getExpo_consult_to_dt());

            if(!evMypageConsultRequestDto.getConsult_from_dt().equals(evExpoResponseDto.getExpo_consult_from_dt())
                    || !evMypageConsultRequestDto.getConsult_to_dt().equals(evExpoResponseDto.getExpo_consult_to_dt())) {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "상담 기간이 아닙니다.");
            } else if(Long.parseLong(evExpoResponseDto.getApct_prod_from_dt().replace("-","")) > Long.parseLong(ndt)
                    || Long.parseLong(evExpoResponseDto.getApct_prod_to_dt().replace("-","")) < Long.parseLong(ndt)) {
                resposeResult.put("result_code", "-2");
                resposeResult.put("result_msg", "상담설정 기간이 아닙니다.");
            } else {
                int return_code = 0;
                evMypageConsultRequestDto.setEv_expo_id(evExpoResponseDto.getEv_expo_id());
                if(Long.parseLong(StringUtils.nvl(evMypageConsultRequestDto.getConsult_time_id(),"0")) > 0) {
                    return_code = evMypageConsultService.consult_settime_update(evMypageConsultRequestDto);
                } else {
                    return_code = evMypageConsultService.consult_settime_insert(evMypageConsultRequestDto);
                }

                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 상담시간 테이블 구성
     * @param evMypageConsultRequestDto
     * @return
     */
    private Map<String,Object> getTimeList(EvMypageConsultRequestDto evMypageConsultRequestDto) {

        Map<String,Object> rtrMap = new HashMap<>();
        List<Map<String,String>> newList = new ArrayList<>();
        List<EvMypageConsultScheduleResponseDto> list = null;

        if("myp09".equals(evMypageConsultRequestDto.getPage_clsf())) {
            list = evMypageConsultService.consult_cust_shedule_search2(evMypageConsultRequestDto);
        } else {
            list = evMypageConsultService.consult_shedule_search(evMypageConsultRequestDto);
        }

        String expoFromDt = evMypageConsultRequestDto.getExpo_consult_from_dt();
        String expoToDt = evMypageConsultRequestDto.getExpo_consult_to_dt();
        String sunday = evMypageConsultRequestDto.getSunday();
        String formTimeCd = evMypageConsultRequestDto.getConsult_from_time();
        String toTimeCd = evMypageConsultRequestDto.getConsult_to_time();
        String timezone_hhmm_fr = expoFromDt.replace("-","") + evMypageConsultRequestDto.getTimezone_hhmm_fr().replace(":","");
        String timezone_hhmm_to = expoToDt.replace("-","") + evMypageConsultRequestDto.getTimezone_hhmm_to().replace(":","");

        /* 예약시간 조회 */
        EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();

        evCommCodeRequestDto.setUpper_cd_id("214000");

        if("213001".equals(evMypageConsultRequestDto.getTiemzone_cd())) { //대한민국,서울
            evCommCodeRequestDto.setOrder_by("cd_nm asc");
        } else if("213002".equals(evMypageConsultRequestDto.getTiemzone_cd())) { //중국,상하이
            evCommCodeRequestDto.setOrder_by("cd_val1 asc");
        } else if("213003".equals(evMypageConsultRequestDto.getTiemzone_cd())) { //영국,런던
            evCommCodeRequestDto.setOrder_by("cd_val2 asc");
        } else if("213004".equals(evMypageConsultRequestDto.getTiemzone_cd())) { //미국,뉴욕
            evCommCodeRequestDto.setOrder_by("cd_val3 asc");
        }

        List<EvCommCodeResponseDto> timeList  = evCommCodeService.comm_code_search_sort(evCommCodeRequestDto);

        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sf2 = new SimpleDateFormat("M/d (EEE)");
        SimpleDateFormat sf3 = new SimpleDateFormat("E");

        try {
            Date dateExpoFromDt = sf.parse(expoFromDt);
            Date dateExpoToDt = sf.parse(expoToDt);
            Date sundayDt = sf.parse(sunday);

            /* header 생성 */
            int key = 0;
            Map<String, String> headerMap = new HashMap<>();

            /*
            long diff = dateExpoToDt.getTime() - dateExpoFromDt.getTime() + 1;
            TimeUnit time = TimeUnit.DAYS;
            long period = time.convert(diff, TimeUnit.MILLISECONDS);
            */

            //시작일을 일요일로 설정한다.

            long period = 7;
            rtrMap.put("period",7);

            headerMap.put("k" + (++key), "시간");

            Calendar cal = Calendar.getInstance();
            Date setFromDt = sundayDt;
            for(int i = 0; i <= period; i++) {
                headerMap.put("k" + (++key), sf2.format(setFromDt));

                cal.setTime(setFromDt);
                cal.add(Calendar.DATE, 1);
                setFromDt = cal.getTime();
            }

            newList.add(headerMap);

            for(EvCommCodeResponseDto evCommCodeResponseDto : timeList) {

                if(Integer.parseInt(evCommCodeResponseDto.getCd_id()) < Integer.parseInt(formTimeCd)
                        || Integer.parseInt(evCommCodeResponseDto.getCd_id()) > Integer.parseInt(toTimeCd)) {
                    continue;
                }

                /* 시간설정 */
                key = 0;
                String frhhmm = "", tohhmm = "";
                Map<String, String> consultMap = new HashMap<>();

                if("213001".equals(evMypageConsultRequestDto.getTiemzone_cd())) { //대한민국,서울
                    consultMap.put("k" + (++key), evCommCodeResponseDto.getCd_nm());
                } else if("213002".equals(evMypageConsultRequestDto.getTiemzone_cd())) { //중국,상하이
                    consultMap.put("k" + (++key), evCommCodeResponseDto.getCd_val1());
                } else if("213003".equals(evMypageConsultRequestDto.getTiemzone_cd())) { //영국,런던
                    consultMap.put("k" + (++key), evCommCodeResponseDto.getCd_val2());
                } else if("213004".equals(evMypageConsultRequestDto.getTiemzone_cd())) { //미국,뉴욕
                    consultMap.put("k" + (++key), evCommCodeResponseDto.getCd_val3());
                }

                cal = Calendar.getInstance();
                setFromDt = sundayDt;

                for(int j = 0; j <= period; j++) {

                    /* 상담시간리스트 */
                    String formatFromDt = sf.format(setFromDt);
                    boolean chkRow = false;
                    for(EvMypageConsultScheduleResponseDto schedule : list) {

                        /* 시간과 일자가 같을 경우 put */
                        //if(schedule.getConsult_dt().equals(formatFromDt) && schedule.getConsult_time_cd().equals(evCommCodeResponseDto.getCd_id())) {

                        String cYMDHM = StringUtils.nvl(schedule.getConsult_dt(),"").replace("-","") + StringUtils.nvl(schedule.getConsult_time_nm(),"").replace(":","");

                        if(schedule.getConsult_dt().equals(formatFromDt)
                                && schedule.getConsult_time_cd().equals(evCommCodeResponseDto.getCd_id())
                                && Long.parseLong(timezone_hhmm_fr) <= Long.parseLong(cYMDHM)
                                && Long.parseLong(cYMDHM) <= Long.parseLong(timezone_hhmm_to)) {
                            key++;
                            consultMap.put("k" + key + "_scheduleId"        , StringUtils.nvl(schedule.getSchedule_id(),""));
                            consultMap.put("k" + key + "_consultTimeId"     , StringUtils.nvl(schedule.getConsult_time_id(),""));
                            consultMap.put("k" + key + "_consultRsvCustId"  , StringUtils.nvl(schedule.getConsult_rsv_cust_id(),""));
                            consultMap.put("k" + key + "_consultRsvCustNm"  , StringUtils.nvl(schedule.getConsult_rsv_cust_nm(),""));
                            consultMap.put("k" + key + "_consultAvailYn"    , StringUtils.nvl(schedule.getConsult_avail_yn(),""));
                            consultMap.put("k" + key + "_consultRsvStatCd"  , StringUtils.nvl(schedule.getConsult_rsv_stat_cd(),""));
                            consultMap.put("k" + key + "_telNo"             , StringUtils.nvl(schedule.getTel_no(),""));
                            chkRow = true;
                        }
                    }

                    if(!chkRow) ++key;

                    //색상표를 위해 엑스포기간을 체크한다.
                    if(Integer.parseInt(expoFromDt.replace("-","")) <= Integer.parseInt(formatFromDt.replace("-",""))
                            && Integer.parseInt(expoToDt.replace("-","")) >= Integer.parseInt(formatFromDt.replace("-",""))) {
                        consultMap.put("k" + key + "_expoYn"  , "Y");
                    }

                    cal.setTime(setFromDt);
                    cal.add(Calendar.DATE, 1);
                    setFromDt = cal.getTime();
                }

                newList.add(consultMap);
            }

            rtrMap.put("newList",newList);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rtrMap;
    }

    /**
     * 상담시간 설정
     * @param evMypageConsultRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mypage/consult_set_yn")
    public Map<String,Object> mypage_consult_set_yn (@RequestBody EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request) {

        Map<String,Object> resposeResult = new HashMap<String,Object>();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            evMypageConsultRequestDto.setCust_id(loginInfoDto.getUser_id());
            evMypageConsultRequestDto.setUser_id(loginInfoDto.getUser_id());

            EvExpoResponseDto evExpoResponseDto = (EvExpoResponseDto)request.getSession().getAttribute(StringUtils.expo_info_session);
            evMypageConsultRequestDto.setEv_expo_id(evExpoResponseDto.getEv_expo_id());

            /* 현재상태체크 */
            List<EvMypageConsultScheduleResponseDto> list = evMypageConsultService.consult_shedule_search(evMypageConsultRequestDto);

            if(list != null && list.size() == 1) {

                EvMypageConsultScheduleResponseDto evMypageConsultScheduleResponseDto = list.get(0);
                String availYn = evMypageConsultScheduleResponseDto.getConsult_avail_yn();

                /* 기존정보를 입력 */
                evMypageConsultService.consult_shedule_delete(evMypageConsultRequestDto); /* del_yn = 'Y' */

                if("Y".equals(availYn))
                    evMypageConsultRequestDto.setConsult_avail_yn("N");
                else
                    evMypageConsultRequestDto.setConsult_avail_yn("Y");

                evMypageConsultService.consult_shedule_insert(evMypageConsultRequestDto); /* 변경된 정보 입력 */

                log.debug("getSchedule_id() : " + evMypageConsultRequestDto.getSchedule_id());

                resposeResult.put("schedule_id", evMypageConsultRequestDto.getSchedule_id());
                resposeResult.put("consult_avail_yn", evMypageConsultRequestDto.getConsult_avail_yn());
                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");

            } else {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "해당내역이 없습니다.");
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;

    }

    /**
     * 상담예약현황-달력
     * @param evMypageConsultRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myc07")
    public String mypage_myc07 (EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/member/login_form";
                return returnUrl;
            } else {
                returnUrl = "/mypage/myc07";
            }

            /* 타임존 조회 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("213000");
            List<EvCommCodeResponseDto> timezoneList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* Expo 정보조회 (예약가능일자조회) */
            EvExpoRequestDto evExpoRequestDtoDto = new EvExpoRequestDto();
            evExpoRequestDtoDto.setCust_id(loginInfoDto.getCust_id());
            List<EvExpoResponseDto> expoInfo = evExpoService.expo_info_search(evExpoRequestDtoDto);
            String consultFromDt = "";
            String consultToDt = "";
            String sunday = "";
            int evExpoId = 0;

            if(expoInfo != null && expoInfo.size() == 1) {
                consultFromDt = expoInfo.get(0).getExpo_consult_from_dt();
                consultToDt = expoInfo.get(0).getExpo_consult_to_dt();
                evExpoId = expoInfo.get(0).getEv_expo_id();
                sunday = expoInfo.get(0).getSunday();

            }

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

            /* 전주(left), 다음주(right) 구분 */
            if("left".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_cls_cd(),""))) {
                Date leftDt = sf.parse(evMypageConsultRequestDto.getSunday());
                long leftTime = leftDt.getTime() - (1000 * 60 * 60 * 24 * 7);
                leftDt.setTime(leftTime);
                sunday = sf.format(leftDt);
            } else if("right".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_cls_cd(),""))) {
                Date rightDt = sf.parse(evMypageConsultRequestDto.getSunday());
                long leftTime = rightDt.getTime() + (1000 * 60 * 60 * 24 * 7);
                rightDt.setTime(leftTime);
                sunday = sf.format(rightDt);
            } else if("now".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_cls_cd(),""))) {
                sunday = evMypageConsultRequestDto.getSunday();
            }

            evMypageConsultRequestDto.setCust_id(loginInfoDto.getCust_id());
            evMypageConsultRequestDto.setEv_expo_id(evExpoId);

            /* 상담-설정조회 */
            List<EvMypageConsultResponseDto> consultSetting = evMypageConsultService.consult_settime_select(evMypageConsultRequestDto);

            Long consultTimeId = 0L; String tiemzone_cd = "", consult_from_time = "", consult_to_time = "", timezone_hhmm_fr = "", timezone_hhmm_to = "";

            if(consultSetting != null && consultSetting.size() == 1) {
                consultTimeId = consultSetting.get(0).getConsult_time_id();
                tiemzone_cd = consultSetting.get(0).getTiemzone_cd();
                consult_from_time = consultSetting.get(0).getConsult_from_time();
                consult_to_time = consultSetting.get(0).getConsult_to_time();

                /* 타이존시간 00:00, 00:30 ... */
                timezone_hhmm_fr = consultSetting.get(0).getTimezone_hhmm_fr();
                timezone_hhmm_to = consultSetting.get(0).getTimezone_hhmm_to();
            }

            /* 예약시간 조회 */
            evCommCodeRequestDto.setUpper_cd_id("214000");
            List<EvCommCodeResponseDto> timeList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 상담가능기간 체크 */
            evMypageConsultRequestDto.setExpo_consult_from_dt(consultFromDt);
            evMypageConsultRequestDto.setExpo_consult_to_dt(consultToDt);
            evMypageConsultRequestDto.setConsult_time_id(consultTimeId);
            evMypageConsultRequestDto.setEv_expo_id(evExpoId);
            evMypageConsultRequestDto.setSunday(sunday); //요일을 일요일부터 표시한다.
            evMypageConsultRequestDto.setConsult_from_time(consult_from_time);
            evMypageConsultRequestDto.setConsult_to_time(consult_to_time);
            evMypageConsultRequestDto.setTiemzone_cd(tiemzone_cd);
            evMypageConsultRequestDto.setTimezone_hhmm_fr(timezone_hhmm_fr);
            evMypageConsultRequestDto.setTimezone_hhmm_to(timezone_hhmm_to);
            evMypageConsultRequestDto.setPage_clsf("myc07");

            /* 시간별 상담내역 */
            Map<String,Object> consultMap = new HashMap<>();

            if(consultSetting != null && consultSetting.size() == 1) {
                consultMap = getTimeList(evMypageConsultRequestDto);
            }

            model.addAttribute("page_clsf", "myc07");
            model.addAttribute("timezoneList", timezoneList);
            model.addAttribute("consult_from_dt", consultFromDt);
            model.addAttribute("consult_to_dt", consultToDt);
            model.addAttribute("timeList", timeList);

            /* 시간별 상담내역 - 헤더건수 */
            model.addAttribute("header_cnt", consultMap.get("period"));

            /* 시간별 상담내역 */
            model.addAttribute("consultList", consultMap.get("newList"));

            /* 상담-설정조회 */
            model.addAttribute("consult_time_id", consultTimeId);
            model.addAttribute("tiemzone_cd", tiemzone_cd);
            model.addAttribute("consult_from_time", consult_from_time);
            model.addAttribute("consult_to_time", consult_to_time);

            model.addAttribute("sunday", sunday);

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 상담예약현황-리스트
     * @param evMypageConsultRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myc07P03")
    public String mypage_myc07P03 (EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            evMypageConsultRequestDto.setCust_id(loginInfoDto.getUser_id());
            evMypageConsultRequestDto.setUser_id(loginInfoDto.getUser_id());

            EvExpoResponseDto evExpoResponseDto = (EvExpoResponseDto)request.getSession().getAttribute(StringUtils.expo_info_session);
            evMypageConsultRequestDto.setEv_expo_id(evExpoResponseDto.getEv_expo_id());

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/member/login_form";
                return returnUrl;
            } else {
                returnUrl = "/mypage/myc07P03";
            }

            /* 타임존 조회 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("213000");
            List<EvCommCodeResponseDto> timezoneList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            evCommCodeRequestDto.setUpper_cd_id("215000");
            List<EvCommCodeResponseDto> consultStsList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* row 개수 */
            evMypageConsultRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMypageConsultRequestDto.getPage_current());
            evMypageConsultRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMypageConsultRequestDto.getPage_current(),""))) {
                evMypageConsultRequestDto.setPage_current(1L);
            }

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();

            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_consult_from_dt(),""))) {
                String strDt = sf.format(nDt);
                evMypageConsultRequestDto.setSh_consult_from_dt(strDt);
            }

            if("".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_consult_to_dt(),""))) {
                Date ftDt = StringUtils.addMonth(nDt,5);
                String strDt = sf.format(ftDt);
                evMypageConsultRequestDto.setSh_consult_to_dt(strDt);
            }

            /* 참가업체 상담리스트 */
            List<EvMypageConsultScheduleResponseDto> list = evMypageConsultService.consult_participation_list(evMypageConsultRequestDto);
            List<EvMypageConsultScheduleResponseDto> listCount = evMypageConsultService.consult_participation_list_count(evMypageConsultRequestDto);

            Long row_count = listCount.get(0).getRow_count();

            model.addAttribute("row_count", row_count); /* 총 개수 */
            model.addAttribute("page_row_cnt", evMypageConsultRequestDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMypageConsultRequestDto.getPage_current());    /* 현재페이지 */

            model.addAttribute("page_clsf", "myc07");
            model.addAttribute("timezoneList", timezoneList);
            model.addAttribute("consultStsList", consultStsList);
            model.addAttribute("list", list);

            /* 상담-설정조회 */
            model.addAttribute("consult_time_id", evMypageConsultRequestDto.getConsult_time_id());
            model.addAttribute("tiemzone_cd", evMypageConsultRequestDto.getTiemzone_cd());
            model.addAttribute("consult_from_dt", evMypageConsultRequestDto.getConsult_from_dt());
            model.addAttribute("consult_to_dt", evMypageConsultRequestDto.getConsult_to_dt());
            model.addAttribute("sunday", evMypageConsultRequestDto.getSunday());

            model.addAttribute("sh_consult_from_dt", evMypageConsultRequestDto.getSh_consult_from_dt());
            model.addAttribute("sh_consult_to_dt", evMypageConsultRequestDto.getSh_consult_to_dt());
            model.addAttribute("sh_consult_sts_cd", evMypageConsultRequestDto.getSh_consult_sts_cd());

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 예약자조회
     * @param evMypageConsultRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mypage/rsv_info")
    public Map<String,Object> mypage_rsv_info (@RequestBody EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request) {

        Map<String,Object> resposeResult = new HashMap<String,Object>();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            evMypageConsultRequestDto.setCust_id(loginInfoDto.getUser_id());
            evMypageConsultRequestDto.setUser_id(loginInfoDto.getUser_id());

            /* 예약자조회 */
            List<EvMypageConsultScheduleResponseDto> list = evMypageConsultService.consult_rsv_info_search(evMypageConsultRequestDto);

            if(list != null && list.size() == 1) {

                resposeResult.put("schedule_id"     , list.get(0).getSchedule_id());
                resposeResult.put("cust_id"         , list.get(0).getCust_id());
                resposeResult.put("cust_nm"         , list.get(0).getCust_nm());
                resposeResult.put("tel_no"          , list.get(0).getTel_no());
                resposeResult.put("result_code"     , "0");
                resposeResult.put("result_msg"      , "성공!!");

            } else {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "해당내역이 없습니다.");
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;

    }

    /**
     * 상담예약현황 팝업
     * @param evMypageConsultRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myc07P01")
    public String mypage_mypc07P01 (EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/member/login_form";
                return returnUrl;
            } else {
                returnUrl = "/mypage/myc07P01";
            }

            /* 현재상태체크 */
            List<EvMypageConsultScheduleResponseDto> list = evMypageConsultService.consult_shedule_search(evMypageConsultRequestDto);

            if(list != null && list.size() == 1) {
                evMypageConsultRequestDto.setConsult_rsv_stat_cd(list.get(0).getConsult_rsv_stat_cd());
                evMypageConsultRequestDto.setCust_id(list.get(0).getConsult_rsv_cust_id());
                evMypageConsultRequestDto.setCust_nm(list.get(0).getConsult_rsv_cust_nm());
                evMypageConsultRequestDto.setTel_no(list.get(0).getTel_no());
            }

            model.addAttribute("schedule_id"        , evMypageConsultRequestDto.getSchedule_id());
            model.addAttribute("consult_rsv_stat_cd", evMypageConsultRequestDto.getConsult_rsv_stat_cd());
            model.addAttribute("cust_id"            , evMypageConsultRequestDto.getCust_id());
            model.addAttribute("cust_nm"            , evMypageConsultRequestDto.getCust_nm());
            model.addAttribute("tel_no"             , evMypageConsultRequestDto.getTel_no());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 상담시간 설정
     * @param evMypageConsultRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mypage/myc07P01U01")
    public Map<String,Object> mypage_myc07P01U01 (@RequestBody EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request) {

        Map<String,Object> resposeResult = new HashMap<String,Object>();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            evMypageConsultRequestDto.setCust_id(loginInfoDto.getUser_id());
            evMypageConsultRequestDto.setUser_id(loginInfoDto.getUser_id());

            EvExpoResponseDto evExpoResponseDto = (EvExpoResponseDto)request.getSession().getAttribute(StringUtils.expo_info_session);
            evMypageConsultRequestDto.setEv_expo_id(evExpoResponseDto.getEv_expo_id());

            /* 현재상태체크 */
            List<EvMypageConsultScheduleResponseDto> list = evMypageConsultService.consult_shedule_search(evMypageConsultRequestDto);

            if(list != null && list.size() == 1) {

                EvMypageConsultScheduleResponseDto evMypageConsultScheduleResponseDto = list.get(0);
                String availYn = evMypageConsultScheduleResponseDto.getConsult_avail_yn();
                String consultRsvStatCd = StringUtils.nvl(evMypageConsultScheduleResponseDto.getConsult_rsv_stat_cd(),"");

                if(availYn.equals("N")) {
                    resposeResult.put("result_code", "-2");
                    resposeResult.put("result_msg", "사용할 수 없는 시간입니다.");
                    return resposeResult;
                }

                if(consultRsvStatCd.equals("215003") || consultRsvStatCd.equals("215004")) {
                    resposeResult.put("result_code", "-3");
                    resposeResult.put("result_msg", "취소처리 또는 반려처리 되었습니다.");
                    return resposeResult;
                }

                /* 기존정보를 입력 */
                evMypageConsultService.consult_shedule_delete(evMypageConsultRequestDto); /* del_yn = 'Y' */

                evMypageConsultRequestDto.setConsult_avail_yn("Y");
                evMypageConsultRequestDto.setConsult_rsv_cust_id(evMypageConsultRequestDto.getConsult_rsv_cust_id());
                evMypageConsultRequestDto.setConsult_rsv_cust_id(evMypageConsultRequestDto.getConsult_rsv_cust_id());
                evMypageConsultService.consult_shedule_insert(evMypageConsultRequestDto); /* 변경된 정보 입력 */

                //취소, 반려인 경우 상태가 없는 내역으로 스케줄을 생성한다.
                String rsvStatCd = evMypageConsultRequestDto.getConsult_rsv_stat_cd();
                if(rsvStatCd.equals("215003") || rsvStatCd.equals("215004")) {
                    EvMypageConsultRequestDto mypageConsultRequestDto = new EvMypageConsultRequestDto();
                    mypageConsultRequestDto = evMypageConsultRequestDto;
                    mypageConsultRequestDto.setConsult_avail_yn("Y");
                    mypageConsultRequestDto.setConsult_rsv_stat_cd("");
                    evMypageConsultRequestDto.setConsult_rsv_cust_id("");
                    mypageConsultRequestDto.setRemarks("");
                    evMypageConsultService.consult_shedule_insert(mypageConsultRequestDto); /* 변경된 정보 입력 */
                }

                log.debug("getSchedule_id() : " + evMypageConsultRequestDto.getSchedule_id());

                resposeResult.put("schedule_id", evMypageConsultRequestDto.getSchedule_id());
                resposeResult.put("consult_rsv_stat_cd", evMypageConsultRequestDto.getConsult_rsv_stat_cd());
                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");

            } else {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "해당내역이 없습니다.");
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;

    }

    /**
     * 상담반려 팝업
     * @param evMypageConsultRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myc07P02")
    public String mypage_mypc07P02 (EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/member/login_form";
                return returnUrl;
            } else {
                returnUrl = "/mypage/myc07P02";
            }

            model.addAttribute("schedule_id", evMypageConsultRequestDto.getSchedule_id());
            model.addAttribute("consult_rsv_cust_id", evMypageConsultRequestDto.getConsult_rsv_cust_id());

        } catch (Exception e) {

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 상담이력
     * @param evBoardSearchDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myc08")
    public String mypage_myc08 (EvBoardSearchDto evBoardSearchDto, HttpServletRequest request, Model model) {

        String returnUrl = "";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/member/login_form";
                return returnUrl;
            } else {
                returnUrl = "/mypage/myc08";
            }

            model.addAttribute("page_clsf", "myc08");
            model.addAttribute("cust_id", loginInfoDto.getCust_id());

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 메시지전송
     * @param evMypageConsultMsgRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/mypage/myc08M01")
    public Map<String,Object> mypage_myc08M01 (@RequestBody EvMypageConsultMsgRequestDto evMypageConsultMsgRequestDto, HttpServletRequest request) {

        Map<String,Object> resposeResult = new HashMap<>();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            EvExpoResponseDto evExpoResponseDto = (EvExpoResponseDto)request.getSession().getAttribute(StringUtils.expo_info_session);

            evMypageConsultMsgRequestDto.setCust_id(loginInfoDto.getCust_id());

            /* 상담-설정조회 */
            EvMypageConsultRequestDto evMypageConsultRequestDto = new EvMypageConsultRequestDto();

            if("202001".equals(evMypageConsultMsgRequestDto.getCust_clsf_cd())) {
                //참관고객인경우 - 참관마이페이지 신청에서 입력되므로 전송대상으로 변경우 다시 로그인ID로 변경한다.
                evMypageConsultMsgRequestDto.setCust_id(evMypageConsultMsgRequestDto.getRcv_cust_id());
                evMypageConsultRequestDto.setCust_id(evMypageConsultMsgRequestDto.getCust_id());

                evMypageConsultMsgRequestDto.setCust_id(loginInfoDto.getCust_id());
            } else {
                evMypageConsultRequestDto.setCust_id(evMypageConsultMsgRequestDto.getCust_id());
            }

            evMypageConsultRequestDto.setEv_expo_id(evExpoResponseDto.getEv_expo_id());

            List<EvMypageConsultResponseDto> consultSetting = evMypageConsultService.consult_settime_select(evMypageConsultRequestDto);

            Long consultTimeId = 0L;

            if(consultSetting != null && consultSetting.size() == 1) {
                consultTimeId = consultSetting.get(0).getConsult_time_id();
            }

            evMypageConsultMsgRequestDto.setConsult_time_id(consultTimeId);
            evMypageConsultMsgRequestDto.setSnd_cust_id(evMypageConsultMsgRequestDto.getCust_id());
            evMypageConsultMsgRequestDto.setRcv_cust_id(evMypageConsultMsgRequestDto.getRcv_cust_id());

            /* 메시지 입력 */
            evMypageConsultService.consult_msg_insert(evMypageConsultMsgRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 메시지조회전송
     * @param evMypageConsultMsgRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/mypage/myc08M02")
    public Map<String,Object> mypage_myc08M02 (@RequestBody EvMypageConsultMsgRequestDto evMypageConsultMsgRequestDto, HttpServletRequest request) {

        Map<String,Object> resposeResult = new HashMap<>();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            EvExpoResponseDto evExpoResponseDto = (EvExpoResponseDto)request.getSession().getAttribute(StringUtils.expo_info_session);

            evMypageConsultMsgRequestDto.setCust_id(loginInfoDto.getCust_id());

            /* 상담-설정조회 */
            EvMypageConsultRequestDto evMypageConsultRequestDto = new EvMypageConsultRequestDto();
            evMypageConsultRequestDto.setCust_id(evMypageConsultMsgRequestDto.getCust_id());
            evMypageConsultRequestDto.setEv_expo_id(evExpoResponseDto.getEv_expo_id());

            List<EvMypageConsultResponseDto> consultSetting = evMypageConsultService.consult_settime_select(evMypageConsultRequestDto);

            Long consultTimeId = 0L;

            if(consultSetting != null && consultSetting.size() == 1) {
                consultTimeId = consultSetting.get(0).getConsult_time_id();
            }

            evMypageConsultMsgRequestDto.setConsult_time_id(consultTimeId);
            evMypageConsultMsgRequestDto.setRcv_cust_id(evMypageConsultMsgRequestDto.getCust_id());
            evMypageConsultMsgRequestDto.setSnd_cust_id(evMypageConsultMsgRequestDto.getSnd_cust_id());

            /* 상담내역조회 */
            List<EvMypageConsultMsgResponseDto> list = evMypageConsultService.consult_msg_search(evMypageConsultMsgRequestDto);
            
            /* 상담건수조회 */
            List<EvMypageConsultMsgResponseDto> listCnt = evMypageConsultService.consult_count(evMypageConsultMsgRequestDto);

            resposeResult.put("consultList", list);
            resposeResult.put("consultListCnt", listCnt);
            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return resposeResult;

    }

    /**
     * 메시지전송고객조회
     * @param evMypageConsultMsgRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/mypage/myc08M03")
    public Map<String,Object> mypage_myc08M03 (@RequestBody EvMypageConsultMsgRequestDto evMypageConsultMsgRequestDto, HttpServletRequest request) {

        Map<String,Object> resposeResult = new HashMap<>();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            EvExpoResponseDto evExpoResponseDto = (EvExpoResponseDto)request.getSession().getAttribute(StringUtils.expo_info_session);

            evMypageConsultMsgRequestDto.setCust_id(loginInfoDto.getCust_id());

            /* 상담-설정조회 */
            EvMypageConsultRequestDto evMypageConsultRequestDto = new EvMypageConsultRequestDto();
            evMypageConsultRequestDto.setCust_id(evMypageConsultMsgRequestDto.getCust_id());
            evMypageConsultRequestDto.setEv_expo_id(evExpoResponseDto.getEv_expo_id());

            List<EvMypageConsultResponseDto> consultSetting = evMypageConsultService.consult_settime_select(evMypageConsultRequestDto);

            Long consultTimeId = 0L;

            if(consultSetting != null && consultSetting.size() == 1) {
                consultTimeId = consultSetting.get(0).getConsult_time_id();
            }

            evMypageConsultMsgRequestDto.setConsult_time_id(consultTimeId);
            evMypageConsultMsgRequestDto.setCust_id(evMypageConsultMsgRequestDto.getCust_id());

            /* 상담내역조회 */
            List<EvMypageConsultMsgResponseDto> list = evMypageConsultService.consult_cust_msg_search(evMypageConsultMsgRequestDto);

            resposeResult.put("consultCustList", list);
            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return resposeResult;

    }



    /**
     * 상담신청현황
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp08")
    public String mypage_myp08 (EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/member/login_form";
                return returnUrl;
            } else {
                returnUrl = "/mypage/myp08";
            }

            /* 타임존 조회 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("213000");
            List<EvCommCodeResponseDto> timezoneList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* Expo 정보조회 (예약가능일자조회) */
            EvExpoRequestDto evExpoRequestDtoDto = new EvExpoRequestDto();
            evExpoRequestDtoDto.setCust_id(loginInfoDto.getCust_id());
            List<EvExpoResponseDto> expoInfo = evExpoService.expo_info_search2(evExpoRequestDtoDto);
            String consultFromDt = "";
            String consultToDt = "";
            String sunday = "";
            int evExpoId = 0;

            if(expoInfo != null && expoInfo.size() == 1) {
                consultFromDt = expoInfo.get(0).getExpo_consult_from_dt();
                consultToDt = expoInfo.get(0).getExpo_consult_to_dt();
                evExpoId = expoInfo.get(0).getEv_expo_id();
                sunday = expoInfo.get(0).getSunday();
            }

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

            /* 전주(left), 다음주(right) 구분 */
            if("left".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_cls_cd(),""))) {
                Date leftDt = sf.parse(evMypageConsultRequestDto.getSunday());
                long leftTime = leftDt.getTime() - (1000 * 60 * 60 * 24 * 7);
                leftDt.setTime(leftTime);
                sunday = sf.format(leftDt);
            } else if("right".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_cls_cd(),""))) {
                Date rightDt = sf.parse(evMypageConsultRequestDto.getSunday());
                long leftTime = rightDt.getTime() + (1000 * 60 * 60 * 24 * 7);
                rightDt.setTime(leftTime);
                sunday = sf.format(rightDt);
            } else if("now".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_cls_cd(),""))) {
                sunday = evMypageConsultRequestDto.getSunday();
            }

            evMypageConsultRequestDto.setCust_id(loginInfoDto.getCust_id());
            evMypageConsultRequestDto.setEv_expo_id(evExpoId);

            /* 상담-설정조회 */
            List<EvMypageConsultResponseDto> consultSetting = evMypageConsultService.consult_cust_settime_select(evMypageConsultRequestDto);

            Long consultTimeId = 0L; String tiemzone_cd = "", consult_from_time = "214019", consult_to_time = "214036", timezone_hhmm_fr = "", timezone_hhmm_to = "";

            if(consultSetting != null && consultSetting.size() == 1) {
                consultTimeId = consultSetting.get(0).getConsult_time_id();
                tiemzone_cd = StringUtils.nvl(consultSetting.get(0).getTiemzone_cd(),"213001"); /* 대한민국,서울 */
                consult_from_time = consultSetting.get(0).getConsult_from_time();
                consult_to_time = consultSetting.get(0).getConsult_to_time();

                /* 타이존시간 00:00, 00:30 ... */
                timezone_hhmm_fr = consultSetting.get(0).getTimezone_hhmm_fr();
                timezone_hhmm_to = consultSetting.get(0).getTimezone_hhmm_to();
            } else {
                    //default 설정
                    consultTimeId = 0L;
                    tiemzone_cd = "213001";
                    consult_from_time = "214019";
                    consult_to_time = "214036";
                    timezone_hhmm_fr = "09:00";
                    timezone_hhmm_to = "17:30";
            }

            /* 예약시간 조회 한국:cd_nm, 중국상하이:cd_val1, 영국런던:cd_val2, 미국뉴욕:cd_val3*/
            evCommCodeRequestDto.setUpper_cd_id("214000");
            List<EvCommCodeResponseDto> timeList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 상담가능기간 체크 */
            evMypageConsultRequestDto.setExpo_consult_from_dt(consultFromDt);
            evMypageConsultRequestDto.setExpo_consult_to_dt(consultToDt);
            evMypageConsultRequestDto.setConsult_time_id(consultTimeId);
            evMypageConsultRequestDto.setEv_expo_id(evExpoId);
            evMypageConsultRequestDto.setSunday(sunday); //요일을 일요일부터 표시한다.
            evMypageConsultRequestDto.setConsult_from_time(consult_from_time);
            evMypageConsultRequestDto.setConsult_to_time(consult_to_time);
            evMypageConsultRequestDto.setTiemzone_cd(tiemzone_cd);
            evMypageConsultRequestDto.setTimezone_hhmm_fr(timezone_hhmm_fr);
            evMypageConsultRequestDto.setTimezone_hhmm_to(timezone_hhmm_to);

            /* 시간별 상담내역 */
            Map<String,Object> consultMap = getCustTimeList(evMypageConsultRequestDto);

            model.addAttribute("page_clsf", "myp08");
            model.addAttribute("timezoneList", timezoneList);
            model.addAttribute("consult_from_dt", consultFromDt);
            model.addAttribute("consult_to_dt", consultToDt);
            model.addAttribute("timeList", timeList);

            /* 시간별 상담내역 - 헤더건수 */
            model.addAttribute("header_cnt", consultMap.get("period"));

            /* 시간별 상담내역 */
            model.addAttribute("consultList", consultMap.get("newList"));

            /* 상담-설정조회 */
            model.addAttribute("consult_time_id", consultTimeId);
            model.addAttribute("tiemzone_cd", tiemzone_cd);
            model.addAttribute("consult_from_time", consult_from_time);
            model.addAttribute("consult_to_time", consult_to_time);

            model.addAttribute("sunday", sunday);

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 참관 상담시간 테이블 구성
     * @param evMypageConsultRequestDto
     * @return
     */
    private Map<String,Object> getCustTimeList(EvMypageConsultRequestDto evMypageConsultRequestDto) {

        Map<String,Object> rtrMap = new HashMap<>();
        List<Map<String,Object>> newList = new ArrayList<>();
        List<EvMypageConsultScheduleResponseDto> list = evMypageConsultService.consult_cust_shedule_search(evMypageConsultRequestDto);

        String expoFromDt = evMypageConsultRequestDto.getExpo_consult_from_dt();
        String expoToDt = evMypageConsultRequestDto.getExpo_consult_to_dt();
        String sunday = evMypageConsultRequestDto.getSunday();
        String formTimeCd = evMypageConsultRequestDto.getConsult_from_time();
        String toTimeCd = evMypageConsultRequestDto.getConsult_to_time();
        String timezone_hhmm_fr = expoFromDt.replace("-","") + evMypageConsultRequestDto.getTimezone_hhmm_fr().replace(":","");
        String timezone_hhmm_to = expoToDt.replace("-","") + evMypageConsultRequestDto.getTimezone_hhmm_to().replace(":","");

        /* 예약시간 조회 */
        EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();

        evCommCodeRequestDto.setUpper_cd_id("214000");
        List<EvCommCodeResponseDto> timeList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

        if("213001".equals(evMypageConsultRequestDto.getTiemzone_cd())) { //대한민국,서울
            evCommCodeRequestDto.setOrder_by("cd_nm asc");
        } else if("213002".equals(evMypageConsultRequestDto.getTiemzone_cd())) { //중국,상하이
            evCommCodeRequestDto.setOrder_by("cd_val1 asc");
        } else if("213003".equals(evMypageConsultRequestDto.getTiemzone_cd())) { //영국,런던
            evCommCodeRequestDto.setOrder_by("cd_val2 asc");
        } else if("213004".equals(evMypageConsultRequestDto.getTiemzone_cd())) { //미국,뉴욕
            evCommCodeRequestDto.setOrder_by("cd_val3 asc");
        }

        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sf2 = new SimpleDateFormat("M/d (EEE)");
        SimpleDateFormat sf3 = new SimpleDateFormat("E");

        try {
            Date dateExpoFromDt = sf.parse(expoFromDt);
            Date dateExpoToDt = sf.parse(expoToDt);
            Date sundayDt = sf.parse(sunday);

            /* header 생성 */
            int key = 0;
            Map<String, Object> headerMap = new HashMap<>();

            /*
            long diff = dateExpoToDt.getTime() - dateExpoFromDt.getTime() + 1;
            TimeUnit time = TimeUnit.DAYS;
            long period = time.convert(diff, TimeUnit.MILLISECONDS);
            */

            //시작일을 일요일로 설정한다.

            long period = 7;
            rtrMap.put("period",7);

            headerMap.put("k" + (++key), "시간");

            Calendar cal = Calendar.getInstance();
            Date setFromDt = sundayDt;
            for(int i = 0; i <= period; i++) {
                headerMap.put("k" + (++key), sf2.format(setFromDt));

                cal.setTime(setFromDt);
                cal.add(Calendar.DATE, 1);
                setFromDt = cal.getTime();
            }

            newList.add(headerMap);

            for(EvCommCodeResponseDto evCommCodeResponseDto : timeList) {

                if(Integer.parseInt(evCommCodeResponseDto.getCd_id()) < Integer.parseInt(formTimeCd)
                        || Integer.parseInt(evCommCodeResponseDto.getCd_id()) > Integer.parseInt(toTimeCd)) {
                    continue;
                }

                /* 시간설정 */
                key = 0;
                Map<String, Object> consultMap = new HashMap<>();

                if("213001".equals(evMypageConsultRequestDto.getTiemzone_cd())) { //대한민국,서울
                    consultMap.put("k" + (++key), evCommCodeResponseDto.getCd_nm());
                } else if("213002".equals(evMypageConsultRequestDto.getTiemzone_cd())) { //중국,상하이
                    consultMap.put("k" + (++key), evCommCodeResponseDto.getCd_val1());
                } else if("213003".equals(evMypageConsultRequestDto.getTiemzone_cd())) { //영국,런던
                    consultMap.put("k" + (++key), evCommCodeResponseDto.getCd_val2());
                } else if("213004".equals(evMypageConsultRequestDto.getTiemzone_cd())) { //미국,뉴욕
                    consultMap.put("k" + (++key), evCommCodeResponseDto.getCd_val3());
                }

                cal = Calendar.getInstance();
                setFromDt = sundayDt;

                //같은날 같은시간 예약인 경우 처리를 위하여 List를 이용함.
                List<Map<String, String>> vList = new ArrayList<>();

                //값비교
                String tempFormatFromDt = "", tempTimeCd = "";
                for(int j = 0; j <= period; j++) {

                    /* 상담시간리스트 */
                    String formatFromDt = sf.format(setFromDt);
                    boolean chkRow = false;

                    for(EvMypageConsultScheduleResponseDto schedule : list) {
                        /* 시간과 일자가 같을 경우 put */
                        //if(schedule.getConsult_dt().equals(formatFromDt) && schedule.getConsult_time_cd().equals(evCommCodeResponseDto.getCd_id())) {
                        String cYMDHM = StringUtils.nvl(schedule.getConsult_dt(),"").replace("-","") + StringUtils.nvl(schedule.getConsult_time_nm(),"").replace(":","");
                        if(schedule.getConsult_dt().equals(formatFromDt)
                                && schedule.getConsult_time_cd().equals(evCommCodeResponseDto.getCd_id())
                                && Long.parseLong(timezone_hhmm_fr) <= Long.parseLong(cYMDHM)
                                && Long.parseLong(cYMDHM) <= Long.parseLong(timezone_hhmm_to)) {

                            if(!tempFormatFromDt.equals(formatFromDt) || !tempTimeCd.equals(evCommCodeResponseDto.getCd_id())) {
                                key++;
                            }

                            Map<String, String> vMap = new HashMap<>();

                            vMap.put("k" + key + "_scheduleId"          , StringUtils.nvl(schedule.getSchedule_id(),""));
                            vMap.put("k" + key + "_consultTimeId"       , StringUtils.nvl(schedule.getConsult_time_id(),""));
                            vMap.put("k" + key + "_consultCustId"       , StringUtils.nvl(schedule.getConsult_cust_id(),""));
                            vMap.put("k" + key + "_consultCustNm"       , StringUtils.nvl(schedule.getConsult_cust_nm(),""));
                            vMap.put("k" + key + "_consultAvailYn"      , StringUtils.nvl(schedule.getConsult_avail_yn(),""));
                            vMap.put("k" + key + "_consultRsvStatCd"    , StringUtils.nvl(schedule.getConsult_rsv_stat_cd(),""));

                            vList.add(vMap);

                            chkRow = true;

                            tempFormatFromDt = formatFromDt;
                            tempTimeCd = evCommCodeResponseDto.getCd_id();
                        }
                    }

                    if(!chkRow) ++key;

                    //색상표를 위해 엑스포기간을 체크한다.
                    if(Integer.parseInt(expoFromDt.replace("-","")) <= Integer.parseInt(formatFromDt.replace("-",""))
                            && Integer.parseInt(expoToDt.replace("-","")) >= Integer.parseInt(formatFromDt.replace("-",""))) {
                        consultMap.put("k" + key + "_expoYn"  , "Y");
                    }

                    consultMap.put("custList", vList);

                    cal.setTime(setFromDt);
                    cal.add(Calendar.DATE, 1);
                    setFromDt = cal.getTime();
                }

                newList.add(consultMap);
            }

            rtrMap.put("newList",newList);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rtrMap;
    }

    /**
     * 상담자조회
     * @param evMypageConsultRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mypage/consult_cust_info")
    public Map<String,Object> mypage_consult_cust_info (@RequestBody EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request) {

        Map<String,Object> resposeResult = new HashMap<String,Object>();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            evMypageConsultRequestDto.setCust_id(loginInfoDto.getUser_id());
            evMypageConsultRequestDto.setUser_id(loginInfoDto.getUser_id());

            /* 예약자조회 */
            List<EvMypageConsultScheduleResponseDto> list = evMypageConsultService.consult_cust_rsv_info_search(evMypageConsultRequestDto);

            if(list != null && list.size() == 1) {

                resposeResult.put("schedule_id"     , list.get(0).getSchedule_id());
                resposeResult.put("cust_id"         , list.get(0).getCust_id());
                resposeResult.put("cust_nm"         , list.get(0).getCust_nm());
                resposeResult.put("tel_no"          , list.get(0).getTel_no());
                resposeResult.put("result_code"     , "0");
                resposeResult.put("result_msg"      , "성공!!");

            } else {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "해당내역이 없습니다.");
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        }

        return resposeResult;

    }

    /**
     * 상담예약현황 팝업
     * @param evMypageConsultRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp08P01")
    public String mypage_mypc08P01 (EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/member/login_form";
                return returnUrl;
            } else {
                returnUrl = "/mypage/myp08P01";
            }

            /* 현재상태체크 */
            List<EvMypageConsultScheduleResponseDto> list = evMypageConsultService.consult_cust_rsv_info_search(evMypageConsultRequestDto);

            if(list != null && list.size() == 1) {
                evMypageConsultRequestDto.setConsult_rsv_stat_cd(list.get(0).getConsult_rsv_stat_cd());
                evMypageConsultRequestDto.setCust_id(list.get(0).getCust_id());
                evMypageConsultRequestDto.setCust_nm(list.get(0).getCust_nm());
                evMypageConsultRequestDto.setTel_no(list.get(0).getTel_no());
            }

            model.addAttribute("schedule_id"        , evMypageConsultRequestDto.getSchedule_id());
            model.addAttribute("consult_rsv_stat_cd", evMypageConsultRequestDto.getConsult_rsv_stat_cd());
            model.addAttribute("cust_id"            , evMypageConsultRequestDto.getCust_id());
            model.addAttribute("cust_nm"            , evMypageConsultRequestDto.getCust_nm());
            model.addAttribute("tel_no"             , evMypageConsultRequestDto.getTel_no());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 상담취소 팝업
     * @param evMypageConsultRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp08P02")
    public String mypage_myp08P02 (EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/member/login_form";
                return returnUrl;
            } else {
                returnUrl = "/mypage/myp08P02";
            }

            model.addAttribute("schedule_id", evMypageConsultRequestDto.getSchedule_id());

        } catch (Exception e) {

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 상담예약현황-리스트 (참관)
     * @param evMypageConsultRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp08P03")
    public String mypage_myp08P03 (EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            evMypageConsultRequestDto.setCust_id(loginInfoDto.getUser_id());
            evMypageConsultRequestDto.setUser_id(loginInfoDto.getUser_id());

            EvExpoResponseDto evExpoResponseDto = (EvExpoResponseDto)request.getSession().getAttribute(StringUtils.expo_info_session);
            evMypageConsultRequestDto.setEv_expo_id(evExpoResponseDto.getEv_expo_id());

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/member/login_form";
                return returnUrl;
            } else {
                returnUrl = "/mypage/myp08P03";
            }

            /* 타임존 조회 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("213000");
            List<EvCommCodeResponseDto> timezoneList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            evCommCodeRequestDto.setUpper_cd_id("215000");
            List<EvCommCodeResponseDto> consultStsList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* row 개수 */
            evMypageConsultRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMypageConsultRequestDto.getPage_current());
            evMypageConsultRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMypageConsultRequestDto.getPage_current(),""))) {
                evMypageConsultRequestDto.setPage_current(1L);
            }

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();

            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_consult_from_dt(),""))) {
                String strDt = sf.format(nDt);
                evMypageConsultRequestDto.setSh_consult_from_dt(strDt);
            }

            if("".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_consult_to_dt(),""))) {
                Date ftDt = StringUtils.addMonth(nDt,5);
                String strDt = sf.format(ftDt);
                evMypageConsultRequestDto.setSh_consult_to_dt(strDt);
            }

            /* 참가업체 상담리스트 */
            List<EvMypageConsultScheduleResponseDto> list = evMypageConsultService.consult_visit_list(evMypageConsultRequestDto);
            List<EvMypageConsultScheduleResponseDto> listCount = evMypageConsultService.consult_visit_list_count(evMypageConsultRequestDto);

            Long row_count = listCount.get(0).getRow_count();

            model.addAttribute("row_count", row_count); /* 총 개수 */
            model.addAttribute("page_row_cnt", evMypageConsultRequestDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMypageConsultRequestDto.getPage_current());    /* 현재페이지 */

            model.addAttribute("page_clsf", "myp08");
            model.addAttribute("timezoneList", timezoneList);
            model.addAttribute("consultStsList", consultStsList);
            model.addAttribute("list", list);

            /* 상담-설정조회 */
            model.addAttribute("consult_time_id", evMypageConsultRequestDto.getConsult_time_id());
            model.addAttribute("tiemzone_cd", evMypageConsultRequestDto.getTiemzone_cd());
            model.addAttribute("consult_from_dt", evMypageConsultRequestDto.getConsult_from_dt());
            model.addAttribute("consult_to_dt", evMypageConsultRequestDto.getConsult_to_dt());
            model.addAttribute("sunday", evMypageConsultRequestDto.getSunday());

            model.addAttribute("sh_consult_from_dt", evMypageConsultRequestDto.getSh_consult_from_dt());
            model.addAttribute("sh_consult_to_dt", evMypageConsultRequestDto.getSh_consult_to_dt());
            model.addAttribute("sh_consult_sts_cd", evMypageConsultRequestDto.getSh_consult_sts_cd());

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 상담예약현황
     * @param evMypageConsultRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp09")
    public String mypage_mmyp09 (EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/member/login_form";
                return returnUrl;
            } else {
                returnUrl = "/mypage/myp09";
            }

            /* 타임존 조회 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("213000");
            List<EvCommCodeResponseDto> timezoneList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* Expo 정보조회 (예약가능일자조회) */
            EvExpoRequestDto evExpoRequestDtoDto = new EvExpoRequestDto();
            evExpoRequestDtoDto.setCust_id(loginInfoDto.getCust_id());
            List<EvExpoResponseDto> expoInfo = evExpoService.expo_info_search2(evExpoRequestDtoDto);
            String consultFromDt = "";
            String consultToDt = "";
            String sunday = "";
            int evExpoId = 0;

            if(expoInfo != null && expoInfo.size() == 1) {
                consultFromDt = expoInfo.get(0).getExpo_consult_from_dt();
                consultToDt = expoInfo.get(0).getExpo_consult_to_dt();
                evExpoId = expoInfo.get(0).getEv_expo_id();
                sunday = expoInfo.get(0).getSunday();

            }

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

            /* 전주(left), 다음주(right) 구분 */
            if("left".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_cls_cd(),""))) {
                Date leftDt = sf.parse(evMypageConsultRequestDto.getSunday());
                long leftTime = leftDt.getTime() - (1000 * 60 * 60 * 24 * 7);
                leftDt.setTime(leftTime);
                sunday = sf.format(leftDt);
            } else if("right".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_cls_cd(),""))) {
                Date rightDt = sf.parse(evMypageConsultRequestDto.getSunday());
                long leftTime = rightDt.getTime() + (1000 * 60 * 60 * 24 * 7);
                rightDt.setTime(leftTime);
                sunday = sf.format(rightDt);
            } else if("now".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_cls_cd(),""))) {
                sunday = evMypageConsultRequestDto.getSunday();
            }

            /* 화면에서 넘겨주는 ID를 셋팅한다. */
            evMypageConsultRequestDto.setCust_id(loginInfoDto.getCust_id());
            evMypageConsultRequestDto.setEv_expo_id(evExpoId);

            /* 상담-설정조회 */
            List<EvMypageConsultResponseDto> consultSettingCust = evMypageConsultService.consult_cust_settime_select(evMypageConsultRequestDto);

            Long consultTimeId = 0L; String tiemzone_cd = "", consult_from_time = "", consult_to_time = "", timezone_hhmm_fr = "", timezone_hhmm_to = "";

            if(consultSettingCust != null && consultSettingCust.size() == 1) {

                EvMypageConsultRequestDto consultRequestDto = new EvMypageConsultRequestDto();
                consultRequestDto.setCust_id(evMypageConsultRequestDto.getConsultCustId());
                consultRequestDto.setEv_expo_id(evExpoId);
                List<EvMypageConsultResponseDto> consultSetting = evMypageConsultService.consult_settime_select(consultRequestDto);

                if(consultSetting != null && consultSetting.size() == 1) {
                    consultTimeId = consultSetting.get(0).getConsult_time_id();
                } else {
                    consultTimeId = 0L;
                }

                tiemzone_cd = consultSettingCust.get(0).getTiemzone_cd();
                consult_from_time = consultSettingCust.get(0).getConsult_from_time();
                consult_to_time = consultSettingCust.get(0).getConsult_to_time();

                /* 타이존시간 00:00, 00:30 ... */
                timezone_hhmm_fr = consultSettingCust.get(0).getTimezone_hhmm_fr();
                timezone_hhmm_to = consultSettingCust.get(0).getTimezone_hhmm_to();
            } else {
                //default 설정
                consultTimeId = 0L;
                tiemzone_cd = "213001";
                consult_from_time = "214019";
                consult_to_time = "214036";
                timezone_hhmm_fr = "09:00";
                timezone_hhmm_to = "17:30";
            }

            /* 예약시간 조회 */
            evCommCodeRequestDto.setUpper_cd_id("214000");
            List<EvCommCodeResponseDto> timeList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 상담가능기간 체크 */
            evMypageConsultRequestDto.setCust_id(evMypageConsultRequestDto.getConsultCustId());
            evMypageConsultRequestDto.setExpo_consult_from_dt(consultFromDt);
            evMypageConsultRequestDto.setExpo_consult_to_dt(consultToDt);
            evMypageConsultRequestDto.setConsult_time_id(consultTimeId);
            evMypageConsultRequestDto.setEv_expo_id(evExpoId);
            evMypageConsultRequestDto.setSunday(sunday); //요일을 일요일부터 표시한다.
            evMypageConsultRequestDto.setConsult_from_time(consult_from_time);
            evMypageConsultRequestDto.setConsult_to_time(consult_to_time);
            evMypageConsultRequestDto.setTiemzone_cd(tiemzone_cd);
            evMypageConsultRequestDto.setTimezone_hhmm_fr(timezone_hhmm_fr);
            evMypageConsultRequestDto.setTimezone_hhmm_to(timezone_hhmm_to);
            evMypageConsultRequestDto.setPage_clsf("myp09");

            /* 시간별 상담내역 */
            Map<String,Object> consultMap = getTimeList(evMypageConsultRequestDto);

            model.addAttribute("page_clsf", "myp09");
            model.addAttribute("timezoneList", timezoneList);
            model.addAttribute("consult_from_dt", consultFromDt);
            model.addAttribute("consult_to_dt", consultToDt);
            model.addAttribute("timeList", timeList);

            /* 시간별 상담내역 - 헤더건수 */
            model.addAttribute("header_cnt", consultMap.get("period"));

            /* 시간별 상담내역 */
            model.addAttribute("consultList", consultMap.get("newList"));

            /* 상담-설정조회 */
            model.addAttribute("consult_time_id", consultTimeId);
            model.addAttribute("tiemzone_cd", tiemzone_cd);
            model.addAttribute("consult_from_time", consult_from_time);
            model.addAttribute("consult_to_time", consult_to_time);
            model.addAttribute("consultCustId", evMypageConsultRequestDto.getConsultCustId());
            model.addAttribute("consultCustNm", evMypageConsultRequestDto.getConsultCustNm());

            model.addAttribute("sunday", sunday);

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 업체조회 팝업
     * @param evMypageCustCorpInfoRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp09P01")
    public String mypage_myp09P01 (EvMypageCustCorpInfoRequestDto evMypageCustCorpInfoRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/member/login_form";
                return returnUrl;
            } else {
                returnUrl = "/mypage/myp09P01";
            }

            String consultCustNm = evMypageCustCorpInfoRequestDto.getConsultCustNm();

            /* 참가업체 조회 - 팝업 */
            if("N".equals(StringUtils.nvl(evMypageCustCorpInfoRequestDto.getSearch_yn(),"N"))) {
                evMypageCustCorpInfoRequestDto.setConsultCustNm("X");
            }

            List<EvMypageCustCorpInfoResponseDto> list = evMypageCustCorpInfoService.mypage_cust_corp_info_popup(evMypageCustCorpInfoRequestDto);

            model.addAttribute("custList", list);
            model.addAttribute("consultCustNm", consultCustNm);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 상담이력
     * @param evBoardSearchDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mypage/myp10")
    public String mypage_myp10 (EvBoardSearchDto evBoardSearchDto, HttpServletRequest request, Model model) {

        String returnUrl = "";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/member/login_form";
                return returnUrl;
            } else {
                returnUrl = "/mypage/myp10";
            }

            model.addAttribute("page_clsf", "myp10");
            model.addAttribute("cust_id", loginInfoDto.getCust_id());

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 메시지전송
     * @param evMypageConsultMsgRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/mypage/myp10M01")
    public Map<String,Object> mypage_myp10M01 (@RequestBody EvMypageConsultMsgRequestDto evMypageConsultMsgRequestDto, HttpServletRequest request) {

        Map<String,Object> resposeResult = new HashMap<>();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            EvExpoResponseDto evExpoResponseDto = (EvExpoResponseDto)request.getSession().getAttribute(StringUtils.expo_info_session);

            evMypageConsultMsgRequestDto.setCust_id(loginInfoDto.getCust_id());

            /* 상담-설정조회 */
            EvMypageConsultRequestDto evMypageConsultRequestDto = new EvMypageConsultRequestDto();
            evMypageConsultRequestDto.setCust_id(evMypageConsultMsgRequestDto.getRcv_cust_id());
            evMypageConsultRequestDto.setEv_expo_id(evExpoResponseDto.getEv_expo_id());

            List<EvMypageConsultResponseDto> consultSetting = evMypageConsultService.consult_settime_select(evMypageConsultRequestDto);

            Long consultTimeId = 0L;

            if(consultSetting != null && consultSetting.size() == 1) {
                consultTimeId = consultSetting.get(0).getConsult_time_id();
            }

            evMypageConsultMsgRequestDto.setConsult_time_id(consultTimeId);
            evMypageConsultMsgRequestDto.setSchedule_id(null);
            evMypageConsultMsgRequestDto.setSnd_cust_id(evMypageConsultMsgRequestDto.getCust_id());
            evMypageConsultMsgRequestDto.setRcv_cust_id(evMypageConsultMsgRequestDto.getRcv_cust_id());

            /* 메시지 입력 */
            evMypageConsultService.consult_msg_insert(evMypageConsultMsgRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 메시지조회전송
     * @param evMypageConsultMsgRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/mypage/myp10M02")
    public Map<String,Object> mypage_myp10M02 (@RequestBody EvMypageConsultMsgRequestDto evMypageConsultMsgRequestDto, HttpServletRequest request) {

        Map<String,Object> resposeResult = new HashMap<>();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            EvExpoResponseDto evExpoResponseDto = (EvExpoResponseDto)request.getSession().getAttribute(StringUtils.expo_info_session);

            evMypageConsultMsgRequestDto.setCust_id(loginInfoDto.getCust_id());
            evMypageConsultMsgRequestDto.setEv_expo_id(evExpoResponseDto.getEv_expo_id());
            evMypageConsultMsgRequestDto.setRcv_cust_id(evMypageConsultMsgRequestDto.getCust_id());
            evMypageConsultMsgRequestDto.setSnd_cust_id(evMypageConsultMsgRequestDto.getSnd_cust_id());

            /* 상담내역조회 */
            List<EvMypageConsultMsgResponseDto> list = evMypageConsultService.consult_msg_search2(evMypageConsultMsgRequestDto);

            /* 상담건수조회 */
            List<EvMypageConsultMsgResponseDto> listCnt = evMypageConsultService.consult_count2(evMypageConsultMsgRequestDto);

            resposeResult.put("consultList", list);
            resposeResult.put("consultListCnt", listCnt);
            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return resposeResult;

    }

    /**
     * 메시지전송고객조회
     * @param evMypageConsultMsgRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/mypage/myp10M03")
    public Map<String,Object> mypage_myp10M03 (@RequestBody EvMypageConsultMsgRequestDto evMypageConsultMsgRequestDto, HttpServletRequest request) {

        Map<String,Object> resposeResult = new HashMap<>();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            EvExpoResponseDto evExpoResponseDto = (EvExpoResponseDto)request.getSession().getAttribute(StringUtils.expo_info_session);

            evMypageConsultMsgRequestDto.setCust_id(loginInfoDto.getCust_id());
            evMypageConsultMsgRequestDto.setEv_expo_id(evExpoResponseDto.getEv_expo_id());

            /* 상담내역조회 */
            List<EvMypageConsultMsgResponseDto> list = evMypageConsultService.consult_cust_msg_search2(evMypageConsultMsgRequestDto);

            resposeResult.put("consultCustList", list);
            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return resposeResult;

    }

    /**
     * 타임존 설정
     * @param evMypageConsultRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/mypage/setTimeZone")
    public Map<String,Object> mypage_setTimeZone (@RequestBody EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request) {

        Map<String,Object> resposeResult = new HashMap<>();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            evMypageConsultRequestDto.setUser_id(loginInfoDto.getCust_id());

            evMypageConsultService.consult_settime_update2(evMypageConsultRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return resposeResult;

    }

    /**
     * 타임존 설정
     * @param evMypageConsultRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/mypage/setTimeZoneCust")
    public Map<String,Object> mypage_setTimeZoneCust (@RequestBody EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request) {

        Map<String,Object> resposeResult = new HashMap<>();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            evMypageConsultRequestDto.setUser_id(loginInfoDto.getCust_id());

            EvMemberLoginRequestDto evMemberLoginRequestDto = new EvMemberLoginRequestDto();
            evMemberLoginRequestDto.setCust_id(loginInfoDto.getCust_id());
            evMemberLoginRequestDto.setUser_id(loginInfoDto.getCust_id());
            evMemberLoginRequestDto.setTiemzone_cd(evMypageConsultRequestDto.getTiemzone_cd());
            evMemberService.update_timezone(evMemberLoginRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return resposeResult;

    }


    /**
     * 상담신청 사용자 체크
     * @param evMypageConsultRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/mypage/myc09CustChk")
    public Map<String,Object> mypage_myc09CustChk (@RequestBody EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request) {

        Map<String,Object> resposeResult = new HashMap<>();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);
            evMypageConsultRequestDto.setUser_id(loginInfoDto.getCust_id());

            /* 상담내역조회 */
            List<EvMypageConsultScheduleResponseDto> list = evMypageConsultService.consult_shedule(evMypageConsultRequestDto);

            if("Y".equals(list.get(0).getDel_yn()) || list == null || list.size() <= 0) {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "상담신청내역이 없습니다.");
            } else if("".equals(StringUtils.nvl(list.get(0).getConsult_rsv_cust_id(),""))) {
                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");
            } else if(!list.get(0).getConsult_rsv_cust_id().equals(loginInfoDto.getCust_id())) {
                resposeResult.put("result_code", "-2");
                resposeResult.put("result_msg", "상담신청내역이 아닙니다");
            } else {
                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return resposeResult;

    }


    /**
     * vr상담신청현황
     * @param evMypageConsultRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/vr/consltreq")
    public String vr_consltreq (EvMypageConsultRequestDto evMypageConsultRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),""))) {
                returnUrl = "/vr/vr_login_form";
                loginInfoDto = new EvMemberLoginInfoDto();
                loginInfoDto.setCust_id("");
                //return returnUrl;
            } else {
                returnUrl = "/vr/vr_coslt_request";
            }

            returnUrl = "/vr/vr_coslt_request";

            /* 타임존 조회 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("213000");
            List<EvCommCodeResponseDto> timezoneList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* Expo 정보조회 (예약가능일자조회) */
            EvExpoRequestDto evExpoRequestDtoDto = new EvExpoRequestDto();
            evExpoRequestDtoDto.setCust_id(loginInfoDto.getCust_id());
            List<EvExpoResponseDto> expoInfo = evExpoService.expo_info_search2(evExpoRequestDtoDto);
            String consultFromDt = "";
            String consultToDt = "";
            String sunday = "";
            int evExpoId = 0;

            if(expoInfo != null && expoInfo.size() == 1) {
                consultFromDt = expoInfo.get(0).getExpo_consult_from_dt();
                consultToDt = expoInfo.get(0).getExpo_consult_to_dt();
                evExpoId = expoInfo.get(0).getEv_expo_id();
                sunday = expoInfo.get(0).getSunday();

            }

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

            /* 전주(left), 다음주(right) 구분 */
            if("left".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_cls_cd(),""))) {
                Date leftDt = sf.parse(evMypageConsultRequestDto.getSunday());
                long leftTime = leftDt.getTime() - (1000 * 60 * 60 * 24 * 7);
                leftDt.setTime(leftTime);
                sunday = sf.format(leftDt);
            } else if("right".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_cls_cd(),""))) {
                Date rightDt = sf.parse(evMypageConsultRequestDto.getSunday());
                long leftTime = rightDt.getTime() + (1000 * 60 * 60 * 24 * 7);
                rightDt.setTime(leftTime);
                sunday = sf.format(rightDt);
            } else if("now".equals(StringUtils.nvl(evMypageConsultRequestDto.getSh_cls_cd(),""))) {
                sunday = evMypageConsultRequestDto.getSunday();
            }

            /* 화면에서 넘겨주는 ID를 셋팅한다. */
            evMypageConsultRequestDto.setCust_id(loginInfoDto.getCust_id());
            evMypageConsultRequestDto.setEv_expo_id(evExpoId);

            /* 상담-설정조회 */
            List<EvMypageConsultResponseDto> consultSettingCust = evMypageConsultService.consult_cust_settime_select(evMypageConsultRequestDto);

            Long consultTimeId = 0L; String tiemzone_cd = "", consult_from_time = "", consult_to_time = "", timezone_hhmm_fr = "", timezone_hhmm_to = "";

            if(consultSettingCust != null && consultSettingCust.size() == 1) {

                EvMypageConsultRequestDto consultRequestDto = new EvMypageConsultRequestDto();
                consultRequestDto.setCust_id(evMypageConsultRequestDto.getConsultCustId());
                consultRequestDto.setEv_expo_id(evExpoId);
                List<EvMypageConsultResponseDto> consultSetting = evMypageConsultService.consult_settime_select(consultRequestDto);

                if(consultSetting != null && consultSetting.size() == 1) {
                    consultTimeId = consultSetting.get(0).getConsult_time_id();
                } else {
                    consultTimeId = 0L;
                }

                tiemzone_cd = consultSettingCust.get(0).getTiemzone_cd();
                consult_from_time = consultSettingCust.get(0).getConsult_from_time();
                consult_to_time = consultSettingCust.get(0).getConsult_to_time();

                /* 타이존시간 00:00, 00:30 ... */
                timezone_hhmm_fr = consultSettingCust.get(0).getTimezone_hhmm_fr();
                timezone_hhmm_to = consultSettingCust.get(0).getTimezone_hhmm_to();
            } else {
                //default 설정
                consultTimeId = 0L;
                tiemzone_cd = "213001";
                consult_from_time = "214019";
                consult_to_time = "214036";
                timezone_hhmm_fr = "09:00";
                timezone_hhmm_to = "17:30";
            }

            /* 예약시간 조회 */
            evCommCodeRequestDto.setUpper_cd_id("214000");
            List<EvCommCodeResponseDto> timeList  = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 상담가능기간 체크 */
            evMypageConsultRequestDto.setCust_id(evMypageConsultRequestDto.getConsultCustId());
            evMypageConsultRequestDto.setExpo_consult_from_dt(consultFromDt);
            evMypageConsultRequestDto.setExpo_consult_to_dt(consultToDt);
            evMypageConsultRequestDto.setConsult_time_id(consultTimeId);
            evMypageConsultRequestDto.setEv_expo_id(evExpoId);
            evMypageConsultRequestDto.setSunday(sunday); //요일을 일요일부터 표시한다.
            evMypageConsultRequestDto.setConsult_from_time(consult_from_time);
            evMypageConsultRequestDto.setConsult_to_time(consult_to_time);
            evMypageConsultRequestDto.setTiemzone_cd(tiemzone_cd);
            evMypageConsultRequestDto.setTimezone_hhmm_fr(timezone_hhmm_fr);
            evMypageConsultRequestDto.setTimezone_hhmm_to(timezone_hhmm_to);

            /* 시간별 상담내역 */
            Map<String,Object> consultMap = getTimeList(evMypageConsultRequestDto);

            model.addAttribute("timezoneList", timezoneList);
            model.addAttribute("consult_from_dt", consultFromDt);
            model.addAttribute("consult_to_dt", consultToDt);
            model.addAttribute("timeList", timeList);

            /* 시간별 상담내역 - 헤더건수 */
            model.addAttribute("header_cnt", consultMap.get("period"));

            /* 시간별 상담내역 */
            model.addAttribute("consultList", consultMap.get("newList"));

            /* 상담-설정조회 */
            model.addAttribute("consult_time_id", consultTimeId);
            model.addAttribute("tiemzone_cd", tiemzone_cd);
            model.addAttribute("consult_from_time", consult_from_time);
            model.addAttribute("consult_to_time", consult_to_time);
            model.addAttribute("consultCustId", evMypageConsultRequestDto.getConsultCustId());
            model.addAttribute("consultCustNm", evMypageConsultRequestDto.getConsultCustNm());

            model.addAttribute("sunday", sunday);

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }
}
