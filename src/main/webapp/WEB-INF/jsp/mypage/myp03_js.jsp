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

	/* 페이징처리 (총페이지, 현재페이지)*/
	var pagingList = setPaging("${row_count}", "${page_current}");
	$('#pagingList').html(pagingList) ;

});

/* 상세이동 */
function doDetail(pId) {
	var frm = document.forms[0];
	frm.method = "post";
	frm.action = "/mypage/myp031?board_id="+pId;
	frm.submit();
}

</script>