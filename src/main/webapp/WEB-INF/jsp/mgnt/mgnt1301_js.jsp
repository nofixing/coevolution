<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script language="javascript">

/**
 * Script 설정
 */
var lComm, lfnPutObj;
var lDataObjectPutGet = new Object(); /* Local Set Get */
$(document).ready(function() {

	lComm = new gfnComm();

	var today = lComm.getToday("-");
	
	/* 검색일자 셋팅 */
	if(getValue("ins_dt_fr") == "")
		setValue("ins_dt_fr", lComm.addDays(today, -30, "-"));
	
	if(getValue("ins_dt_to") == "")
		setValue("ins_dt_to", tolComm.addDays(today, 30, "-"));

	$('#btnSearch').on('click', function () {
		fnSearchMgnt13("1");
	});	

	$('#btnInsert').on('click', function () {
		var frm = document.forms[0];
		frm.method = "post";
		frm.action = "/mgnt/eventform";
		frm.submit();
	});	

    $('#btnExcel').on('click', function () {
        fnExcelMgnt13(1);
    });

	/* 총건수, 현재이지, view row, 호출할 function */
	var pageHtml = setPaging("${row_count}", "${page_current}", "${page_row_cnt}", "fnSearchMgnt13");	
	$('#pagingList').html(pageHtml);

});

function fnSearchMgnt13(pPageCurrent) {

	setValue("page_current", pPageCurrent);

	/* 필수항목 체크 */
	var chk = '['
		+ '  {"id":"ins_dt_fr","name":"조회 시작일자"} '
		+ ', {"id":"ins_dt_to","name":"조회 종료일자"} ';
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
	}

	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mgnt/event";
	frm.submit();

}


/* 조회 */
function fnExcelMgnt13(pPageCurrent) {

	setValue("page_current", pPageCurrent);

	/* 필수항목 체크 */
	var chk = '['
		+ '  {"id":"ins_dt_fr","name":"조회 시작일자"} '
		+ ', {"id":"ins_dt_to","name":"조회 종료일자"} ';
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
	}

	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mgnt/eventexcel";
	frm.submit();

}

/* 상세이동 */
function doDetail(pId) {
	var frm = document.forms[0];
	setValue("board_id", pId);

	frm.method = "post";
	frm.action = "/mgnt/eventform";
	frm.submit();
}

</script>