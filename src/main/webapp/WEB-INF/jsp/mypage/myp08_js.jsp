<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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

	$('#left-circle').on('click', function () {
		if(getValue("sunday") < getValue("consult_from_dt")) {
			alert("상담 기간이 아닙니다.");
			return false;
		};

		fnSearch("left");
	});

	$('#right-circle').on('click', function () {
		var dtSunday = new Date(getValue("sunday"));
		var dtConsultToDt = new Date(getValue("consult_to_dt"));

		dtSunday.setDate(dtSunday.getDate() + 7); /* 7일을 더하여 상담기간이 큰 경우만 진행한다. */

		if(dtSunday.getTime() > dtConsultToDt.getTime()) {
			alert("상담 기간이 아닙니다.");
			return false;
		};

		fnSearch("right");
	});

});

/* 상담시간 설정 내역 조회 */
var lFormValue;
function fnSearch(pClsCd) {
	var frm = document.forms[0];
	frm.sh_cls_cd.value = lComm.nvl(pClsCd,"now");;
	frm.action = "/mypage/myp08";
	frm.method = "post";
	frm.submit();
}

/* 스케줄설정변경 */
var objSheduleId = new Object();
function scheduleClick(pScheduleId) {

	if(pScheduleId == "") return false;
	
	gfnPutObj("schedule_id", pScheduleId);

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/mypage/consult_cust_info", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
            alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {

			var vUrl = "/mypage/myp08P01?schedule_id="+pScheduleId+"&cust_id="+message.cust_id+"&cust_nm="+message.cust_nm+"&tel_no="+message.tel_no;
			gfnPopup (vUrl, "<spring:message code='mypage.member7' text='상담예약 내역'/>", "100%", "260px", function() {
				fnSearch();
			 });

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