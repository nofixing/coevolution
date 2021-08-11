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

	$('#sundayCd').on('change', function () {
		setValue("sunday",getValue("sundayCd")); 
		fnSearch("now");
	});
	

});

function fnSearch(pClsCd) {	
	var frm = document.forms[0];
	frm.sh_cls_cd.value = lComm.nvl(pClsCd,"now");
	frm.action = "/mypage/myp09";
	frm.method = "post";
	frm.submit();
}

/* 상담신청/상담신청취소 */
function scheduleClick(pScheduleId, pConsultRsvStatCd) {

	if(pScheduleId == "") return;

	//스케줄ID 체크
	gfnPutObj("schedule_id", pScheduleId);

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

    sendForm("POST", "/mypage/myc09CustChk", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
            alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {
			
			if(pConsultRsvStatCd == "215001" || pConsultRsvStatCd == "215002") {
				//상담신청, 상담확정
				gfnAlert ("CONFIRM", "<spring:message code='mypage.member15' text='상담신청 취소'/>", "<spring:message code='mypage.member16' text='상담신청을 취소하시겠습니까?'/>", function(pRtn) {
					if(pRtn) {
						//상담신청 취소하기
						setRsvStatCd(pScheduleId, "215004");
					}
				});
			} else if(pConsultRsvStatCd == "") {
				//상담내역이 없을 경우
				gfnAlert ("CONFIRM", "<spring:message code='mypage.member17' text='상담신청 요청'/>", "<spring:message code='mypage.member18' text='상담 신청하시겠습니까?'/>", function(pRtn) {
					if(pRtn) {
						//상담신청하기
						setRsvStatCd(pScheduleId, "215001");
					}
				});
			}
		} else if(message.result_code == "-1") {
            alert("<spring:message code='mypage.member19' text='상담신청내역이 없습니다.'/>");
		} else if(message.result_code == "-2") {
            alert("<spring:message code='mypage.member20' text='상담신청내역이 아닙니다.'/>");
		}
	});
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
            alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {
            
			var msg = "";
			if(pConsultRsvStatCd == "215001") {
				msg = "<spring:message code='mypage.member21' text='상담 신청하였습니다.'/>";
			} else if(pConsultRsvStatCd == "215004") {
				msg = "<spring:message code='mypage.member22' text='상담 신청 취소하였습니다.'/>";
			}

			fnSndMsg(pScheduleId, msg);

			alert(msg);

            window.parent.parent.$('#showModal').modal('hide');

			fnSearch();

		} else if(message.result_code == (-1)) {
			var msg = "<spring:message code='mypage.member11' text='조회된 내역이 없습니다.'/>";
      		alert(msg);
		} else if(message.result_code == (-2)) {
			var msg = "<spring:message code='mypage.member12' text='상담 시간 설정에 오류가 있습니다.'/>\r\n<spring:message code='mypage.member13' text='좌측 메뉴를 다시 선택하신 후 진행하시기 바랍니다.'/>";
      		alert(msg);
		} else if(message.result_code == (-3)) {
			var msg = "<spring:message code='mypage.member14' text='상담 요청시간이 취소 또는 반려처리 되었습니다.'/>";
      		alert(msg);
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
            alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
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