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

	//상담취소
	$('#btnReturnConfirm').on('click', function () {
		fnConsultProc("215004");
	});

	//이전
	$('#btnReturnCncl').on('click', function () {
		document.location.href="/mypage/myp08P01?schedule_id=${schedule_id}";
	});

});

/* 스케줄설정변경 */
var objSheduleId = new Object();

/* 상담확정처리 */
function fnConsultProc(pConsultRsvStatCd) {

	if(lComm.isNull(getValue("remarks"))) {
        alert("<spring:message code='mypage.member8' text='취소 사유를 입력하세요.'/>");
		lComm.setFocus("remarks");
		return false;
	}

	gfnPutObj("schedule_id", getValue("schedule_id"));
	gfnPutObj("consult_rsv_stat_cd", pConsultRsvStatCd);
	gfnPutObj("remarks", getValue("remarks"));

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();
	var pMsg = ""

	if(pConsultRsvStatCd == "215004") {
		pMsg = "상담 취소 처리하시겠습니까?";
	}

    if(!confirm("<spring:message code='mypage.member9' text='상담 취소 처리하시겠습니까?'/>")) return false;

    sendForm("POST", "/mypage/myc07P01U01", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
            alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {
            alert("<spring:message code='mypage.member10' text='상담신청 취소되었습니다.'/>");
            
            window.parent.parent.$('#showModal').modal('hide');

		} else if(message.result_code == (-1)) {
			var msg = "조회된 내역이 없습니다.";
      		alert("<spring:message code='mypage.member11' text='조회된 내역이 없습니다.'/>");
		} else if(message.result_code == (-2)) {
			var msg = "상담 시간 설정에 오류가 있습니다. \r\n좌측 메뉴를 다시 선택하신 후 진행하시기 바랍니다.";
      		alert("<spring:message code='mypage.member12' text='상담 시간 설정에 오류가 있습니다.'/>"+"\r\n<spring:message code='mypage.member13' text='좌측 메뉴를 다시 선택하신 후 진행하시기 바랍니다.'/>");
		} else if(message.result_code == (-3)) {
			var msg = "상담 요청시간이 취소 또는 반려처리 되었습니다.";
      		alert("<spring:message code='mypage.member14' text='상담 요청시간이 취소 또는 반려처리 되었습니다.'/>");
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