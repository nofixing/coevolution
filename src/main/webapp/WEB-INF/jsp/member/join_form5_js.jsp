<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script language="javascript">

/**
 * Script 설정
 */
var lComm;
var lDataObjectPutGet = new Object(); /* Local Set Get */
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();
	var yyyyMMdd = lComm.getToday("-");

	//중복확인
	$('#btnDupCheck').on('click', function () {
		fnDupCheck();
	});

	//확인 (회원가입)
	$('#btnSignUp').on('click', function () {
		fnSignUp();
	});

	//취소
	$('#btnCncl').on('click', function () {
		document.location.href="/index";
	});

	//주소검색
	$('#search_zip_code').on('click', function () {
		
	});

	//이메일 선택
	$('#email_clsf').on('change', function () {
		setValue("email_id2", getValue("email_clsf"));
	});

	//휴대전화번호
	$('#tel_no').on('focusout', function () {
		var telNo = lComm.setTelNoFormat(getValue("tel_no"));
		setValue("tel_no", telNo);
	});

	//전화번호
	$('#hp_no').on('focusout', function () {
		var telNo = lComm.setTelNoFormat(getValue("hp_no"));
		setValue("hp_no", telNo);
	});	

	//동의정보가 없을 경우 약관동의로 이동
	if("${agree_1}" != "Y" && "${agree_2}" != "Y") {
		document.location.href="/member/join_form4";
	}

});

/* ID중복체크 */
function fnDupCheck() {
	var chk = '['
		+ '  {"id":"cust_id","name":"아이디"}';
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
	}

	/* JSON 생성을 위해 입력*/
	gfnPutObj("cust_id", getValue("cust_id"));

	/* form값 global 변수에 입력 */
	gfnGetFormJSON();

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/member/dup", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		console.log("message : " + message.result_code);

		if(message.result_code == 0) {
			if(message.dup_yn == "N") {
				alert("사용가능한 ID입니다.");

				/* ID 중복체크여부 임시저장 */
				lfnPutObj(lDataObjectPutGet, "cust_id", getValue("cust_id"));
				lfnPutObj(lDataObjectPutGet, "dup_yn", message.dup_yn);

				console.log(lfnGetObj(lDataObjectPutGet, "dup_yn"));

			} else {
				alert("중복된 아이디가 있습니다.\r\n아이디를 다시 입력해주세요.");
				lComm.setFocus("cust_id");
			}
		} else {
			alert("[중복체크 오류]\r\n잠시 후 다시 진행하시기 바랍니다.");
			lComm.setFocus("cust_id");
		}

	});	
}

/* 회원가입 */
function fnSignUp() {

	/* 필수체크 */
	var chk = '['
		+ '  {"id":"cust_id","name":"아이디(ID)"}'
		+ ', {"id":"cust_pw","name":"비밀번호(Password)"}'
		+ ', {"id":"cust_pw2","name":"비밀번호 확인(Password Check)"}'
		+ ', {"id":"cust_nm","name":"기업명(Company)"}'
		+ ', {"id":"dept_nm","name":"부서(Department)"}'
		+ ', {"id":"rep_nm","name":"담당자명(Person in charge)"}'
		+ ', {"id":"hp_no","name":"휴대전화번호(Phone number)"}'
		+ ', {"id":"email_id1","name":"이메일주소(e-mail)"}'
		+ ', {"id":"email_id2","name":"이메일주소(e-mail)"}'
		+ ', {"id":"country_cd","name":"국가(Country)"}'
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
	}

	/* 비밀번호 확인 체크 */
	if(getValue("cust_pw") != getValue("cust_pw2")) {
		alert("정확한 비밀번호를 입력하세요.")
		return false;
	}

	/* 인증받은 ID 체크 */
	if(lfnGetObj(lDataObjectPutGet, "dup_yn") != "N") {
		alert("중복확인을 진행하시기 바랍니다.")
		return false;
	} else if(lfnGetObj(lDataObjectPutGet, "cust_id") != getValue("cust_id")) {
		alert("인증받은 아이디와 같지 않습니다.\r\n다시 중복확인 하시기 바랍니다.")
		return false;
	}

	gfnPutObj('email_id', getValue("email_id1")+"@"+getValue("email_id2"));

	/* form값 global 변수에 입력 */
	gfnGetFormJSON();

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/member/insert", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		console.log("message : " + message.result_code);

		if(message.result_code == 0) {
            var msg = "참관등록 완료되었습니다. ";
            /*
			gfnAlert ("alert", "참관등록 완료", msg, function(rtnValue){
				document.location.href="/";
			});
			*/
            alert(msg);
            document.location.href="/";
		} else {
			alert("[참가신청 오류]\r\n잠시 후 다시 진행하시기 바랍니다.");
			lComm.setFocus("cust_id");
		}

	});	
}

</script>