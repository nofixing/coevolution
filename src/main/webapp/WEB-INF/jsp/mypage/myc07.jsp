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
              상담예약현황
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
              상담예약현황
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
            <jsp:include page="/WEB-INF/jsp/include/cLeftMenu.jsp"></jsp:include>
           
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
                <input type="hidden" name="sunday" id="sunday" value="${sunday}"/>
                <input type="hidden" name="sh_cls_cd" id="sh_cls_cd"/>
                <input type="hidden" name="consult_from_dt" id="consult_from_dt" value="${consult_from_dt}"/>
                <input type="hidden" name="consult_to_dt" id="consult_to_dt" value="${consult_to_dt}"/>

                <!--상담시간설정-->
                <div class="form-row align-items-center pb-3">
                    <div class="col-md-2 col-sm-12 pt-1">
                        <span class="form-control form-control-sm" style="background-color:#f7f7f7">타임존</span>
                    </div>

                    <div class="col-md-7 col-sm-12 p-0 form-inline">
                        <div class="col-sm-7 pt-1 pl-1 pr-1">
                          <select name="tiemzone_cd" id="tiemzone_cd" class="form-control form-control-sm" style="width:100%;">
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

                        <div class="col-sm-5 pt-1 pl-1 pr-1">
                          <select name="form_clsf" id="form_clsf" class="form-control form-control-sm" style="width:100%;">
                            <option value="1" selected>달력</option>
                            <option value="2">리스트</option>
                          </select>
                        </div>

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

                <div class="input-group pb-1">
                  <div class="col-sm-2 pl-0  pr-2">
                    <select class="form-control form-control-sm" id="sundayCd" style="width:100%">
                      <c:forEach var="list" items="${sundayList}">
                      <option value="${list.sunday}" <c:if test="${list.sunday eq sunday}">selected</c:if>>${list.sunday_fm}</option>
                      </c:forEach>
                    </select>
                  </div>
                  <div class="col-sm-10 pb-1 pl-0 pr-0 d-flex justify-content-between align-items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" style="cursor:pointer" class="bi bi-arrow-left-circle btn-outline-primary" viewBox="0 0 16 16" id="left-circle">
                      <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-4.5-.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5z"/>
                    </svg>
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" style="cursor:pointer" class="bi bi-arrow-right-circle btn-outline-primary" viewBox="0 0 16 16" id="right-circle">
                      <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z"/>
                    </svg>
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
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1 <c:choose><c:when test = "${list.k2_consultRsvStatCd eq '215001'}">purple-100</c:when><c:when test = "${list.k2_consultRsvStatCd eq '215002'}">yellow-200</c:when><c:when test = "${list.k2_expoYn eq 'Y'}">bd-gray-200</c:when></c:choose>" style="width:12%;" id="div_${list.k2_scheduleId}" onClick="scheduleClick('${list.k2_scheduleId}','${list.k2_consultRsvStatCd}')">
                          <span style='<c:if test='${list.k2_consultRsvCustNm ne ""}'>cursor:pointer;</c:if>'> <c:out value="${list.k2_consultRsvCustNm}"/></span>
                        </div>
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1 <c:choose><c:when test = "${list.k3_consultRsvStatCd eq '215001'}">purple-100</c:when><c:when test = "${list.k3_consultRsvStatCd eq '215002'}">yellow-200</c:when><c:when test = "${list.k3_expoYn eq 'Y'}"> bd-gray-200</c:when></c:choose>" style="width:12%;<" id="div_${list.k3_scheduleId}" onClick="scheduleClick('${list.k3_scheduleId}','${list.k3_consultRsvStatCd}')">
                         <span style='<c:if test='${list.k3_consultRsvCustNm ne ""}'>cursor:pointer;</c:if>'> <c:out value="${list.k3_consultRsvCustNm}"/></span>
                        </div>
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1 <c:choose><c:when test = "${list.k4_consultRsvStatCd eq '215001'}">purple-100</c:when><c:when test = "${list.k4_consultRsvStatCd eq '215002'}">yellow-200</c:when><c:when test = "${list.k4_expoYn eq 'Y'}"> bd-gray-200</c:when></c:choose>" style="width:12%;" id="div_${list.k4_scheduleId}" onClick="scheduleClick('${list.k4_scheduleId}','${list.k4_consultRsvStatCd}')">
                          <span style='<c:if test='${list.k4_consultRsvCustNm ne ""}'>cursor:pointer;</c:if>'> <c:out value="${list.k4_consultRsvCustNm}"/></span>
                        </div>
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1 <c:choose><c:when test = "${list.k5_consultRsvStatCd eq '215001'}">purple-100</c:when><c:when test = "${list.k5_consultRsvStatCd eq '215002'}">yellow-200</c:when><c:when test = "${list.k5_expoYn eq 'Y'}"> bd-gray-200</c:when></c:choose>" style="width:12%;" id="div_${list.k5_scheduleId}" onClick="scheduleClick('${list.k5_scheduleId}','${list.k5_consultRsvStatCd}')">
                          <span style='<c:if test='${list.k5_consultRsvCustNm ne ""}'>cursor:pointer;</c:if>'> <c:out value="${list.k5_consultRsvCustNm}"/></span>
                        </div>
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1 <c:choose><c:when test = "${list.k6_consultRsvStatCd eq '215001'}">purple-100</c:when><c:when test = "${list.k6_consultRsvStatCd eq '215002'}">yellow-200</c:when><c:when test = "${list.k6_expoYn eq 'Y'}"> bd-gray-200</c:when></c:choose>" style="width:12%;" id="div_${list.k6_scheduleId}" onClick="scheduleClick('${list.k6_scheduleId}','${list.k6_consultRsvStatCd}')">
                          <span style='<c:if test='${list.k6_consultRsvCustNm ne ""}'>cursor:pointer;</c:if>'> <c:out value="${list.k6_consultRsvCustNm}"/></span>
                        </div>
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1 <c:choose><c:when test = "${list.k7_consultRsvStatCd eq '215001'}">purple-100</c:when><c:when test = "${list.k7_consultRsvStatCd eq '215002'}">yellow-200</c:when><c:when test = "${list.k7_expoYn eq 'Y'}"> bd-gray-200</c:when></c:choose>" style="width:12%;" id="div_${list.k7_scheduleId}" onClick="scheduleClick('${list.k7_scheduleId}','${list.k7_consultRsvStatCd}')">
                          <span style='<c:if test='${list.k7_consultRsvCustNm ne ""}'>cursor:pointer;</c:if>'> <c:out value="${list.k7_consultRsvCustNm}"/></span>
                        </div>
                        <div class="border border-top-0 text-center pt-1 pb-1 <c:choose><c:when test = "${list.k8_consultRsvStatCd eq '215001'}">purple-100</c:when><c:when test = "${list.k8_consultRsvStatCd eq '215002'}">yellow-200</c:when><c:when test = "${list.k8_expoYn eq 'Y'}"> bd-gray-200</c:when></c:choose>" style="width:12%;" id="div_${list.k8_scheduleId}" onClick="scheduleClick('${list.k8_scheduleId}','${list.k8_consultRsvStatCd}')">
                          <span style='<c:if test='${list.k8_consultRsvCustNm ne ""}'>cursor:pointer;</c:if>'> <c:out value="${list.k8_consultRsvCustNm}"/></span>
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
    <jsp:include page="myc07_js.jsp"></jsp:include>   

  </body>
</html>