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
                  ${page_clsf_nm}
                </strong>
              </h3>

              <form name="form1" class="form-styled">
                <input type="hidden" name="page_current" id="page_current">
                <div class="form-row d-flex justify-content-end pb-2">
                      <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnUpdate">등록</button>
                </div> 

                <article>

                    <div class="board-list">
                      <table class="board-table">
                        <thead class="table-light">
                          <tr>
                            <th scope="col" class="text-center">번호</th>
                            <th scope="col" class="text-left">최근등록일</th>
                            <th scope="col" class="text-center">등록자</th>
                          </tr>
                        </thead>
                        <tbody id="codeList">

                          <c:forEach var="list" items="${termslist}" varStatus="status">

                          <tr>
                            <td class="text-center">${list.rn}</td>
                            <td class="text-left">${list.ins_dtm}</td>
                            <td class="text-center">${list.ins_user}</td>
                          </tr>   

                          </c:forEach>

                          <c:if test="${fn:length(termslist) == 0}">
                          <tr>
                            <td scope="row" class="text-center" colspan="3">조회된 내용이 없습니다.</td>
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
  <jsp:include page="mgnt0701_js.jsp"></jsp:include>   

  </body>
</html>