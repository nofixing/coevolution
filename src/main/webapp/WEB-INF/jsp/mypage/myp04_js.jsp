<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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
            alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
            document.location.href="/member/login_form";
		}
		else if(message.result_code == 0) {
			//console.log(message);

			lFormValue = message;

			/* 국가코드 */  
			setSelectOption("country_cd", message.countrylist, "", "<spring:message code='join_form2.optional' text='선택'/>","","${sessionScope.LANG}");

			/* 관심분야 */
			setCheckRadioList("checkbox", "S", message.list1, "list1", "<li>", "</li>","${sessionScope.LANG}");

			/* 종사분야 */
			setCheckRadioList("checkbox", "S", message.list2, "list2", "<li>", "</li>","${sessionScope.LANG}");

			/* 업무(구매)권한 */
			setCheckRadioList("checkbox", "S", message.list3, "list3", "<li>", "</li>","${sessionScope.LANG}");

			/* 방문목적 */
			setCheckRadioList("checkbox", "S", message.list4, "list4", "<li>", "</li>","${sessionScope.LANG}");

			/* 인지경로 */
			setCheckRadioList("checkbox", "S", message.list5, "list5", "<li>", "</li>","${sessionScope.LANG}");			

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
				setValue("agree_1", "<spring:message code='form.myinfo.update.agree' text='동의'/>");
			} else {
				setValue("agree_1", "<spring:message code='form.myinfo.update.disagree' text='미동의'/>");
			}

			/* 마케팅활용동의 */
			if(message.custInfo[0].agree_3 == "Y") {
				setValue("agree_3", "<spring:message code='form.myinfo.update.agree' text='동의'/>");
			} else {
				setValue("agree_3", "<spring:message code='form.myinfo.update.disagree' text='미동의'/>");
			}

		} else {
			if(message.session_yn == "N") {
                alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
				document.location.href="/index";
			} else {
                alert("<spring:message code='join.form2' text='서버 오류입니다.'/>"+"\r\n"+"<spring:message code='join.form3' text='잠시 후 다시 진행하시기 바랍니다.'/>");
			}
		}

	});	
}

/* 회원정보수정 */
function fnUpdate() {

	/* 필수체크 */
	var chk = '['
		+ '  {"id":"email_id","name":"이메일 주소","name2":"E-mail","lang":"${sessionScope.LANG}"}'
		+ ', {"id":"addr_1","name":"주소","name2":"Address","lang":"${sessionScope.LANG}"}'
		+ ', {"id":"company_nm","name":"소속","name2":"Affiliation","lang":"${sessionScope.LANG}"}'
		+ ', {"id":"dept_nm","name":"부서","name2":"Department","lang":"${sessionScope.LANG}"}'
		+ ', {"id":"hp_no","name":"전화번호","name2":"Phone number","lang":"${sessionScope.LANG}"}'
		//+ ', {"id":"tel_no","name":"연락처"}'
		+ ', {"id":"country_cd","name":"국가","name2":"Nation","lang":"${sessionScope.LANG}"}'
		+ ', {"id":"city_nm","name":"시도","name2":"City Province","lang":"${sessionScope.LANG}"}'
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems2(jsonCheck)) {
		return false;
	}

	/* 관심분야 체크 */
	var arry = [];
	arry = codeList(lFormValue.list1, arry);

	if(chkYn(arry) == "N") {
        alert("<spring:message code='join.form16' text='관심분야를 선택하세요.'/>");
		return false;
	}

	/* 종사분야 체크 */
	arry = [];
	arry = codeList(lFormValue.list2, arry);

	if(chkYn(arry) == "N") {
        alert("<spring:message code='join.form17' text='종사분야를 선택하세요.'/>");
		return false;
	}

	/* 업무(구매)권한 체크 */
	arry = [];
	arry = codeList(lFormValue.list3, arry);

	if(chkYn(arry) == "N") {
        alert("<spring:message code='join.form18' text='업무(구매)권한를 선택하세요.'/>");
		return false;
	}	

	/* 방문목적 체크 */
	arry = [];
	arry = codeList(lFormValue.list4, arry);


	if(chkYn(arry) == "N") {
        alert("<spring:message code='join.form19' text='방문목적을 선택하세요.'/>");
		return false;
	}	

	/* 인지경로 체크 */
	arry = [];
	arry = codeList(lFormValue.list5, arry);


	if(chkYn(arry) == "N") {
        alert("<spring:message code='join.form21' text='인지경로을 선택하세요.'/>");
		return false;
	}

	/* form값 global 변수에 입력 */
	gfnGetFormJSON();

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/mypage/member/update", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		console.log("message : " + message.result_code);

		if(message == "parsererror") {
            alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
				document.location.href="/member/login_form";
		}
		else if(message.result_code == 0) {
			fnSearch();
            alert("<spring:message code='mypage.member2' text='회원정보가 수정되었습니다.'/>");
		} else {
			if(message.session_yn == "N") {
                alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
				document.location.href="/index";
			} else {
                alert("<spring:message code='join.form2' text='서버 오류입니다.'/>"+"\r\n"+"<spring:message code='join.form3' text='잠시 후 다시 진행하시기 바랍니다.'/>");
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