<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script language="javascript">

/**
 * Script 설정
 */
var lComm, lfnPutObj;
var lDataObjectPutGet = new Object(); /* Local Set Get */
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();
	var yyyyMMdd = lComm.getToday("-");

	//확인 (회원가입)
	$('#btnUpdate').on('click', function () {
		fnUpdate();
	});

	$('#btnList').on('click', function () {
		document.location.href="/mgnt/m_corp_search";
	});

	//중복확인
	$('#btnDupCheck').on('click', function () {
		fnDupCheck();
	});

	//전화번호
	$('#hp_no').on('focusout', function () {
		var telNo = lComm.setTelNoFormat(getValue("hp_no"));
		setValue("hp_no", telNo);
	});	

	fnSearch();

});

var lFormValue;
function fnSearch() {
	
	var pParamJson = "{}";
	sendForm("POST", "/mgnt/mgnt0301S01", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
			alert("로그아웃되었습니다.");
			document.location.href="/member/login_form";
		} else if(message.result_code == 0) {
			console.log(message);

			lFormValue = message;

			/* 국가코드 */  
			setSelectOption("country_cd", message.countrylist);

			/* 카테고리1 */  
			setSelectOption("category1", message.category1, "", "선택");

			setValue("country_cd", "212029");
			setValue("category1", "");

		} else {
			if(message.session_yn == "N") {
				alert("로그아웃되었습니다.");	
				document.location.href="/index";
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}
		}

	});	
}

/* 회원정보수정 */
function fnUpdate() {

	/* 필수체크 */
	var chk = '['
		+ '  {"id":"cust_id","name":"아이디"}'
		+ ', {"id":"cust_pw","name":"비밀번호"}'
		+ ', {"id":"cust_pw2","name":"비밀번호 확인"}'
		+ ', {"id":"cust_nm","name":"기업명"}'
		//+ ', {"id":"dept_nm","name":"부서"}'
		//+ ', {"id":"rep_nm","name":"담당자명"}'
		//+ ', {"id":"hp_no","name":"휴대전화번호"}'
		//+ ', {"id":"email_id","name":"이메일주소"}'
		//+ ', {"id":"country_cd","name":"국가"}'
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
	
	sendForm("POST", "/mgnt/mgnt0301001", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		console.log("message : " + message.result_code);

		if(message == "parsererror") {
			alert("로그아웃되었습니다.");
			document.location.href="/m.do";
		} else if(message.result_code == 0) {
			var msg = "회원정보가 저장되었습니다.";
            alert(msg);
			document.location.href="/mgnt/m_corp_search";
		} else {
			if(message.session_yn == "N") {
				alert("로그아웃되었습니다.");	
				document.location.href="/index";
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}
		}

	});	
}

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

</script>