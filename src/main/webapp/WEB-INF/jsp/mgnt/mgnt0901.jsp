<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>

    <style>
      .form_height1 {
        height:calc(1.9rem + 2px);
      }
    </style>

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
              접속현황
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
              접속현황
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
            <jsp:include page="/WEB-INF/jsp/include/mLeftMenu.jsp"></jsp:include>
          </div>
          <div class="col-md-9">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mt-4 mb-4">
                <strong>
                  접속현황
                </strong>
              </h3>

              <form name="form1" class="form-styled">
                <input type="hidden" name="page_current" id="page_current">

                <!--검색조건-->
                  <div class="form-row align-items-center pb-2">
                      <div class="col-2 text-center form-control-sm">
                        접속자명
                      </div>                  
                      <div class="col">
                        <div class="form-inline">
                          <input type="text" class="form-control form-control-sm mb-2" id="access_nm" name="access_nm" value="${access_nm}">
                        </div>
                      </div>

                      <div class="col-2 text-center form-control-sm">
                        접속ID
                      </div>    
                      <div class="col">
                        <div class="form-inline">
                          <input type="text" class="form-control form-control-sm mb-2" id="access_id" name="access_id" value="${access_id}">
                        </div>
                      </div>

                  </div>

                  <div class="form-row align-items-center pb-2">
                      <div class="col-2 text-center form-control-sm">
                        검색기간
                      </div>                  
                      <div class="col-6">
                        <div class="form-inline">
                          <input type="date" class="form-control form-control-sm mb-2" id="ins_dt_fr" name="ins_dt_fr" value="${ins_dt_fr}"> <span class="pl-2 pr-2">~</span>
                          <input type="date" class="form-control form-control-sm mb-2" id="ins_dt_to" name="ins_dt_to" value="${ins_dt_to}">
                        </div>
                      </div>
                      <div class="col-2">
                        <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnSearch">조회</button>
                      </div>
                      <div class="col-2">
                        <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 7rem;" id="btnExcel">액셀 다운로드</button>
                      </div>
                  </div>                  


                <div class="table-responsive pt-3" style="overflow-x: auto; white-space:nowrap">
                  <table class="table table-striped table-hover table-sm border-bottom" id="tableList">
                    <thead class="table-light">
                      <tr>
                        <th scope="col" class="text-center">번호</th>
                        <th scope="col" class="text-left">접속자명</th>
                        <th scope="col" class="text-left">접속ID</th>
                        <th scope="col" class="text-center">접속IP</th>
                        <th scope="col" class="text-center">접속일시</th>
                      </tr>               
                    </thead>
                    <tbody id="codeList">

                      <c:forEach var="list" items="${list}" varStatus="status">

                      <tr>
                        <td class="text-center">${list.rn}</td>
                        <td class="text-left">${list.cust_nm}</td>
                        <td class="text-left">${list.cust_id}</td>
                        <td class="text-center">${list.ip}</td>
                        <td class="text-center">${list.login_dtm}</td>
                      </tr>   

                      </c:forEach>

                      <c:if test="${fn:length(list) == 0}">
                      <tr>
                        <td scope="row" class="text-center" colspan="5">조회된 내용이 없습니다.</td>
                      </tr>
                      </c:if> 
                    </tbody>
                  </table>
                </div>

                <!-- paging -->
                <div class="table-responsive d-flex justify-content-center">
                  <nav aria-label="Page navigation">
                    <ul class="pagination pt-3" id="pagingList"></ul>
                  </nav>
                </div>                

            </form>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="mgnt0901_js.jsp"></jsp:include>   

  </body>
</html>