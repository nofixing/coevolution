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
              <spring:message code="left.menu.extend.privacy" text="개인정보 재동의"/>
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
              <spring:message code="left.menu.extend.privacy" text="개인정보 재동의"/>
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>
    
        <!-- CONTENT
    ================================================== -->
    <section class="section pt-0">
      <div class="container mt-block">

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
                  <spring:message code="left.menu.extend.privacy" text="개인정보 재동의"/>
                </strong>
              </h3>
              
              <form class="form-styled">

                <div class="register_section">
                  <h4><strong><spring:message code="terms.and.conditions" text="이용약관"/><spring:message code="join_form2.required" text="(필수)"/></strong></h4>
                  <div class="register_section_area" id="agree_1_contents">
                    <c:if test="${sessionScope.LANG ne 'en'}">
                      ${agree1_contents}
                    </c:if>
                    <c:if test="${sessionScope.LANG eq 'en'}">
                      ${agree1_contents_en}
                    </c:if>  
                  </div>
                  <div class="custom-control custom-checkbox">
                    <input type="checkbox" value="Y" name="agree_1" id="agree_1" class="custom-control-input">
                    <label class="custom-control-label" for="agree_1"><spring:message code="terms.and.conditions.agreement" text="이용약관에 동의합니다."/><spring:message code="join_form2.required" text="(필수)"/></label>
                  </div>
                </div>
                <div class="register_section">
                  <h4><strong><spring:message code="pirvate.policy" text="개인정보처리방침안내"/><spring:message code="join_form2.required" text="(필수)"/></strong></h4>
                  <div class="register_section_area" id="agree_2_contents">
                    <c:if test="${sessionScope.LANG ne 'en'}">
                      ${agree2_contents}
                    </c:if>
                    <c:if test="${sessionScope.LANG eq 'en'}">
                      ${agree2_contents_en}
                    </c:if> 
                  </div>
                  <div class="custom-control custom-checkbox">
                    <input type="checkbox" value="Y" name="agree_2" id="agree_2" class="custom-control-input">
                    <label class="custom-control-label" for="agree_2"><spring:message code="pirvate.policy.agreement" text="개인정보처리방침에 동의합니다."/><spring:message code="join_form2.required" text="(필수)"/></label>
                  </div>
                </div>
                <div class="register_page">
                    <button type="button" class="register_page_submit" id="btnAgree"><spring:message code="form.confirm" text="확인"/></button>
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