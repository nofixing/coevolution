<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {

	var email_check = '${email_check}';

	if (email_check == 'dup_email') {
	    alert('이미 소셜 로그인으로 회원가입된 회원이 있습니다. \n가입된 소셜 로그인으로 로그인하셔서 계정연결하실 수 있습니다.');
    }

    $('#google_login').on('click', function () {

        console.log("google_login click");
        document.location.href = "/oauth2/authorization/google";

    });

    //social login facebook
    $('#facebook_login').on('click', function () {

        console.log("facebook_login click");
        document.location.href = "/oauth2/authorization/facebook";

    });

    //social login naver
    $('#naver_login').on('click', function () {

        console.log("naver_login click");
        document.location.href = "/oauth2/authorization/naver";

    });

    //social login kakao
    $('#kakao_login').on('click', function () {

        console.log("kakao_login click");
        document.location.href = "/oauth2/authorization/kakao";

    });

});

function fnPrtpct() {
    alert("기업참가(부스)등록 기간이 아닙니다.");
}

</script>