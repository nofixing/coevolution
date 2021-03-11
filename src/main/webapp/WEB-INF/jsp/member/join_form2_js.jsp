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

	if("${agree_yn}" == "N") {
		alert("필수항목 동의하시기 바랍니다.");
	}

	//이벤트
	$('#btnSignUp').on('click', function () {
		//로그인체크

		/* 필수항목 체크 */
		var chk = '['
			+ '  {"id":"agree_1","name":"이용약관 동의"} '
			+ ', {"id":"agree_2","name":"개인정보처리방침 동의"} ';
		chk += ']';

		var jsonCheck = JSON.parse(chk);

		if(!lComm.fnRequiredItemsChkRdo(jsonCheck)) {
			return false;
		} else {
			var frm = document.forms[0];
			frm.method = "post";
			frm.action = "/member/join_form5";
			frm.submit();
		}

	});

});

</script>