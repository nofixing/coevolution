<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();
	var yyyyMMdd = lComm.getToday("-");
	

	//이벤트
	$('#btnLogin').on('click', function () {
		//로그인체크

		/* 필수항목 체크 */
		var chk = '['
			+ '  {"id":"user_id","name":"아이디"} '
			+ ', {"id":"user_pw","name":"비밀번호"} ';
		chk += ']';

		var jsonCheck = JSON.parse(chk);

		if(!lComm.fnRequiredItems(jsonCheck)) {
			return false;
		}

		/* form값 global 변수에 입력 */
		gfnGetFormJSON();
	
		/* global 변수 json으로 변환 */
		var pParamJson = gfnGetJson();

		//console.log("pParamJson : " + pParamJson);
	
		sendForm("POST", "/member/login", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		    //console.log("message : " + message.result_code);
			if(message.result_code == 0) {
				alert("로그인성공!!");
			} else {
				alert("일치하는 정보가 없습니다.\r\n확인후 다시 입력해주세요.");
			}

		});

	});

	/* 회원가입 */
	$('#btnJoin').on('click', function () {
		document.location.href="/member/join_form1"
	});

});

</script>