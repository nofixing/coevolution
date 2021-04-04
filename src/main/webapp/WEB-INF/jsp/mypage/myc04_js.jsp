<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();

	$('#btnSearch').on('click', function () {
		//검색
		fnSearchMyc04("1");
	});	

	/* 총건수, 현재이지, view row, 호출할 function */
	var pageHtml = setPaging("${row_count}", "${page_current}", "${page_row_cnt}", "fnSearchMyc04");	
	$('#pagingList').html(pageHtml);

});

function fnSearchMyc04(pPageCurrent) {

	setValue("page_current", pPageCurrent);

	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mypage/conslt_list";
	frm.submit();	
}

/* 상세이동 */
function doDetail(pId) {
	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mypage/myc041?board_id="+pId;
	frm.submit();
}

</script>