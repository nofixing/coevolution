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

	//추천인검색
	$('#search_rcmder_cust_id').on('click', function () {
		fnRrcmderCustId();
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
		document.location.href="/member/join_form2";
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

/* 추천인 검색 */
function fnRrcmderCustId() {
	var chk = '['
		+ '  {"id":"rcmder_cust_id","name":"추천인(ID)"}';
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
	}

	/* JSON 생성을 위해 입력*/
	gfnPutObj("cust_id", getValue("rcmder_cust_id"));

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/member/dup", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		console.log("message : " + message.result_code);

		if(message.result_code == 0) {
			if(message.dup_yn == "Y") {
				alert(getValue("rcmder_cust_id") + "은 추천인(ID)로 등록 가능합니다");

				/* ID 중복체크여부 임시저장 */
				lfnPutObj(lDataObjectPutGet, "rcmder_cust_id", getValue("rcmder_cust_id"));

			} else {
				alert("추천인ID를 정확하게 다시 입력해주세요");
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
		+ '  {"id":"cust_id","name":"아이디"}'
		+ ', {"id":"cust_pw","name":"비밀번호"}'
		+ ', {"id":"cust_pw2","name":"비밀번호 확인"}'
		+ ', {"id":"cust_nm","name":"이름"}'
		+ ', {"id":"company_nm","name":"소속"}'
		+ ', {"id":"dept_nm","name":"부서"}'
		+ ', {"id":"hp_no","name":"전화번호"}'
		+ ', {"id":"tel_no","name":"연락처"}'
		+ ', {"id":"country_cd","name":"국가"}'
		+ ', {"id":"city_nm","name":"시도"}'
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

	/* 추천인 ID 체크 */
	if(getValue("rcmder_cust_id") != "") {
		if(lfnGetObj(lDataObjectPutGet, "rcmder_cust_id") != getValue("rcmder_cust_id")) {
			alert("인증받은 추천인ID가 같지 않습니다.\r\n다시 추천인 검색을 진행하시기 바랍니다.")
			return false;
		}
	}
	

	/* 관심분야 체크 */
	var arry = ["S206001","S206002","S206003","S206004","S206005","S206006"];

	if(chkYn(arry) == "N") {
		alert("관심분야를 선택하세요.");
		return false;
	}

	/* 종사분야 체크 */
	arry = ["S207001","S207002","S207003","S207004","S207005","S207006","S207007","S207008","S207009","S207010"];

	if(chkYn(arry) == "N") {
		alert("종사분야를 선택하세요.");
		return false;
	}

	/* 업무(구매)권한 체크 */
	arry = ["S208001","S208002","S208003","S208004","S208005","S208006","S208007","S208008"];

	if(chkYn(arry) == "N") {
		alert("업무(구매)권한를 선택하세요.");
		return false;
	}	

	/* 방문목적 체크 */
	arry = ["S209001","S209002","S209003","S209004","S209005","S209006"];

	if(chkYn(arry) == "N") {
		alert("방문목적을 선택하세요.");
		return false;
	}	

	/* 인지경로 체크 */
	arry = ["S210001","S210002","S210003","S210004","S210005","S210006","S210007","S210008"];

	if(chkYn(arry) == "N") {
		alert("인지경로을 선택하세요.");
		return false;
	}

	if(getValue("email_id1") != "" && getValue("email_id2") != "") {
		gfnPutObj('email_id', getValue("email_id1")+"@"+getValue("email_id2"));
	} else if((getValue("email_id1") != "" && getValue("email_id2") == "") || (getValue("email_id1") == "" && getValue("email_id2") != "")) {
		alert("정확한 이메일 주소를 입력하세요.")
		return false;
	}

	/* form값 global 변수에 입력 */
	gfnGetFormJSON();

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/member/insert", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		console.log("message : " + message.result_code);

		if(message.result_code == 0) {
			var msg = "회원가입이 완료되었습니다. <br><br>";
			msg += "참관등록하신 분들을 대상으로 뱃지(10)를 지급해드립니다. <br>";
			msg += "뱃지는 제8회 국제전기자동차엑스포의 비추얼전시관 부스에 사용할 수 있습니다.   <br><br>";
			msg += "주제/국가별 부스에 EV포인트 부여 시 추첨을 통해 경품 기회 제공합니다. <br>";
			msg += "※ 지급된 뱃지는 마이페이지에서 확인가능합니다.<br>";

			gfnAlert ("alert", "회원가입완료", msg, function(rtnValue){
				document.location.href="/member/login_form";
			});	
		} else {
			alert("[참관신청 오류]\r\n잠시 후 다시 진행하시기 바랍니다.");
			lComm.setFocus("cust_id");
		}

	});	
}

/* 체크박스 1건이라도 체크되어있으면 Y 아니면 N */
function chkYn(pArry) {
	var rtnValue = "N";
	for (var key in pArry) {

		var field = pArry[key];
		var chk = checked(field);

		if(chk) {
			rtnValue = "Y";
			gfnPutObj(lComm.replaceAll(field, "S","chk_"), "Y");
		} else {
			gfnPutObj(lComm.replaceAll(field, "S","chk_"), "N");
		}
		
	}

	return rtnValue;
}

</script>