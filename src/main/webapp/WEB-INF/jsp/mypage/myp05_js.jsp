<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();

	$('#btnChange').on('click', function () {

		/* 필수항목 체크 */
		var chk = '['
			+ '  {"id":"user_current_pw","name":"현재 비밀번호"} '
			+ ', {"id":"user_change_pw1","name":"새 비밀번호"} '
			+ ', {"id":"user_change_pw2","name":"새 비밀번호"} '
		chk += ']';

		var jsonCheck = JSON.parse(chk);

		if(!lComm.fnRequiredItems(jsonCheck)) {
			return false;
		}

		/* form값 global 변수에 입력 */
		gfnGetFormJSON();
	
		/* global 변수 json으로 변환 */
		var pParamJson = gfnGetJson();		

		sendForm("POST", "/mypage/member/passwd", "application/json; charset=utf-8", "json", pParamJson, function(message) {
			
			if(message.result_code == 0) {
				alert("비밀번호가 정상적으로 변경 되었습니다.");
				//마이페이지 이동 필요
			} else if(message.result_code > 0) {
				alert(message.result_msg);				
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}

		});	

	});	

});

</script>