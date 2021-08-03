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
        });
        
    </script>

  </head>
  <body>

    <jsp:include page="/WEB-INF/jsp/include/footer_vr.jsp"></jsp:include>

  </body>
</html>
