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

        // 기본적으로 세팅 하기
        $(".find_box").hide();
        $(".find_box:first").show();

        var pageURL = $(location).attr("href");

        if(pageURL.indexOf('#') > -1) {
            $(".find_tab a").removeClass("on");
            $(".find_tab a:last").addClass("on");
            $(".find_box").hide();
            $(".find_box:last").show();
        }

        //alert(pageURL);

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

        $('#btnIdFind').on('click', function () {

            /* 필수항목 체크 */
            var chk = '['
                + '  {"id":"cust_nm","name":"이름","name2":"Name","lang":"${sessionScope.LANG}"} '
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

            console.log("pParamJson : " + pParamJson);

            sendForm("POST", "/member/search_id", "application/json; charset=utf-8", "json", pParamJson, function(message) {

                if(message.result_code == 0) {
                    document.location.href="/member/id_sh_form2?id="+message.cust_id;
                } else {
                    alert("<spring:message code='login.notMatchID' text='입력하신 정보에 해당하는 아이디가 없습니다.'/>"+"\r\n"+"<spring:message code='login.notMatchID2' text='다시 시도하시거나 관리자에게 문의해 주십시오.'/>");
                }

            });

        });

        $('#btnPwFind').on('click', function () {

            console.log("btnPwFind click");

            /* 필수항목 체크 */
            var chk = '['
                + '  {"id":"cust_id_pw","name":"아이디","name2":"ID","lang":"${sessionScope.LANG}"} '
                + ', {"id":"cust_nm_pw","name":"이름","name2":"Name","lang":"${sessionScope.LANG}"} '
                + ', {"id":"email_id_pw","name":"이메일","name2":"E-mail","lang":"${sessionScope.LANG}"} ';
            chk += ']';

            var jsonCheck = JSON.parse(chk);

            //return false;

            if(!lComm.fnRequiredItems2(jsonCheck)) {
                console.log("fnRequiredItems break");
                return false;
            }

            /* form값 global 변수에 입력 */
            gfnGetFormJSON();

            /* global 변수 json으로 변환 */
            var pParamJson = gfnGetJson();

            console.log("pParamJson : " + pParamJson);
            //return false;
            sendForm("POST", "/member/passwd_init", "application/json; charset=utf-8", "json", pParamJson, function(message) {

                if(message.result_code == 0) {
                    alert("success");
                    //document.location.href="/member/pw_sh_form2";
                } else {
                    alert("<spring:message code='join.form30' text='처리중 오류가 발생하였습니다.'/>"+"\r\n"+"<spring:message code='join.form31' text='관리자에게 문의해 주십시오.'/>");
                }

            });


        });

    });

    function idFind() {
        /* 필수항목 체크 */
        var chk = '['
            + '  {"id":"cust_nm","name":"이름","name2":"Name","lang":"${sessionScope.LANG}"} '
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

        console.log("pParamJson : " + pParamJson);

        sendForm("POST", "/member/search_id", "application/json; charset=utf-8", "json", pParamJson, function(message) {

            if(message.result_code == 0) {
                document.location.href="/member/id_sh_form2?id="+message.cust_id;
            } else {
                alert("<spring:message code='login.notMatchID' text='입력하신 정보에 해당하는 아이디가 없습니다.'/>"+"\r\n"+"<spring:message code='login.notMatchID2' text='다시 시도하시거나 관리자에게 문의해 주십시오.'/>");
            }

        });
    }

    function pwFind() {
        console.log("btnPwFind click");

        /* 필수항목 체크 */
        var chk = '['
            + '  {"id":"cust_id_pw","name":"아이디","name2":"ID","lang":"${sessionScope.LANG}"} '
            + ', {"id":"cust_nm_pw","name":"이름","name2":"Name","lang":"${sessionScope.LANG}"} '
            + ', {"id":"email_id_pw","name":"이메일","name2":"E-mail","lang":"${sessionScope.LANG}"} ';
        chk += ']';

        var jsonCheck = JSON.parse(chk);

        //return false;

        if(!lComm.fnRequiredItems2(jsonCheck)) {
            console.log("fnRequiredItems break");
            return false;
        }

        /* form값 global 변수에 입력 */
        gfnGetFormJSON();

        /* global 변수 json으로 변환 */
        var pParamJson = gfnGetJson();

        console.log("pParamJson : " + pParamJson);
        //return false;
        sendForm("POST", "/member/passwd_init", "application/json; charset=utf-8", "json", pParamJson, function(message) {

            if(message.result_code == 0) {
                document.location.href="/member/id_sh_form3";
            } else {
                alert("<spring:message code='login.notMatchID' text='입력하신 정보에 해당하는 아이디가 없습니다.'/>"+"\r\n"+"<spring:message code='login.notMatchID2' text='다시 시도하시거나 관리자에게 문의해 주십시오.'/>");
            }

        });
    }

</script>