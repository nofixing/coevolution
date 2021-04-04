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

	/* 총건수, 현재이지, view row, 호출할 function */
	var pageHtml = setPaging("${row_count}", "${page_current}", "${page_row_cnt}", "searchMyp01");	
	$('#myp01_page').html(pageHtml);

});

/* 페이지 조회 */
function searchMyp01(pPageCurrent) {

	setValue("page_current", pPageCurrent);

	var frm = document.forms[0];
	frm.action = "/mypage/favorts";
	frm.submit();
}

</script>