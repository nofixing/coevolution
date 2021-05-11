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
              부스현황
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
              부스현황
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
                  부스현황
                </strong>
              </h3>

              <form name="form1" class="form-styled">
                <input type="hidden" name="page_current" id="page_current">

                <!--검색조건-->
                  <div class="form-row align-items-center pb-2">
                      <div class="col-2 text-center form-control-sm">
                        부스선택
                      </div>                  
                      <div class="col">
                        <div class="form-inline">

                          <select class="form-control form-control-sm mb-2" id="category1" name="category1">
                            <option value="" <c:if test="${category1 eq ''}">selected</c:if>>전체</option>
                            <c:forEach var="category" items="${category}">
                              <option value="${category.cd_id}" <c:if test="${category1 eq category.cd_id}">selected</c:if>>${category.cd_nm}</option>
                            </c:forEach>
                          </select>

                        </div>
                      </div>

                      <div class="col-2 text-center form-control-sm">
                        고객명
                      </div>    
                      <div class="col">
                        <div class="form-inline">
                          <input type="text" class="form-control form-control-sm mb-2" id="cust_nm" name="cust_nm" value="${cust_nm}">
                        </div>
                      </div>

                  </div>

                  <div class="form-row align-items-center pb-2">
                      <div class="col-2 text-center form-control-sm">
                        검색기간
                      </div>                  
                      <div class="col">
                        <div class="form-inline">
                          <input type="date" class="form-control form-control-sm mb-2" id="ins_dt_fr" name="ins_dt_fr" value="${ins_dt_fr}"> <span class="pl-2 pr-2">~</span>
                          <input type="date" class="form-control form-control-sm mb-2" id="ins_dt_to" name="ins_dt_to" value="${ins_dt_to}">
                        </div>
                      </div>
                      <div class="col-2 text-right">
                        <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnSearch">조회</button>
                      </div>                        
                  </div>                  


                <div class="table-responsive pt-3" style="overflow-x: auto; white-space:nowrap">
                  <table class="table table-striped table-hover table-sm border-bottom" id="tableList">
                    <thead class="table-light">
                      <tr>
                        <th rowspan="2" scope="col" class="text-center border-top" style="width:50px;vertical-align: middle;">번호</th>
                        <th rowspan="2" scope="col" class="text-left border-top" style="width:90px;vertical-align: middle;">구분</th>
                        <th rowspan="2" scope="col" class="text-left border-top" style="width:150px;vertical-align: middle;">부스명</th>
                        <th rowspan="2" scope="col" class="text-center border-top" style="width:80px;vertical-align: middle;">일자</th>
                        <th colspan="10" scope="col" class="text-center border-top border-bottom">접속건수</th>
                      </tr>
                      <tr>
                        <th scope="col" class="text-center">즐겨찾기</th>
                        <th scope="col" class="text-center">뱃지</th>
                        <th scope="col" class="text-center">상담</th>
                        <th scope="col" class="text-center">기업정보</th>
                        <th scope="col" class="text-center">이미지</th>
                        <th scope="col" class="text-center">기타1</th>
                        <th scope="col" class="text-center">기타2</th>
                        <th scope="col" class="text-center">기타3</th>
                        <th scope="col" class="text-center">기타4</th>
                        <th scope="col" class="text-center">기타5</th>
                      </tr>                      
                    </thead>
                    <tbody id="codeList">

                      <c:forEach var="list" items="${list}" varStatus="status">

                      <tr>
                        <td class="text-center">${list.rn}</td>
                        <td class="text-left">${list.caregori_nm}</td>
                        <td class="text-left">${list.cust_nm}</td>
                        <td class="text-center">${list.ins_dt}</td>
                        <td class="text-center">${list.favorts_cnt}</td>
                        <td class="text-center">${list.badge_cnt}</td>
                        <td class="text-center">${list.access01_cnt}</td>
                        <td class="text-center">${list.access02_cnt}</td>
                        <td class="text-center">${list.access03_cnt}</td>
                        <td class="text-center">${list.access04_cnt}</td>
                        <td class="text-center">${list.access06_cnt}</td>
                        <td class="text-center">${list.access07_cnt}</td>
                        <td class="text-center">${list.access08_cnt}</td>
                        <td class="text-center">${list.access09_cnt}</td>
                      </tr>   

                      </c:forEach>

                      <c:if test="${fn:length(list) == 0}">
                      <tr>
                        <td scope="row" class="text-center" colspan="14">조회된 내용이 없습니다.</td>
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
  <jsp:include page="mgnt0801_js.jsp"></jsp:include>   

  </body>
</html>