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

	//상담반려처리
	$('#btnReturnConfirm').on('click', function () {
		fnConsultProc("215003");
	});

	//반려처리취소
	$('#btnReturnCncl').on('click', function () {
		document.location.href="/mypage/myc07P01?schedule_id=${schedule_id}";
	});

});

/* 스케줄설정변경 */
var objSheduleId = new Object();

/* 상담확정처리 */
function fnConsultProc(pConsultRsvStatCd) {

	if(lComm.isNull(getValue("remarks"))) {
		alert("반려 사유를 입력하세요.");
		lComm.setFocus("remarks");
		return false;
	}

	gfnPutObj("schedule_id", getValue("schedule_id"));
	gfnPutObj("consult_rsv_stat_cd", pConsultRsvStatCd);
	gfnPutObj("remarks", getValue("remarks"));

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();
	var pMsg = ""

	if(pConsultRsvStatCd == "215003") {
		pMsg = "상담 신청 내역 반려 처리하시겠습니까?";
	}

    if(!confirm(pMsg)) return false;

    sendForm("POST", "/mypage/myc07P01U01", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
			alert("로그아웃되었습니다.");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {
            
			if(pConsultRsvStatCd == "215003") {
				alert("상담 신청 반려 처리 완료하였습니다.");
			}
            
            window.parent.parent.$('#showModal').modal('hide');

		} else if(message.result_code == (-1)) {
			var msg = "조회된 내역이 없습니다.";
      		alert(msg);
		} else if(message.result_code == (-2)) {
			var msg = "상담 시간 설정에 오류가 있습니다. \r\n좌측 메뉴를 다시 선택하신 후 진행하시기 바랍니다.";
      		alert(msg);
		} else if(message.result_code == (-3)) {
			var msg = "상담 요청시간이 취소 또는 반려처리 되었습니다.";
      		alert(msg);
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