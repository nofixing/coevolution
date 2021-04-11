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

	fnSearch();

});

/* 회원정보조회 */
var lFormValue;
function fnSearch() {
	
	var pParamJson = "{}";
	sendForm("POST", "/mypage/member/search", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
				alert("로그아웃되었습니다.");
				document.location.href="/member/login_form";
		}
		else if(message.result_code == 0) {
			//console.log(message);

			lFormValue = message;

			/* 국가코드 */  
			setSelectOption("country_cd", message.countrylist);

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

			/* 필드값입력 */
			var pFieldArry = ["cust_id","cust_nm","email_id","addr_1","addr_2","tel_no","hp_no","company_nm","dept_nm","posn_nm","country_cd","city_nm","rcmder_cust_id","ins_dt","cust_sts_nm"];
			gfnSetField(message.custInfo[0], pFieldArry);

			/* 성별 */
			gfnSetCheck("gender_cd_"+message.custInfo[0].gender_cd);

			/* 연령대별 */
			gfnSetCheck("age_cd_"+message.custInfo[0].age_cd);		
			
			/* 방문타입 */
			gfnSetCheck("visit_pups_cd_"+message.custInfo[0].visit_pups_cd);		
			
			/* 관심분야, 종사분야, 업무(구매)권한, 방문목적, 인지경로 값셋팅 */
			var intrst = message.custIntrst;
			for(var i = 0; i < intrst.length; i++) {
				gfnSetCheck("S"+intrst[i].intrst_cd);	
			}

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
		+ ', {"id":"addr_1","name":"주소"}'
		+ ', {"id":"company_nm","name":"소속"}'
		+ ', {"id":"dept_nm","name":"부서"}'
		+ ', {"id":"hp_no","name":"전화번호"}'
		//+ ', {"id":"tel_no","name":"연락처"}'
		+ ', {"id":"country_cd","name":"국가"}'
		+ ', {"id":"city_nm","name":"시도"}'
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
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

	/* form값 global 변수에 입력 */
	gfnGetFormJSON();

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/mypage/member/update", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		console.log("message : " + message.result_code);

		if(message == "parsererror") {
				alert("로그아웃되었습니다.");
				document.location.href="/member/login_form";
		}
		else if(message.result_code == 0) {
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