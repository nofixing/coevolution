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
      .form_height1 {
        height:calc(1.9rem + 2px);
      }

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
                  부스현황
                </strong>
              </h3>

              <form name="form1" id="form1" class="form-styled">
                <input type="hidden" name="page_current" id="page_current">

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
                        부스선택
                      </div>                  
                      <div class="col">
                        <div class="form-inline">

                          <select class="form-control form-control-sm mb-2" id="category1" name="category1" style="width:100%">
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

                      <div class="col-2 form-control-sm text-right">
                        <input type="checkbox" class="form-check-input" id="tot_period" name="tot_period" value="Y" <c:if test="${tot_period eq 'Y'}">checked</c:if>>
                        <label class="form-check-label" for="tot_period">기간합계</label>
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
                      <div class="col-4 col-4 d-flex justify-content-end">
                        <button type="button" class="btn-outline-primary form-control form-control-sm mb-2 mr-1" style="width: 6rem;" id="btnSearch">조회</button>
                        <button type="button" class="btn-outline-primary form-control form-control-sm mb-2 ml-1" style="width: 7rem;" id="btnExcel">액셀 다운로드</button>
                      </div>              
                  </div>                  

                <article>
                  <div class="board-list">
                    <table class="board-table">
                      <thead>
                        <tr>
                          <th rowspan="2" scope="col">번호</th>
                          <th rowspan="2" scope="col">구분</th>
                          <th rowspan="2" scope="col">부스명</th>
                          <th rowspan="2" scope="col">일자</th>
                          <th colspan="10" scope="col" class="text-center border-bottom">접속건수</th>
                        </tr>
                        <tr>
                          <th scope="col" class="text-center">즐겨찾기</th>
                          <th scope="col" class="text-center">뱃지</th>
                          <th scope="col" class="text-center">기업정보</th>
                          <th scope="col" class="text-center">자료소개</th>
                          <th scope="col" class="text-center">갤러리</th>
                          <th scope="col" class="text-center">Q&A</th>
                          <th scope="col" class="text-center">홍보동영상</th>
                          <th scope="col" class="text-center">링크바로가기</th>
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
                          <td class="text-center">${list.access05_cnt}</td>
                          <td class="text-center">${list.access06_cnt}</td>
                        </tr>   

                        </c:forEach>

                        <c:if test="${fn:length(list) == 0}">
                        <tr>
                          <td scope="row" class="text-center" colspan="12">조회된 내용이 없습니다.</td>
                        </tr>
                        </c:if> 
                      </tbody>
                    </table>
                  </div>

                  <!-- paging -->
                  <div class="table-responsive d-flex justify-content-center">
                    <nav aria-label="Page navigation" class="d-flex justify-content-center">
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
  <jsp:include page="mgnt0801_js.jsp"></jsp:include>   

  </body>
</html>