<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

/**
 * Script 설정
 */
var lComm, lCodeList;
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();

	$('#btnCodeSearch').on('click', function () {
		fnSearchMgntCode();
	});	

	$('#btnCodeSave').on('click', function () {
		fnSaveMgntCode();
	});	

	$('#btnCodeNew').on('click', function () {
		fnNewMgntCode();
	});	

	$('#code_clsf1').on('change', function () {
		if(lComm.isNull(getValue("code_clsf1"))) {
			setSelectOption("code_clsf2", {}, "", "선택", "form1");
			setSelectOption("code_clsf3", {}, "", "선택", "form1");
		} else {
			searchCodeBody(getValue("code_clsf1"), "code_clsf2");
		}
	});

	$('#code_clsf2').on('change', function () {

		if(lComm.isNull(getValue("code_clsf2"))) {
			setSelectOption("code_clsf3", {}, "", "선택", "form1");
		} else {
			searchCodeBody(getValue("code_clsf2"), "code_clsf3");
		}

	});	

	searchCodeBody("init", "");
});

/*신규코드입력 폼*/
var levl = "";
function fnNewMgntCode() {

	var code_clsf1_nm = $("#code_clsf1 option:checked").text();
	var code_clsf2_nm = $("#code_clsf2 option:checked").text();

	var msg = "";
	var upperCd = "000000";
	if(lComm.isNull(getValue("code_clsf1"))) {
		msg += "대분류에 코드를 추가하시겠습니까?\r\n검색조건 대분류 선택 시 중분류를 입력할 수 있습니다.";
		levl = "1";
	} else if(lComm.isNull(getValue("code_clsf2"))) {
		msg += code_clsf1_nm + "코드에 대한 중분류 코드를 추가하시겠습니까?\r\n검색조건 중분류 선택 시 소분류를 입력할 수 있습니다.";
		upperCd = getValue("code_clsf1");
		levl = "2";
	} else if(!lComm.isNull(getValue("code_clsf2"))) {
		msg += code_clsf2_nm + "코드에 대한 소분류에 코드를 추가하시겠습니까?";
		upperCd = getValue("code_clsf2");
		levl = "3";
	}

	if(!confirm(msg)) {
		return false;
	}

	var vHtml = getCodeAddHtml(upperCd);

	gfnAlert ("", "", vHtml, function(rtnValue){
		searchCodeBody("init", "");
    });
}

/* 신규코드입력 */
function fnInsertMgntCode() {

	/* 필수체크 */
	var chk = '['
		+ '  {"id":"new_cd_nm","name":"코드명"}'
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
	}	

	gfnPutObj("cd_id", "");
	gfnPutObj("cd_nm", getValue("new_cd_nm"));
	gfnPutObj("upper_cd_id", getValue("new_upper_cd_id"));
	gfnPutObj("cd_val1", getValue("new_cd_val1"));
	gfnPutObj("cd_val2", getValue("new_cd_val2"));
	gfnPutObj("cd_val3", getValue("new_cd_val3"));
	gfnPutObj("priority", getValue("new_priority"));
	gfnPutObj("use_yn", getValue("new_use_yn"));
	gfnPutObj("levl", levl);

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/mgnt/codeInsert", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message == "parsererror") {
				alert("로그아웃되었습니다.");
				document.location.href="/m.do";
		} else if(message.result_code == 0) {
			alert("신규 코드를 저장하였습니다.");
		} else {
			alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
		}

	});		

}

/* 코드조회 */
function searchCodeBody(param1, param2) {

	/* JSON 생성을 위해 입력*/
	if(param1 == "init") {
		gfnPutObj("upper_cd_id", "000000");
	} else {
		gfnPutObj("upper_cd_id", param1);
	}

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/comm/code", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message.result_code == 0) {

			if(param1 == "init") {

				if("${code_clsf1}" == "") {
					setSelectOption("code_clsf1", message.codeList, "", "선택", "form1");
					setSelectOption("code_clsf2", {}, "", "선택", "form1");
					setSelectOption("code_clsf3", {}, "", "선택", "form1");
				}

			} else {
				setSelectOption(param2, message.codeList, "", "선택", "form1");
			} 
			
		} else {
			alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
		}

	});		
}


/* 조회 */
function fnSearchMgntCode() {
	
	/* 필수체크 */
	var chk = '['
		+ '  {"id":"code_clsf1","name":"대분류 코드"}'
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
	}

	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mgnt/codeList";
	frm.submit();
}

/* 코드삭제 */
function fnSaveMgntCode() {

	if(confirm("변경된 내용을 저장하시겠습니까?")) {

		/* form값 global 변수에 입력 */
		gfnGetFormJSON();

		/* global 변수 json으로 변환 */
		var pParamJson = gfnGetJson();

		sendForm("POST", "/mgnt/codeSave", "application/json; charset=utf-8", "json", pParamJson, function(message) {

			if(message == "parsererror") {
				alert("로그아웃되었습니다.");
				document.location.href="/m.do";
			} else if(message.result_code == 0) {
				fnSearchMgntCode();
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}

		});		
	}

}

/* 공통코드신규등록 */
function getCodeAddHtml(pUpperCd) {

	var vHtml = '';
	vHtml += '<div class="form-group">';
	vHtml += '	<div class="form-row justify-content-center">';
	vHtml += '		<table class="basic-table">';
	vHtml += '			<tr>';
	vHtml += '				<th>코드명</th>';
	vHtml += '				<td>';
	vHtml += '					<input type="text" class="form-control-sm" id="new_cd_nm" name="new_cd_nm" maxlength="50">';
	vHtml += '				</td>';
	vHtml += '				<th>상위코드</th>';
	vHtml += '				<td>';
	vHtml += '					<input type="text" class="form-control-sm" id="new_upper_cd_id" name="new_upper_cd_id" maxlength="6" readonly value="'+pUpperCd+'">';
	vHtml += '				</td>';
	vHtml += '			</tr>';
	vHtml += '			<tr>';
	vHtml += '				<th>값1</th>';
	vHtml += '				<td>';
	vHtml += '					<input type="text" class="form-control-sm" id="new_cd_val1" name="new_cd_val1" maxlength="50">';
	vHtml += '				</td>';
	vHtml += '				<th>값2</th>';
	vHtml += '				<td>';
	vHtml += '					<input type="text" class="form-control-sm" id="new_cd_val2" name="new_cd_val2" maxlength="50">';
	vHtml += '				</td>';
	vHtml += '			</tr>';
	vHtml += '			<tr>';
	vHtml += '				<th>값3</th>';
	vHtml += '				<td>';
	vHtml += '					<input type="text" class="form-control-sm" id="new_cd_val3" name="new_cd_val3" maxlength="50">';
	vHtml += '				</td>';
	vHtml += '				<th>순번</th>';
	vHtml += '				<td>';
	vHtml += '					<input type="number" class="form-control-sm" id="new_priority" name="new_priority" maxlength="3">';
	vHtml += '				</td>';
	vHtml += '			</tr>';
	vHtml += '			<tr>';
	vHtml += '				<th>사용여부</th>';
	vHtml += '				<td>';
	vHtml += '					<select class="form-control-sm" id="new_use_yn" name="new_use_yn"><option value="Y">Y</option><option value="N">N</option></select>';
	vHtml += '				</td>';
	vHtml += '				<th></th>';
	vHtml += '				<td></td>';
	vHtml += '			</tr>';
	vHtml += '		</table>';
	vHtml += '		<button type="button" class="btn-outline-primary form-control form-control-sm mt-4" style="width: 100px;" onClick="fnInsertMgntCode()">저장</button>';
	vHtml += '	</div>';
	vHtml += '</div>';

	return vHtml;
}

</script>