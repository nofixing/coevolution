<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();

	var today = lComm.getToday("-");
	
	/* 검색일자 셋팅 */
	if(getValue("favorts_ins_fr") == "")
		setValue("favorts_ins_fr", lComm.addDays(today, -30, "-"));
	
	if(getValue("favorts_ins_to") == "")
		setValue("favorts_ins_to", today);

	$('#btnSearch').on('click', function () {
		//검색

		/* 필수항목 체크 */
		var chk = '['
			+ '  {"id":"favorts_ins_fr","name":"조회 시작일자"} '
			+ ', {"id":"favorts_ins_to","name":"조회 종료일자"} ';
		chk += ']';

		var jsonCheck = JSON.parse(chk);

		if(!lComm.fnRequiredItems(jsonCheck)) {
			return false;
		}

		var frm = document.forms[0];
		frm.method = "post";
		frm.action = "/mypage/favortscorp";
		frm.submit();
	});	

});

</script>