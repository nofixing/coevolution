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

	/* 목록이동 */
	$('#btnSearch').on('click', function () {
		fnSearchMgnt12("1");
	});

	/* 총건수, 현재이지, view row, 호출할 function */
	var pageHtml = setPaging("${row_count}", "${page_current}", "${page_row_cnt}", "fnSearchMgnt12");	
	$('#pagingList').html(pageHtml);

});

function fnSearchMgnt12(pPageCurrent) {

	setValue("page_current", pPageCurrent);

	/* 필수항목 체크 */
	var chk = '['
		+ '  {"id":"consult_dt_fr","name":"검색 시작일자"} '
		+ ', {"id":"consult_dt_to","name":"검색 종료일자"} ';
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
	}

	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mgnt/conslt_list";
	frm.submit();

}


</script>