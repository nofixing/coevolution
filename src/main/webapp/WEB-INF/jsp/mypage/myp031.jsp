<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="ko">
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
              <spring:message code="left.menu.consultation" text="1:1 상담"/>
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
              <spring:message code="left.menu.consultation" text="1:1 상담"/>
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
                  <spring:message code="left.menu.consultation" text="1:1 상담"/>
                </strong>
              </h3>

              <form class="form-styled">
                <div class="form-row col-sm-12 border-bottom pt-2 pl-2">
                  <div class="col-sm-12"> <span id="board_subject"></span> </div>
                </div>
                
                <div class="form-row col-sm-12 border-bottom p-2">
                  <div class="col-sm-6 small"><spring:message code="form.consultation.booths" text="부스명"/> | <span id="conslt_cust_nm"></span> </div>
                  <div class="col-sm-3 small"><spring:message code="form.consultation.date" text="등록일"/> | <span id="reg_dt"></span></div>
                  <div class="col-sm-3 small"><spring:message code="form.consultation.status" text="상태"/> | <span><em class="basic-em" id="board_stat_nm"></em></span></div>
                </div>

                <div class="form-row col-sm-12 border-bottom p-2" id="board_content" style="white-space:pre-wrap"></div>              

                <div class="form-row col-sm-12 pt-3 justify-content-between">
                  <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnList"><spring:message code="form.consultation.list" text="목록"/></button>
                  <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnDtl"><spring:message code="form.consultation.delete" text="삭제"/></button>
                </div>
                
                <div class="form-row col-sm-12 border-bottom pt-3 pl-2">
                  <div class="col-sm-12"> <strong><spring:message code="form.consultation.reply" text="답변내용"/></strong></div>
                </div>  
                
                <div class="form-row col-sm-12 border-bottom p-2">
                  <div class="col-sm-5 small"><spring:message code="form.consultation.reply.date" text="답변일자"/> | <span id="board_reply_ins_dtm"></span></div>
                </div>    
                <div class="form-row col-sm-12 border-bottom p-2" id="board_reply_content" style="white-space:pre-wrap"></div>               
              </div>

            </form>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myp031_js.jsp"></jsp:include>

  </body>
</html>