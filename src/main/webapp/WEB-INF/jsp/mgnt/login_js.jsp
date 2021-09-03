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
	

	//이벤트
	$('#btnLogin').on('click', function () {
		//로그인체크
		login();
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

	$('#btnChgPw').on('click', function () {
		fnPwUpdate();
	});

    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var mgntUserInputId = getCookie("mgntUserInputId");

    $("input[name='user_id']").val(mgntUserInputId);

    if($("input[name='user_id']").val() != ""){ // 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
        $("#check_id").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }

    $("#check_id").change(function(){ // 체크박스에 변화가 있다면,
        if($("#check_id").is(":checked")){ // ID 저장하기 체크했을 때,
            var mgntUserInputId = $("input[name='user_id']").val();
            setCookie("mgntUserInputId", mgntUserInputId, 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("mgntUserInputId");
        }
    });

    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("input[name='user_id']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#check_id").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            var mgntUserInputId = $("input[name='user_id']").val();
            setCookie("mgntUserInputId", mgntUserInputId, 7); // 7일 동안 쿠키 보관
        }
    });
	
});

function login() {

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

	sendForm("POST", "/mgnt/login", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		//console.log("message : " + message.result_code);
		if(message.result_code == 0) {
			document.location.href="/mgnt/expo";
		} else if(message.result_code == -2) {
			alert(" 비밀번호를 변경해 주시기 바랍니다.");
			$(".modal").css("display", "block");
		} else {
			alert("일치하는 정보가 없습니다.\r\n확인후 다시 입력해주세요.");
		}

	});

}

function fnPwUpdate() {

	/* 필수체크 */
	var chk = '['
		+ '  {"id":"bf_user_pw","name":"기존비밀번호"}'
		+ ', {"id":"tobe_passwd1","name":"새비밀번호"}'
		+ ', {"id":"tobe_passwd2","name":"새비밀번호 확인"}'
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
	}

	/* form값 global 변수에 입력 */
	gfnGetFormJSON();

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	/* 비밀번호 확인 체크 */
	if(getValue("bf_user_pw") == getValue("tobe_passwd1")) {
		alert("기존 비밀번호와 동일합니다. 다른 비밀번호로 입력하세요.");
		return false;
	} else if(getValue("tobe_passwd1") != getValue("tobe_passwd2")) {
		alert("정확한 비밀번호를 입력하세요.");
		return false;
	} 

	gfnPutObj("user_id", getValue("user_id"));
	gfnPutObj("bf_user_pw", getValue("bf_user_pw"));
	gfnPutObj("tobe_passwd1", getValue("tobe_passwd1"));
	gfnPutObj("tobe_passwd2", getValue("tobe_passwd2"));

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/mgnt/pwChg", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
			alert("로그아웃되었습니다.");
			document.location.href="/m.do";
		} else if(message.result_code == 0) {
			var msg = "수정하였습니다.";
			alert(msg);
			$(".modal").css('display', 'none');
		} else if(message.result_code == "-1") {
			alert("비밀번호가 일치하지 않습니다.");	
		} else if(message.result_code == "-2") {
			alert("기존 비밀번호가 일치하지 않습니다.");	
		} else if(message.result_code == "-3") {
			alert("기존 비밀번호와 동일합니다. 다른 비밀번호로 입력하세요.");
		} else if(message.result_code == "-4") {
			alert("비밀번호를 정확히 입력하세요.");	
		} else {
			if(message.result_code == undefined || message.session_yn == "N") {
				alert("로그아웃되었습니다.");	
				document.location.href="/index";
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}
		}

	});	
}

</script>