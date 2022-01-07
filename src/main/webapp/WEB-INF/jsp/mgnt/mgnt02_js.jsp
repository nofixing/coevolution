<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();

	var today = lComm.getToday("-");
	
	/* 검색일자 셋팅 */
	if(getValue("ins_dt_fr") == "")
		setValue("ins_dt_fr", lComm.addDays(today, -30, "-"));
	
	if(getValue("ins_dt_to") == "")
		setValue("ins_dt_to", today);

	$('#btnSearch').on('click', function () {
		fnSearchMgnt02("1");
	});	

	/* 총건수, 현재이지, view row, 호출할 function */
	var pageHtml = setPaging("${row_count}", "${page_current}", "${page_row_cnt}", "fnSearchMgnt02");	
	$('#pagingList').html(pageHtml);		
	
});

function fnSearchMgnt02(pPageCurrent) {

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
	frm.action = "/mgnt/conslt";
	frm.submit();

}


/* 상세이동 */
function doDetail(pId) {

	setValue("board_id", pId);

	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mgnt/conslt_dtl";
	frm.submit();
}

</script>