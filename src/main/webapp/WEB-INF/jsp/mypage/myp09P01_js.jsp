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

	//상담업체조회
	$('#btnCustInfo').on('click', function () {
		fnSearch();
	});

	$('#btnClose').on('click', function () {
		window.parent.parent.$('#showModal').modal('hide');
	});
	
});

function fnSearch() {

	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mypage/myp09P01";
	frm.submit();
}

function fnDetail(pCustId, pCustNm) {
	window.parent.parent.$('#consultCustId').val(pCustId);
	window.parent.parent.$('#consultCustNm').val(pCustNm);
	window.parent.parent.$('#showModal').modal('hide');
}

</script>