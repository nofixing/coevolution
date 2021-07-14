<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

/**
 * Script 설정
 */
var lComm;

$(document).ready(function() {

//로그인되어있는경우 MyPage로 이동
<c:choose>
    <c:when test="${sessionScope.login_session.cust_clsf_cd eq '202001'}">
        document.location.href="/mypage/favorts";
    </c:when>
    <c:when test="${sessionScope.login_session.cust_clsf_cd eq '202002'}">
        document.location.href="/mypage/myc01";
    </c:when>
</c:choose>	

<c:if test="${sessionScope.social_login_yn eq 'N'}">
    alert("<spring:message code='login.notMatch' text='일치하는 정보가 없습니다.'/>"+"\r\n"+"<spring:message code='login.notMatch2' text='소셜 회원가입 후 로그인하시기 바랍니다.'/>"
    );
</c:if>

${sessionScope.social_login_yn = ""}


	//초기 값 설정
	lComm = new gfnComm();
	var yyyyMMdd = lComm.getToday("-");

    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var userInputId = getCookie("userInputId");

    $("input[name='user_id']").val(userInputId);

    if($("input[name='user_id']").val() != ""){ // 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
        $("#check_id").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }

    $("#check_id").change(function(){ // 체크박스에 변화가 있다면,
        if($("#check_id").is(":checked")){ // ID 저장하기 체크했을 때,
            var userInputId = $("input[name='user_id']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("userInputId");
        }
    });

    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("input[name='user_id']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#check_id").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            var userInputId = $("input[name='user_id']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }
    });

    $( "#user_id" ).keypress(function(event) {
        if ( event.which == 13 ) {
            lComm.setFocus("user_pw");
        }
    });

    $( "#user_pw" ).keypress(function(event) {
        if ( event.which == 13 ) {
            login();
        }
    });
	
	//이벤트
	$('#btnLogin').on('click', function () {
		//로그인체크
        login();
	});

    //social login google
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

	/* 회원가입 */
	$('#btnJoin').on('click', function () {
		document.location.href="/member/join_form1"
	});

});

/*로그인처리*/
function login() {
    /* 필수항목 체크 */
    var chk = '['
        + '  {"id":"user_id","name":"아이디","name2":"ID","lang":"${sessionScope.LANG}"} '
        + ', {"id":"user_pw","name":"비밀번호","name2":"Password","lang":"${sessionScope.LANG}"} ';
    chk += ']';

    var jsonCheck = JSON.parse(chk);

    if(!lComm.fnRequiredItems2(jsonCheck)) {
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
            if('${sessionScope.url_prior_login}' != '') {
                document.location.href = '${sessionScope.url_prior_login}';
            } else {
                if (message.cust_clsf_cd == "202001") {
                    document.location.href = "/mypage/favorts";
                } else if (message.cust_clsf_cd == "202002") {
                    document.location.href = "/mypage/myc01";
                } 
            }
        } else {
            alert("<spring:message code='login.notMatch' text='일치하는 정보가 없습니다.'/>"+"\r\n"+"<spring:message code='login.notMatch3' text='확인후 다시 입력해주세요.'/>"
            );
        }

    });    
}

</script>