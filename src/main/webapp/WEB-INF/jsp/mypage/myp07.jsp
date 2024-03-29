<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

    <!-- BREADCRUMB
    ================================================== -->
    <nav class="breadcrumb">
      <div class="container">
        <div class="row align-items-center">
          <div class="col">
            
            <!-- Heading -->
            <h5 class="breadcrumb-heading">
              <spring:message code="left.menu.withdrawal" text="회원탈퇴"/>
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="/index">Home</a>
            </span>
            <span class="breadcrumb-item active">
              <spring:message code="left.menu.mypage" text="마이페이지"/>
            </span>
            <span class="breadcrumb-item active">
              <spring:message code="left.menu.withdrawal" text="회원탈퇴"/>
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>
    
    <!-- CONTENT
    ================================================== -->
    <section class="section pt-0 mt-block">
      <div class="container">

        <div class="row">

          <div class="col-xl-3" id="gLeftMenu">
            <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/pLeftMenu.jsp"></jsp:include>
          </div>

          <div class="col-xl-9">


            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mt-4 mb-4">
                <strong>
                  <spring:message code="left.menu.withdrawal" text="회원탈퇴"/>
                </strong>
              </h3>              
              <form class="form-styled">

                <div class="form-group">
                  <!-- 회원 탈퇴 내용 -->
                  <div class="text-center">
                    <c:if test="${sessionScope.LANG ne 'en'}">
                      <span class="small">그동안 국제전기자동차엑스포 버추얼전시회를 이용해 주셔서 진심으로 감사합니다. </span><br>
                      <span class="small">사이트 이용 시 불편했거나 부족했던 부분을 알려주시면 더 좋은 모습으로 찾아 뵙기 위해 노력하겠습니다.</span>
                    </c:if>
                    <c:if test="${sessionScope.LANG eq 'en'}">
                      <span class="small">Thank you very much for joining the Virtual International Electric Vehicle Expo.</span><br>
                      <span class="small">If you let me know what was uncomfortable or lacking when using the site, I will try to come back with better features.</span>
                    </c:if>
                  </div>
                  <div class="input-group mt-3">
                    <input type="text" class="form-control form-control-sm mb-4" id="member_wdrwl_rsn" maxlength="100" placeholder="<spring:message code='form.withdrawal.characters' text='최대 100자 까지 입력 가능합니다.'/>">
                  </div>   

                  <div class="form-row justify-content-center">
  
                    <!-- Button -->
                    <div class="text-center text-md-right p-1">
                      <button type="button" class="basic-btn-default" id="btnWdrwl"><spring:message code="form.withdraw" text="탈퇴하기"/></button>
                      <!--button type="button" class="basic-btn">취소하기</button-->
                    </div>

                  </div> <!-- / .form-row -->   

                </div>  


              </form>

         

          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myp07_js.jsp"></jsp:include>

  </body>
</html>