<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>
  </head>
  <body>

  <!-- top Menu -->
  <jsp:include page="/WEB-INF/jsp/include/topMenu.jsp"></jsp:include>
    
  <!-- vr -->
  <c:if test="${sessionScope.LANG eq 'en'}">
    <iframe id="iframe" src="/ieve2021/ieve2021_eng/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
  </c:if>

  <c:if test="${sessionScope.LANG ne 'en'}">
    <iframe id="iframe" src="/ieve2021/ieve2021_kor/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
  </c:if>
  
  </body>
</html>