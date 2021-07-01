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

	//상담확정처리
	$('#btnConsultConfirm').on('click', function () {
		fnConsultProc("215002");
	});

	//상담취소처리
	$('#btnConsultCancel').on('click', function () {
		fnConsultProc("215004");
	});

	//반려처리
	$('#btnConsultReturn').on('click', function () {
		document.location.href="/mypage/myc07P02?schedule_id=${schedule_id}&consult_rsv_cust_id=${cust_id}";
	});

	//soket설정
	webSocketConnect("msg", function(pMsg) {
	});

});

/* 스케줄설정변경 */
var objSheduleId = new Object();

/* 상담확정처리 */
function fnConsultProc(pConsultRsvStatCd) {

	gfnPutObj("schedule_id", getValue("schedule_id"));
	gfnPutObj("consult_rsv_stat_cd", pConsultRsvStatCd);
	gfnPutObj("consult_rsv_cust_id", "${cust_id}");
	
	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();
	var pMsg = ""

	if(pConsultRsvStatCd == "215002") {
		pMsg = "상담예약을 확정하시겠습니까?";
	} else if(pConsultRsvStatCd == "215004") {
		pMsg = "상담을 취소하시겠습니까?";
	}

    if(!confirm(pMsg)) return false;

    sendForm("POST", "/mypage/myc07P01U01", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
			alert("로그아웃되었습니다.");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {
            
			var sndMsg = "";
			if(pConsultRsvStatCd == "215002") {
				sndMsg = "상담신청 확정되었습니다.";
			} else if(pConsultRsvStatCd == "215004") {
				sndMsg = "상담신청 취소되었습니다.";
			}
            
			fnSndMsg("${schedule_id}", sndMsg)

			alert(sndMsg);

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

/**
	메시지 저장 및 전송
*/
function fnSndMsg(pSchedule_id, pMsg) {

	gfnPutObj("message"			, pMsg);
	gfnPutObj("snd_cust_id"		, "${sessionScope.login_session.cust_id}");
	gfnPutObj("rcv_cust_id"		, "${cust_id}");
	gfnPutObj("schedule_id"		, pSchedule_id);
	gfnPutObj("cust_clsf_cd"	, "202002");

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

    sendForm("POST", "/mypage/myc08M01", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
			alert("로그아웃되었습니다.");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {

			/* 메시지 전송 */
			gfnPutObj("message"		, pMsg);
			gfnPutObj("snd_cust_id"	, "${sessionScope.login_session.cust_id}");
			gfnPutObj("rcv_cust_id"	, "${cust_id}");
			gfnPutObj("schedule_id"	, pSchedule_id);

			/* global 변수 json으로 변환 */
			pParamJson = gfnGetJson().replace("[","").replace("]","");
			//pParamJson = JSON.stringify({'snd_cust_id': getValue("cust_id"), 'rcv_cust_id': lSndCustId,'message': getValue("taMsgSnd")});
			stompClient.send("/app/msg", {}, pParamJson);

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