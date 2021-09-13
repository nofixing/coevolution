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
              이벤트 참여 내역
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="/index">Home</a>
            </span>
            <span class="breadcrumb-item active">
              마이페이지
            </span>
            <span class="breadcrumb-item active">
              이벤트 참여 내역
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
                  이벤트 참여 내역
                </strong>
              </h3>

              <form class="form-styled">


                <div class="table-responsive" id="divFavorit">
                  <table class="table table-striped table-hover table-md border-bottom" id="tbFavorit">
                    <thead class="table-light">
                      <tr>
                        <th scope="col" class="text-center">번호</th>
                        <th scope="col" class="text-left">참여일</th>
                        <th scope="col" class="text-center">이벤트명</th>
                        <th scope="col" class="text-center">당첨내역</th>
                        <th scope="col" class="text-center">비고</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="list" items="${list}">
                      <tr>
                        <th scope="row" class="text-center">${list.rn}</th>
                        <td class="text-left table-des">${list.reg_dt}</td>
                        <td class="text-center">SK증권 '전기차 관련 주식 1주 증정 이벤트</td>
                        <td class="text-center">${list.ep_stock_code_name}</td>
                        <td></td>
                      </tr>
                      </c:forEach>
                    <c:if test="${fn:length(list) == 0}">
                    <tr>
                      <th scope="row" class="text-center" colspan="5"><spring:message code="form.no.search" text="조회된 내용이 없습니다."/></th>
                    </tr>
                    </c:if>
                    </tbody>
                  </table>

                  <div class="pt-2 d-flex justify-content-end" id="nav-tabContent">
                      <!--button type="button" class="basic-btn"  id="btnSnd">당첨정보 입력하기</button-->
                  </div>
                </div>


                <!-- paging -->
                <div class="table-responsive d-flex justify-content-center">
                  <nav aria-label="Page navigation">
                    <ul class="pagination pt-3" id="event_page"></ul>
                  </nav>
                </div>

              </form>

            </div>

          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myp11_js.jsp"></jsp:include>

  </body>
</html>