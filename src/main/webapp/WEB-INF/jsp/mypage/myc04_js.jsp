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
		var frm = document.forms[0];
		frm.method = "post";
		frm.action = "/mypage/conslt_list";
		frm.submit();
	});	

});

/* 상세이동 */
function doDetail(pId) {
	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mypage/myc041?board_id="+pId;
	frm.submit();
}

</script>