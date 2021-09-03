<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script language="javascript">

/**
 * Script 설정
 */
var lComm, lfnPutObj;
var lDataObjectPutGet = new Object(); /* Local Set Get */
$(document).ready(function() {

	lComm = new gfnComm();

	var today = lComm.getToday("-");

	if(getValue("evnt_fr_dt") == "")
		setValue("evnt_fr_dt", today);
	
	if(getValue("evnt_fr_to") == "")
		setValue("evnt_fr_to", today);

	if(getValue("req_fr_dt") == "")
		setValue("req_fr_dt", today);
	
	if(getValue("req_to_dt") == "")
		setValue("req_to_dt", today);

	/* 목록이동 */
	$('#btnList').on('click', function () {
		document.location.href="/mgnt/event";
	});

	//저장 
	$('#btnSave').on('click', function () {
		fnUpdate();
	});

	<c:if test="${board_id != '' && board_id != null}">
		setValue("board_id", "${board_id}");
		fnSearch();
	</c:if>

});


function fnSearch() {
	
	/* form값 global 변수에 입력 */
	gfnGetFormJSON();

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/mgnt/eventdtl", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
			alert("로그아웃되었습니다.");
			document.location.href="/m.do";
		} else if(message.result_code == 0) {
				/* 필드값입력 */
				var pFieldArry = ["board_clsf_dtl_cd","board_subject","evnt_fr_dt","evnt_to_dt","req_fr_dt","req_fr_hhmm","req_to_dt","req_to_hhmm","board_content","ref_url"];
				gfnSetField(message.list[0], pFieldArry);

				if(message.list[0].use_yn == "Y") {
					gfnSetCheck("use_yn1");
				} else {
					gfnSetCheck("use_yn2");
				}
		} else {
			if(message.session_yn == "N") {
				alert("로그아웃되었습니다.");	
				document.location.href="/m.do";
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}
		}

	});	
}

/* 이벤트정보입력 */
function fnUpdate() {

	/* 필수체크 */
	var chk = '['
		+ '  {"id":"board_clsf_dtl_cd","name":"구분"}'
		+ ', {"id":"board_subject","name":"이벤트명"}'
		+ ', {"id":"evnt_fr_dt","name":"이벤트 기간"}'
		+ ', {"id":"evnt_to_dt","name":"이벤트 기간"}'
		+ ', {"id":"req_fr_dt","name":"신청기간"}'
		+ ', {"id":"req_fr_hhmm","name":"신청기간"}'
		+ ', {"id":"req_to_dt","name":"신청기간"}'
		+ ', {"id":"req_to_hhmm","name":"신청기간"}'
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
	}

	if(getValue("ref_url") != "" && getValue("board_content") != "") {
		alert("이벤트 URL과 내용을 동시에 입력 할 수 없습니다.");
		return false;
	}

	/* form값 global 변수에 입력 */
	gfnGetFormJSON();

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/mgnt/eventsave", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
			alert("로그아웃되었습니다.");
			document.location.href="/m.do";
		} else if(message.result_code == 0) {
			var msg = "이벤트를 등록하였습니다.";
            alert(msg);
			document.location.href="/mgnt/event";
		} else {
			if(message.session_yn == "N") {
				alert("로그아웃되었습니다.");	
				document.location.href="/m.do";
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}
		}

	});	
}


</script>