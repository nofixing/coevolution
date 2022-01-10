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

	$('#btnSearch').on('click', function () {
		fnSearchMgnt08(1);
	});	

    $('#btnExcel').on('click', function () {
        fnExcelMgnt08(1);
    });

    $('#ev_expo_id').on('change', function () {
        fnExpoIdChange();
    });

	

	/* 총건수, 현재이지, view row, 호출할 function */
	var pageHtml = setPaging("${row_count}", "${page_current}", "${page_row_cnt}", "fnSearchMgnt08");	
	$('#pagingList').html(pageHtml);		

});

function fnSearchMgnt08(pPageCurrent) {

	setValue("page_current", pPageCurrent);

	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mgnt/booth";
	frm.submit();

}

function fnExcelMgnt08(pPageCurrent) {
    var frm = document.forms[0];
    frm.method = "post";
    frm.action = "/mgnt/booth_xlsx";
    frm.submit();

}

function fnExpoIdChange() {

	/* JSON 생성을 위해 입력*/
	gfnPutObj("UPPER_CD", "106000");
	gfnPutObj("USE_YN", "Y");
	gfnPutObj("CD_VAL2", getValue("ev_expo_id"));

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/member/com_cd", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message.result_code == 0) {
			setSelectOption("category1", message.C106000, "", "전체","form1");
		} else {
			alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
		}

	});	
	
}


</script>