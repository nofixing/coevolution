<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {

	//초기 값 설정
	lComm = new gfnComm();
    
    // 기본적으로 세팅 하기
    $(".find_box").hide(); 
    $(".find_box:first").show(); 

    // 클릭 이벤트 발생
    $(".find_tab a").click(function () { 
        // 클릭 이벤트 한 영역 css 변경
        $(".find_tab a").removeClass("on"); 
        $(this).addClass("on"); 
        
        // 클릭 한 요소의 인덱스 담기 (li의 인덱스)
        var test = $(this).index(); 
        
        // 나타내기
        $(".find_box").hide(); 
        $(".find_area > div").eq(test).fadeIn(200); 
    });

});

</script>