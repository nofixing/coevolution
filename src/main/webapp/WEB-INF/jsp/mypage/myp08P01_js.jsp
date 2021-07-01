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

	//상담취소처리
	$('#btnConsultCancel').on('click', function () {
		document.location.href="/mypage/myp08P02?schedule_id=${schedule_id}";
	});

	$('#btnClose').on('click', function () {
		window.parent.parent.$('#showModal').modal('hide');
	});
	
});


</script>