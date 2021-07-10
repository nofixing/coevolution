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
    
    <!-- FULLPAGE
    ================================================== -->
    <section class="section section-full section-top bg-light">

        <!-- Content -->
        <div class="container">
            <div class="justify-content-center text-center">
                <div class="main-img">
                    <c:if test="${sessionScope.LANG eq 'en'}">
                    <a href="/index/ieve2021">
                        <img src="/assets/img/icons/main-img_en.png" alt="">
                    </a>
                    </c:if>
                    <c:if test="${sessionScope.LANG ne 'en'}">
                    <a href="/index/ieve2021">
                        <img src="/assets/img/icons/main-img.png" alt="">
                    </a>
                    </c:if>
                </div>
            </div>
        </div> <!-- / .row -->
        </div> <!-- / .container -->

    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>

  </body>
</html>