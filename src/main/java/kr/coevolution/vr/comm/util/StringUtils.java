package kr.coevolution.vr.comm.util;

import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtils {

    /**
     * 로그인세션이름설정
     */
    public static String login_session = "login_session";

    /**
     * 페이징 개수
     */
    public static int page_row_cnt = 10;

    public static int page_row_corp_cnt = 4;

    /**
     * 비밀번호체크
     */
    public static final String pattern1 = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[$@$!%*#?&])[A-Za-z[0-9]$@$!%*#?&]{6,20}$"; // 영문, 숫자, 특수문자
    public static final String pattern2 = "^[A-Za-z[0-9]]{6,20}$"; // 영문, 숫자
    public static final String pattern3 = "^[[0-9]$@$!%*#?&]{6,20}$"; //영문,  특수문자
    public static final String pattern4 = "^[[A-Za-z]$@$!%*#?&]{6,20}$"; // 특수문자, 숫자
    public static final String pattern5 = "(\\w)\\1\\1\\1"; // 같은 문자, 숫자


    /**
     * Null 처리
     * @param str
     * @param chgStr
     * @return
     */
    public static String nvl(String str, String chgStr) {

        String rtnValue = str;

        if(str == null || str.isEmpty() && !chgStr.isEmpty()) {
            rtnValue = chgStr;
        }

        return rtnValue;
    }

    /**
     * null처리
     * @param str
     * @param chgStr
     * @return
     */
    public static String nvl(Object str, String chgStr) {

        String rtnValue = String.valueOf(str);

        if(str == null || "".equals(String.valueOf(str)) || "null".equals(String.valueOf(str))) {
            rtnValue = chgStr;
        }

        return rtnValue;
    }

    /**
     * 페이징 처리 - 시작 row
     * @param page_current
     * @return
     */
    public static Long page_start_row(Long page_current) {
        Long startRow = 0L;
        if(page_current == null) page_current = 1L;
        startRow = (page_current - 1 ) * page_row_cnt;
        return startRow;
    }

    /**
     * 페이징처리-시작, 페이지가 10개가 아닌 경우
     * @param page_current
     * @param pPage_row_cnt
     * @return
     */
    public static Long page_start_row(Long page_current, int pPage_row_cnt) {
        Long startRow = 0L;
        if(page_current == null) page_current = 1L;
        startRow = (page_current - 1 ) * pPage_row_cnt;
        return startRow;
    }

    /**
     * 페이지 처리 - 종료 row
     * @param page_current
     * @return
     */
    public static Long page_end_row(Long page_current) {
        Long endRow = 0L;
        if(page_current == null) page_current = 1L;

        endRow = page_current * page_row_cnt;
        return endRow;
    }

    /**
     * 총페이지
     * @param row_count
     * @return
     */
    public static Long page_tot(Long row_count) {
        Long pageTot = 0L;
        Long pageCount = (row_count / page_row_cnt);
        Long pageRemain = (row_count % page_row_cnt);

        if(pageRemain > 0) {
            pageCount += 1;
        }
        return pageCount;
    }

    /**
     * 페이지처리 - 다음페이지
     * @param page_current
     * @param row_count
     * @return
     */
    public static Long page_next(Long page_current, Long row_count, String lastPageYn) {
        Long nextPage = 0L;

        if(page_current == null) page_current = 1L;

        Long pageTot = page_tot(row_count);

        if("Y".equals(lastPageYn)) {
            nextPage = pageTot;
        } else {
            if((page_current + 1) >= pageTot) {
                nextPage = page_current;
            } else {
                nextPage = page_current + 1;
            }
        }

        return nextPage;
    }

    /**
     * 이전페이지
     * @param page_current
     * @return
     */
    public static Long page_priv(Long page_current) {
        Long privPage = 0L;
        if(page_current == null) page_current = 1L;

        if((page_current - 1) > 0) {
            privPage = page_current - 1;
        }

        return privPage;
    }

    /**
     * 월을 더한다.
     * @param date
     * @param months
     * @return
     */
    public static Date addMonth(Date date, int months) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.MONTH, months);
        return cal.getTime();
    }

    /**
     * 비밀번호 정규식 체크
     * @param newPwd
     * @param oldPwd
     * @param userId
     * @return
     */
    public static int pwdRegularExpressionChk(String newPwd, String oldPwd, String userId) {

        Matcher  match;
        boolean chk = false;
        int chkRtn = 0;

        // 특수문자, 영문, 숫자 조합 (6~20 자리)
        match = Pattern.compile(pattern1).matcher(newPwd);

        if(newPwd.equals(oldPwd)) {
            chkRtn = 1;
        } else if(match.find()) {
            chkRtn = 2;
        }

        return chkRtn;
/*
        // 영문, 숫자 (10~20 자리)
        match = Pattern.compile(pattern2).matcher(newPwd);

        if(match.find()) {
            chk = true;
        }

        // 영문, 특수문자 (6~20 자리)
        match = Pattern.compile(pattern3).matcher(newPwd);

        if(match.find()) {
            chk = true;
        }

        // 특수문자, 숫자 (6~20 자리)
        match = Pattern.compile(pattern4).matcher(newPwd);

        if(match.find()) {
            chk = true;
        }

        if(chk) {
            // 연속문자 4자리
            if(samePwd(newPwd)) {
                chkRtn = 1;
            }

            // 같은문자 4자리
            if(continuousPwd(newPwd)) {
                chkRtn = 2;
            }

            // 이전 아이디 4자리
            if(newPwd.equals(oldPwd)) {
                chkRtn = 3;
            }

            // 아이디와 동일 문자 4자리
            if(sameId(newPwd, userId)) {
                chkRtn = 4;
            }
        }

        return chkRtn;

 */
    }

    /**
     * 같은 문자, 숫자 4자리 체크
     * @param pwd
     * @return
     */

    private static boolean samePwd(String pwd) {

        Matcher  match;
        match = Pattern.compile(pattern5).matcher(pwd);

        return match.find() ? true : false;
    }

    /**
     * 연속 문자, 숫자 4자리 체크
     * @param pwd
     * @return
     */
    private static boolean continuousPwd(String pwd) {

        int o = 0;
        int d = 0;
        int p = 0;
        int n = 0;
        int limit = 4;

        for(int i=0; i<pwd.length(); i++) {

            char tempVal = pwd.charAt(i);

            if(i > 0 && (p = o - tempVal) > -2 && (n = p == d ? n + 1 :0) > limit -3) {
                return true;
            }

            d = p;
            o = tempVal;
        }

        return false;
    }

    /**
     * 아이디와 동일 문자 4자리 체크
     * @param pwd
     * @param id
     * @return
     */
    private static boolean sameId(String pwd, String id) {

        for(int i=0; i<pwd.length()-3; i++) {
            if(id.contains(pwd.substring(i, i+4))) {
                return true;
            }
        }

        return false;
    }
}


