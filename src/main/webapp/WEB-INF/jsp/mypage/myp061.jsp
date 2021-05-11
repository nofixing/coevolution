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
              개인정보 재동의
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="/index">Home</a>
            </span>
            <span class="breadcrumb-item active">
              마이페이지
            </span>
            <span class="breadcrumb-item active">
              개인정보 재동의
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>
    
        <!-- CONTENT
    ================================================== -->
    <section class="section pt-0">
      <div class="container">

        <div class="row">
          <div class="col-md-3">
            
            <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/pLeftMenu.jsp"></jsp:include>
          </div>

          <div class="col-md-9">


            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mt-4 mb-4">
                <strong>
                  개인정보 재동의에 따른 약관 동의
                </strong>
              </h3>
              
              <form class="form-styled">

                <div class="register_section">
                  <h4><strong>이용약관(필수)</strong></h4>
                  <div class="register_section_area" id="agree_1_contents">${agree1_contents}</div>
                  <div class="custom-control custom-checkbox">
                    <input type="checkbox" value="Y" name="agree_1" id="agree_1" class="custom-control-input">
                    <label class="custom-control-label" for="agree_1">이용약관에 동의합니다.(필수)</label>
                  </div>
                </div>
                <div class="register_section">
                  <h4><strong>개인정보처리방침안내(필수)</strong></h4>
                  <div class="register_section_area" id="agree_2_contents">${agree2_contents}</div>
                  <div class="custom-control custom-checkbox">
                    <input type="checkbox" value="Y" name="agree_2" id="agree_2" class="custom-control-input">
                    <label class="custom-control-label" for="agree_2">개인정보처리방침에 동의합니다.(필수)</label>
                  </div>
                </div>
                <div class="register_page">
                    <button type="button" class="register_page_submit" id="btnAgree">확인</button>
                </div>

              </form>

          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myp061_js.jsp"></jsp:include>

  </body>
</html>