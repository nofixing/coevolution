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

});

/* 상담시간 설정 내역 조회 */
var lFormValue;
function fnSearch() {
	document.location.href="/mypage/myc07";
}

/* 스케줄설정변경 */
var objSheduleId = new Object();
function scheduleClick(pScheduleId, pRsvStatCd) {

	if(pRsvStatCd == "" || pRsvStatCd == "") return false;
	
	gfnPutObj("schedule_id", pScheduleId);

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/mypage/rsv_info", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
			alert("로그아웃되었습니다.");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {

			var vUrl = "/mypage/myc07P01?schedule_id="+pScheduleId+"&consult_rsv_stat_cd="+pRsvStatCd+"&cust_id="+message.cust_id+"&cust_nm="+message.cust_nm+"&tel_no="+message.tel_no;
			gfnPopup (vUrl, "상담예약 확정/반려", "100%", "260px", function() {
				document.location.href="/mypage/myc07";
			 });

		} else {
			if(message.session_yn == "N") {
				alert("로그아웃되었습니다.");
				document.location.href="/index";
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}
		}

	});	

}

/* 타임존 저장 */
function fnTimeZoneSave() {

	/* global 변수 json으로 변환 */
	gfnPutObj("tiemzone_cd"		, getValue("tiemzone_cd"));
	gfnPutObj("consult_time_id"	, getValue("consult_time_id"));
	
	var pParamJson = gfnGetJson();

	sendForm("POST", "/mypage/setTimeZone", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
			alert("로그아웃되었습니다.");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {
			fnSearch();
		} else {
			if(message.session_yn == "N") {
				alert("로그아웃되었습니다.");
				document.location.href="/index";
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}
		}

	});	
}

</script>