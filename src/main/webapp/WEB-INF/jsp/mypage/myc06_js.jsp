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

	//상담시간설정
	$('#btnSettime').on('click', function () {
		fnSave();
	});

});

/* 상담시간 설정 내역 조회 */
var lFormValue;
function fnSearch() {
	document.location.href="/mypage/consltset";
}

/* 회원정보수정 */
function fnSave() {

	/* 필수체크 */
	var chk = '['
		+ '  {"id":"tiemzone_cd","name":"타임존"}'
		+ ', {"id":"consult_from_time","name":"상담가능시간"}'
		+ ', {"id":"consult_to_time","name":"상담가능시간"}'
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
	}

	if(lComm.isNull(getValue("consult_from_dt")) || lComm.isNull(getValue("consult_to_dt"))) {
		alert("상당 기간이 아닙니다.");
		return false;
	} else if (getValue("consult_from_time") == getValue("consult_to_time") || getValue("consult_from_time") > getValue("consult_to_time")) {
		alert("정확한 상담 시간을 설정해 주세요.");
		return false;
	}

	/* form값 global 변수에 입력 */
	gfnGetFormJSON();

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

sendForm("POST", "/mypage/consult_settime", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
			alert("로그아웃되었습니다.");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {
			var msg = "시간설정을 완료하였습니다.";
			
			alert(msg);

			fnSearch();

		} else if(message.result_code == (-1)) {
			var msg = "상담 기간이 아닙니다.";
      		alert(message.result_msg);
		} else if(message.result_code == (-2)) {
			var msg = "상담설정 기간이 아닙니다.";
      		alert(message.result_msg);
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

/* 스케줄설정변경 */
var objSheduleId = new Object();
function scheduleClick(pScheduleId) {

	if(pScheduleId == "") return false;

	/* JSON 생성을 위해 입력 - 신규로 입력된 키값이 있으면 변경된 키값을 넘긴다.*/
	if(typeof eval("objSheduleId.KEY_"+pScheduleId) == "undefined" || eval("objSheduleId.KEY_"+pScheduleId) == null) {
		gfnPutObj("schedule_id", pScheduleId);
	} else {
		gfnPutObj("schedule_id", eval("objSheduleId.KEY_"+pScheduleId));
	}

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/mypage/consult_set_yn", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
			alert("로그아웃되었습니다.");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {

			/* 키값이 변경되므로 저장한다. */
			objSheduleId["KEY_"+pScheduleId] = message.schedule_id;

			if(message.consult_avail_yn == "Y") {
				lComm.setCssRemove("svg_"+pScheduleId,"text-muted");
				lComm.setCssAdd("svg_"+pScheduleId,"text-warning");
			} else {
				lComm.setCssRemove("svg_"+pScheduleId,"text-warning");
				lComm.setCssAdd("svg_"+pScheduleId,"text-muted");
			}

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