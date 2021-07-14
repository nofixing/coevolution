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
			setSelectOption("country_cd", message.countrylist, "", "<spring:message code='join_form2.optional' text='선택'/>","","${sessionScope.LANG}");
			setValue("country_cd", "212029");

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
			
		} else {
            alert("<spring:message code='join.form2' text='서버 오류입니다.'/>"+"\r\n"+"<spring:message code='join.form3' text='잠시 후 다시 진행하시기 바랍니다.'/>");
		}

	});	
}

/* 추천인 검색 */
function fnRrcmderCustId() {
	var chk = '['
		+ '  {"id":"rcmder_cust_id","name":"추천인(ID)","name2":"Recommender(ID)","lang":"${sessionScope.LANG}"}';
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems2(jsonCheck)) {
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
                alert(getValue("rcmder_cust_id") + "<spring:message code='join.form8' text='은 추천인(ID)로 등록 가능합니다.'/>");

				/* ID 중복체크여부 임시저장 */
				lfnPutObj(lDataObjectPutGet, "rcmder_cust_id", getValue("rcmder_cust_id"));

			} else {
                alert("<spring:message code='join.form9' text='추천인ID를 정확하게 다시 입력해주세요.'/>");
				lComm.setFocus("cust_id");
			}
		} else {
            alert("<spring:message code='join.form7' text='[중복체크 오류]'/>"+"\r\n"+"<spring:message code='join.form3' text='잠시 후 다시 진행하시기 바랍니다.'/>");
			lComm.setFocus("cust_id");
		}

	});	
}

/* 회원가입 */
function fnSignUp() {

	/* 필수체크 */
	var chk = '['
        + '  {"id":"cust_nm","name":"이름","name2":"Name","lang":"${sessionScope.LANG}"}'
        + ', {"id":"company_nm","name":"소속","name2":"Affiliation","lang":"${sessionScope.LANG}"}'
        + ', {"id":"dept_nm","name":"부서","name2":"Department","lang":"${sessionScope.LANG}"}'
        + ', {"id":"hp_no","name":"전화번호","name2":"Phone number","lang":"${sessionScope.LANG}"}'
		//+ ', {"id":"tel_no","name":"연락처"}'
        + ', {"id":"email_id1","name":"이메일 주소","name2":"E-mail","lang":"${sessionScope.LANG}"}'
        + ', {"id":"email_id2","name":"이메일 주소","name2":"E-mail","lang":"${sessionScope.LANG}"}'
        + ', {"id":"country_cd","name":"국가","name2":"Nation","lang":"${sessionScope.LANG}"}'
        + ', {"id":"city_nm","name":"시도","name2":"City Province","lang":"${sessionScope.LANG}"}'
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems2(jsonCheck)) {
		return false;
	}

	/* 추천인 ID 체크 */
	if(getValue("rcmder_cust_id") != "") {
		if(lfnGetObj(lDataObjectPutGet, "rcmder_cust_id") != getValue("rcmder_cust_id")) {
            alert("<spring:message code='join.form14' text='인증받은 추천인ID가 같지 않습니다.'/>"+"\r\n"+"<spring:message code='join.form15' text='다시 추천인 검색을 진행하시기 바랍니다.'/>");
			return false;
		}
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

	if(getValue("email_id1") != "" && getValue("email_id2") != "") {
		gfnPutObj('email_id', getValue("email_id1")+"@"+getValue("email_id2"));
	} else if((getValue("email_id1") != "" && getValue("email_id2") == "") || (getValue("email_id1") == "" && getValue("email_id2") != "")) {
        alert("<spring:message code='join.form22' text='정확한 이메일 주소를 입력하세요.'/>");
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

        } else if(message.result_code == 1) {
            alert("<spring:message code='join.form23' text='이전 비밀번호와 현재 비밀번호가 같습니다.'/>");
        } else if(message.result_code == 2) {
            alert("<spring:message code='join.form24' text='비밀번호와 사용자ID가 같습니다.'/>");
        } else if(message.result_code == 3) {
            alert("<spring:message code='join.form25' text='비밀번호를 특수문자, 영문, 숫자 조합으로 입력하시기 바랍니다.'/>");
        } else if(message.result_code == 4) {
            alert("<spring:message code='join.form26' text='같은 문자를 연속하여 사용할 수 없습니다.'/>");
        } else if(message.result_code == 5) {
            alert("<spring:message code='join.form27' text='비밀번호에 공백이 있습니다.'/>");
        } else {
            alert("<spring:message code='join.form28' text='[참관신청 오류]'/>"+"\r\n"+"<spring:message code='join.form3' text='잠시 후 다시 진행하시기 바랍니다.'/>");
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

/* 관심사항에 대한 항목 */
function codeList(pList, pArray) {
	var str = "";
	for(var i = 0; i < pList.length; i++) {
		pArray.push("S"+pList[i].cd_id);
	}

	return pArray;
}

</script>