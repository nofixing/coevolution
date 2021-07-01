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

});

/* 상담시간 설정 내역 조회 */
var lFormValue;
function fnSearch() {
	document.location.href="/mypage/myp08";
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
			alert("로그아웃되었습니다.");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {

			var vUrl = "/mypage/myp08P01?schedule_id="+pScheduleId+"&cust_id="+message.cust_id+"&cust_nm="+message.cust_nm+"&tel_no="+message.tel_no;
			gfnPopup (vUrl, "상담예약 내역", "100%", "260px", function() {
				document.location.href="/mypage/myp08";
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


</script>