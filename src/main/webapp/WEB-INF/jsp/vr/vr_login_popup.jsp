<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>

    <script>

        $(document).ready(function() {

            <c:if test="${sessionScope.social_login_yn eq 'N'}">
                alert("<spring:message code='login.notMatch' text='일치하는 정보가 없습니다.'/>"+"\r\n"+"<spring:message code='login.notMatch2' text='소셜 회원가입 후 로그인하시기 바랍니다.'/>");
                <c:set var="social_login_yn" value="" scope="session" />
                window.close();
            </c:if>

            <c:if test="${login eq 'google'}">
                document.location.href="/oauth2/authorization/google";
            </c:if>
            <c:if test="${login eq 'facebook'}">
                document.location.href="/oauth2/authorization/facebook";
            </c:if>
            <c:if test="${login eq 'naver'}">
                document.location.href="/oauth2/authorization/naver";
            </c:if>
            <c:if test="${login eq 'kakao'}">
                document.location.href="/oauth2/authorization/kakao";
            </c:if>

            /* login 되었을 경우 */
            <c:if test="${login_id ne ''}">
                var return_url = decodeURIComponent("${sessionScope.vr_return_url}");
                opener.document.location.href=return_url;
                window.close();
            </c:if>
        });

    </script>

  </head>
  <body>

    <jsp:include page="/WEB-INF/jsp/include/footer_vr.jsp"></jsp:include>

  </body>
</html>
