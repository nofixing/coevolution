<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="ko">
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
                  기업회원
                </strong>
              </h3>


              <div class="form-styled">


                <!--검색조건-->
                <form class="pt-4 pb-3" onsubmit="return false">
                  <input type="hidden" id="cust_id" name="cust_id"/>
	                <input type="hidden" id="page_current" name="page_current"/>

                  <div class="form-row align-items-center pb-2">
                      <div class="col-2 text-center form-control-sm">
                        가입일
                      </div>                  
                      <div class="col">
                        <div class="form-inline">
                          <input type="date" class="form-control form-control-sm" id="ins_dt_fr" name="ins_dt_fr" value="${ins_dt_fr}"> <span class="pl-2 pr-2">~</span>
                          <input type="date" class="form-control form-control-sm" id="ins_dt_to" name="ins_dt_to" value="${ins_dt_to}">
                        </div>
                      </div>
                  </div>

                  <div class="form-row align-items-center">
                      <div class="col-2 text-center form-control-sm">
                        키워드
                      </div>                  
                      <div class="col-4">
                        <input type="text" class="form-control form-control-sm" id="keyword" name="keyword" value="${keyword}" style="width:100%">
                      </div>     
                      <div class="col-2">
                        <button type="button" class="btn-outline-primary form-control form-control-sm mb-0" style="width:100%" id="btnSearch">조회</button>
                      </div>           
                      <div class="col-2">
                        <button type="button" class="btn-outline-primary form-control form-control-sm mb-0" id="btnInsert">참가업체입력</button> 
                      </div> 
                      <div class="col-2">
                        <button type="button" class="btn-outline-primary form-control form-control-sm mb-0" id="btnExcel">엑셀다운</button> 
                      </div>                       
                  </div>                  

                </form>   

                <article>     
                  <div class="board-list">
                    <table class="board-table" id="tableList">
                      <thead>
                        <tr>
                          <th scope="col" class="text-left">번호</th>
                          <th scope="col" class="text-left">아이디</th>
                          <th scope="col" class="text-left">VR_ID</th>
                          <th scope="col" class="text-left">참가업체명</th>
                          <th scope="col" class="text-left">가입일자</th>
                          <th scope="col" class="text-left">최종로그인</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach var="list" items="${list}">
                        <tr>
                          <td class="text-center">${list.rn}</td>
                          <td class="text-left"><a href="javascript:doDetail('${list.cust_id}')">${list.cust_id}</a></td>
                          <td class="text-left">${list.vr_cust_id}</td>
                          <td class="text-left" style="white-space:pre-line;word-break: break-all;">${list.cust_nm}</td>
                          <td class="text-left">${list.ins_dtm}</td>
                          <td class="text-left">${list.login_dtm}</td>
                        </tr>   
                        </c:forEach>
                        <c:if test="${fn:length(list) == 0}">
                        <tr>
                          <td scope="row" class="text-center" colspan="6">조회된 내용이 없습니다.</td>
                        </tr>
                        </c:if>                                                                                                                                                                                                                             
                      </tbody>
                    </table>
                  </div>
                </article>

                <!-- paging -->
                <div class="table-responsive d-flex justify-content-center">
                  <nav aria-label="Page navigation" class="d-flex justify-content-center">
                    <ul class="pagination pt-3" id="pagingList"></ul>
                  </nav>
                </div>

              </div>

            </div>
           
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer_mgnt.jsp"></jsp:include>
    <jsp:include page="mgnt0301_js.jsp"></jsp:include>

  </body>
</html>