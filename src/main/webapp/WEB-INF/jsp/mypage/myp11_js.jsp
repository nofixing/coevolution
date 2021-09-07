<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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

    $('#btnSnd').on('click', function () {
		getStock();
    });

});

function getStock() {
    
    var isMobile = false;
    // PC 환경
    var filter = "win16|win32|win64|mac";

    if(navigator.platform){
       isMobile = filter.indexOf(navigator.platform.toLowerCase()) < 0;
    }

	var stockCode 	= "${list[0].ep_stock_code}";
	var cust_id 	= "${list[0].ep_cust_id}";
	var cust_seq 	= "${list[0].ep_cust_seq}";
	var hp_no 		= "${list[0].ep_hp}";
	var eventday 	= "${list[0].ep_stock_day}";

	if(stockCode == "") {
		alert("이벤트 참여 후 확인하실 수 있습니다.");
		return false;
	}
	
    var url="";
    if(isMobile == false){
     url = "http://direct-sks.com/expo?"+"stockCode="+stockCode+"&cust_id="+cust_id+"&cust_seq="+cust_seq+"&hp_no="+hp_no+"&event_day="+eventday;
    }else{
     url = "http://m.direct-sks.com/expo?"+"stockCode="+stockCode+"&cust_id="+cust_id+"&cust_seq="+cust_seq+"&hp_no="+hp_no+"&event_day="+eventday;
    }

	alert('이벤트에 참여되었습니다. 당첨정보를 정확하게 입력해주세요.');

	var options = 'width=500, height=600, top=30, left=30, resizable=no, scrollbars=no, location=no';

	window.open(url, "eventpop", options);

}


</script>