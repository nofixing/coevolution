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
		fnSearchMgnt0501("1");
	});	

	$('#btnReg').on('click', function () {
		document.location.href="/mgnt/user_form";
	});		

	/* 총건수, 현재이지, view row, 호출할 function */
	var pageHtml = setPaging("${row_count}", "${page_current}", "${page_row_cnt}", "fnSearchMgnt0501");	
	$('#pagingList').html(pageHtml);
	
});

/* 조회 */
function fnSearchMgnt0501(pPageCurrent) {

	setValue("page_current", pPageCurrent);
	
	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mgnt/user";
	frm.submit();
}

/* 상세내역이동 */
function doDetail(pCustId) {

	setValue("mgnt_id", pCustId);

	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mgnt/user_form?mode=U";
	frm.submit();

	return false;
}

</script>