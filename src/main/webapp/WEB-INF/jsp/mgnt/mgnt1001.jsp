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
    </style>

  </head>
  <body>

    <!-- top Menu -->
    <jsp:include page="/WEB-INF/jsp/include/mTopMenu.jsp"></jsp:include>

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
                  엑스포관리
                </strong>
              </h3>

              <form name="form1" class="form-styled">
                <input type="hidden" name="page_current" id="page_current">
                <input type="hidden" name="ev_expo_id" id="ev_expo_id">
                
                <!--검색조건-->
                <div class="form-row align-items-center pb-2">
                    <div class="col-2 text-center form-control-sm">
                      엑스포명
                    </div>                  
                    <div class="col">
                      <div class="form-inline">
                        <input type="text" class="form-control form-control-sm mb-2" id="ev_expo_nm" name="ev_expo_nm" value="${ev_expo_nm}">
                      </div>
                    </div>
                    <div class="col-2 text-center form-control-sm">
                      사용여부
                    </div>                  
                    <div class="col">
                      <div class="form-inline">
                          <select id="use_yn" name="use_yn" class="form-control form-control-sm mb-2" style="width:5rem">
                            <option value="Y" <c:if test="${'N' ne use_yn}">selected</c:if>>Y</option>
                            <option value="N" <c:if test="${'N' eq use_yn}">selected</c:if>>N</option>
                          </select>
                      </div>
                    </div>
                </div>

                <div class="form-row align-items-center pb-2">
                    <div class="col-2 text-center form-control-sm">
                      검색기간
                    </div>                  
                    <div class="col-6">
                      <div class="form-inline">
                        <input type="date" class="form-control form-control-sm mb-2" id="expo_dt_fr" name="expo_dt_fr" value="${expo_dt_fr}"> <span class="pl-2 pr-2">~</span>
                        <input type="date" class="form-control form-control-sm mb-2" id="expo_dt_to" name="expo_dt_to" value="${expo_dt_to}">
                      </div>
                    </div>
                    <div class="col-4 form-inline d-flex justify-content-end">
                      <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnSearch">조회</button>&nbsp;
                      <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnInsert">엑스포등록</button> 
                    </div>
                </div>                  


                <div class="table-responsive pt-3" style="overflow-x: auto; white-space:nowrap">
                  <table class="table table-striped table-hover table-sm border-bottom" id="tableList">
                    <thead class="table-light">
                      <tr>
                        <th scope="col" class="text-center">번호</th>
                        <th scope="col" class="text-left">엑스포명</th>
                        <th scope="col" class="text-center">접수시작일</th>
                        <th scope="col" class="text-center">접수종료일</th>
                        <th scope="col" class="text-center">엑스포시작일</th>
                        <th scope="col" class="text-center">엑스포종료일</th>
                        <th scope="col" class="text-center">사용여부</th>
                      </tr>               
                    </thead>
                    <tbody id="codeList">

                      <c:forEach var="list" items="${list}" varStatus="status">

                      <tr>
                        <td class="text-center">${list.rn}</td>
                        <td class="text-left"><a href="javascript:doDetail('${list.ev_expo_id}')">${list.ev_expo_nm}</a></td>
                        <td class="text-center">${list.apct_prod_from_dt}</td>
                        <td class="text-center">${list.apct_prod_to_dt}</td>
                        <td class="text-center">${list.expo_from_dtm}</td>
                        <td class="text-center">${list.expo_to_dtm}</td>
                        <td class="text-center">${list.use_yn}</td>
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

  <jsp:include page="/WEB-INF/jsp/include/footer_mgnt.jsp"></jsp:include>
  <jsp:include page="mgnt1001_js.jsp"></jsp:include>   

  </body>
</html>