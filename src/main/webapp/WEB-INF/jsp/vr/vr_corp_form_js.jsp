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
	
	//즐겨찾기
	$('#corpFavorit').on('click', function () {

        /* JSON 생성을 위해 입력*/
        gfnPutObj("favorts_cust_id", "${custInfo.cust_id}");

        /* global 변수 json으로 변환 */
        var pParamJson = gfnGetJson();

        sendForm("POST", "/vr/favorts/insert", "application/json; charset=utf-8", "json", pParamJson, function(message) {

            if(message == "parsererror") {
                alert("로그아웃되었습니다.");
                document.location.href="/m.do";
            } else  if(message.result_code == 0) {
                
                if(message.favorit_yn == "Y") {
                    lComm.setCssAdd("corpFavorit","text-warning");
                } else {
                    lComm.setCssRemove("corpFavorit","text-warning");
                }

            } else {
                if(message.result_code == (-999) || message == undefined) {
                    alert("로그인 후 사용할 수 있습니다.");
                } else {
                    alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
                }
            }

        });		

	});

	//관심뱃지
	$('#corpBadge').on('click', function () {
		
        /* JSON 생성을 위해 입력*/
        gfnPutObj("give_cust_id", "${custInfo.cust_id}");

        /* global 변수 json으로 변환 */
        var pParamJson = gfnGetJson();

        sendForm("POST", "/vr/badge/insert", "application/json; charset=utf-8", "json", pParamJson, function(message) {

            if(message == "parsererror") {
                alert("로그아웃되었습니다.");
                document.location.href="/m.do";
            } else  if(message.result_code == 0) {
                
                if(message.badge_yn == "Y") {
                    lComm.setCssAdd("corpBadge","text-warning");
                } else {
                    lComm.setCssRemove("corpBadge","text-warning");
                }

                setValue("tot_badge", message.tot_badge);

            } else {
                if(message.result_code == (-999) || message == undefined) {
                    alert("로그인 후 사용할 수 있습니다.");
                } else {
                    alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
                }
            }

        });	

	});    

    var pageURL = $(location).attr("href"); //info(nav1), brochure(nav2), gallery(nav3)

    if(pageURL.indexOf('#') > -1) {
        var anchor = pageURL.substring(pageURL.indexOf('#')+1, pageURL.length);

        if(anchor == "info") {
            
        } else if(anchor == "brochure") {
            $('#nav a[href="#nav2"]').tab('show');
            doPdfViewer();
        } else if(anchor == "gallery") {
            $('#nav a[href="#nav3"]').tab('show');
        } 
    } else {
        $('#nav a[href="#nav1"]').tab('show');
    }

});

function doPdfViewer (pUrl) {

    if(pUrl == "" || pUrl == undefined) {
        <c:forEach var="prod" items="${prodList}" varStatus="status">
            <c:if test="${status.index eq 0}">
                pUrl = "/files${prod.file_path}";
            </c:if>
        </c:forEach>
    }

    pUrl = "/js/pdfjs/web/viewer.html?file="+pUrl;
    var vHtml="<iframe src='"+pUrl+"' style='position: relative;   top: 0;  bottom: 0; left: 0;   width: 100%;   height: 500px;  border: 0'>";
    $("#pdfViewer").html(vHtml);
}

</script>