<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();

	$('#btnList').on('click', function () {
		//목록
		var frm = document.forms[0];
		frm.method = "post";
		frm.action = "/mgnt/conslt";
		frm.submit();
	});	

	$('#btnSave').on('click', function () {

		if(!confirm("저장하시겠습니까?")) return false;

		gfnPutObj("board_id", "${board_id}");
		gfnPutObj("board_content", getValue("board_reply_content"));

		var pParamJson = gfnGetJson();		

		sendForm("POST", "/vr/conslt/reply", "application/json; charset=utf-8", "json", pParamJson, function(message) {
			
			if(message == "parsererror") {
				alert("로그아웃되었습니다.");
				document.location.href="/m.do";
			} else if(message.result_code == 0) {
				alert("상담문의내역 답변이 등록되었습니다.");
				document.location.href="/mgnt/conslt";
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}

		});			
	});	

	$('#btnDel').on('click', function () {

		if(!confirm("삭제하시겠습니까?")) return false;

		gfnPutObj("board_id", "${board_id}");
		gfnPutObj("board_content", getValue("board_reply_content"));

		var pParamJson = gfnGetJson();		

		sendForm("POST", "/vr/conslt/delete", "application/json; charset=utf-8", "json", pParamJson, function(message) {
			
			if(message == "parsererror") {
				alert("로그아웃되었습니다.");
				document.location.href="/m.do";
			} else if(message.result_code == 0) {
				alert("상담문의내역을 삭제하였습니다.");
				document.location.href="/mgnt/conslt";
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}

		});			
	});		

	/* 데이터 조회 */
	fnInit();

});

/* 데이터 조회 */
function fnInit() {

	var pParamJson = '{"board_id":"${board_id}"}';

	sendForm("POST", "/mypage/conslt_dtl", "application/json; charset=utf-8", "json", pParamJson, function(message) {
		
		var pFieldArry = ["board_subject","reg_dt","board_stat_nm","board_reply_ins_dtm","board_content","board_reply_content","conslt_cust_nm","email_id"];

		if(message == "parsererror") {
			alert("로그아웃되었습니다.");
			document.location.href="/m.do";
		} else if(message.result_code == 0) {
			 gfnSetField(message.data[0], pFieldArry);
		} else {
			alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
		}
	});	
}

</script>