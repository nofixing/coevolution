<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {

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

</script>