<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();

	$('#btnAgree').on('click', function () {

		/* 필수항목 체크 */
		var chk = '['
			+ '  {"id":"agree_1","name":"이용약관 동의"} '
			+ ', {"id":"agree_2","name":"개인정보처리방침 동의"} '
		chk += ']';

		var jsonCheck = JSON.parse(chk);

		if(!lComm.fnRequiredItemsChkRdo(jsonCheck)) {
			return false;
		}

		/* form값 global 변수에 입력 */
		gfnGetFormJSON();
	
		/* global 변수 json으로 변환 */
		var pParamJson = gfnGetJson();		

		sendForm("POST", "/mypage/member/agree_update", "application/json; charset=utf-8", "json", pParamJson, function(message) {
			
			if(message.result_code == 0) {
				alert("재동의가 완료되었습니다.");
				document.location.href="/mypage/myp06";
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}

		});	

	});	

});


</script>