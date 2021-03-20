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
              즐겨찾기 내역
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="/">Home</a>
            </span>
            <span class="breadcrumb-item active">
              마이페이지
            </span>
            <span class="breadcrumb-item active">
              즐겨찾기 내역
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
            <jsp:include page="/WEB-INF/jsp/include/cLeftMenu.jsp"></jsp:include>

          </div>
          <div class="col-md-10">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mb-4">
                내 부스 즐겨찾기 내역
              </h3>

              <form class="form-styled">
                <!-- Subheading -->
                <p class="text-muted">
                  <img src="/image/star.png" width="16rem" /> <span id="badgeCnt">${row_count}</span>명이 즐겨찾기 등록 했습니다.
                </p>

                <!--검색조건-->
                <div class="form-row align-items-center pb-3">
                  <div class="col-auto">
                    <input type="date" class="form-control form-control-sm mb-2" id="favorts_ins_fr" name="favorts_ins_fr" value="${favorts_ins_fr}">
                  </div>
                  <div class="col-auto">~</div>                  
                  <div class="col-auto">
                    <input type="date" class="form-control form-control-sm mb-2" id="favorts_ins_to" name="favorts_ins_to" value="${favorts_ins_to}">
                  </div>
                  <div class="col-auto">
                    <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 8rem;" id="btnSearch">조회</button>
                  </div>
                  <div class="col-auto">
                    <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 8rem;" id="btnMove">부스 바로가기</button>
                  </div>                  
                </div>              

                <table class="table table-striped table-hover table-sm border-bottom">
                  <thead class="table-light">
                    <tr>
                      <th scope="col" width="10%" class="text-center">번호</th>
                      <th scope="col" width="40%" class="text-left">내 부스명</th>
                      <th scope="col" width="25%" class="text-center">회원명</th>
                      <th scope="col" width="25%" class="text-center">즐겨찾기 설정일</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="list" items="${list}">
                    <tr>
                      <th scope="row" class="text-center">${list.rn}</th>
                      <td class="text-left">${list.favorts_cust_nm}</td>
                      <td class="text-center">${list.cust_nm}(${list.cust_id})</td>
                      <td class="text-center">${list.ins_dtm}</td>
                    </tr>
                    </c:forEach>
                    <c:if test="${fn:length(list) == 0}">
                    <tr>
                      <th scope="row" class="text-center" colspan="4">조회된 내용이 없습니다.</th>
                    </tr>
                    </c:if>                    
                  </tbody>
                </table>

                <!-- paging -->
                <div class="table-responsive d-flex justify-content-center">
                  <nav aria-label="Page navigation">
                    <ul class="pagination pt-3">
                      <li class="page-item">
                        <a class="page-link" href="#">Previous</a>
                      </li>
                      <li class="page-item">
                        <a class="page-link" href="#">1</a>
                      </li>
                      <li class="page-item">
                        <a class="page-link" href="#">2</a>
                      </li>
                      <li class="page-item">
                        <a class="page-link" href="#">3</a>
                      </li>
                      <li class="page-item">
                        <a class="page-link" href="#">Next</a>
                      </li>
                    </ul>
                  </nav>
                </div>
              
              </form>

            </div>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myc02_js.jsp"></jsp:include>

  </body>
</html>