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
              <spring:message code="left.menu.favorite.booths" text="부스 즐겨찾기 내역"/>
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="/index">Home</a>
            </span>
            <span class="breadcrumb-item active">
              <spring:message code="left.menu.mypage" text="마이페이지"/>
            </span>
            <span class="breadcrumb-item active">
              <spring:message code="left.menu.favorite.booths" text="부스 즐겨찾기 내역"/>
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>
    
    <!-- CONTENT
    ================================================== -->
    <section class="section pt-0">
      <div class="container mt-block">
        <div class="row">
          <div class="col-xl-3" id="gLeftMenu">
            
            <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/pLeftMenu.jsp"></jsp:include>
           
          </div>

          <div class="col-xl-9">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mt-4 mb-4">
                <strong>
                  <spring:message code="left.menu.favorite.booths" text="부스 즐겨찾기 내역"/>
                </strong>
              </h3>

              <form class="form-styled">

                <input type="hidden" name="page_current" id="page_current"/>

                <!-- Subheading -->
                <p class="text-muted">
                  <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-bookmark-star" viewBox="0 0 16 16">
                    <path d="M7.84 4.1a.178.178 0 0 1 .32 0l.634 1.285a.178.178 0 0 0 .134.098l1.42.206c.145.021.204.2.098.303L9.42 6.993a.178.178 0 0 0-.051.158l.242 1.414a.178.178 0 0 1-.258.187l-1.27-.668a.178.178 0 0 0-.165 0l-1.27.668a.178.178 0 0 1-.257-.187l.242-1.414a.178.178 0 0 0-.05-.158l-1.03-1.001a.178.178 0 0 1 .098-.303l1.42-.206a.178.178 0 0 0 .134-.098L7.84 4.1z"/>
                    <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z"/>
                  </svg> 
                  <c:if test="${sessionScope.LANG ne 'en'}">
                    <span id="spCnt">${row_count}</span>개 부스를 즐겨찾기 했습니다.
                  </c:if>
                  <c:if test="${sessionScope.LANG eq 'en'}">
                   You have <span id="spCnt">${row_count}</span> favorite booths
                  </c:if> 
                </p>
                <div class="table-responsive" id="divFavorit">
                  <table class="table table-striped table-hover table-md border-bottom" id="tbFavorit">
                    <thead class="table-light">
                      <tr>
                        <th scope="col" class="text-center"><spring:message code="form.favorite.booths.no" text="번호"/></th>
                        <th scope="col" class="text-left"><spring:message code="form.favorite.company" text="부스명"/></th>
                        <th scope="col" class="text-center"><spring:message code="form.favorite.booth.history" text="즐겨찾기내역"/></th>
                        <th scope="col" class="text-center"><spring:message code="form.favorite.gotobooth" text="부스바로가기"/></th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="list" items="${list}">
                      <tr>
                        <th scope="row" class="text-center">${list.rn}</th>
                        <td class="text-left table-des">${list.favorts_cust_nm}</td>
                        <td class="text-center">
                          <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-bookmark-star text-warning" viewBox="0 0 16 16">
                            <path d="M7.84 4.1a.178.178 0 0 1 .32 0l.634 1.285a.178.178 0 0 0 .134.098l1.42.206c.145.021.204.2.098.303L9.42 6.993a.178.178 0 0 0-.051.158l.242 1.414a.178.178 0 0 1-.258.187l-1.27-.668a.178.178 0 0 0-.165 0l-1.27.668a.178.178 0 0 1-.257-.187l.242-1.414a.178.178 0 0 0-.05-.158l-1.03-1.001a.178.178 0 0 1 .098-.303l1.42-.206a.178.178 0 0 0 .134-.098L7.84 4.1z"/>
                            <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z"/>
                          </svg>
                        </td>
                        <td class="text-center"><a href="${list.shortcut_url}" class="basic-btn"><spring:message code="form.favorite.go" text="바로가기"/></a></td>
                      </tr>        
                      </c:forEach>   
                    <c:if test="${fn:length(list) == 0}">
                    <tr>
                      <th scope="row" class="text-center" colspan="4"><spring:message code="form.no.search" text="조회된 내용이 없습니다."/></th>
                    </tr>
                    </c:if>                                                                                                                                     
                    </tbody>
                  </table>
                </div>


                <!-- paging -->
                <div class="table-responsive d-flex justify-content-center">
                  <nav aria-label="Page navigation">
                    <ul class="pagination pt-3" id="myp01_page"></ul>
                  </nav>
                </div>
              
              </form>

            </div>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myp01_js.jsp"></jsp:include>

  </body>
</html>