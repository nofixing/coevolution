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
                  <spring:message code="left.menu.extend.privacy" text="개인정보 재동의"/>
                </strong>
              </h3>

              <div class="form-group col-sm-12 pt-2 pl-2 border" style="background-color: #FFF;">
                <div class="col-sm-12 pb-2" > 
                  <span class="small">
                  <c:if test="${sessionScope.LANG ne 'en'}">
                    ● 개인정보 재동의 시행 안내 
                  </c:if>
                  <c:if test="${sessionScope.LANG eq 'en'}">
                    ● Announcement about the extension of privacy consent period
                  </c:if>
                  </span>
                </div>
                <div class="col-sm-12"> 
                  <span class="small">
                      <c:if test="${sessionScope.LANG ne 'en'}">
                        <strong>버추얼 전시관 홈페이지는 개인정보 보호법에 따른 2년주기 개인정보 재동의</strong> 절차를 시행합니다.</span>
                      </c:if>
                      <c:if test="${sessionScope.LANG eq 'en'}">
                        <strong>This Virtual IEVE website implements the procedure of re-agreeing personal information every 2 years according to the Personal Information Protection Act.</strong>
                      </c:if>
                  <br>
                  <span class="small">
                      <c:if test="${sessionScope.LANG ne 'en'}">
                        <span style="color:red" id="cust_nm"></span> 님께서는 
                        <strong>
                          <span style="color:red" id="agree1_dt_end"></span>
                          <em class="red">까지</em>
                        </strong> 재동의 하지 않을 경우 
                        <em class="red">자동으로 회원 탈퇴 처리됨을 알려드립니다.</em>
                      </c:if>
                      <c:if test="${sessionScope.LANG eq 'en'}">
                        <input type="hidden" id="cust_nm" name="cust_nm">
                        If you don’t extend the Privacy Consent Period <em class="red">by <span style="color:red" id="agree1_dt_end"></span>, you will be automatically withdrawn.</em>
                      </c:if>
                  </span>
                </div>
              </div>
              
              <form class="form-styled">

                <div class="form-group text-left">
                  <!-- 개인정보 재동의 내용 -->
                  <div class="input-group">
                    <span class="col-sm-4 input-group-text border-0" style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small;"><spring:message code="form.privacy.consent.main.content" text="주요내용"/></span>
                    <span class="col-sm-8 input-group-text border-0 bg-white " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" >
                      <span id="agree1_dt_end2"></span>
                    </span>                    
                  </div>   
                  <div class="input-group">
                    <span class="col-sm-4 input-group-text border-0" style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small">
                      <spring:message code="form.privacy.consent.effective.date" text="개인정보 파기 및 탈퇴 처리 시행일자"/>
                    </span>
                    <span class="col-sm-8 input-group-text border-0 bg-white "  style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" id="agree1_dt_expr"></span>
                  </div>      
                  <div class="input-group">
                    <span class="col-sm-4 input-group-text border-0 " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small">
                      <spring:message code="form.privacy.consent.deleted" text="파기 대상 개인정보 항목"/>
                    </span>
                    <span class="col-sm-8 input-group-text border-0 bg-white text-left" style="white-space:normal;border-top:1px solid rgba(0,0,0,.1)!important; font-size: small">
                      <em class="cr">
                        <c:if test="${sessionScope.LANG ne 'en'}">
                          회원가입 시 입력한 모든 정보는 삭제 처리되고 아이디는 재사용 및 복구 불가능합니다.
                        </c:if>
                        <c:if test="${sessionScope.LANG eq 'en'}">
                          All information entered will be deleted and the ID will not be reused or recovered.
                        </c:if>
                      </em>
                    </span>
                  </div>    
                  <div class="input-group">
                    <span class="col-sm-4 input-group-text border-0 " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small">
                      <spring:message code="form.privacy.consent.statutes" text="관련법령"/>
                    </span>
                    <span class="col-sm-8 input-group-text border-0 bg-white text-left" style="white-space:normal;border-top:1px solid rgba(0,0,0,.1)!important; font-size: small">
                      <em class="cr">
                        <c:if test="${sessionScope.LANG ne 'en'}">
                          표준개인정보보호지침 제60조(개인정보파일 보유기간의 산정)<br>
                          제③항 정책고객, 홈페이지회원 등의 홍보 및 대국민서비스 목적의 외부고객 명부는 특별한 경우를 제외하고는 2년을 주기로 정보주체의 재동의 절차를 거쳐 동의한 경우에만 계속하여 보유할 수 있다.
                        </c:if>
                        <c:if test="${sessionScope.LANG eq 'en'}">
                          Article 60 of the Standard Privacy Guidelines (Estimation of the Period for Holding Personal Information Files)<br>
                          3. A list of external customers for the purpose of public relations and public service of policy customers, website members, etc. may be kept continuously only if they agree again through the process of the extension of the Privacy Consent Period every two years, except in special cases.
                        </c:if>

                      </em>
                    </span>
                  </div>                                     
                  
                  <div class="form-row justify-content-center">
  
                    <!-- Button -->
                    <div class="text-center text-md-right pt-3">
                      <a href="/mypage/myp061" class="basic-btn"><spring:message code="form.privacy.consent.extend.period" text="재동의 하기"/></a>
                      <a href="#divAgreeList" data-toggle="collapse" class="basic-btn-default"><spring:message code="form.privacy.consent.extension.history" text="재동의 이력보기"/></a>
                    </div>

                  </div> <!-- / .form-row -->   

                  <div class="form-row justify-content-center pt-5 collapse " id="divAgreeList">
                    <table class="table table-striped table-hover table-md border-bottom text-center">
                      <thead>
                        <tr>
                          <th><spring:message code="form.favorite.booths.no" text="번호"/></th>
                          <th><spring:message code="form.privacy.consent.date" text="가입일"/></th>
                          <th><spring:message code="form.privacy.consent.agreement" text="동의 일시"/></th>
                        </tr>
                      </thead>
                      <tbody id="tbodyAgree"></tbody>
                    </table>
                  </div>

                </div>  


              </form>

         

          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myp06_js.jsp"></jsp:include>

  </body>
</html>