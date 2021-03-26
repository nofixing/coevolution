<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {

	//초기 값 설정
	lComm = new gfnComm();
    
    $('#btnLogin').on('click', function () {
        document.location.href="/member/login_form";
    });	
});

</script>