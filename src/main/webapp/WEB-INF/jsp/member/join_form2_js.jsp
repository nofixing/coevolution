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

    //로그인되어있는경우 MyPage로 이동
    <c:choose>
        <c:when test="${sessionScope.login_session.cust_clsf_cd eq '202001'}">
            document.location.href="/mypage/favorts";
        </c:when>
        <c:when test="${sessionScope.login_session.cust_clsf_cd eq '202002'}">
            document.location.href="/mypage/myc01";
        </c:when>
    </c:choose>	

	if("${agree_yn}" == "N") {
		alert("필수항목 동의하시기 바랍니다.");
	}

	//이벤트
	$('#btnSignUp').on('click', function () {

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
			frm.action = "/member/join_form3";
			frm.submit();
		}

	});

	$('#agree-all').on('click', function () {
		//전체체크
		if(checked("agree-all")) {
			gfnSetCheck("agree_1");
			gfnSetCheck("agree_2");
			gfnSetCheck("agree_3");
		} else {
			gfnSetUnCheck("agree_1");
			gfnSetUnCheck("agree_2");
			gfnSetUnCheck("agree_3");			
		}

	});	

	$('#agree_1').on('click', function () {
		fn_checked();
	});

	$('#agree_2').on('click', function () {
		fn_checked();
	});

	$('#agree_3').on('click', function () {
		fn_checked();
	});

});

function fn_checked() {
	if(checked("agree_1") && checked("agree_2") && checked("agree_3")) {
		gfnSetCheck("agree-all");
	} else {
		gfnSetUnCheck("agree-all");
	}
}

</script>