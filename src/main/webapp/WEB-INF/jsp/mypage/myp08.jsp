<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="ko">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>

  <style>
    .yellow-200 {
      background-color : #ffe69c;
    }
    .purple-100 {
      background-color : #e2d9f3;
    }
    .bd-gray-200 {
      background-color : #e9ecef;
    }
    .yellow-200-color {
      color : #ffe69c;
    }
    .purple-100-color {
      color : #e2d9f3;
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
              마이페이지
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
                  상담예약현황
                </strong>
              </h3>

              <form class="form-styled">
                <input type="hidden" name="consult_time_id" id="consult_time_id" value="${consult_time_id}"/>
                <!--상담시간설정-->
                <div class="form-row align-items-center pb-3">
                    <div class="col-md-2 col-sm-12 pt-1">
                        <span class="form-control form-control-sm" style="background-color:#f7f7f7">타임존</span>
                    </div>

                    <div class="col-md-7 col-sm-12 pt-1">
                        <select name="tiemzone_cd" id="tiemzone_cd" class="form-control form-control-sm" style="width: 11rem;">
                          <c:forEach var="list" items="${timezoneList}">
                            <c:if test="${tiemzone_cd eq list.cd_id}">
                              <option value="${list.cd_id}" selected>${list.cd_nm}</option>
                            </c:if>
                            <c:if test="${tiemzone_cd ne list.cd_id}">
                              <option value="${list.cd_id}">${list.cd_nm}</option>
                            </c:if>
                          </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-3 col-sm-12 pt-1 d-flex justify-content-end">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill purple-100-color" viewBox="0 0 16 16">
                          <path fill-rule="evenodd" d="M4 0h8a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2z"/>
                        </svg> 상담신청
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill yellow-200-color" viewBox="0 0 16 16">
                          <path fill-rule="evenodd" d="M4 0h8a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2z"/>
                        </svg> 상담확정
                    </div>
                </div>

                <!-- Subheading -->
                <div class="table-responsive">

                  <c:forEach var="list" items="${consultList}" varStatus="status">

                    <c:if test="${status.first}">
                      
                      <div class="row m-0" style="width: 100%;">
                            <div class="border border-right-0 text-center pt-2 pb-2 bg-light" style="width:16%;">${list.k1}</div>
                            <div class="border border-right-0 text-center pt-2 pb-2 bg-light" style="width:12%;">${list.k2}</div>
                            <div class="border border-right-0 text-center pt-2 pb-2 bg-light" style="width:12%;">${list.k3}</div>
                            <div class="border border-right-0 text-center pt-2 pb-2 bg-light" style="width:12%;">${list.k4}</div>
                            <div class="border border-right-0 text-center pt-2 pb-2 bg-light" style="width:12%;">${list.k5}</div>
                            <div class="border border-right-0 text-center pt-2 pb-2 bg-light" style="width:12%;">${list.k6}</div>
                            <div class="border border-right-0 text-center pt-2 pb-2 bg-light" style="width:12%;">${list.k7}</div>
                            <div class="border text-center pt-2 pb-2 bg-light" style="width:12%;">${list.k8}</div>
                      </div>

                    </c:if>

                    <c:if test="${!status.first}">

                      <div class="row m-0" style="width: 100%;"> 
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1" style="width:16%;">${list.k1}</div> 
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1 <c:if test = "${list.k2_expoYn eq 'Y'}">bd-gray-200</c:if>" style="width:12%;">
                          <c:forEach var="custList" items="${list.custList}" varStatus="cStatus">
                            <c:if test="${!empty fn:trim(custList.k2_consultCustNm)}">
                              <a href="javascript:scheduleClick('${custList.k2_scheduleId}')">
                                <h5 class="<c:choose><c:when test = "${custList.k2_consultRsvStatCd eq '215001'}">purple-100</c:when><c:when test = "${custList.k2_consultRsvStatCd eq '215002'}">yellow-200</c:when></c:choose>"> <c:out value="${fn:trim(custList.k2_consultCustNm)}"/></h5>
                              </a>
                            </c:if>
                          </c:forEach>
                        </div>
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1 <c:if test = "${list.k3_expoYn eq 'Y'}">bd-gray-200</c:if>" style="width:12%;">
                          <c:forEach var="custList" items="${list.custList}" varStatus="cStatus">
                            <c:if test="${!empty fn:trim(custList.k3_consultCustNm)}">
                              <a href="javascript:scheduleClick('${custList.k3_scheduleId}')">
                                <h5 class="<c:choose><c:when test = "${custList.k3_consultRsvStatCd eq '215001'}">purple-100</c:when><c:when test = "${custList.k3_consultRsvStatCd eq '215002'}">yellow-200</c:when></c:choose>"> <c:out value="${fn:trim(custList.k3_consultCustNm)}"/></h5>
                              </a>
                            </c:if>
                          </c:forEach>
                        </div>
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1 <c:if test = "${list.k4_expoYn eq 'Y'}">bd-gray-200</c:if>" style="width:12%;">
                          <c:forEach var="custList" items="${list.custList}" varStatus="cStatus">
                            <c:if test="${!empty fn:trim(custList.k4_consultCustNm)}">
                              <a href="javascript:scheduleClick('${custList.k4_scheduleId}')">
                                <h5 class="<c:choose><c:when test = "${custList.k4_consultRsvStatCd eq '215001'}">purple-100</c:when><c:when test = "${custList.k4_consultRsvStatCd eq '215002'}">yellow-200</c:when></c:choose>"> <c:out value="${fn:trim(custList.k4_consultCustNm)}"/></h5>
                              </a>
                            </c:if>
                          </c:forEach>
                        </div>
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1 <c:if test = "${list.k5_expoYn eq 'Y'}">bd-gray-200</c:if>" style="width:12%;">
                          <c:forEach var="custList" items="${list.custList}" varStatus="cStatus">
                            <c:if test="${!empty fn:trim(custList.k5_consultCustNm)}">
                              <a href="javascript:scheduleClick('${custList.k5_scheduleId}')">
                                <h5 class="<c:choose><c:when test = "${custList.k5_consultRsvStatCd eq '215001'}">purple-100</c:when><c:when test = "${custList.k5_consultRsvStatCd eq '215002'}">yellow-200</c:when></c:choose>"> <c:out value="${fn:trim(custList.k5_consultCustNm)}"/></h5>
                              </a>
                            </c:if>
                          </c:forEach>
                        </div>
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1 <c:if test = "${list.k6_expoYn eq 'Y'}">bd-gray-200</c:if>" style="width:12%;">
                          <c:forEach var="custList" items="${list.custList}" varStatus="cStatus">
                            <c:if test="${!empty fn:trim(custList.k6_consultCustNm)}">
                              <a href="javascript:scheduleClick('${custList.k6_scheduleId}')">
                                <h5 class="<c:choose><c:when test = "${custList.k6_consultRsvStatCd eq '215001'}">purple-100</c:when><c:when test = "${custList.k6_consultRsvStatCd eq '215002'}">yellow-200</c:when></c:choose>"> <c:out value="${fn:trim(custList.k6_consultCustNm)}"/></h5>
                              </a>
                            </c:if>
                          </c:forEach>
                        </div>
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1 <c:if test = "${list.k7_expoYn eq 'Y'}">bd-gray-200</c:if>" style="width:12%;">
                          <c:forEach var="custList" items="${list.custList}" varStatus="cStatus">
                            <c:if test="${!empty fn:trim(custList.k7_consultCustNm)}">
                              <a href="javascript:scheduleClick('${custList.k7_scheduleId}')">
                                <h5 class="<c:choose><c:when test = "${custList.k7_consultRsvStatCd eq '215001'}">purple-100</c:when><c:when test = "${custList.k7_consultRsvStatCd eq '215002'}">yellow-200</c:when></c:choose>"> <c:out value="${fn:trim(custList.k7_consultCustNm)}"/></h5>
                              </a>
                            </c:if>
                          </c:forEach>
                        </div>
                        <div class="border border-top-0 text-center pt-1 pb-1 <c:if test = "${list.k8_expoYn eq 'Y'}">bd-gray-200</c:if>" style="width:12%;">
                          <c:forEach var="custList" items="${list.custList}" varStatus="cStatus">
                            <c:if test="${!empty fn:trim(custList.k8_consultCustNm)}">
                              <a href="javascript:scheduleClick('${custList.k8_scheduleId}')">
                                <h5 class="<c:choose><c:when test = "${custList.k8_consultRsvStatCd eq '215001'}">purple-100</c:when><c:when test = "${custList.k8_consultRsvStatCd eq '215002'}">yellow-200</c:when></c:choose>"> <c:out value="${fn:trim(custList.k8_consultCustNm)}"/></h5>
                              </a>
                            </c:if>
                          </c:forEach>
                        </div>
                      </div>

                    </c:if>

                  </c:forEach>
                </div>
              
              </form>

            </div>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myp08_js.jsp"></jsp:include>   

  </body>
</html>