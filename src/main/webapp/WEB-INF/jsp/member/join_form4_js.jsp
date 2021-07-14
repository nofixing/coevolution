<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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
        alert("<spring:message code='join.form' text='필수항목 동의하시기 바랍니다.'/>");
	}

	//이벤트
	$('#btnSignUp').on('click', function () {
		//로그인체크

		/* 필수항목 체크 */
		var chk = '['
			+ '  {"id":"agree_1","name":"이용약관 동의","name2":"Agree Terms of Use","lang":"${sessionScope.LANG}"} '
			+ ', {"id":"agree_2","name":"개인정보처리방침 동의","name2":"Agree with the privacy processing policy","lang":"${sessionScope.LANG}"} ';
		chk += ']';

		var jsonCheck = JSON.parse(chk);

		if(!lComm.fnRequiredItemsChkRdo2(jsonCheck)) {
			return false;
		} else {
			var frm = document.forms[0];
			frm.method = "post";
			frm.action = "/member/join_form5";
			frm.submit();
		}

	});

	$('#agree-all').on('click', function () {
		//전체체크
		if(checked("agree_1")) {
			gfnSetUnCheck("agree_1");
			gfnSetUnCheck("agree_2");
			gfnSetUnCheck("agree_3");
		} else {
			gfnSetCheck("agree_1");
			gfnSetCheck("agree_2");
			gfnSetCheck("agree_3");
		}

	});		

});

</script>