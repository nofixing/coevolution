<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();

	fnInit();

});

/* 동의정보 조회 */
function fnInit() {
	sendForm("POST", "/mypage/member/agree_search", "application/json; charset=utf-8", "json", "{}", function(message) {
	
		if(message == "parsererror") {
            alert("<spring:message code='mypage.member' text='로그아웃되었습니다.'/>");
            document.location.href="/member/login_form";
		}
		else if(message.result_code == 0) {
			setValue("cust_nm",message.data[0].cust_nm);
			//setValue("agree1_dtm_fm",message.data[0].agree1_dtm_fm);
			
			<c:if test="${sessionScope.LANG ne 'en'}">
				setValue("agree1_dt_end2",message.data[0].agree1_dt_end+"까지 정보제공 재동의 하지 않은 경우 회원 개인정보 삭제 및 자동 탈퇴처리");
			</c:if>
			<c:if test="${sessionScope.LANG eq 'en'}">
				setValue("agree1_dt_end2","If the Privacy Consent Period is not extended by "+message.data[0].agree1_dt_end+", the deletion of the personal information of the member and the automatic withdrawal will be processed.");
			</c:if>

			setValue("agree1_dt_end",message.data[0].agree1_dt_end);
			setValue("agree1_dt_expr",message.data[0].agree1_dt_expr);

			/*동의정보*/
			var vHtml = "";
			var list = message.agreeList;
			for(var i = 0; i < list.length; i++) {
				vHtml += "<tr><td>"+list[i].rn+"</td><td>"+list[i].ins_dt+"</td><td>"+list[i].agree_dtm+"</td></tr>";
			}

			if(list.length <= 0) {
				vHtml += "<tr><td colspan='3'><spring:message code='mypage.member5' text='재동의 이력이 없습니다.'/></td></tr>";
			}

			$("#tbodyAgree").html(vHtml);

		} else {
            alert("<spring:message code='join.form2' text='서버 오류입니다.'/>"+"\r\n"+"<spring:message code='join.form3' text='잠시 후 다시 진행하시기 바랍니다.'/>");
		}

	});	
}

</script>