<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

/**
 * Script 설정
 */
var lComm, lCodeList;
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();

	$('#btnSearch').on('click', function () {
		fnSearchMgnt10(1);
	});

	$('#btnInsert').on('click', function () {
		doDetail("0");
	});

    /* 총건수, 현재이지, view row, 호출할 function */
	var pageHtml = setPaging("${row_count}", "${page_current}", "${page_row_cnt}", "fnSearchMgnt10");	
	$('#pagingList').html(pageHtml);		

});

function fnSearchMgnt10(pPageCurrent) {

	setValue("page_current", pPageCurrent);

	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mgnt/expo";
	frm.submit();

}

function doDetail(expoId) {

	setValue("ev_expo_id", expoId);

	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mgnt/expo_exhibitors_dtl";
	frm.submit();

}

</script>