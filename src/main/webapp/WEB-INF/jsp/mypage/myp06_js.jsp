<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	
		if(message.result_code == 0) {
			setValue("cust_nm",message.data[0].cust_nm);
			//setValue("agree1_dtm_fm",message.data[0].agree1_dtm_fm);
			setValue("agree1_dt_end",message.data[0].agree1_dt_end);
			setValue("agree1_dt_end2",message.data[0].agree1_dt_end+"까지 정보제공 재동의 하지 않은 경우 회원 개인정보 삭제 및 자동 탈퇴처리");
			setValue("agree1_dt_expr",message.data[0].agree1_dt_expr);

			/*동의정보*/
			var vHtml = "";
			var list = message.agreeList;
			for(var i = 0; i < list.length; i++) {
				vHtml += "<tr><td>"+list[i].rn+"</td><td>"+list[i].ins_dt+"</td><td>"+list[i].agree_dtm+"</td></tr>";
			}

			if(list.length <= 0) {
				vHtml += "<tr><td colspan='3'>재동의 이력이 없습니다.</td></tr>";
			}

			$("#tbodyAgree").html(vHtml);

		} else {
			alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
		}

	});	
}

</script>