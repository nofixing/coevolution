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

<!-- BREADCRUMB
    ================================================== -->
    <nav class="breadcrumb">
      <div class="container">
        <div class="row align-items-center">
          <div class="col">
            
            <!-- Heading -->
            <h5 class="breadcrumb-heading">
              <spring:message code="join_form2.visitor.registration" text="참관등록"/>
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="/index">Home</a>
            </span>
            <span class="breadcrumb-item active">
              <spring:message code="join_form2.visitor.registration" text="참관등록"/>
            </span>
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>    

    <section class="section section-full section-top">
      <!-- Form -->
      <form>
        <div class="form">
            <div class="form_head">
                <p><spring:message code="join_form2.visitor.registration" text="참관등록"/></p>
            </div>
            <div class="join_inner">
                <div class="register_head clearfix">
                    <!-- <p class="register_head_tit">약관동의<span>* 회원가입약관 및 개인정보처리방침안내의 내용에 동의하셔야 회원가입 하실 수 있습니다.</span></p> -->
                    <ul class="register_seq">
                      <li  class="on"><span>Step 01</span> <spring:message code="join_form.step.01" text="약관동의"/></li>
                      <li><span>Step 02</span> <spring:message code="join_form.step.02" text="정보입력"/></li>
                      <li><span>Step 03</span> <spring:message code="join_form.step.03" text="가입완료"/></li>
                    </ul>
                </div>
                <div class="form_inner">
                    <div class="register_section">
                        <h4><strong><spring:message code="terms.and.conditions" text="이용약관"/><spring:message code="join_form2.required" text="(필수)"/></strong></h4>
                        <div class="register_section_area">
                          <c:if test="${sessionScope.LANG ne 'en'}">
                            ${agree1_contents}
                          </c:if>
                          <c:if test="${sessionScope.LANG eq 'en'}">
                            ${agree1_contents_en}
                          </c:if>
                        </div>
                      <div class="custom-control custom-checkbox">
                        <input type="checkbox" id="agree_1" name="agree_1" value="Y" class="custom-control-input">
                        <label class="custom-control-label" for="agree_1"><spring:message code="terms.and.conditions.agreement" text="이용약관에 동의합니다."/><spring:message code="join_form2.required" text="(필수)"/></label>
                      </div>
                    </div>
                    <div class="register_section">
                      <h4><strong><spring:message code="pirvate.policy" text="개인정보처리방침안내"/><spring:message code="join_form2.required" text="(필수)"/></strong></h4>
                        <div class="register_section_area">
                          <c:if test="${sessionScope.LANG ne 'en'}">
                            ${agree2_contents}
                          </c:if>
                          <c:if test="${sessionScope.LANG eq 'en'}">
                            ${agree2_contents_en}
                          </c:if>                        
                        </div>
                        <div class="custom-control custom-checkbox">
                          <input type="checkbox" id="agree_2" name="agree_2" value="Y" class="custom-control-input">
                          <label class="custom-control-label" for="agree_2"><spring:message code="pirvate.policy.agreement" text="개인정보처리방침에 동의합니다."/><spring:message code="join_form2.required" text="(필수)"/></label>
                        </div>
                    </div>
                    <div class="register_section">
                        <h4><strong><spring:message code="join_form2.marketing.promotion" text="개인정보 마케팅 활용 동의"/><spring:message code="join_form2.optional" text="(선택)"/></strong></h4>
                        <div class="register_section_area">
                          <c:if test="${sessionScope.LANG ne 'en'}">
                            ${agree3_contents}
                          </c:if>
                          <c:if test="${sessionScope.LANG eq 'en'}">
                            ${agree3_contents_en}
                          </c:if>  
                        </div>
                        <div class="custom-control custom-checkbox">
                          <input type="checkbox" id="agree_3" name="agree_3" value="Y" class="custom-control-input">
                          <label class="custom-control-label" for="agree_3"><spring:message code="join_form2.marketing.promotion.agreement" text="개인정보 마케팅 활용에 동의합니다."/><spring:message code="join_form2.optional" text="(선택)"/></label>
                        </div>
                    </div>
                    <div class="register_section">
                      <div class="custom-control custom-checkbox">
                        <input type="checkbox" id="agree-all" class="custom-control-input">
                        <label class="custom-control-label" for="agree-all"><strong><spring:message code="join_form2.fully.agree" text="모든 약관을 확인하고 전체 동의합니다."/></strong></label>
                      </div>
                    </div>
                    <div class="register_page">
                        <button type="button" class="register_page_submit" id="btnSignUp">
                          <spring:message code="join_form2.register" text="회원가입"/>
                        </button>                        
                    </div>
                </div>
            </div>
        </div>
      </form>
    </section>


    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="join_form2_js.jsp"></jsp:include>

  </body>
</html>