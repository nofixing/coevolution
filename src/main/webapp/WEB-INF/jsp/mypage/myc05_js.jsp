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

	//확인 (회원가입)
	$('#btnUpdate').on('click', function () {
		fnUpdate();
	});

	//전화번호
	$('#hp_no').on('focusout', function () {
		var telNo = lComm.setTelNoFormat(getValue("hp_no"));
		setValue("hp_no", telNo);
	});	

	fnSearch();

});

/* 회원정보조회 */
var lFormValue;
function fnSearch() {
	
	var pParamJson = "{}";
	sendForm("POST", "/mypage/member/search", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message.result_code == 0) {
			console.log(message);

			lFormValue = message;

			/* 국가코드 */  
			setSelectOption("country_cd", message.countrylist);

			/* 필드값입력 */
			var pFieldArry = ["cust_id","cust_nm","email_id","hp_no","dept_nm","rep_nm","country_cd","ins_dt","cust_sts_nm"];
			gfnSetField(message.custInfo[0], pFieldArry)

			/* 개인정보수집이용동의 */
			if(message.custInfo[0].agree_1 == "Y") {
				setValue("agree_1", "동의");
			} else {
				setValue("agree_1", "미동의");
			}

			/* 마케팅활용동의 */
			if(message.custInfo[0].agree_3 == "Y") {
				setValue("agree_3", "동의");
			} else {
				setValue("agree_3", "미동의");
			}

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
		+ '  {"id":"email_id","name":"이메일 주소"}'
		+ ', {"id":"hp_no","name":"휴대폰"}'
		+ ', {"id":"dept_nm","name":"부서"}'
		+ ', {"id":"rep_nm","name":"담당자명"}'
		+ ', {"id":"country_cd","name":"국가"}'
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
	}

	/* form값 global 변수에 입력 */
	gfnGetFormJSON();

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/mypage/member/update", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		console.log("message : " + message.result_code);

		if(message.result_code == 0) {
			var msg = "회원정보가 수정되었습니다.";
			fnSearch();
            alert(msg);
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

</script>