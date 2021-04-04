<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();

	var today = lComm.getToday("-");
	
	/* 검색일자 셋팅 */
	if(getValue("ins_dt_fr") == "")
		setValue("ins_dt_fr", lComm.addDays(today, -30, "-"));
	
	if(getValue("ins_dt_to") == "")
		setValue("ins_dt_to", today);

	$('#btnSearch').on('click', function () {
		fnSearchMyp02("1");
	});	

	/* 총건수, 현재이지, view row, 호출할 function */
	var pageHtml = setPaging("${row_count}", "${page_current}", "${page_row_cnt}", "fnSearchMyp02");	
	$('#pagingList').html(pageHtml);

});

/* 조회 */
function fnSearchMyp02(pPageCurrent) {

	setValue("page_current", pPageCurrent);

	/* 필수항목 체크 */
	var chk = '['
		+ '  {"id":"ins_dt_fr","name":"조회 시작일자"} '
		+ ', {"id":"ins_dt_to","name":"조회 종료일자"} ';
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
	}

	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mypage/badge";
	frm.submit();	
}

/* 검색조건 셋팅 */
function setBadgeClsf(pClsf, pSltBadgeClsf) {

	setValue("slt_badge_clsf", pClsf);

	for(var i = 1; i <= 4; i++) {
		lComm.setCssRemove("slt_badge_clsf"+i, "on");
	}
	
	lComm.setCssAdd(pSltBadgeClsf, "on");
}

</script>