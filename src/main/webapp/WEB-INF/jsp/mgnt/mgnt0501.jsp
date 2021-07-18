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
              참관회원
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
              관리자정보
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
                  관리자정보
                </strong>
              </h3>


              <div class="form-styled">


                <!--검색조건-->
                <form class="pt-4 pb-3" onsubmit="return false">

                  <input type="hidden" id="page_current" name="page_current"/>
                  <input type="hidden" id="mgnt_id" name="mgnt_id"/>

                  <div class="form-row align-items-center pb-2">
                      <div class="col-2 text-center form-control-sm">
                        ID
                      </div>                  
                      <div class="col-4">
                        <input type="text" class="form-control form-control-sm" id="mgnt_id_sh" name="mgnt_id_sh" value="${mgnt_id_sh}" style="width:100%">
                      </div>     
                      <div class="col-2 text-center form-control-sm">
                        담당자명
                      </div>                  
                      <div class="col-4">
                        <input type="text" class="form-control form-control-sm" id="mgnt_nm_sh" name="mgnt_nm_sh" value="${mgnt_nm_sh}" style="width:100%">
                      </div>                       
                  </div>  

                  <div class="form-row align-items-center pb-2">
                       <div class="col-sm-12 d-flex justify-content-end">            
                        <button type="button" class="btn-outline-primary form-control form-control-sm m-1" style="width: 6rem;" id="btnSearch">조회</button>
                        <button type="button" class="btn-outline-primary form-control form-control-sm m-1" style="width: 6rem;" id="btnReg">등록</button>
                      </div>                       
                  </div>                      
           

                </form>            
                <div class="table-responsive" style="overflow-x: auto; white-space:nowrap">
                  <table class="table table-striped table-hover table-sm border-bottom" id="tableList">
                    <thead class="table-light">
                      <tr>
                        <th scope="col" class="text-center">번호</th>
                        <th scope="col" class="text-center">아이디</th>
                        <th scope="col" class="text-center">담당자명</th>
                        <th scope="col" class="text-center">이메일</th>
                        <th scope="col" class="text-center">부서</th>
                        <th scope="col" class="text-center">사용여부</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="list" items="${list}">
                      <tr>
                        <td class="text-center">${list.rn}</td>
                        <td class="text-center"><a href="javascript:doDetail('${list.mgnt_id}')">${list.mgnt_id}</a></td>
                        <td class="text-center">${list.mgnt_nm}</td>
                        <td class="text-center">${list.email_id}</td>
                        <td class="text-center">${list.dept_nm}</td>
                        <td class="text-center">${list.use_yn}</td>
                      </tr>   
                      </c:forEach>
                      <c:if test="${fn:length(list) == 0}">
                      <tr>
                        <th scope="row" class="text-center" colspan="7">조회된 내용이 없습니다.</th>
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

              </div>

            </div>
           
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="mgnt0501_js.jsp"></jsp:include>

  </body>
</html>