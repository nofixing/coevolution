<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/mHeader.jsp"></jsp:include>

    <style>
      .page-item a {
        padding: 0.75rem 0.75rem;
      }
    </style>

  </head>
  <body>

    <!-- top Menu -->
    <jsp:include page="/WEB-INF/jsp/include/mTopMenu.jsp"></jsp:include>

    <!-- CONTENT
    ================================================== -->
    <section class="section pt-7 pl-5 pr-5">
      <div class="container_fluid">

        <div class="row">
          <div class="col-md-2">
            <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/mLeftMenu.jsp"></jsp:include>
          </div>
          <div class="col-md-10">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mt-4 mb-4">
                <strong>
                  상담신청현황
                </strong>
              </h3>
              <form name="form1" class="form-styled">
                <input type="hidden" id="page_current" name="page_current">
                <!--검색조건-->

                <div class="form-row align-items-center pb-2">
                    <div class="col-2 text-center form-control-sm">
                      엑스포명
                    </div>                  
                    <div class="col">
                      <div class="form-inline">

                        <select class="form-control form-control-sm mb-2" id="ev_expo_id" name="ev_expo_id" style="width:100%">
                          <c:forEach var="expoCdList" items="${expoCdList}">
                            <option value="${expoCdList.ev_expo_id}" <c:if test="${expo_id eq expoCdList.ev_expo_id}">selected</c:if>>${expoCdList.ev_expo_nm}</option>
                          </c:forEach>
                        </select>

                      </div>
                    </div>
                </div>

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


                <article>
                  <div class="board-list">
                    <table class="board-table">
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

                  <div>
                    <nav aria-label="Page navigation" class="d-flex justify-content-center" style="width:100%">
                      <ul class="pagination pt-3" id="pagingList"></ul>
                    </nav>
                  </div>

                </article>

              </form>
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

  <jsp:include page="/WEB-INF/jsp/include/footer_mgnt.jsp"></jsp:include>
  <jsp:include page="mgnt1201_js.jsp"></jsp:include>   

  </body>
</html>