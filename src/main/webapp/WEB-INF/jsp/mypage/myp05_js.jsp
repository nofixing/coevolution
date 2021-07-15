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

	$('#btnChange').on('click', function () {

		/* 필수항목 체크 */
		var chk = '['
			+ '  {"id":"user_current_pw","name":"현재 비밀번호","name2":"Current Password","lang":"${sessionScope.LANG}"} '
			+ ', {"id":"user_change_pw1","name":"새 비밀번호","name2":"New Password","lang":"${sessionScope.LANG}"} '
			+ ', {"id":"user_change_pw2","name":"새 비밀번호","name2":"New Password","lang":"${sessionScope.LANG}"} '
		chk += ']';

		var jsonCheck = JSON.parse(chk);

		if(!lComm.fnRequiredItems2(jsonCheck)) {
			return false;
		}

		/* form값 global 변수에 입력 */
		gfnGetFormJSON();
	
		/* global 변수 json으로 변환 */
		var pParamJson = gfnGetJson();		

		sendForm("POST", "/mypage/member/passwd", "application/json; charset=utf-8", "json", pParamJson, function(message) {
			
			if(message == "parsererror") {
                alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
				document.location.href="/member/login_form";
			}
			else if(message.result_code == 0) {
                alert("<spring:message code='mypage.member28' text='비밀번호가 정상적으로 변경 되었습니다.'/>");
				//마이페이지 이동 필요
			} else if(message.result_code == 1) {
                alert("<spring:message code='mypage.member29' text='이전 비밀번호와 현재 비밀번호가 같습니다.'/>");
			} else if(message.result_code == 2) {
                alert("<spring:message code='join.form24' text='비밀번호와 사용자ID가 같습니다.'/>");
			} else if(message.result_code == 3) {
                alert("<spring:message code='join.form25' text='비밀번호를 특수문자, 영문, 숫자 조합으로 입력하시기 바랍니다.'/>");
			} else if(message.result_code == 4) {
                alert("<spring:message code='join.form26' text='같은 문자를 연속하여 사용할 수 없습니다.'/>");
			} else if(message.result_code == 5) {
                alert("<spring:message code='join.form27' text='비밀번호에 공백이 있습니다.'/>");
			} else if(message.result_code == 6) {
                alert("<spring:message code='mypage.member3' text='새 비밀번호가 같지 않습니다.'/>");
			} else if(message.result_code == 7) {
                alert("<spring:message code='mypage.member4' text='현재 비밀번호가 맞지 않습니다.'/>");
			} else {
                alert("<spring:message code='join.form2' text='서버 오류입니다.'/>"+"\r\n"+"<spring:message code='join.form3' text='잠시 후 다시 진행하시기 바랍니다.'/>");
			}

		});	

	});	

});

</script>