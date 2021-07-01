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

	//고객정보조회
	$('#btnCustInfo').on('click', function () {
		var vUrl = "/mypage/myp09P01";
		gfnPopup (vUrl, "참가업체조회", "100%", "600px", function() {
			fnSearch();
		});
	});

	$('#btnSearch').on('click', function () {
		fnSearch();
	});

	//soket설정
	webSocketConnect("msg", function(pMsg) {
	});

});

function fnSearch() {
	
	var frm = document.forms[0];
	frm.action = "/mypage/myp09";
	frm.method = "post";
	frm.submit();
}

/* 상담신청/상담신청취소 */
function scheduleClick(pScheduleId, pConsultRsvStatCd) {

	if(pScheduleId == "") return;
	if(lComm.isNull(getValue("consultCustId"))) return;

	//스케줄ID 체크

	if(pConsultRsvStatCd == "215001" || pConsultRsvStatCd == "215002") {
		//상담신청, 상담확정
		gfnAlert ("CONFIRM", "상담신청 취소", "상담신청을 취소하시겠습니까?", function(pRtn) {
			if(pRtn) {
				//상담신청 취소하기
				setRsvStatCd(pScheduleId, "215004");
			}
		});
	} else if(pConsultRsvStatCd == "") {
		//상담내역이 없을 경우
		gfnAlert ("CONFIRM", "상담신청 요청", "상담 신청하시겠습니까?", function(pRtn) {
			if(pRtn) {
				//상담신청하기
				setRsvStatCd(pScheduleId, "215001");
			}
		});
	}
}

/* 상태변경하기 */
function setRsvStatCd(pScheduleId, pConsultRsvStatCd) {

	gfnPutObj("schedule_id", pScheduleId);
	gfnPutObj("consult_rsv_cust_id", getValue("consult_rsv_cust_id"));
	gfnPutObj("consult_rsv_stat_cd", pConsultRsvStatCd);

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

    sendForm("POST", "/mypage/myc07P01U01", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
			alert("로그아웃되었습니다.");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {
            
			var msg = "";
			if(pConsultRsvStatCd == "215001") {
				msg = "상담 신청하였습니다.";
			} else if(pConsultRsvStatCd == "215004") {
				msg = "상담 신청 취소하였습니다.";
			}

			fnSndMsg(pScheduleId, msg);

			alert(msg);

            window.parent.parent.$('#showModal').modal('hide');

			fnSearch();

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
	gfnPutObj("snd_cust_id"		, getValue("consult_rsv_cust_id"));
	gfnPutObj("rcv_cust_id"		, getValue("consultCustId"));
	gfnPutObj("schedule_id"		, pSchedule_id);
	gfnPutObj("cust_clsf_cd"	, "202001");

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

    sendForm("POST", "/mypage/myc08M01", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
			alert("로그아웃되었습니다.");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {

			/* 메시지 전송 */
			gfnPutObj("message"		, pMsg);
			gfnPutObj("snd_cust_id"	, getValue("consult_rsv_cust_id"));
			gfnPutObj("rcv_cust_id"	, getValue("consultCustId"));
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