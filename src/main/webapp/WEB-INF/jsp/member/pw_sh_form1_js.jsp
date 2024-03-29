<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {

	//초기 값 설정
	lComm = new gfnComm();

    //이벤트
    $('#btnPwInit').on('click', function () {
        //로그인체크

        /* 필수항목 체크 */
        var chk = '['
            + '  {"id":"cust_id","name":"아이디","name2":"ID","lang":"${sessionScope.LANG}"} '
            + ', {"id":"email_id","name":"이메일","name2":"E-mail","lang":"${sessionScope.LANG}"} ';
        chk += ']';

        var jsonCheck = JSON.parse(chk);

        if(!lComm.fnRequiredItems2(jsonCheck)) {
            return false;
        }

        /* form값 global 변수에 입력 */
        gfnGetFormJSON();

        /* global 변수 json으로 변환 */
        var pParamJson = gfnGetJson();

        //console.log("pParamJson : " + pParamJson);

        sendForm("POST", "/member/passwd_init", "application/json; charset=utf-8", "json", pParamJson, function(message) {

            if(message.result_code == 0) {
                document.location.href="/member/pw_sh_form2";
            } else {
                alert("<spring:message code='join.form30' text='처리중 오류가 발생하였습니다.'/>"+"\r\n"+"<spring:message code='join.form31' text='관리자에게 문의해 주십시오.'/>");
            }

        });

    });
    
});

</script>