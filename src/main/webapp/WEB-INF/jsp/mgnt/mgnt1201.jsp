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

      #tableList {
          border-collapse: collapse;
      }
      #tableList th {
          position: sticky;
          background-color:#e7e7e7;
          top: 0px;
      }
      .basic-table-fix td {
          padding:5px 10px;
          border-bottom:1px solid #e7e7e7;
          border-left:0px solid #e7e7e7;
          box-sizing:border-box;
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
              상담신청현황
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
              상담신청현황
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
                  상담신청현황
                </strong>
              </h3>
              <form name="form1" class="form-styled">
                
                <!--검색조건-->
                <div class="form-row align-items-center pb-2">
                  <div class="col-2 text-center form-control-sm">
                    참가업체명
                  </div>                  
                  <div class="col">
                    <div class="form-inline">
                      <input type="text" class="form-control form-control-sm mb-2" id="exhibitors_cust_nm" name="exhibitors_cust_nm" value="${exhibitors_cust_nm}">
                    </div>
                  </div>
                  <div class="col-2 text-center form-control-sm">
                    상담고객명
                  </div>                  
                  <div class="col">
                    <div class="form-inline">
                      <input type="text" class="form-control form-control-sm mb-2" id="consult_rsv_cust_nm" name="consult_rsv_cust_nm" value="${consult_rsv_cust_nm}">
                    </div>
                  </div>
                </div>

                <div class="form-row align-items-center pb-2">
                    <div class="col-2 text-center form-control-sm">
                      검색기간
                    </div>                  
                    <div class="col-6">
                      <div class="form-inline">
                        <input type="date" class="form-control form-control-sm mb-2" id="consult_dt_fr" name="consult_dt_fr" value="${consult_dt_fr}"> <span class="pl-2 pr-2">~</span>
                        <input type="date" class="form-control form-control-sm mb-2" id="consult_dt_to" name="consult_dt_to" value="${consult_dt_to}">
                      </div>
                    </div>
                    <div class="col-4 form-inline d-flex justify-content-end">
                      <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnSearch">조회</button>
                    </div>
                </div>  

                <div class="table-responsive" style="overflow-x: auto; overflow-y: auto;white-space:nowrap; height: 30rem;">
                  <table class="table table-sm border-bottom basic-table-fix" id="tableList">
                    <thead>
                      <tr>
                        <th class="text-center">번호</th>
                        <th class="text-left">참가업체</th>
                        <th class="text-left">상담고객</th>
                        <th class="text-center">신청건수</th>
                        <th class="text-center">확정건수</th>
                        <th class="text-center">반려건수</th>
                        <th class="text-center">취소건수</th>
                      </tr>               
                    </thead>
                    <tbody id="codeList">

                      <c:forEach var="list" items="${list}" varStatus="status">

                      <tr>
                        <td class="text-center">${list.rn}</td>
                        <td class="text-left">${list.exhibitors_cust_nm}</td>
                        <td class="text-left">${list.consult_rsv_cust_nm}</td>
                        <td class="text-center">${list.s215001_cnt}</td>
                        <td class="text-center">${list.s215002_cnt}</td>
                        <td class="text-center">${list.s215003_cnt}</td>
                        <td class="text-center">${list.s215004_cnt}</td>
                      </tr>   

                      </c:forEach>

                      <c:if test="${fn:length(list) == 0}">
                      <tr>
                        <td scope="row" class="text-center" colspan="7">조회된 내용이 없습니다.</td>
                      </tr>                
                      </c:if> 
                    </tbody>
                  </table>
                </div>
              </form>
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="mgnt1201_js.jsp"></jsp:include>   

  </body>
</html>