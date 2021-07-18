<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script language="javascript">

/**
 * Script 설정
 */
var lComm, lfnPutObj;
var lDataObjectPutGet = new Object(); /* Local Set Get */
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();
	var yyyyMMdd = lComm.getToday("-");

	/* 목록이동 */
	$('#btnList').on('click', function () {
		document.location.href="/mgnt/expo";
	});

	//저장 
	$('#btnUpdate').on('click', function () {
		fnUpdate();
	});

});


/* 엑스포정보수정 */
function fnUpdate() {

	/* form값 global 변수에 입력 */
	gfnGetFormJSON();

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/mgnt/expo_cust_mgnt", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
			alert("로그아웃되었습니다.");
			document.location.href="/m.do";
		} else if(message.result_code == 0) {
			var msg = "참가업체를 등록하였습니다.";
            alert(msg);
	
			var frm = document.forms[0];
			frm.method = "post";
			frm.action = "/mgnt/expo_exhibitors_dtl";
			frm.submit();

		} else {
			if(message.result_code == undefined || message.session_yn == "N") {
				alert("로그아웃되었습니다.");	
				document.location.href="/index";
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}
		}

	});	
}

</script>