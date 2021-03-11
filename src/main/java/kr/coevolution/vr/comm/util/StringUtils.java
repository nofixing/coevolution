package kr.coevolution.vr.comm.util;

public class StringUtils {

    /**
     * 로그인세션이름설정
     */
    public static String login_session = "login_session";

    /**
     * 페이징 개수
     */
    public static int page_row_cnt = 10;

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
            if(!chgStr.isEmpty()) {
                rtnValue = chgStr;
            }
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
}
