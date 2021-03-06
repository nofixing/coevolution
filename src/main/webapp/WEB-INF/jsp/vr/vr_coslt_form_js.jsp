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
	var yyyyMMdd = lComm.getToday("-");
	
	//상담저장
	$('#btnSave').on('click', function () {

        /* 필수항목 체크 */
        var chk = '['
            + '  {"id":"board_subject","name":"제목"} '
            + ', {"id":"board_content","name":"내용"} ';
        chk += ']';

        var jsonCheck = JSON.parse(chk);

        if(!lComm.fnRequiredItems(jsonCheck)) {
            return false;
        }

        /* JSON 생성을 위해 입력*/
        gfnPutObj("board_subject", getValue("board_subject"));
        gfnPutObj("board_content", getValue("board_content"));
        gfnPutObj("conslt_cust_id", "${custInfo.cust_id}");

        /* global 변수 json으로 변환 */
        var pParamJson = gfnGetJson();

        sendForm("POST", "/vr/conslt/insert", "application/json; charset=utf-8", "json", pParamJson, function(message) {

            if(message == "parsererror") {
                alert("로그아웃되었습니다.");
                document.location.href="/m.do";
            } else if(message.result_code == 0) {
                alert("상담등록이 완료되었습니다.");
            } else {
                if(message == undefined) {
                    alert("로그인 후 사용할 수 있습니다.");
                } else {
                    alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
                }
            }

        });	

	});


});

</script>