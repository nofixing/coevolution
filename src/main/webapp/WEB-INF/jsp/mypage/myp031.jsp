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
              상담문의 내역
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="#">Home</a>
            </span>
            <span class="breadcrumb-item active">
              마이페이지
            </span>
            <span class="breadcrumb-item active">
              상담문의 내역
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>
    
    <!-- CONTENT
    ================================================== -->
    <section class="section pt-4">
      <div class="container">
        <div class="row">
          <div class="col-md-2">
            
            <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/pLeftMenu.jsp"></jsp:include>

          </div>
          <div class="col-md-10">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mb-4">
                상담문의 내역
              </h3>

              <form class="form-styled">
                <input type="hidden" id="board_id"/>
                <div class="form-row col-sm-12 border-bottom pt-2 pl-2">
                  <div class="col-sm-12"> <span id="board_subject"></span> </div>
                </div>
                
                <div class="form-row col-sm-12 border-bottom p-2">
                  <div class="col-sm-6 small">부스명 | <span id="conslt_cust_nm"></span> </div>
                  <div class="col-sm-3 small">등록일 | <span id="reg_dt"></span></div>
                  <div class="col-sm-3 small">상태 | <span id="board_stat_nm"></span></div>
                </div>

                <div class="form-row col-sm-12 border-bottom p-2" id="board_content">
                </div>              

                <div class="form-row col-sm-12 pt-3 justify-content-between">
                  <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnList">목록</button>
                  <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnDtl">삭제</button>
                </div>
                
                <div class="form-row col-sm-12 border-bottom pt-3 pl-2">
                  <div class="col-sm-12"> <strong>답변내용</strong></div>
                </div>  
                
                <div class="form-row col-sm-12 border-bottom p-2">
                  <div class="col-sm-5 small">답변일자 | <span id="board_reply_ins_dtm"></span></div>
                </div>    
                
                <div class="form-row col-sm-12 border-bottom p-2" id="board_reply_content">
                </div>               

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