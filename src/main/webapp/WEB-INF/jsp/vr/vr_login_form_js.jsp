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
				 document.location.href = '${sessionScope.url_prior_login}';
			} else {
				alert("일치하는 정보가 없습니다.\r\n확인후 다시 입력해주세요.");
			}

		});

	});

    //social login google
    $('#google_login').on('click', function () {

        console.log("google_login click");
        window.open("/vr/login_popup?login=google", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=500,height=500");
        //document.location.href = "/oauth2/authorization/google";

    });

    //social login facebook
    $('#facebook_login').on('click', function () {

        console.log("facebook_login click");
        window.open("/vr/login_popup?login=facebook", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=500,height=500");
        //document.location.href = "/oauth2/authorization/facebook";

    });

    //social login naver
    $('#naver_login').on('click', function () {

        console.log("naver_login click");
        window.open("/vr/login_popup?login=naver", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=500,height=500");
        //document.location.href = "/oauth2/authorization/naver";

    });

    //social login kakao
    $('#kakao_login').on('click', function () {

        console.log("kakao_login click");
        window.open("/vr/login_popup?login=kakao", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=500,height=500");
        //document.location.href = "/oauth2/authorization/kakao";

    });

	/* 회원가입 */
	$('#btnJoin').on('click', function () {
		document.location.href="/member/join_form1"
	});

});

</script>