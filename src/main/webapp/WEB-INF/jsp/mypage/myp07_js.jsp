<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();

	$('#btnWdrwl').on('click', function () {

		/* 필수항목 체크 */
		var chk = '['
			+ '  {"id":"member_wdrwl_rsn","name":"탈퇴사유"} '
		chk += ']';

		var jsonCheck = JSON.parse(chk);

		if(!lComm.fnRequiredItems(jsonCheck)) {
			return false;
		}

		if(!confirm("탈퇴 하시겠습니까?")) return false;

		/* form값 global 변수에 입력 */
		gfnGetFormJSON();
	
		/* global 변수 json으로 변환 */
		var pParamJson = gfnGetJson();		

		sendForm("POST", "/mypage/member/wdrwal", "application/json; charset=utf-8", "json", pParamJson, function(message) {
			
			if(message == "parsererror") {
				alert("로그아웃되었습니다.");
				document.location.href="/member/login_form";
			}
			else if(message.result_code == 0) {
				alert("회원 탈퇴가 완료되었습니다.");
				document.location.href="/";
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}

		});	

	});	
});

</script>