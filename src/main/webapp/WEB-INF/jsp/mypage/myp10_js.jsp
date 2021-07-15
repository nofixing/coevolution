<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script language="javascript">

/**
 * Script 설정
 */
var lComm;
var lSndCustId = ""; /* 메시지 전송id */
var lDataObjectPutGet = new Object(); /* Local Set Get */
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();
	var yyyyMMdd = lComm.getToday("-");

	//메시지전송
	$('#btnMsgSnd').on('click', function () {
		if(lSndCustId != "") {
			fnSndMsg();
		} else {
			alert("<spring:message code='form.meet.select.left' text='전송'/>");
		}
	});

	//soket설정
	webSocketConnect("msg", function(pMsg) {

		//alert("snd_cust_id - > " + pMsg.snd_cust_id + ",  rcv_cust_id -> " + pMsg.rcv_cust_id + ", lSndCustId -> " + lSndCustId);

		var vhtml = "";
		if(pMsg.snd_cust_id == getValue("cust_id")) {

			vhtml += '<div class="m-4 speech-bubble-right">'+pMsg.message+'<br><small>'+pMsg.ins_dtm+'</small></div>';
			$("#speech_bubble").append(vhtml);

			/* 스크롤이동 */
			$("#speech_bubble").scrollTop($("#speech_bubble")[0].scrollHeight);

			 setValue("taMsgSnd","");

		} else if(pMsg.rcv_cust_id == getValue("cust_id") && pMsg.snd_cust_id == lSndCustId) {
			vhtml += '<div class="m-4 speech-bubble-left">'+pMsg.message+'<br><small>'+pMsg.ins_dtm+'</small></div>';
			$("#speech_bubble").append(vhtml);

			/* 스크롤이동 */
			$("#speech_bubble").scrollTop($("#speech_bubble")[0].scrollHeight);
		}
		
	});

	/* 상담요청자 조회 */
	consult_cust_search();

});

/* 상담요청자 조회 */
function consult_cust_search() {

	gfnPutObj("id", "");

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();
	
    sendForm("POST", "/mypage/myp10M03", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
            alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {

			var vhtml = "";
           	for(var i = 0; i < message.consultCustList.length; i++) {
				
				if(i == 0) {
					vhtml += '<a href="javascript:consult_search(\''+message.consultCustList[i].cust_id+'\')" class="list-group-item list-group-item-action active" id="cust_'+message.consultCustList[i].cust_id+'">'+message.consultCustList[i].cust_nm+'</a>';
					lSndCustId = message.consultCustList[i].cust_id;
				} else {
					vhtml += '<a href="javascript:consult_search(\''+message.consultCustList[i].cust_id+'\')" class="list-group-item list-group-item-action" id="cust_'+message.consultCustList[i].cust_id+'">'+message.consultCustList[i].cust_nm+'</a>';
				}
				
			}
			   	
			$("#custList").html(vhtml);

			/* 상담상세내역조회 */
			consult_search(lSndCustId);

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

/* 상담상세내역 조회 */
function consult_search(pSndCustId) {

	gfnPutObj("snd_cust_id", pSndCustId);

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

    sendForm("POST", "/mypage/myp10M02", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
            alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {

			/* 색상표시 */
			lComm.setCssRemove("cust_"+lSndCustId, "active");
			lComm.setCssAdd("cust_"+pSndCustId, "active");

			lSndCustId = pSndCustId;

			/* 건수표시 */
			setValue("chat_cnt"		, lComm.setNumberComma(String(parseInt(message.consultListCnt[0].chat_cnt))));
			setValue("consult_cnt"	, lComm.setNumberComma(String(parseInt(message.consultListCnt[0].consult_cnt))));
			setValue("consult_time"	, lComm.setNumberComma(String(parseFloat(message.consultListCnt[0].consult_time))));
			
			var vhtml = "";
           	for(var i = 0; i < message.consultList.length; i++) {
				
				if(message.consultList[i].snd_cust_id == getValue("cust_id")) {
					vhtml += '<div class="m-4 speech-bubble-right">'+message.consultList[i].message+'<br><small>'+message.consultList[i].ins_dtm+'</small></div>';
				} else {
					vhtml += '<div class="m-4 speech-bubble-left">'+message.consultList[i].message+'<br><small>'+message.consultList[i].ins_dtm+'</small></div>';
				}
			}
			   	
			$("#speech_bubble").html(vhtml);

			/* 스크롤이동 */
			$("#speech_bubble").scrollTop($("#speech_bubble")[0].scrollHeight);

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
function fnSndMsg() {

	gfnPutObj("message"		, getValue("taMsgSnd"));
	gfnPutObj("snd_cust_id"	, getValue("cust_id"));
	gfnPutObj("rcv_cust_id"	, lSndCustId);

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

    sendForm("POST", "/mypage/myp10M01", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
            alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {

			/* 메시지 전송 */
			gfnPutObj("snd_cust_id"	, getValue("cust_id"));
			gfnPutObj("rcv_cust_id"	, lSndCustId);
			gfnPutObj("message"		, getValue("taMsgSnd"));

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

</script>
