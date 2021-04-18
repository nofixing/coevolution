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
              ${page_clsf_nm}
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="/index">Home</a>
            </span>
            <span class="breadcrumb-item active">
              관리자페이지
            </span>
            <span class="breadcrumb-item active">
              ${page_clsf_nm}
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>
    
    <!-- CONTENT
    ================================================== -->
    <section class="section">
      <div class="container">
        <div class="form_head">
          <p>관리자페이지</p>
      </div>
        <div class="row">
          <div class="col-md-3">
            
            <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/mLeftMenu.jsp"></jsp:include>        
           
          </div>
          <div class="col-md-9">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mb-4">
                <strong>
                  ${page_clsf_nm}
                </strong>
              </h3>

              <form class="form-styled">
                <div class="form-row col-sm-12 p-2">
                  <textarea class="form-control" name="board_content" rows="15" id="board_content"></textarea>
                  <input type="hidden" name="board_id" id="board_id">
                </div>               

                <div class="form-row col-sm-12 pt-3 pr-0 justify-content-end">
                  <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnSave">수정</button>
                </div>

              </div>

            </form>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="mgnt0702_js.jsp"></jsp:include>

  </body>
</html>