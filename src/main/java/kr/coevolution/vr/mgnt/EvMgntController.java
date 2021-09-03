package kr.coevolution.vr.mgnt;

import kr.coevolution.vr.board.dto.*;
import kr.coevolution.vr.board.service.EvBoardService;
import kr.coevolution.vr.comm.dto.EvCommCodeRequestDto;
import kr.coevolution.vr.comm.dto.EvCommCodeResponseDto;
import kr.coevolution.vr.comm.dto.EvExpoRequestDto;
import kr.coevolution.vr.comm.dto.EvExpoResponseDto;
import kr.coevolution.vr.comm.service.EvCommCodeService;
import kr.coevolution.vr.comm.service.EvExpoService;
import kr.coevolution.vr.comm.util.SecureUtils;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.dto.EvMemberLoginRequestDto;
import kr.coevolution.vr.member.dto.EvMemberResposeDto;
import kr.coevolution.vr.member.dto.EvMemberSearchDto;
import kr.coevolution.vr.member.service.EvMemberService;
import kr.coevolution.vr.mgnt.dto.*;
import kr.coevolution.vr.mgnt.service.EvMgntConsultService;
import kr.coevolution.vr.mgnt.service.EvMgntService;
import kr.coevolution.vr.mypage.EvMypageMemberController;
import kr.coevolution.vr.mypage.dto.EvMypageBadgeRequestDto;
import kr.coevolution.vr.mypage.dto.EvMypageBadgeResponseDto;
import kr.coevolution.vr.mypage.dto.EvMypageCustCorpInfoRequestDto;
import kr.coevolution.vr.mypage.service.EvMypageBoardConsltService;
import kr.coevolution.vr.mypage.service.EvMypageCustCorpInfoService;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@NoArgsConstructor
@Controller
public class EvMgntController {

    @Autowired
    private EvMgntService evMgntService;

    @Autowired
    private EvMemberService evMemberService;

    @Autowired
    private EvCommCodeService evCommCodeService;

    @Autowired
    private EvMypageCustCorpInfoService evMypageCustCorpInfoService;

    @Autowired
    private EvMypageBoardConsltService evMypageBoardConsltService;

    @Autowired
    private EvBoardService evBoardService;

    @Autowired
    private EvExpoService evExpoService;

    @Autowired
    private EvMgntConsultService evMgntConsultService;


    @Autowired
    AuthenticationManager authenticationManager;

    Logger logger = LoggerFactory.getLogger(this.getClass());

    @ResponseBody
    @PostMapping("/mgnt/login")
    public Map<String,Object> mgnt_login(@RequestBody EvMemberLoginRequestDto evMemberLoginRequestDto, HttpSession session, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        logger.info("member_login post start");
        String msg = "";
        try {
            /* 패스워드를 암호화하여 비교한다. */
            String userPw = evMemberLoginRequestDto.getUser_pw();
            userPw = SecureUtils.getSecurePassword(userPw);
            evMemberLoginRequestDto.setUser_pw(userPw);

            List<EvMemberLoginInfoDto> evMemberLoginInfoDtoList = evMgntService.search_login(evMemberLoginRequestDto);

            if(evMemberLoginInfoDtoList.size() == 1) {

                if("Y".equals(evMemberLoginInfoDtoList.get(0).getChange_yn())) {
                    resposeResult.put("result_code", "-2");
                    resposeResult.put("result_msg", "비밀번호를 변경해 주시기 바랍니다.");
                } else {

                    /* sesstion 정보 입력 */
                    session.setAttribute(StringUtils.login_mgnt_session, evMemberLoginInfoDtoList.get(0));

                    /* sesstion 정보 입력 expo 정보 */
                    EvExpoRequestDto evExpoRequestDtoDto = new EvExpoRequestDto();
                    evExpoRequestDtoDto.setCust_id(evMemberLoginInfoDtoList.get(0).getCust_id());
                    List<EvExpoResponseDto> expoInfoList = evExpoService.expo_info_search(evExpoRequestDtoDto);

                    session.setAttribute(StringUtils.expo_info_session, expoInfoList.get(0));

                    UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(evMemberLoginRequestDto.getCust_nm(), userPw);

                    // Authenticate the user
                    Authentication authentication = authenticationManager.authenticate(authRequest);
                    SecurityContext securityContext = SecurityContextHolder.getContext();
                    securityContext.setAuthentication(authentication);

                    // Create a new session and add the security context.
                    session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);

                    //관리자 메뉴 리스트 조회
                    Map<String, String> pMap = new HashMap<String, String>();
                    pMap.put("mgnt_id", evMemberLoginInfoDtoList.get(0).getMgnt_id());
                    pMap.put("menu_lvel", "1"); //메뉴레벨1
                    List<Map<String, String>> userMenuList1 = evMgntService.mgnt_user_menu_list(pMap);
                    session.setAttribute("MGNT_MENU_LEVL1", userMenuList1);

                    pMap.put("menu_lvel", "2"); //메뉴레벨2
                    List<Map<String, String>> userMenuList2 = evMgntService.mgnt_user_menu_list(pMap);
                    session.setAttribute("MGNT_MENU_LEVL2", userMenuList2);

                    resposeResult.put("cust_clsf_cd", evMemberLoginInfoDtoList.get(0).getCust_clsf_cd());
                    resposeResult.put("result_code", "0");
                    resposeResult.put("result_msg", "성공!!");
                }

            } else {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "로그인정보가 정확하지 않습니다.");
            }

        } catch (Exception e) {
            msg = e.toString();
            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "입력실패!!");

            e.printStackTrace();
        } finally {
            try {
                String ip = StringUtils.getRemoteIP(request);

                Map<String, String> map = new HashMap<String, String>();
                map.put("cust_id", evMemberLoginRequestDto.getUser_id());
                map.put("ip", ip);
                map.put("rmk", String.valueOf(resposeResult.get("result_code")) + " : " + String.valueOf(resposeResult.get("result_msg")) + "\r\n"+msg);

                evMgntService.login_log(map);

            } catch (Exception e2){}

        }

        return resposeResult;
    }

    /**
     * 관리자 뱃지관리
     * @param evMypageBadgeRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/badge")
    public String mgnt_badge_list(EvMypageBadgeRequestDto evMypageBadgeRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt01";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);
            EvExpoResponseDto expoInfoList = (EvExpoResponseDto)httpSession.getAttribute(StringUtils.expo_info_session);

            evMypageBadgeRequestDto.setUser_id(loginInfoDto.getCust_id());
            evMypageBadgeRequestDto.setCust_id(loginInfoDto.getCust_id());

            if("".equals(StringUtils.nvl(evMypageBadgeRequestDto.getEv_expo_id(),""))) {
                evMypageBadgeRequestDto.setEv_expo_id(String.valueOf(expoInfoList.getEv_expo_id()));
            }

            /* 콤보용엑스포리스트 */
            EvMgntExpoRequestDto evMgntExpoRequestDto = new EvMgntExpoRequestDto();
            List<EvMgntExpoResponseDto> expoCdList = evMgntService.expo_all_list(evMgntExpoRequestDto);
            
            /* 공통코드조회 - 부스 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("106000");
            evCommCodeRequestDto.setUse_yn("Y");
            List<EvCommCodeResponseDto> category = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            model.addAttribute("category", category);

            /* row 개수 */
            evMypageBadgeRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMypageBadgeRequestDto.getPage_current(), StringUtils.page_row_cnt);
            evMypageBadgeRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMypageBadgeRequestDto.getPage_current(),""))) {
                evMypageBadgeRequestDto.setPage_current(1L);
            }

            /* 참관/참가 구분 */
            if("".equals(StringUtils.nvl(evMypageBadgeRequestDto.getCust_clsf_sh(),""))) {
                evMypageBadgeRequestDto.setCust_clsf_sh("202001");
            }

            model.addAttribute("page_current", String.valueOf(evMypageBadgeRequestDto.getPage_current()));  /* 현재페이지 */

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();

            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evMypageBadgeRequestDto.getIns_dt_fr(),""))) {
                Date ftDt = StringUtils.addMonth(nDt,-1);
                String strDt = sf.format(ftDt);
                evMypageBadgeRequestDto.setIns_dt_fr(strDt);
            }

            if("".equals(StringUtils.nvl(evMypageBadgeRequestDto.getIns_dt_to(),""))) {
                String strDt = sf.format(nDt);
                evMypageBadgeRequestDto.setIns_dt_to(strDt);
            }

            /* 뱃지 리스트 조회 */
            List<EvMypageBadgeResponseDto> list = null;
            List<EvMypageBadgeResponseDto> listCnt = null;

            if("202001".equals(evMypageBadgeRequestDto.getCust_clsf_sh())) {
                list = evMgntService.mgnt_badge_list(evMypageBadgeRequestDto);
                listCnt = evMgntService.mgnt_badge_list_count(evMypageBadgeRequestDto);
            } else {
                list = evMgntService.mgnt_badge_list2(evMypageBadgeRequestDto);
                listCnt = evMgntService.mgnt_badge_list2_count(evMypageBadgeRequestDto);
            }

            Long row_count = 0L;

            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count();
            }

            model.addAttribute("page_clsf", "mgnt01");
            model.addAttribute("expo_id", evMypageBadgeRequestDto.getEv_expo_id());
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총 개수 */
            model.addAttribute("page_row_cnt", evMypageBadgeRequestDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMypageBadgeRequestDto.getPage_current());    /* 현재페이지 */
            model.addAttribute("expoCdList", expoCdList);

            /* 검색조건 */
            model.addAttribute("ins_dt_fr", evMypageBadgeRequestDto.getIns_dt_fr());
            model.addAttribute("ins_dt_to", evMypageBadgeRequestDto.getIns_dt_to());
            model.addAttribute("cust_clsf_sh", evMypageBadgeRequestDto.getCust_clsf_sh());
            model.addAttribute("category_sh", evMypageBadgeRequestDto.getCategory_sh());
            model.addAttribute("category_nm_sh", evMypageBadgeRequestDto.getCategory_nm_sh());

            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;

    }

    /**
     * 관리자 뱃지관리 엑셀다운
     * @param evMypageBadgeRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/badgeExcel")
    public void mgnt_badge_excel(EvMypageBadgeRequestDto evMypageBadgeRequestDto, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {

        String returnUrl = "/mgnt/mgnt01";

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);
        EvExpoResponseDto expoInfoList = (EvExpoResponseDto)httpSession.getAttribute(StringUtils.expo_info_session);

        evMypageBadgeRequestDto.setUser_id(loginInfoDto.getCust_id());
        evMypageBadgeRequestDto.setCust_id(loginInfoDto.getCust_id());

        if("".equals(StringUtils.nvl(evMypageBadgeRequestDto.getEv_expo_id(),""))) {
            evMypageBadgeRequestDto.setEv_expo_id(String.valueOf(expoInfoList.getEv_expo_id()));
        }

        /* 콤보용엑스포리스트 */
        EvMgntExpoRequestDto evMgntExpoRequestDto = new EvMgntExpoRequestDto();
        List<EvMgntExpoResponseDto> expoCdList = evMgntService.expo_all_list(evMgntExpoRequestDto);

        /* 공통코드조회 - 부스 */
        EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
        evCommCodeRequestDto.setUpper_cd_id("106000");
        evCommCodeRequestDto.setUse_yn("Y");
        List<EvCommCodeResponseDto> category = evCommCodeService.comm_code_search(evCommCodeRequestDto);

        model.addAttribute("category", category);

        /* row 개수 */
        evMypageBadgeRequestDto.setPage_row_cnt(100000L);
        evMypageBadgeRequestDto.setPage_row_start(0L);

        if("".equals(StringUtils.nvl(evMypageBadgeRequestDto.getPage_current(),""))) {
            evMypageBadgeRequestDto.setPage_current(1L);
        }

        /* 참관/참가 구분 */
        if("".equals(StringUtils.nvl(evMypageBadgeRequestDto.getCust_clsf_sh(),""))) {
            evMypageBadgeRequestDto.setCust_clsf_sh("202001");
        }

        model.addAttribute("page_current", String.valueOf(evMypageBadgeRequestDto.getPage_current()));  /* 현재페이지 */

        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        Date nDt = new Date();

        /* 최초 날짜가 null 인경우 */
        if("".equals(StringUtils.nvl(evMypageBadgeRequestDto.getIns_dt_fr(),""))) {
            Date ftDt = StringUtils.addMonth(nDt,-1);
            String strDt = sf.format(ftDt);
            evMypageBadgeRequestDto.setIns_dt_fr(strDt);
        }

        if("".equals(StringUtils.nvl(evMypageBadgeRequestDto.getIns_dt_to(),""))) {
            String strDt = sf.format(nDt);
            evMypageBadgeRequestDto.setIns_dt_to(strDt);
        }

        /* 뱃지 리스트 조회 */
        List<EvMypageBadgeResponseDto> list = null;
        List<EvMypageBadgeResponseDto> listCnt = null;

        if("202001".equals(evMypageBadgeRequestDto.getCust_clsf_sh())) {
            list = evMgntService.mgnt_badge_list(evMypageBadgeRequestDto);
        } else {
            list = evMgntService.mgnt_badge_list2(evMypageBadgeRequestDto);
        }

        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("첫번째 시트");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;

        if("202001".equals(evMypageBadgeRequestDto.getCust_clsf_sh())) {
            // Header
            row = sheet.createRow(rowNum++);
            cell = row.createCell(0);
            cell.setCellValue("번호");
            cell = row.createCell(1);
            cell.setCellValue("회원명");
            cell = row.createCell(2);
            cell.setCellValue("뱃지지급");
            cell = row.createCell(3);
            cell.setCellValue("사용뱃지");
            cell = row.createCell(4);
            cell.setCellValue("잔여뱃지");
            cell = row.createCell(5);
            cell.setCellValue("피추천수");
            cell = row.createCell(6);
            cell.setCellValue("사용기간");
            cell = row.createCell(7);
            cell.setCellValue("부여일");
        } else {
            // Header
            row = sheet.createRow(rowNum++);
            cell = row.createCell(0);
            cell.setCellValue("번호");
            cell = row.createCell(1);
            cell.setCellValue("회원명");
            cell = row.createCell(2);
            cell.setCellValue("총뱃지");
            cell = row.createCell(3);
            cell.setCellValue("뱃지부여");
            cell = row.createCell(4);
            cell.setCellValue("뱃지회수");
            cell = row.createCell(5);
            cell.setCellValue("사용기간");
            cell = row.createCell(6);
            cell.setCellValue("부여일");
        }

        // Body
        for (int i=0; i < list.size(); i++) {
            EvMypageBadgeResponseDto dto = list.get(i);

            row = sheet.createRow(rowNum++);

            if("202001".equals(evMypageBadgeRequestDto.getCust_clsf_sh())) {
                cell = row.createCell(0);
                cell.setCellValue(dto.getRn());
                cell = row.createCell(1);
                cell.setCellValue(dto.getCust_nm());
                cell = row.createCell(2);
                cell.setCellValue(dto.getTot_badge_paid_cnt());
                cell = row.createCell(3);
                cell.setCellValue(dto.getTot_badge_use_cnt());
                cell = row.createCell(4);
                cell.setCellValue(dto.getTot_badge_rmin_cnt());
                cell = row.createCell(5);
                cell.setCellValue(dto.getTot_badge_rcmd_cnt());
                cell = row.createCell(6);
                cell.setCellValue(dto.getExpo_consult_prod());
                cell = row.createCell(7);
                cell.setCellValue(dto.getIns_dt());
            } else {
                cell = row.createCell(0);
                cell.setCellValue(dto.getRn());
                cell = row.createCell(1);
                cell.setCellValue(dto.getCust_nm());
                cell = row.createCell(2);
                cell.setCellValue(dto.getTot_badge());
                cell = row.createCell(3);
                cell.setCellValue(dto.getTot_rcv());
                cell = row.createCell(4);
                cell.setCellValue(dto.getTot_recall());
                cell = row.createCell(5);
                cell.setCellValue(dto.getExpo_consult_prod());
                cell = row.createCell(6);
                cell.setCellValue(dto.getIns_dt());
            }
        }

        String strDt = sf.format(nDt);

        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename="+strDt+".xlsx");

        // Excel File Output
        wb.write(response.getOutputStream());
        wb.close();

    }

    /**
     * 관리자 상담문의내역
     * @param evBoardSearchDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/conslt")
    public String mgnt_conslt_list(EvBoardSearchDto evBoardSearchDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt02";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();


            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evBoardSearchDto.getIns_dt_fr(),""))) {
                Date ftDt = StringUtils.addMonth(nDt,-1);
                String strDt = sf.format(ftDt);
                evBoardSearchDto.setIns_dt_fr(strDt);
            }

            if("".equals(StringUtils.nvl(evBoardSearchDto.getIns_dt_to(),""))) {
                String strDt = sf.format(nDt);
                evBoardSearchDto.setIns_dt_to(strDt);
            }

            /* row 개수 */
            evBoardSearchDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evBoardSearchDto.getPage_current());
            evBoardSearchDto.setPage_row_start(page_row_start);

            List<EvBoardConsltResponseDto> list = evMypageBoardConsltService.mgnt_conslt_list(evBoardSearchDto);
            List<EvBoardConsltResponseDto> listCnt = evMypageBoardConsltService.mgnt_conslt_list_count(evBoardSearchDto);

            Long row_count = 0L;
            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count();
            }

            if("".equals(StringUtils.nvl(evBoardSearchDto.getPage_current(),""))) {
                evBoardSearchDto.setPage_current(1L);
            }

            model.addAttribute("page_clsf", "mgnt02");
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총 개수 */
            model.addAttribute("page_row_cnt", evBoardSearchDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evBoardSearchDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("board_stat_cd", evBoardSearchDto.getBoard_stat_cd());
            model.addAttribute("keyword_clsf_cd", evBoardSearchDto.getKeyword_clsf_cd());
            model.addAttribute("keyword", evBoardSearchDto.getKeyword());
            model.addAttribute("ins_dt_fr", evBoardSearchDto.getIns_dt_fr());
            model.addAttribute("ins_dt_to", evBoardSearchDto.getIns_dt_to());

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;

    }

    /**
     * 상담상세내용
     * @param evBoardSearchDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/conslt_dtl")
    public String mgnt_conslt_dtl(EvBoardSearchDto evBoardSearchDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt021";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            model.addAttribute("board_id", evBoardSearchDto.getBoard_id());
            model.addAttribute("page_clsf", "mgnt02");
            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;

    }
    /**
     * 참가고개정 정보 조회
     * @param evMgntMemberRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/m_corp_search")
    public String mgnt_member_corp_search(EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0301";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            evMgntMemberRequestDto.setUser_id(loginInfoDto.getCust_id());
            evMgntMemberRequestDto.setCust_id(loginInfoDto.getCust_id());
            evMgntMemberRequestDto.setCust_clsf_cd("202002"); //참가

            /* row 개수 */
            evMgntMemberRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMgntMemberRequestDto.getPage_current());
            evMgntMemberRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getPage_current(),""))) {
                evMgntMemberRequestDto.setPage_current(1L);
            }

            model.addAttribute("page_current", String.valueOf(evMgntMemberRequestDto.getPage_current()));  /* 현재페이지 */

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();


            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_fr(),""))) {
                Date ftDt = StringUtils.addMonth(nDt,-1);
                String strDt = sf.format(ftDt);
                evMgntMemberRequestDto.setIns_dt_fr(strDt);
            }

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_to(),""))) {
                String strDt = sf.format(nDt);
                evMgntMemberRequestDto.setIns_dt_to(strDt);
            }

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getKeyword(),""))) {
                evMgntMemberRequestDto.setKeyword("");
            }

            /* 뱃지 리스트 조회 */
            List<EvMgntMemberResponseDto> list = evMgntService.search_member_list(evMgntMemberRequestDto);
            List<EvMgntMemberResponseDto> listCnt = evMgntService.search_member_list_count(evMgntMemberRequestDto);

            Long row_count = 0L;

            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count(); /* 총건수 */
            }

            for(EvMgntMemberResponseDto vList : list) {
                Long base62Encode = vList.getCust_seq() * SecureUtils.vr_cust_seq_const;
                vList.setVr_cust_id(SecureUtils.base62Encoding(base62Encode));
            }

            Long page_row_cnt = StringUtils.page_tot(row_count);

            model.addAttribute("page_clsf", "mgnt0301");
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총건수 */
            model.addAttribute("page_row_cnt", evMgntMemberRequestDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMgntMemberRequestDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("ins_dt_fr", evMgntMemberRequestDto.getIns_dt_fr());
            model.addAttribute("ins_dt_to", evMgntMemberRequestDto.getIns_dt_to());
            model.addAttribute("keyword", evMgntMemberRequestDto.getKeyword());

            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;

    }

    /**
     * 참가고개정 정보 조회 (엑셀)
     * @param evMgntMemberRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/m_corp_excel")
    public void mgnt_m_corp_excel(EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

        evMgntMemberRequestDto.setUser_id(loginInfoDto.getCust_id());
        evMgntMemberRequestDto.setCust_id(loginInfoDto.getCust_id());
        evMgntMemberRequestDto.setCust_clsf_cd("202002"); //참가

        /* row 개수 */
        evMgntMemberRequestDto.setPage_row_cnt(100000L);
        evMgntMemberRequestDto.setPage_row_start(0L);

        if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getPage_current(),""))) {
            evMgntMemberRequestDto.setPage_current(1L);
        }

        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        Date nDt = new Date();

        /* 최초 날짜가 null 인경우 */
        if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_fr(),""))) {
            Date ftDt = StringUtils.addMonth(nDt,-1);
            String strDt = sf.format(ftDt);
            evMgntMemberRequestDto.setIns_dt_fr(strDt);
        }

        if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_to(),""))) {
            String strDt = sf.format(nDt);
            evMgntMemberRequestDto.setIns_dt_to(strDt);
        }

        if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getKeyword(),""))) {
            evMgntMemberRequestDto.setKeyword("");
        }

        List<EvMgntMemberResponseDto> list = evMgntService.search_member_list(evMgntMemberRequestDto);

        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("첫번째 시트");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;

        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("번호");
        cell = row.createCell(1);
        cell.setCellValue("아이디");
        cell = row.createCell(2);
        cell.setCellValue("VR_ID");
        cell = row.createCell(3);
        cell.setCellValue("참가업체명");
        cell = row.createCell(4);
        cell.setCellValue("이메일");
        cell = row.createCell(5);
        cell.setCellValue("가입일자");
        cell = row.createCell(6);
        cell.setCellValue("최종로그인");

        // Body
        for (int i=0; i < list.size(); i++) {
            EvMgntMemberResponseDto dto = list.get(i);
            row = sheet.createRow(rowNum++);
            cell = row.createCell(0);
            cell.setCellValue(dto.getRn());
            cell = row.createCell(1);
            cell.setCellValue(dto.getCust_id());
            cell = row.createCell(2);

            Long base62Encode = dto.getCust_seq() * SecureUtils.vr_cust_seq_const;
            dto.setVr_cust_id(SecureUtils.base62Encoding(base62Encode));

            cell.setCellValue(dto.getVr_cust_id());
            cell = row.createCell(3);
            cell.setCellValue(dto.getCust_nm());
            cell = row.createCell(4);
            cell.setCellValue(dto.getEmail_id());
            cell = row.createCell(5);
            cell.setCellValue(dto.getIns_dtm());
            cell = row.createCell(6);
            cell.setCellValue(dto.getLogin_dtm());
        }

        String strDt = sf.format(nDt);

        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename="+strDt+".xlsx");

        // Excel File Output
        wb.write(response.getOutputStream());
        wb.close();

    }

    /**
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/m_corp_user_form")
    public String mgnt_member_corp_user_form(HttpServletRequest request, Model model) {
        String returnUrl = "/mgnt/mgnt0302";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            model.addAttribute("page_clsf", "mgnt0301");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 상세내역이동
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/m_corp_detail")
    public String mgnt_member_corp_detail(HttpServletRequest request, Model model) {
        String returnUrl = "/mgnt/mgnt0303";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            model.addAttribute("page_clsf", "mgnt0301");
            model.addAttribute("cust_id", request.getParameter("cust_id"));

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }


    /**
     * 관리자-기업정보조회
     * @param map
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/m_corp_custinfo")
    public Map<String,Object> mgnt_member_corp_custinfo(@RequestBody Map map, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

        if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),"")) || !"202003".equals(loginInfoDto.getCust_clsf_cd())) {
            httpSession.removeAttribute(StringUtils.login_mgnt_session);
            resposeResult.put("session_yn", "N");
            resposeResult.put("result_code", "-9999");
            resposeResult.put("result_msg", "세션정보없음");
            return resposeResult;
        } else {
            resposeResult.put("session_yn", "Y");
        }

        try {
            EvMypageMemberController memberController = new EvMypageMemberController();

            EvMemberSearchDto evMemberSearchDto = new EvMemberSearchDto();
            evMemberSearchDto.setUser_id(String.valueOf(map.get("cust_id")));
            evMemberSearchDto.setCust_id(String.valueOf(map.get("cust_id")));

            /* 고객정보조회 */
            List<EvMemberResposeDto> custInfo = evMemberService.search_cust_info(evMemberSearchDto);

            /* 국가코드조회 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("212000");
            evCommCodeRequestDto.setUse_yn("Y");
            List<EvCommCodeResponseDto> countrylist = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 카테고리 */
            evCommCodeRequestDto.setUpper_cd_id("106000");
            List<EvCommCodeResponseDto> category1 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            resposeResult.put("custInfo", custInfo);
            resposeResult.put("countrylist", countrylist);
            resposeResult.put("category1", category1);

            /* vr-기업정보 url */
            Long base62Encode = custInfo.get(0).getCust_seq() * SecureUtils.vr_cust_seq_const;
            String vr_corpinfo_url = SecureUtils.base62Encoding(base62Encode);
            resposeResult.put("vr_corpinfo_url", "/vr/vr_corp_form?c="+vr_corpinfo_url);
            resposeResult.put("vr_corpcoslt_url", "/vr/vr_coslt_form?c="+vr_corpinfo_url);
            resposeResult.put("vr_log_url", "/index/loginsert");
            resposeResult.put("vr_cust_seq", vr_corpinfo_url);

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
     * 관리자-기업정보수정
     * @param map
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/m_corp_custupdate")
    public Map<String,Object> mgnt_member_corp_custupdate(@RequestBody Map map, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

        if(loginInfoDto == null || "".equals(StringUtils.nvl(loginInfoDto.getCust_id(),"")) || !"202003".equals(loginInfoDto.getCust_clsf_cd())) {
            httpSession.removeAttribute(StringUtils.login_mgnt_session);
            resposeResult.put("session_yn", "N");
            resposeResult.put("result_code", "-9999");
            resposeResult.put("result_msg", "세션정보없음");
            return resposeResult;
        } else {
            resposeResult.put("session_yn", "Y");
        }

        try {
            map.put("cust_id", map.get("cust_id"));
            map.put("user_id", loginInfoDto.getCust_id());

            int result_code = evMemberService.member_update2(map);

            if(result_code < 0) {
                throw new RuntimeException();
            }

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
     * 내부스정보-첨부파일 저당
     * @param evMypageCustCorpInfoRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/m_corp_attach")
    public Map<String,Object> mgnt_corpattach (EvMypageCustCorpInfoRequestDto evMypageCustCorpInfoRequestDto, @RequestPart List<MultipartFile> files, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            EvMemberSearchDto evMemberSearchDto = new EvMemberSearchDto();
            evMemberSearchDto.setCust_id(evMypageCustCorpInfoRequestDto.getFile_cust_id());

            /* 고객정보조회 */
            List<EvMemberResposeDto> custInfo = evMemberService.search_cust_info(evMemberSearchDto);

            evMypageCustCorpInfoRequestDto.setBoard_id(custInfo.get(0).getCust_seq());
            evMypageCustCorpInfoRequestDto.setCust_id(evMypageCustCorpInfoRequestDto.getFile_cust_id());
            evMypageCustCorpInfoRequestDto.setUser_id(loginInfoDto.getCust_id());

            /* 내 부스정보 첨부파일 업로드 */
            int return_code = evMypageCustCorpInfoService.mypage_cust_corp_file(evMypageCustCorpInfoRequestDto, files);

            if(return_code != 0) {
                new RuntimeException("-1");
            } else {
                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "업로드실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 비밀번호를 초기화한다.
     * @param pMap
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/m_corp_pwreset")
    public Map<String,Object> mgnt_corppwreset (@RequestBody Map<String, String> pMap, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);
            EvMemberLoginRequestDto evMemberLoginRequestDto = new EvMemberLoginRequestDto();

            /* cust_id를 비밀번호로 변경한다 - 초기화 */
            String userCurrentPw = pMap.get("cust_id");

            userCurrentPw = SecureUtils.getSecurePassword(pMap.get("cust_id"));
            evMemberLoginRequestDto.setUser_change_pw1(userCurrentPw);
            evMemberLoginRequestDto.setUser_id(loginInfoDto.getCust_id());
            evMemberLoginRequestDto.setCust_id(pMap.get("cust_id"));

            int result_code = evMemberService.member_passwd(evMemberLoginRequestDto);

            if(result_code != 0) {
                new RuntimeException("-1");
            } else {
                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "업로드실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 참관고객조회
     * @param evMgntMemberRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/m_member_search")
    public String mgnt_member_search(EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0401";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            evMgntMemberRequestDto.setUser_id(loginInfoDto.getCust_id());
            evMgntMemberRequestDto.setCust_id(loginInfoDto.getCust_id());
            evMgntMemberRequestDto.setCust_clsf_cd("202001"); //참관

            /* row 개수 */
            evMgntMemberRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMgntMemberRequestDto.getPage_current());
            evMgntMemberRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getPage_current(),""))) {
                evMgntMemberRequestDto.setPage_current(1L);
            }

            model.addAttribute("page_current", String.valueOf(evMgntMemberRequestDto.getPage_current()));  /* 현재페이지 */

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();


            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_fr(),""))) {
                Date ftDt = StringUtils.addMonth(nDt,-1);
                String strDt = sf.format(ftDt);
                evMgntMemberRequestDto.setIns_dt_fr(strDt);
            }

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_to(),""))) {
                String strDt = sf.format(nDt);
                evMgntMemberRequestDto.setIns_dt_to(strDt);
            }

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getKeyword(),""))) {
                evMgntMemberRequestDto.setKeyword("");
            }

            /* 뱃지 리스트 조회 */
            List<EvMgntMemberResponseDto> list = evMgntService.search_member_list(evMgntMemberRequestDto);
            List<EvMgntMemberResponseDto> listCnt = evMgntService.search_member_list_count(evMgntMemberRequestDto);

            Long row_count = 0L;

            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count(); /* 총건수 */
            }

            Long page_row_cnt = StringUtils.page_tot(row_count);

            model.addAttribute("page_clsf", "mgnt0401");
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총건수 */
            model.addAttribute("page_row_cnt", evMgntMemberRequestDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMgntMemberRequestDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("ins_dt_fr", evMgntMemberRequestDto.getIns_dt_fr());
            model.addAttribute("ins_dt_to", evMgntMemberRequestDto.getIns_dt_to());
            model.addAttribute("keyword", evMgntMemberRequestDto.getKeyword());

            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    @RequestMapping("/mgnt/m_member_form")
    public String m_member_form(EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0402";

        try {
            model.addAttribute("cust_id", evMgntMemberRequestDto.getCust_id());
            model.addAttribute("page_clsf", "mgnt0401");
            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 관리자페이지 조회
     * @param map
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/m_member_search_dtl")
    public Map<String,Object> m_member_search_dtl(@RequestBody Map map, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

        try {
            EvMemberSearchDto evMemberSearchDto = new EvMemberSearchDto();
            evMemberSearchDto.setUser_id(loginInfoDto.getCust_id());
            evMemberSearchDto.setCust_id(StringUtils.nvl(map.get("cust_id"),""));

            /* 고객정보조회 */
            List<EvMemberResposeDto> custInfo = evMemberService.search_cust_info(evMemberSearchDto);

            /* 선택항목조회 (관심분야, 종사분야, 업무(구매)권한, 방문목적) */
            List<Map<String, Object>> custIntrst = evMemberService.search_cust_intrst(evMemberSearchDto);

            /* 국가코드조회 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("212000");
            evCommCodeRequestDto.setUse_yn("Y");
            List<EvCommCodeResponseDto> countrylist = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 관심분야 */
            evCommCodeRequestDto.setUpper_cd_id("206000");
            List<EvCommCodeResponseDto> list1 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 종사분야 */
            evCommCodeRequestDto.setUpper_cd_id("207000");
            List<EvCommCodeResponseDto> list2 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 업무(구매)권한 */
            evCommCodeRequestDto.setUpper_cd_id("208000");
            List<EvCommCodeResponseDto> list3 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 방문목적 */
            evCommCodeRequestDto.setUpper_cd_id("209000");
            List<EvCommCodeResponseDto> list4 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 인지경로 */
            evCommCodeRequestDto.setUpper_cd_id("210000");
            List<EvCommCodeResponseDto> list5 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            /* 카테고리 */
            evCommCodeRequestDto.setUpper_cd_id("106000");
            List<EvCommCodeResponseDto> category1 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            resposeResult.put("custInfo", custInfo);
            resposeResult.put("custIntrst", custIntrst);
            resposeResult.put("countrylist", countrylist);
            resposeResult.put("list1", list1);
            resposeResult.put("list2", list2);
            resposeResult.put("list3", list3);
            resposeResult.put("list4", list4);
            resposeResult.put("list5", list5);
            resposeResult.put("category1", category1);

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
     * 관리자 리스트
     * @param evMgntMemberRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/user")
    public String m_member_user_list(EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0501";
        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            evMgntMemberRequestDto.setUser_id(loginInfoDto.getCust_id());
            evMgntMemberRequestDto.setCust_id(loginInfoDto.getCust_id());

            /* row 개수 */
            evMgntMemberRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMgntMemberRequestDto.getPage_current());
            evMgntMemberRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getPage_current(),""))) {
                evMgntMemberRequestDto.setPage_current(1L);
            }

            model.addAttribute("page_current", String.valueOf(evMgntMemberRequestDto.getPage_current()));  /* 현재페이지 */

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getMgnt_id(),""))) {
                evMgntMemberRequestDto.setMgnt_id("");
            }

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getMgnt_nm(),""))) {
                evMgntMemberRequestDto.setMgnt_nm("");
            }

            /* 뱃지 리스트 조회 */
            List<EvMgntMemberResponseDto> list = evMgntService.search_mgnt_user_list(evMgntMemberRequestDto);
            List<EvMgntMemberResponseDto> listCnt = evMgntService.search_mgnt_user_list_count(evMgntMemberRequestDto);

            Long row_count = 0L;

            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count(); /* 총건수 */
            }

            Long page_row_cnt = StringUtils.page_tot(row_count);

            model.addAttribute("page_clsf", "mgnt05");
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총건수 */
            model.addAttribute("page_row_cnt", evMgntMemberRequestDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMgntMemberRequestDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("mgnt_id_sh", evMgntMemberRequestDto.getMgnt_id_sh());
            model.addAttribute("mgnt_nm_sh", evMgntMemberRequestDto.getMgnt_nm_sh());

            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 관리자페이지 - 관리자입력 폼
     * @param evMgntMemberRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/user_form")
    public String m_member_user_form(EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0502";

        try {

            if("U".equals(evMgntMemberRequestDto.getMode())) {
                returnUrl = "/mgnt/mgnt0503";
                
                //관리자정보조회
                List<EvMgntMemberResponseDto> mgntInfo = evMgntService.search_mgnt_user_info(evMgntMemberRequestDto);
                model.addAttribute("mgnt_id", mgntInfo.get(0).getMgnt_id());
                model.addAttribute("mgnt_nm", mgntInfo.get(0).getMgnt_nm());
                model.addAttribute("email_id", mgntInfo.get(0).getEmail_id());
                model.addAttribute("hp_no", mgntInfo.get(0).getHp_no());
                model.addAttribute("dept_nm", mgntInfo.get(0).getDept_nm());
                model.addAttribute("use_yn", mgntInfo.get(0).getUse_yn());

                //권한
                Map<String, String> pMap = new HashMap<String, String>();
                pMap.put("mgnt_id", evMgntMemberRequestDto.getMgnt_id());
                List<Map<String,String>> listPrms = evMgntService.search_mgnt_prms_list(pMap);

                for(int i = 0; i < listPrms.size(); i++) {
                    model.addAttribute("S"+listPrms.get(i).get("menu_id"), listPrms.get(i).get("use_yn"));
                }
            }

            model.addAttribute("mgnt_id", evMgntMemberRequestDto.getMgnt_id());
            model.addAttribute("page_clsf", "mgnt05");
            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 관리자 중복체크
     * @param evMgntMemberRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/user_dup")
    public Map<String,Object> mgnt_user_dup(@RequestBody EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

        try {

            List<EvMgntMemberResponseDto> list = evMgntService.search_mgnt_dup_chk(evMgntMemberRequestDto);

            String dup_yn = "N";
            if(0 < list.get(0).getDup_cnt()) {
                dup_yn = "Y";
            }

            resposeResult.put("dup_yn", dup_yn);
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
     * 관리자를 등록한다.
     * @param pMap
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/insert")
    public Map<String,Object> mgnt_user_insert(@RequestBody Map<String, String> pMap, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

        try {
            /* 등록자 입력 */
            pMap.put("user_id", loginInfoDto.getMgnt_id());

            evMgntService.mgnt_user_insert(pMap);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            if("-1".equals(e.getMessage())) {
                resposeResult.put("result_code", e.getMessage());
                resposeResult.put("result_msg", "ID중복 오류");
            } else {
                resposeResult.put("result_code", "-99");
                resposeResult.put("result_msg", "입력실패!!");
            }

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 관리자 정보를 수정한다.
     * @param pMap
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/update")
    public Map<String,Object> mgnt_user_update(@RequestBody Map<String, String> pMap, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

        try {
            /* 등록자 입력 */
            pMap.put("user_id", loginInfoDto.getMgnt_id());

            evMgntService.mgnt_user_update(pMap);

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
     * 비밀번호변경
     * @param evMgntMemberRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/pwChange")
    public Map<String,Object> mgnt_user_password_chagne(@RequestBody EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

        try {
            if(!evMgntMemberRequestDto.getMgnt_passwd1().equals(evMgntMemberRequestDto.getMgnt_passwd2())) {
                throw new RuntimeException("-1");
            }

            /* 비밀번호 암호화 */
            String mgnt_pw = String.valueOf(evMgntMemberRequestDto.getMgnt_passwd1());
            mgnt_pw = SecureUtils.getSecurePassword(mgnt_pw);
            evMgntMemberRequestDto.setMgnt_pw(mgnt_pw);
            evMgntMemberRequestDto.setUser_id(loginInfoDto.getMgnt_id());

            evMgntService.mgnt_user_passwd_change(evMgntMemberRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {
            if("-1".equals(e.getMessage())) {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "비밀번호 오류!!");
            } else {
                resposeResult.put("result_code", "-99");
                resposeResult.put("result_msg", "입력실패!!");
            }

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 비밀번호변경
     * @param evMgntMemberRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/pwChg")
    public Map<String,Object> mgnt_user_password_chagne2(@RequestBody EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        try {

            EvMemberLoginRequestDto evMemberLoginRequestDto = new EvMemberLoginRequestDto();

            if(evMgntMemberRequestDto.getTobe_passwd1().equals(evMgntMemberRequestDto.getBf_user_pw())) {
                resposeResult.put("result_code", "-3");
                resposeResult.put("result_msg", "기존 비밀번호와 동일합니다. 다른 비밀번호로 입력하세요.");
            } else if(!evMgntMemberRequestDto.getTobe_passwd1().equals(evMgntMemberRequestDto.getTobe_passwd2())) {
                    resposeResult.put("result_code", "-4");
                    resposeResult.put("result_msg", "비밀번호를 정확히 입력하세요.");
            } else {

                /* 패스워드를 암호화하여 비교한다. */
                String userPw = evMgntMemberRequestDto.getBf_user_pw();
                userPw = SecureUtils.getSecurePassword(userPw);
                evMemberLoginRequestDto.setUser_pw(userPw);
                evMemberLoginRequestDto.setUser_id(evMgntMemberRequestDto.getUser_id());

                List<EvMemberLoginInfoDto> evMemberLoginInfoDtoList = evMgntService.search_login(evMemberLoginRequestDto);

                if (evMemberLoginInfoDtoList.size() == 1) {
                    /* 비밀번호 암호화 */
                    String mgnt_pw = String.valueOf(evMgntMemberRequestDto.getTobe_passwd1());
                    mgnt_pw = SecureUtils.getSecurePassword(mgnt_pw);
                    evMgntMemberRequestDto.setMgnt_pw(mgnt_pw);
                    evMgntMemberRequestDto.setUser_id(evMgntMemberRequestDto.getUser_id());
                    evMgntMemberRequestDto.setMgnt_id(evMgntMemberRequestDto.getUser_id());

                    evMgntService.mgnt_user_passwd_change(evMgntMemberRequestDto);

                    resposeResult.put("result_code", "0");
                    resposeResult.put("result_msg", "성공!!");
                } else {
                    resposeResult.put("result_code", "-2");
                    resposeResult.put("result_msg", "기존 비밀번호가 일치하지 않습니다.");
                }
            }
        } catch (Exception e) {
            if("-1".equals(e.getMessage())) {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "비밀번호 오류!!");
            } else {
                resposeResult.put("result_code", "-99");
                resposeResult.put("result_msg", "입력실패!!");
            }

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 공콩코드 form
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/code")
    public String mgnt_code (Model model) {

        String returnUrl = "/mgnt/mgnt0601";
        model.addAttribute("page_clsf", "mgnt06");

        return returnUrl;
    }

    /**
     * 공콩코드 form
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/codeList")
    public String mgnt_codeList (EvCommCodeRequestDto evCommCodeRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0601";
        
        /* 검색조건셋팅 */
        if(!"".equals(StringUtils.nvl(evCommCodeRequestDto.getCode_clsf3(),""))) {
            evCommCodeRequestDto.setCd_id(evCommCodeRequestDto.getCode_clsf3());
        } else if(!"".equals(StringUtils.nvl(evCommCodeRequestDto.getCode_clsf2(),""))) {
            evCommCodeRequestDto.setUpper_cd_id(evCommCodeRequestDto.getCode_clsf2());
        } else if(!"".equals(StringUtils.nvl(evCommCodeRequestDto.getCode_clsf1(),""))) {
            evCommCodeRequestDto.setUpper_cd_id(evCommCodeRequestDto.getCode_clsf1());
        }

        List<EvCommCodeResponseDto> list = evCommCodeService.comm_code_search(evCommCodeRequestDto);

        model.addAttribute("codelist", list);

        /* 검색조건 */
        model.addAttribute("code_clsf1", evCommCodeRequestDto.getCode_clsf1());

        evCommCodeRequestDto.setUpper_cd_id("000000");
        evCommCodeRequestDto.setCd_id(null);
        list = evCommCodeService.comm_code_search(evCommCodeRequestDto);
        model.addAttribute("code_clsf1_list", list);

        model.addAttribute("code_clsf2", evCommCodeRequestDto.getCode_clsf2());

        if(!"".equals(evCommCodeRequestDto.getCode_clsf1())) {
            evCommCodeRequestDto.setUpper_cd_id(evCommCodeRequestDto.getCode_clsf1());
            list = evCommCodeService.comm_code_search(evCommCodeRequestDto);
            model.addAttribute("code_clsf2_list", list);
        }

        model.addAttribute("code_clsf3", evCommCodeRequestDto.getCode_clsf3());

        if(!"".equals(evCommCodeRequestDto.getCode_clsf2())) {
            evCommCodeRequestDto.setUpper_cd_id(evCommCodeRequestDto.getCode_clsf2());
            list = evCommCodeService.comm_code_search(evCommCodeRequestDto);
            model.addAttribute("code_clsf3_list", list);
        }

        model.addAttribute("page_clsf", "mgnt06");

        return returnUrl;
    }

    /**
     * 공통코드 수정
     * @param pMap
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/codeSave")
    public Map<String,Object> mgnt_code_save(@RequestBody Map<String, String> pMap, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

        try {
            String[] vField = new String[]{"cd_nm", "upper_cd_id", "cd_val1", "cd_val2", "cd_val3", "priority", "use_yn"};

            /* List 만들기 */
            List list = new ArrayList();
            for(int i = 0; i < 8; i++) {
                Map<String, String> vMap = new HashMap<String, String>();
                String cdId = pMap.get("cd_id_"+i);
                vMap.put("cd_id", cdId);
                vMap.put("user_id", loginInfoDto.getCust_id());

                for(int j = 0; j < vField.length; j++) {
                    vMap.put(vField[j], pMap.get(vField[j] + "_"+ cdId));
                }

                list.add(vMap);
            }

            /* 공통코드 수정 */
            evCommCodeService.comm_cd_update(list);
            
            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {
            if("-1".equals(e.getMessage())) {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "비밀번호 오류!!");
            } else {
                resposeResult.put("result_code", "-99");
                resposeResult.put("result_msg", "입력실패!!");
            }

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 공통코드 신규저장
     * @param evCommCodeRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/codeInsert")
    public Map<String,Object> mgnt_code_insert(@RequestBody EvCommCodeRequestDto evCommCodeRequestDto, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

        try {
            /* 공통코드 수정 */
            evCommCodeRequestDto.setUser_id(loginInfoDto.getCust_id());
            evCommCodeService.comm_cd_insert(evCommCodeRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {
            if("-1".equals(e.getMessage())) {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "비밀번호 오류!!");
            } else {
                resposeResult.put("result_code", "-99");
                resposeResult.put("result_msg", "입력실패!!");
            }

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 공콩코드 form
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/terms_list")
    public String mgnt_terms_list (EvBoardSearchDto evBoardSearchDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0701";

        evBoardSearchDto.setBoard_clsf_cd(evBoardSearchDto.getT());

        evBoardSearchDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
        Long page_row_start = StringUtils.page_start_row(evBoardSearchDto.getPage_current());
        evBoardSearchDto.setPage_row_start(page_row_start);

        List<EvBoardTermsResponseDto> list = evBoardService.terms_list(evBoardSearchDto);
        List<EvBoardTermsResponseDto> listCnt = evBoardService.terms_list_count(evBoardSearchDto);

        Long row_count = 0L;
        if(listCnt != null && listCnt.size() > 0) {
            row_count = listCnt.get(0).getRow_count();
        }

        if("".equals(StringUtils.nvl(evBoardSearchDto.getPage_current(),""))) {
            evBoardSearchDto.setPage_current(1L);
        }

        model.addAttribute("termslist", list);
        model.addAttribute("row_count", row_count); /* 총 개수 */
        model.addAttribute("page_row_cnt", evBoardSearchDto.getPage_row_cnt());    /* 페이지 row 개수 */
        model.addAttribute("page_current", evBoardSearchDto.getPage_current());    /* 현재페이지 */

        model.addAttribute("board_clsf_cd",  evBoardSearchDto.getT()); //구분

        if("101006".equals(evBoardSearchDto.getT())) {
            model.addAttribute("page_clsf", "mgnt071"); //개인정보처리방침
            model.addAttribute("page_clsf_nm", "개인정보처리방침"); //개인정보처리방침
        } else if("101007".equals(evBoardSearchDto.getT())) {
            model.addAttribute("page_clsf", "mgnt072"); //이용약관
            model.addAttribute("page_clsf_nm", "이용약관"); //이용약관
        } else if("101009".equals(evBoardSearchDto.getT())) {
            model.addAttribute("page_clsf", "mgnt073"); //마케팅활용동의
            model.addAttribute("page_clsf_nm", "마케팅활용동의"); //마케팅활용동의
        }

        return returnUrl;
    }

    /**
     * 약관상세
     * @param evBoardSearchDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/terms_form")
    public String mgnt_terms_form (EvBoardSearchDto evBoardSearchDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0702";
        model.addAttribute("board_clsf_cd",  evBoardSearchDto.getBoard_clsf_cd()); //구분

        if("101006".equals(evBoardSearchDto.getBoard_clsf_cd())) {
            model.addAttribute("page_clsf", "mgnt071"); //개인정보처리방침
            model.addAttribute("page_clsf_nm", "개인정보처리방침"); //개인정보처리방침
        } else if("101007".equals(evBoardSearchDto.getBoard_clsf_cd())) {
            model.addAttribute("page_clsf", "mgnt072"); //이용약관
            model.addAttribute("page_clsf_nm", "이용약관"); //이용약관
        } else if("101009".equals(evBoardSearchDto.getBoard_clsf_cd())) {
            model.addAttribute("page_clsf", "mgnt073"); //마케팅활용동의
            model.addAttribute("page_clsf_nm", "마케팅활용동의"); //마케팅활용동의
        }

        return returnUrl;
    }

    /**
     * 공통코드 신규저장
     * @param evBoardSearchDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/terms_detail")
    public Map<String,Object> mgnt_terms_detail(@RequestBody EvBoardSearchDto evBoardSearchDto, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

        try {
            List<EvBoardTermsResponseDto> list = evBoardService.terms_detail(evBoardSearchDto);
            resposeResult.put("data", list);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {
            if("-1".equals(e.getMessage())) {
                resposeResult.put("result_code", "-1");
                resposeResult.put("result_msg", "비밀번호 오류!!");
            } else {
                resposeResult.put("result_code", "-99");
                resposeResult.put("result_msg", "입력실패!!");
            }

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 부스현황조회
     * @param evMgntMemberRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/booth")
    public String mgnt_booth_list(EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0801";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            EvExpoResponseDto expoInfoList = (EvExpoResponseDto)httpSession.getAttribute(StringUtils.expo_info_session);

            evMgntMemberRequestDto.setUser_id(loginInfoDto.getCust_id());

            /* 공통코드조회 - 부스 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("106000");
            evCommCodeRequestDto.setUse_yn("Y");
            List<EvCommCodeResponseDto> category = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            model.addAttribute("category", category);

            /* row 개수 */
            evMgntMemberRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMgntMemberRequestDto.getPage_current(), StringUtils.page_row_cnt);
            evMgntMemberRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getPage_current(),""))) {
                evMgntMemberRequestDto.setPage_current(1L);
            }

            model.addAttribute("page_current", String.valueOf(evMgntMemberRequestDto.getPage_current()));  /* 현재페이지 */

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();

            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_fr(),""))) {
                Date ftDt = StringUtils.addMonth(nDt,-1);
                String strDt = sf.format(ftDt);
                evMgntMemberRequestDto.setIns_dt_fr(strDt);
            }

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_to(),""))) {
                String strDt = sf.format(nDt);
                evMgntMemberRequestDto.setIns_dt_to(strDt);
            }

            evMgntMemberRequestDto.setEv_expo_id(expoInfoList.getEv_expo_id());

            /* 부스 리스트 조회 */
            List<EvMgntMemberResponseDto> listCnt = evMgntService.mgnt_booth_list_count(evMgntMemberRequestDto);
            List<EvMgntMemberResponseDto> list = evMgntService.mgnt_booth_list(evMgntMemberRequestDto);


            Long row_count = 0L;

            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count();
            }

            model.addAttribute("page_clsf", "mgnt08");
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총 개수 */
            model.addAttribute("page_row_cnt", evMgntMemberRequestDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMgntMemberRequestDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("ins_dt_fr", evMgntMemberRequestDto.getIns_dt_fr());
            model.addAttribute("ins_dt_to", evMgntMemberRequestDto.getIns_dt_to());
            model.addAttribute("cust_nm", evMgntMemberRequestDto.getCust_nm());
            model.addAttribute("category1", evMgntMemberRequestDto.getCategory1());
            model.addAttribute("cust_id", evMgntMemberRequestDto.getCust_id());
            model.addAttribute("tot_period", evMgntMemberRequestDto.getTot_period());

            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;

    }

    /**
     * 부스현황 엑셀
     * @param evMgntMemberRequestDto
     * @param request
     * @param model
     * @throws IOException
     */
    @RequestMapping("/mgnt/booth_xlsx")
    public void booth_xlsx(EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request, HttpServletResponse response, Model model)  throws IOException {

        EvExpoResponseDto expoInfoList = (EvExpoResponseDto)request.getSession().getAttribute(StringUtils.expo_info_session);

        evMgntMemberRequestDto.setPage_row_cnt(100000L);
        evMgntMemberRequestDto.setPage_row_start(0L);

        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        Date nDt = new Date();

        /* 최초 날짜가 null 인경우 */
        if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_fr(),""))) {
            Date ftDt = StringUtils.addMonth(nDt,-1);
            String strDt = sf.format(ftDt);
            evMgntMemberRequestDto.setIns_dt_fr(strDt);
        }

        if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_to(),""))) {
            String strDt = sf.format(nDt);
            evMgntMemberRequestDto.setIns_dt_to(strDt);
        }

        evMgntMemberRequestDto.setEv_expo_id(expoInfoList.getEv_expo_id());

        /* 부스 리스트 조회 */
        List<EvMgntMemberResponseDto> list = evMgntService.mgnt_booth_list(evMgntMemberRequestDto);

        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("첫번째 시트");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;

        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("번호");
        cell = row.createCell(1);
        cell.setCellValue("구분");
        cell = row.createCell(2);
        cell.setCellValue("부스명");
        cell = row.createCell(3);
        cell.setCellValue("일자");
        cell = row.createCell(4);
        cell.setCellValue("즐겨찾기");
        cell = row.createCell(5);
        cell.setCellValue("뱃지");
        cell = row.createCell(6);
        cell.setCellValue("기업정보");
        cell = row.createCell(7);
        cell.setCellValue("자료소개");
        cell = row.createCell(8);
        cell.setCellValue("갤러리");
        cell = row.createCell(9);
        cell.setCellValue("Q&A");
        cell = row.createCell(10);
        cell.setCellValue("홍보동영상");
        cell = row.createCell(11);
        cell.setCellValue("링크바로가기");


        // Body
        for (int i=0; i < list.size(); i++) {
            EvMgntMemberResponseDto dto = list.get(i);
            row = sheet.createRow(rowNum++);
            cell = row.createCell(0);
            cell.setCellValue(dto.getRn());
            cell = row.createCell(1);
            cell.setCellValue(dto.getCaregori_nm());
            cell = row.createCell(2);
            cell.setCellValue(dto.getCust_nm());
            cell = row.createCell(3);
            cell.setCellValue(dto.getIns_dt());
            cell = row.createCell(4);
            cell.setCellValue(dto.getFavorts_cnt());
            cell = row.createCell(5);
            cell.setCellValue(dto.getBadge_cnt());
            cell = row.createCell(6);
            cell.setCellValue(dto.getAccess01_cnt());
            cell = row.createCell(7);
            cell.setCellValue(dto.getAccess02_cnt());
            cell = row.createCell(8);
            cell.setCellValue(dto.getAccess03_cnt());
            cell = row.createCell(9);
            cell.setCellValue(dto.getAccess04_cnt());
            cell = row.createCell(10);
            cell.setCellValue(dto.getAccess05_cnt());
            cell = row.createCell(11);
            cell.setCellValue(dto.getAccess06_cnt());
        }

        String strDt = sf.format(nDt);

        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=access_log_"+strDt+".xlsx");

        // Excel File Output
        wb.write(response.getOutputStream());
        wb.close();
    }


    /**
     * 접속로그
     * @param evMgntMemberRequestDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/access")
    public String mgnt_access_list(EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt0901";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            evMgntMemberRequestDto.setUser_id(loginInfoDto.getCust_id());

            /* row 개수 */
            evMgntMemberRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMgntMemberRequestDto.getPage_current(), StringUtils.page_row_cnt);
            evMgntMemberRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getPage_current(),""))) {
                evMgntMemberRequestDto.setPage_current(1L);
            }

            model.addAttribute("page_current", String.valueOf(evMgntMemberRequestDto.getPage_current()));  /* 현재페이지 */

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();

            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_fr(),""))) {
                Date ftDt = StringUtils.addMonth(nDt,-1);
                String strDt = sf.format(ftDt);
                evMgntMemberRequestDto.setIns_dt_fr(strDt);
            }

            if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_to(),""))) {
                String strDt = sf.format(nDt);
                evMgntMemberRequestDto.setIns_dt_to(strDt);
            }

            /* 접속현황 리스트 조회 */
            List<EvMgntMemberResponseDto> list = evMgntService.mgnt_access_log_list(evMgntMemberRequestDto);
            List<EvMgntMemberResponseDto> listCnt = evMgntService.mgnt_access_log_list_count(evMgntMemberRequestDto);

            Long row_count = 0L;

            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count();
            }

            model.addAttribute("page_clsf", "mgnt09");
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총 개수 */
            model.addAttribute("page_row_cnt", evMgntMemberRequestDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMgntMemberRequestDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("ins_dt_fr", evMgntMemberRequestDto.getIns_dt_fr());
            model.addAttribute("ins_dt_to", evMgntMemberRequestDto.getIns_dt_to());
            model.addAttribute("access_nm", evMgntMemberRequestDto.getAccess_nm());
            model.addAttribute("access_id", evMgntMemberRequestDto.getAccess_id());

            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;

    }


    @RequestMapping("/mgnt/access_xlsx")
    public void excelDownload(EvMgntMemberRequestDto evMgntMemberRequestDto, HttpServletResponse response) throws IOException {

        evMgntMemberRequestDto.setPage_row_cnt(100000L);
        evMgntMemberRequestDto.setPage_row_start(0L);

        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        Date nDt = new Date();

        /* 최초 날짜가 null 인경우 */
        if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_fr(),""))) {
            Date ftDt = StringUtils.addMonth(nDt,-1);
            String strDt = sf.format(ftDt);
            evMgntMemberRequestDto.setIns_dt_fr(strDt);
        }

        if("".equals(StringUtils.nvl(evMgntMemberRequestDto.getIns_dt_to(),""))) {
            String strDt = sf.format(nDt);
            evMgntMemberRequestDto.setIns_dt_to(strDt);
        }

        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("첫번째 시트");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;

        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("번호");
        cell = row.createCell(1);
        cell.setCellValue("접속자명");
        cell = row.createCell(2);
        cell.setCellValue("접속ID");
        cell = row.createCell(3);
        cell.setCellValue("접속IP");
        cell = row.createCell(4);
        cell.setCellValue("접속일시");

        /* 접속현황 리스트 조회 */
        List<EvMgntMemberResponseDto> list = evMgntService.mgnt_access_log_list(evMgntMemberRequestDto);

        // Body
        for (int i=0; i < list.size(); i++) {
            EvMgntMemberResponseDto dto = list.get(i);
            row = sheet.createRow(rowNum++);
            cell = row.createCell(0);
            cell.setCellValue(dto.getRn());
            cell = row.createCell(1);
            cell.setCellValue(dto.getCust_nm());
            cell = row.createCell(2);
            cell.setCellValue(dto.getCust_id());
            cell = row.createCell(3);
            cell.setCellValue(dto.getIp());
            cell = row.createCell(4);
            cell.setCellValue(dto.getLogin_dtm());
        }

        String strDt = sf.format(nDt);

        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=access_log_"+strDt+".xlsx");

        // Excel File Output
        wb.write(response.getOutputStream());
        wb.close();
    }


    /**
     * 참가회원등록 공통코드 조회
     * @param map
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/mgnt0301S01")
    public Map<String,Object> mgnt_mgnt0301S01(@RequestBody Map map, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

        try {
            EvMemberSearchDto evMemberSearchDto = new EvMemberSearchDto();
            evMemberSearchDto.setUser_id(loginInfoDto.getCust_id());
            evMemberSearchDto.setCust_id(loginInfoDto.getCust_id());
            evMemberSearchDto.setLang(StringUtils.nvl(httpSession.getAttribute("LANG"),"ko"));

            /* 국가코드조회 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("212000");
            List<EvCommCodeResponseDto> countrylist = evCommCodeService.comm_code_search(evCommCodeRequestDto);
            /* 카테고리 */
            evCommCodeRequestDto.setUpper_cd_id("106000");
            List<EvCommCodeResponseDto> category1 = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            resposeResult.put("countrylist", countrylist);
            resposeResult.put("category1", category1);

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
     * 참가회원등록
     * @param map
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/mgnt0301001")
    public Map<String,Object> mgnt_mgnt0301001(@RequestBody Map map, HttpServletRequest request) {

        Map resposeResult = new HashMap();

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

        try {
            map.put("cust_sts_cd", "105001"); //정상
            map.put("cust_clsf_cd", "202002"); //참가고객
            map.put("user_id", loginInfoDto.getCust_id());
            map.put("cust_pw", SecureUtils.getSecurePassword(String.valueOf(map.get("cust_pw"))));
            evMgntService.cust_user_insert(map);

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
     * 엑스포관리-조히
     * @param evMgntExpoRequestDto
     * @param request
     * @return
     */
    @RequestMapping("/mgnt/expo")
    public String mgnt_expo(EvMgntExpoRequestDto evMgntExpoRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt1001";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            evMgntExpoRequestDto.setUser_id(loginInfoDto.getCust_id());

            /* row 개수 */
            evMgntExpoRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMgntExpoRequestDto.getPage_current(), StringUtils.page_row_cnt);
            evMgntExpoRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMgntExpoRequestDto.getPage_current(),""))) {
                evMgntExpoRequestDto.setPage_current(1L);
            }

            model.addAttribute("page_current", String.valueOf(evMgntExpoRequestDto.getPage_current()));  /* 현재페이지 */

            SimpleDateFormat sf = new SimpleDateFormat("yyyy");
            Date nDt = new Date();
            String yyyy = sf.format(nDt);

            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evMgntExpoRequestDto.getExpo_dt_fr(),""))) {
                evMgntExpoRequestDto.setExpo_dt_fr(yyyy + "-01-01");
            }

            if("".equals(StringUtils.nvl(evMgntExpoRequestDto.getExpo_dt_to(),""))) {
                evMgntExpoRequestDto.setExpo_dt_to(yyyy + "-12-31");
            }

            if("".equals(StringUtils.nvl(evMgntExpoRequestDto.getUse_yn(),""))) {
                evMgntExpoRequestDto.setUse_yn("Y");
            }

            /* 뱃지 리스트 조회 */
            List<EvMgntExpoResponseDto> list = null;
            List<EvMgntExpoResponseDto> listCnt = null;

            list = evMgntService.expo_list(evMgntExpoRequestDto);
            listCnt = evMgntService.expo_list_count(evMgntExpoRequestDto);

            Long row_count = 0L;

            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count();
            }

            model.addAttribute("page_clsf", "mgnt10");
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총 개수 */
            model.addAttribute("page_row_cnt", evMgntExpoRequestDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMgntExpoRequestDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("expo_dt_fr", evMgntExpoRequestDto.getExpo_dt_fr());
            model.addAttribute("expo_dt_to", evMgntExpoRequestDto.getExpo_dt_to());
            model.addAttribute("ev_expo_nm", evMgntExpoRequestDto.getEv_expo_nm());
            model.addAttribute("use_yn", evMgntExpoRequestDto.getUse_yn());

            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * expo id 조회
     * @param evMgntExpoRequestDto
     * @param request
     * @param model
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/expo_id")
    public Map<String,Object> mgnt_expo_id(@RequestBody EvMgntExpoRequestDto evMgntExpoRequestDto, HttpServletRequest request, Model model) {

        Map resposeResult = new HashMap();

        try {
            List<EvMgntExpoResponseDto> list = evMgntService.expo_id();

            int expoId = list.get(0).getEv_expo_id();

            resposeResult.put("expoId", expoId);
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
     * 엑스포관리-상세조회
     * @param evMgntExpoRequestDto
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/expo_insert")
    public Map<String,Object> mgnt_expo_insert(@RequestBody EvMgntExpoRequestDto evMgntExpoRequestDto, HttpServletRequest request, Model model) {

        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            evMgntExpoRequestDto.setUser_id(loginInfoDto.getCust_id());
            evMgntExpoRequestDto.setExpo_from_hrm(evMgntExpoRequestDto.getExpo_from_hh()+":"+evMgntExpoRequestDto.getExpo_from_mm());
            evMgntExpoRequestDto.setExpo_to_hrm(evMgntExpoRequestDto.getExpo_to_hh()+":"+evMgntExpoRequestDto.getExpo_to_mm());

            if(evMgntExpoRequestDto.getEv_expo_id() == 0L) {
                int cnt = evMgntService.expo_insert(evMgntExpoRequestDto);
            } else {
                int cnt = evMgntService.expo_update(evMgntExpoRequestDto);
            }

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
     * 엑스포관리-상세조회
     * @param evMgntExpoRequestDto
     * @param request
     * @return
     */
    @RequestMapping("/mgnt/expo_dtl")
    public String mgnt_expo_dtl(EvMgntExpoRequestDto evMgntExpoRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt1002";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            List<EvMgntExpoResponseDto> list = evMgntService.expo_dtl(evMgntExpoRequestDto);

            if(list != null && list.size() > 0) {
                model.addAttribute("expo_dtl", list.get(0));
            }

            model.addAttribute("page_clsf", "mgnt10");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 엑스포관리-조히
     * @param evMgntExpoRequestDto
     * @param request
     * @return
     */
    @RequestMapping("/mgnt/expo_exhibitors")
    public String mgnt_expo_exhibitors(EvMgntExpoRequestDto evMgntExpoRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt1101";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            evMgntExpoRequestDto.setUser_id(loginInfoDto.getCust_id());

            /* row 개수 */
            evMgntExpoRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMgntExpoRequestDto.getPage_current(), StringUtils.page_row_cnt);
            evMgntExpoRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMgntExpoRequestDto.getPage_current(),""))) {
                evMgntExpoRequestDto.setPage_current(1L);
            }

            model.addAttribute("page_current", String.valueOf(evMgntExpoRequestDto.getPage_current()));  /* 현재페이지 */

            SimpleDateFormat sf = new SimpleDateFormat("yyyy");
            Date nDt = new Date();
            String yyyy = sf.format(nDt);

            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evMgntExpoRequestDto.getExpo_dt_fr(),""))) {
                evMgntExpoRequestDto.setExpo_dt_fr(yyyy + "-01-01");
            }

            if("".equals(StringUtils.nvl(evMgntExpoRequestDto.getExpo_dt_to(),""))) {
                evMgntExpoRequestDto.setExpo_dt_to(yyyy + "-12-31");
            }

            if("".equals(StringUtils.nvl(evMgntExpoRequestDto.getUse_yn(),""))) {
                evMgntExpoRequestDto.setUse_yn("Y");
            }

            /* 엑스포 리스트 조회 */
            List<EvMgntExpoResponseDto> list = null;
            List<EvMgntExpoResponseDto> listCnt = null;

            list = evMgntService.expo_list(evMgntExpoRequestDto);
            listCnt = evMgntService.expo_list_count(evMgntExpoRequestDto);

            Long row_count = 0L;

            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count();
            }

            model.addAttribute("page_clsf", "mgnt11");
            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총 개수 */
            model.addAttribute("page_row_cnt", evMgntExpoRequestDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMgntExpoRequestDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("expo_dt_fr", evMgntExpoRequestDto.getExpo_dt_fr());
            model.addAttribute("expo_dt_to", evMgntExpoRequestDto.getExpo_dt_to());
            model.addAttribute("ev_expo_nm", evMgntExpoRequestDto.getEv_expo_nm());
            model.addAttribute("use_yn", evMgntExpoRequestDto.getUse_yn());

            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 엑스포참가업체관리-상세
     * @param evMgntExpoRequestDto
     * @param request
     * @return
     */
    @RequestMapping("/mgnt/expo_exhibitors_dtl")
    public String mgnt_expo_exhibitors_dtl(EvMgntExpoRequestDto evMgntExpoRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt1102";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            /* 참가고객리스트 */
            List<EvMgntExpoResponseDto> list = evMgntService.expo_cust_list(evMgntExpoRequestDto);

            /* 엑스포정보 */
            List<EvMgntExpoResponseDto> expo_dtl = evMgntService.expo_dtl(evMgntExpoRequestDto);

            if(list != null && list.size() > 0) {
                model.addAttribute("expo_dtl", expo_dtl.get(0));
            }

            model.addAttribute("list", list);
            model.addAttribute("page_clsf", "mgnt11");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 엑스포관리-업가업체입력, 삭제
     * @param pMap
     * @param request
     * @return
     */

    @ResponseBody
    @PostMapping("/mgnt/expo_cust_mgnt")
    public Map<String,Object> mgnt_expo_cust_mgnt(@RequestBody Map<String, String> pMap, HttpServletRequest request, Model model) {

        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            /* 참가고객리스트 */
            EvMgntExpoRequestDto evMgntExpoRequestDto = new EvMgntExpoRequestDto();
            evMgntExpoRequestDto.setEv_expo_id(Integer.parseInt(pMap.get("ev_expo_id")));
            List<EvMgntExpoResponseDto> list = evMgntService.expo_cust_list(evMgntExpoRequestDto);

            EvMgntExpoRequestDto req = null;
            for (EvMgntExpoResponseDto custList : list) {

                req = new EvMgntExpoRequestDto();
                req.setEv_expo_id(evMgntExpoRequestDto.getEv_expo_id());
                req.setCust_id(custList.getCust_id());
                req.setUser_id(loginInfoDto.getUser_id());

                evMgntService.expo_cust_delete(req);

                if("Y".equals(pMap.get("chk_"+custList.getCust_id()))) {
                    evMgntService.expo_cust_insert(req);
                }
            }

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
     * 상담신청현호아
     * @param evMgntConsultRequestDto
     * @param request
     * @return
     */
    @RequestMapping("/mgnt/conslt_list")
    public String mgnt_conslt_list(EvMgntConsultRequestDto evMgntConsultRequestDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt1201";

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);
            EvExpoResponseDto expoInfoList = (EvExpoResponseDto)httpSession.getAttribute(StringUtils.expo_info_session);

            evMgntConsultRequestDto.setUser_id(loginInfoDto.getCust_id());
            evMgntConsultRequestDto.setCust_id(loginInfoDto.getCust_id());

            /* row 개수 */
            evMgntConsultRequestDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evMgntConsultRequestDto.getPage_current(), StringUtils.page_row_cnt);
            evMgntConsultRequestDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evMgntConsultRequestDto.getPage_current(),""))) {
                evMgntConsultRequestDto.setPage_current(1L);
            }

            model.addAttribute("page_current", String.valueOf(evMgntConsultRequestDto.getPage_current()));  /* 현재페이지 */

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();

            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evMgntConsultRequestDto.getConsult_dt_fr(),""))) {
                Date ftDt = StringUtils.addMonth(nDt,-1);
                String strDt = sf.format(ftDt);
                evMgntConsultRequestDto.setConsult_dt_fr(strDt);
            }

            if("".equals(StringUtils.nvl(evMgntConsultRequestDto.getConsult_dt_to(),""))) {
                String strDt = sf.format(nDt);
                evMgntConsultRequestDto.setConsult_dt_to(strDt);
            }

            /* 상담 리스트 조회 */
            List<EvMgntConsultResposeDto> list = null;
            List<EvMgntConsultResposeDto> listCnt = null;

            evMgntConsultRequestDto.setEv_expo_id(expoInfoList.getEv_expo_id());

            list = evMgntConsultService.consult_list(evMgntConsultRequestDto);
            listCnt = evMgntConsultService.consult_list_count(evMgntConsultRequestDto);

            Long row_count = 0L;

            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count();
            }

            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총 개수 */
            model.addAttribute("page_row_cnt", evMgntConsultRequestDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evMgntConsultRequestDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("consult_dt_fr", evMgntConsultRequestDto.getConsult_dt_fr());
            model.addAttribute("consult_dt_to", evMgntConsultRequestDto.getConsult_dt_to());
            model.addAttribute("consult_rsv_cust_nm", evMgntConsultRequestDto.getConsult_rsv_cust_nm());
            model.addAttribute("exhibitors_cust_nm", evMgntConsultRequestDto.getExhibitors_cust_nm());

            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

            model.addAttribute("page_clsf", "mgnt12");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 이벤트관리
     * @param evBoardSearchDto
     * @param request
     * @return
     */
    @RequestMapping("/mgnt/event")
    public String mgnt_event_list(EvBoardSearchDto evBoardSearchDto, HttpServletRequest request, Model model) {

        String returnUrl = "/mgnt/mgnt1301";

        try {
            //이벤트관리 셋팅
            evBoardSearchDto.setBoard_clsf_cd("101001"); 

            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            /* row 개수 */
            evBoardSearchDto.setPage_row_cnt((long) StringUtils.page_row_cnt);
            Long page_row_start = StringUtils.page_start_row(evBoardSearchDto.getPage_current(), StringUtils.page_row_cnt);
            evBoardSearchDto.setPage_row_start(page_row_start);

            if("".equals(StringUtils.nvl(evBoardSearchDto.getPage_current(),""))) {
                evBoardSearchDto.setPage_current(1L);
            }

            model.addAttribute("page_current", String.valueOf(evBoardSearchDto.getPage_current()));  /* 현재페이지 */

            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Date nDt = new Date();

            /* 최초 날짜가 null 인경우 */
            if("".equals(StringUtils.nvl(evBoardSearchDto.getIns_dt_fr(),""))) {
                Date ftDt = StringUtils.addMonth(nDt,-1);
                String strDt = sf.format(ftDt);
                evBoardSearchDto.setIns_dt_fr(strDt);
            }

            if("".equals(StringUtils.nvl(evBoardSearchDto.getIns_dt_to(),""))) {
                Date toDt = StringUtils.addMonth(nDt,1);
                String strDt = sf.format(toDt);
                evBoardSearchDto.setIns_dt_to(strDt);
            }

            /* 이벤트 선택 리스트 */
            EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
            evCommCodeRequestDto.setUpper_cd_id("108000");
            evCommCodeRequestDto.setUse_yn("Y");
            List<EvCommCodeResponseDto> boardClsfDtlCdList = evCommCodeService.comm_code_search(evCommCodeRequestDto);

            model.addAttribute("boardClsfDtlCdList", boardClsfDtlCdList);

            /* 상담 리스트 조회 */
            List<EvBoardResponseDto> list = null;
            List<EvBoardResponseDto> listCnt = null;

            list = evBoardService.board_list(evBoardSearchDto);
            listCnt = evBoardService.board_list(evBoardSearchDto);

            Long row_count = 0L;

            if(listCnt != null && listCnt.size() > 0) {
                row_count = listCnt.get(0).getRow_count();
            }

            model.addAttribute("list", list);
            model.addAttribute("row_count", row_count); /* 총 개수 */
            model.addAttribute("page_row_cnt", evBoardSearchDto.getPage_row_cnt());    /* 페이지 row 개수 */
            model.addAttribute("page_current", evBoardSearchDto.getPage_current());    /* 현재페이지 */

            /* 검색조건 */
            model.addAttribute("ins_dt_fr", evBoardSearchDto.getIns_dt_fr());
            model.addAttribute("ins_dt_to", evBoardSearchDto.getIns_dt_to());
            model.addAttribute("keyword", evBoardSearchDto.getKeyword());
            model.addAttribute("board_clsf_dtl_cd", evBoardSearchDto.getBoard_clsf_dtl_cd());

            model.addAttribute("result_code", "0");
            model.addAttribute("result_msg", "성공!!");

            model.addAttribute("page_clsf", "mgnt13");

        } catch (Exception e) {

            model.addAttribute("result_code", "-99");
            model.addAttribute("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return returnUrl;
    }

    /**
     * 이벤트등록폼
     * @param evBoardSearchDto
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mgnt/eventform")
    public String mgnt_event_form(EvBoardSearchDto evBoardSearchDto, HttpServletRequest request, Model model) {
        String returnUrl = "/mgnt/mgnt1302";

        /* 이벤트 선택 리스트 */
        EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();
        evCommCodeRequestDto.setUpper_cd_id("108000");
        evCommCodeRequestDto.setUse_yn("Y");
        List<EvCommCodeResponseDto> boardClsfDtlCdList = evCommCodeService.comm_code_search(evCommCodeRequestDto);

        model.addAttribute("boardClsfDtlCdList", boardClsfDtlCdList);
        model.addAttribute("board_id", evBoardSearchDto.getBoard_id());
        model.addAttribute("page_clsf", "mgnt13");

        return returnUrl;
    }

    /**
     * 이벤트등록
     * @param evBoardRequestDto
     * @param request
     * @param model
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/eventsave")
    public Map<String,Object> mgnt_event_save(@RequestBody EvBoardRequestDto evBoardRequestDto, HttpServletRequest request, Model model) {

        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            //이벤트관리 셋팅
            evBoardRequestDto.setBoard_clsf_cd("101001");
            evBoardRequestDto.setUser_id(loginInfoDto.getUser_id());

            if(evBoardRequestDto.getBoard_id() == null || evBoardRequestDto.getBoard_id() == 0) {
                evBoardService.insert(evBoardRequestDto);
            } else {
                evBoardService.update(evBoardRequestDto);
            }

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
     * 이벤트상세
     * @param evBoardSearchDto
     * @param request
     * @param model
     * @return
     */
    @ResponseBody
    @PostMapping("/mgnt/eventdtl")
    public Map<String,Object> mgnt_event_save(@RequestBody EvBoardSearchDto evBoardSearchDto, HttpServletRequest request, Model model) {

        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

            evBoardSearchDto.setBoard_clsf_cd("101001");
            List<EvBoardResponseDto> list = evBoardService.board_dtl(evBoardSearchDto);
            resposeResult.put("list", list);

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
     * 이벤트엑셀다운로드
     * @param evBoardSearchDto
     * @param request
     * @param response
     * @param model
     * @throws IOException
     */
    @RequestMapping("/mgnt/eventexcel")
    public void mgnt_eventexcel(EvBoardSearchDto evBoardSearchDto, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {

        //이벤트관리 셋팅
        evBoardSearchDto.setBoard_clsf_cd("101001");

        /* 로그인정보 */
        HttpSession httpSession = request.getSession();
        EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_mgnt_session);

        /* row 개수 */
        evBoardSearchDto.setPage_row_cnt(100000L);
        evBoardSearchDto.setPage_row_start(0L);

        if("".equals(StringUtils.nvl(evBoardSearchDto.getPage_current(),""))) {
            evBoardSearchDto.setPage_current(1L);
        }

        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        Date nDt = new Date();

        /* 최초 날짜가 null 인경우 */
        if("".equals(StringUtils.nvl(evBoardSearchDto.getIns_dt_fr(),""))) {
            Date ftDt = StringUtils.addMonth(nDt,-1);
            String strDt = sf.format(ftDt);
            evBoardSearchDto.setIns_dt_fr(strDt);
        }

        if("".equals(StringUtils.nvl(evBoardSearchDto.getIns_dt_to(),""))) {
            Date toDt = StringUtils.addMonth(nDt,1);
            String strDt = sf.format(toDt);
            evBoardSearchDto.setIns_dt_to(strDt);
        }

        if("".equals(StringUtils.nvl(evBoardSearchDto.getKeyword(),""))) {
            evBoardSearchDto.setKeyword("");
        }

        List<EvBoardResponseDto> list = evBoardService.board_list(evBoardSearchDto);

        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("첫번째 시트");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;

        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("번호");
        cell = row.createCell(1);
        cell.setCellValue("이벤트명");
        cell = row.createCell(2);
        cell.setCellValue("이벤트기간");
        cell = row.createCell(3);
        cell.setCellValue("참여자");
        cell = row.createCell(4);
        cell.setCellValue("등록자");
        cell = row.createCell(5);
        cell.setCellValue("등록일");
        cell = row.createCell(6);
        cell.setCellValue("조회수");
        cell = row.createCell(7);
        cell.setCellValue("노출여부");

        // Body
        for (int i=0; i < list.size(); i++) {
            EvBoardResponseDto dto = list.get(i);
            row = sheet.createRow(rowNum++);
            cell = row.createCell(0);
            cell.setCellValue(dto.getRn());
            cell = row.createCell(1);
            cell.setCellValue(dto.getBoard_subject());
            cell = row.createCell(2);
            cell.setCellValue(dto.getEvnt_prod_dt());
            cell = row.createCell(3);
            cell.setCellValue("");
            cell = row.createCell(4);
            cell.setCellValue(dto.getIns_user());
            cell = row.createCell(5);
            cell.setCellValue(dto.getIns_dtm());
            cell = row.createCell(6);
            cell.setCellValue(dto.getBoard_cnt());
            cell = row.createCell(7);
            cell.setCellValue(dto.getUse_yn());
        }

        String strDt = sf.format(nDt);

        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename="+strDt+".xlsx");

        // Excel File Output
        wb.write(response.getOutputStream());
        wb.close();

    }

}
