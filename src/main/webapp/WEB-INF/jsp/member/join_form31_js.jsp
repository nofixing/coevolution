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

	fnSearch();

});

/* 코드정보조회 */
var lFormValue;
function fnSearch() {
	
	var pParamJson = "{}";
	sendForm("POST", "/member/search_join_com_code", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message.result_code == 0) {
			//console.log(message);

			lFormValue = message;

			/* 국가코드 */  
			setSelectOption("country_cd", message.countrylist);
			setValue("country_cd", "212032");

			/* 관심분야 */
			setCheckRadioList("checkbox", "S", message.list1, "list1", "<li>", "</li>");

			/* 종사분야 */
			setCheckRadioList("checkbox", "S", message.list2, "list2", "<li>", "</li>");

			/* 업무(구매)권한 */
			setCheckRadioList("checkbox", "S", message.list3, "list3", "<li>", "</li>");

			/* 방문목적 */
			setCheckRadioList("checkbox", "S", message.list4, "list4", "<li>", "</li>");

			/* 인지경로 */
			setCheckRadioList("checkbox", "S", message.list5, "list5", "<li>", "</li>");			
			
		} else {
			alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
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
		+ ' {"id":"cust_nm","name":"이름"}'
		+ ', {"id":"company_nm","name":"소속"}'
		+ ', {"id":"dept_nm","name":"부서"}'
		+ ', {"id":"hp_no","name":"전화번호"}'
		//+ ', {"id":"tel_no","name":"연락처"}'
		+ ', {"id":"email_id1","name":"이메일 주소"}'
		+ ', {"id":"email_id2","name":"이메일 주소"}'
		+ ', {"id":"country_cd","name":"국가"}'
		+ ', {"id":"city_nm","name":"시도"}'
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
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
	var arry = [];
	arry = codeList(lFormValue.list1, arry);

	if(chkYn(arry) == "N") {
		alert("관심분야를 선택하세요.");
		return false;
	}

	/* 종사분야 체크 */
	arry = [];
	arry = codeList(lFormValue.list2, arry);

	if(chkYn(arry) == "N") {
		alert("종사분야를 선택하세요.");
		return false;
	}

	/* 업무(구매)권한 체크 */
	arry = [];
	arry = codeList(lFormValue.list3, arry);

	if(chkYn(arry) == "N") {
		alert("업무(구매)권한를 선택하세요.");
		return false;
	}	

	/* 방문목적 체크 */
	arry = [];
	arry = codeList(lFormValue.list4, arry);


	if(chkYn(arry) == "N") {
		alert("방문목적을 선택하세요.");
		return false;
	}	

	/* 인지경로 체크 */
	arry = [];
	arry = codeList(lFormValue.list5, arry);


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

	sendForm("POST", "/member/insert_social", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		console.log("message : " + message.result_code);

		if(message.result_code == 0) {
			var msg = "회원가입이 완료되었습니다. <br><br>";
			msg += "참관등록하신 분들을 대상으로 <span style='color:red; font-weight:bold'>뱃지(10)</span>를 지급해드립니다. <br>";
			msg += "뱃지는 제8회 국제전기자동차엑스포의 비추얼전시관 부스에 사용할 수 있습니다.   <br><br>";
			msg += "주제/국가별 부스에 EV포인트 부여 시 추첨을 통해 경품 기회 제공합니다. <br>";
			msg += "※ 지급된 뱃지는 마이페이지에서 확인가능합니다.<br>";
            
			gfnAlert ("alert", "회원가입완료", msg, function(rtnValue){
				document.location.href="/member/login_form";
			});
			
            //alert(msg);
            //document.location.href="/member/login_form";
		} else {
			alert("[참관신청 오류]\r\n잠시 후 다시 진행하시기 바랍니다.");
			lComm.setFocus("cust_nm");
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

/* 관심사항에 대한 항목 */
function codeList(pList, pArray) {
	var str = "";
	for(var i = 0; i < pList.length; i++) {
		pArray.push("S"+pList[i].cd_id);
	}

	return pArray;
}

</script>