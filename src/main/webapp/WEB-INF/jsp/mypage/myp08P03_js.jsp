<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script language="javascript">

/**
 * Script 설정
 */
var lComm;
var lDataObjectPutGet = new Object(); /* Local Set Get */
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();
	var yyyyMMdd = lComm.getToday("-");

	//타임존변경
	$('#tiemzone_cd').on('change', function () {
		fnTimeZoneSave();
	});

	//조회구분변경
	$('#form_clsf').on('change', function () {
		var frm = document.forms[0];
		frm.sh_cls_cd.value = "now";
		frm.action = "/mypage/myp08";
		frm.method = "post";
		frm.submit();
	});

	$('#btnSearch').on('click', function () {
		fnSearch("1");
	});	

	/* 총건수, 현재이지, view row, 호출할 function */
	var pageHtml = setPaging("${row_count}", "${page_current}", "${page_row_cnt}", "fnSearch");	
	$('#pagingList').html(pageHtml);	

});

/* 리스트 조회 */
/* 검색 */
function fnSearch(pPageCurrent) {

	setValue("page_current", pPageCurrent);

	/* 필수항목 체크 */
	var chk = '['
		+ '  {"id":"sh_consult_from_dt","name":"조회 시작일자"} '
		+ ', {"id":"sh_consult_to_dt","name":"조회 종료일자"} ';
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
	}
	
	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mypage/myp08P03";
	frm.submit();	
}

/* 타임존 저장 */
function fnTimeZoneSave() {

	/* global 변수 json으로 변환 */
	gfnPutObj("tiemzone_cd"		, getValue("tiemzone_cd"));
	
	var pParamJson = gfnGetJson();

	sendForm("POST", "/mypage/setTimeZoneCust", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
            alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {
			fnSearch();
		} else {
			if(message.session_yn == "N") {
                alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
				document.location.href="/index";
			} else {
                alert("<spring:message code='join.form2' text='서버 오류입니다.'/>"+"\r\n"+"<spring:message code='join.form3' text='잠시 후 다시 진행하시기 바랍니다.'/>");
			}
		}

	});	
}

</script>