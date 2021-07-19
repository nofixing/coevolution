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
    <section class="section section-full section-top bg-light section-main">
        <div class="main-video">
            <video muted autoplay loop>
                <source src="/files/video/main-video.mp4" type="video/mp4">
            </video>
        </div>
        <!-- Content -->
        <div class="container">
            <div class="justify-content-center text-center">
                <div class="main-article">
                    <c:if test="${sessionScope.LANG eq 'en'}">
                     <div class="main-article-txt">
                         <p class="main-article-txt-1">2021 the 8th</p>
                         <p class="main-article-txt-1">International Electric Vehicle Expo</p>
                         <span>2021.09.07 (Tue) ~ 09.10 (Fri) <em>ICC JEJU</em></span>
                      </div>
                     <div class="main-article-btn">
                         <a href="/member/join_form1"><span><svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-badge-vr" viewBox="0 0 16 16">
                                              <path d="M14 3a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h12zM2 2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2H2z"/>
                                              <path d="M4.508 11h1.429l1.99-5.999H6.61L5.277 9.708H5.22L3.875 5.001H2.5L4.508 11zm6.387-5.999H8.5V11h1.173V8.763h1.064L11.787 11h1.327L11.91 8.583C12.455 8.373 13 7.779 13 6.9c0-1.147-.773-1.9-2.105-1.9zm-1.222 2.87V5.933h1.05c.63 0 1.05.347 1.05.989 0 .633-.408.95-1.067.95H9.673z"/>
                                            </svg></span><span>Virtual IEVE<br>Registration</span></a>
                         <a href="javascript:alert('To be updated soon.')"><span><svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
                                              <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                              <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
                                            </svg></span><span>Visitor Guide</span></a>
                     </div>
                    </c:if>
                    <c:if test="${sessionScope.LANG ne 'en'}">
                   <div class="main-article-txt">
                       <p class="main-article-txt-1">2021년 제8회</p>
                       <p class="main-article-txt-1">국제전기자동차엑스포</p>
                       <span>2021.09.07 (Tue) ~ 09.10 (Fri) <em>ICC JEJU</em></span>
                    </div>
                    <div class="main-article-btn">
                         <a href="/member/join_form1"><span><svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-badge-vr" viewBox="0 0 16 16">
                                              <path d="M14 3a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h12zM2 2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2H2z"/>
                                              <path d="M4.508 11h1.429l1.99-5.999H6.61L5.277 9.708H5.22L3.875 5.001H2.5L4.508 11zm6.387-5.999H8.5V11h1.173V8.763h1.064L11.787 11h1.327L11.91 8.583C12.455 8.373 13 7.779 13 6.9c0-1.147-.773-1.9-2.105-1.9zm-1.222 2.87V5.933h1.05c.63 0 1.05.347 1.05.989 0 .633-.408.95-1.067.95H9.673z"/>
                                            </svg></span><span>버추얼전시회<br>사전 참관 등록</span></a>
                         <a href="javascript:alert('준비중입니다.')"><span><svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
                                              <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                              <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
                                            </svg></span><span>관람가이드</span></a>
                     </div>
                    </c:if>
                </div>
            </div>
        </div> <!-- / .row -->
        </div> <!-- / .container -->

    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>

  </body>
</html>