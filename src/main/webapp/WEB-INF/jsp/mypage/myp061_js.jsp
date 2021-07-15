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

	$('#btnAgree').on('click', function () {

		/* 필수항목 체크 */
		var chk = '['
			+ '  {"id":"agree_1","name":"이용약관 동의","name2":"Agree Terms of Use","lang":"${sessionScope.LANG}"} '
			+ ', {"id":"agree_2","name":"개인정보처리방침 동의","name2":"Agree with the privacy processing policy","lang":"${sessionScope.LANG}"} '
		chk += ']';

		var jsonCheck = JSON.parse(chk);

		if(!lComm.fnRequiredItemsChkRdo2(jsonCheck)) {
			return false;
		}

		/* form값 global 변수에 입력 */
		gfnGetFormJSON();
	
		/* global 변수 json으로 변환 */
		var pParamJson = gfnGetJson();		

		sendForm("POST", "/mypage/member/agree_update", "application/json; charset=utf-8", "json", pParamJson, function(message) {
			
			if(message == "parsererror") {
                alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
				document.location.href="/member/login_form";
			}
			else if(message.result_code == 0) {
				alert("<spring:message code='mypage.member26' text='재동의가 완료되었습니다.'/>");
				document.location.href="/mypage/myp06";
			} else {
                alert("<spring:message code='join.form2' text='서버 오류입니다.'/>"+"\r\n"+"<spring:message code='join.form3' text='잠시 후 다시 진행하시기 바랍니다.'/>");
			}

		});	

	});	

});


</script>