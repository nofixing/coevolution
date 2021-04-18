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
		frm.action = "/mgnt/terms_list?t=${board_clsf_cd}";
		frm.submit();
	});	

	$('#btnSave').on('click', function () {

		if(!confirm("저장하시겠습니까?")) return false;

		gfnPutObj("board_subject", "${page_clsf_nm} 수정");
		gfnPutObj("board_content", getValue("board_content"));
		gfnPutObj("board_clsf_cd", "${board_clsf_cd}");

		var pParamJson = gfnGetJson();		

		sendForm("POST", "/board/insert", "application/json; charset=utf-8", "json", pParamJson, function(message) {
			
			if(message == "parsererror") {
				alert("로그아웃되었습니다.");
				document.location.href="/m.do";
			} else if(message.result_code == 0) {
				alert("${page_clsf_nm} 수정하였습니다.");
				document.location.href="/mgnt/terms_list?t=${board_clsf_cd}";
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

	var pParamJson = '{"board_clsf_cd":"${board_clsf_cd}"}';

	sendForm("POST", "/mgnt/terms_detail", "application/json; charset=utf-8", "json", pParamJson, function(message) {
		
		var pFieldArry = ["board_content","board_id"];

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