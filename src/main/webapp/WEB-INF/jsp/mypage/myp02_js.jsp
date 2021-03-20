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
		//검색

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
	});	

	/* 페이징처리 (총페이지, 현재페이지)*/
	var pagingList = setPaging("${row_count}", "${page_current}");
	$('#pagingList').html(pagingList) ;
});

</script>