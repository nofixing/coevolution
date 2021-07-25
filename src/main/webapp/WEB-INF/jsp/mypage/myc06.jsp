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
              상담시간설정
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
              상담시간설정
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
                  상담시간 설정
                </strong>
              </h3>

              <form class="form-styled">
                <input type="hidden" name="consult_time_id" id="consult_time_id" value="${consult_time_id}"/>
                <input type="hidden" name="sunday" id="sunday" value="${sunday}"/>
                <input type="hidden" name="sh_cls_cd" id="sh_cls_cd"/>

                <!--상담시간설정-->
                <div class="form-row align-items-center pb-3">
                    <div class="col-md-2 col-sm-12 pt-1">
                        <span class="form-control form-control-sm" style="background-color:#f7f7f7">타임존</span>
                    </div>

                    <div class="col-md-auto col-sm-12 pt-1" style="width: 11rem;">
                        <select name="tiemzone_cd" id="tiemzone_cd" class="form-control form-control-sm">
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
                </div>

                <div class="form-row align-items-center pb-3">
                    
                  <div class="col-md-2 col-sm-12 pt-1">
                      <span class="form-control form-control-sm" style="background-color:#f7f7f7">상담가능일자</span>
                  </div>

                  <div class="col-md-auto col-sm-12 pt-1">
                      <input type="date" class="form-control form-control-sm" style="width: 11rem;" id="consult_from_dt" name="consult_from_dt" value="${consult_from_dt}" readonly>
                  </div>

                  <div class="col-md-auto col-sm-12 pt-1">
                      <input type="date" class="form-control form-control-sm" style="width: 11rem;" id="consult_to_dt" name="consult_to_dt" value="${consult_to_dt}" readonly>
                  </div>

                </div>

                <div class="form-row align-items-center pb-3">
                    
                  <div class="col-md-2 col-sm-12 pt-1">
                      <span class="form-control form-control-sm" style="background-color:#f7f7f7">상담가능시간</span>
                  </div>

                  <div class="col-md-auto col-sm-12 pt-1">
                    <select name="consult_from_time" id="consult_from_time" class="bg-white form-control form-control-sm" style="width: 11rem;">
                      <c:forEach var="list" items="${timeList}">
                        <c:if test="${consult_from_time eq list.cd_id}">
                          <c:if test="${tiemzone_cd eq '213001'}">
                            <option value="${list.cd_id}" selected>${list.cd_nm}</option>
                          </c:if>
                          <c:if test="${tiemzone_cd eq '213002'}">
                            <option value="${list.cd_id}" selected>${list.cd_val1}</option>
                          </c:if>
                          <c:if test="${tiemzone_cd eq '213003'}">
                            <option value="${list.cd_id}" selected>${list.cd_val2}</option>
                          </c:if>
                          <c:if test="${tiemzone_cd eq '213004'}">
                            <option value="${list.cd_id}" selected>${list.cd_val3}</option>
                          </c:if>
                        </c:if>
                        <c:if test="${consult_from_time ne list.cd_id}">
                          <c:if test="${tiemzone_cd eq '213001'}">
                            <option value="${list.cd_id}">${list.cd_nm}</option>
                          </c:if>
                          <c:if test="${tiemzone_cd eq '213002'}">
                            <option value="${list.cd_id}">${list.cd_val1}</option>
                          </c:if>
                          <c:if test="${tiemzone_cd eq '213003'}">
                            <option value="${list.cd_id}">${list.cd_val2}</option>
                          </c:if>
                          <c:if test="${tiemzone_cd eq '213004'}">
                            <option value="${list.cd_id}">${list.cd_val3}</option>
                          </c:if>
                        </c:if>
                      </c:forEach>
                    </select>
                  </div>

                  <div class="col-md-auto col-sm-12 pt-1">
                    <select name="consult_to_time" id="consult_to_time" class="bg-white form-control form-control-sm" style="width: 11rem;">
                      <c:forEach var="list" items="${timeList}">
                        <c:if test="${consult_to_time eq list.cd_id}">
                          <c:if test="${tiemzone_cd eq '213001'}">
                            <option value="${list.cd_id}" selected>${list.cd_nm}</option>
                          </c:if>
                          <c:if test="${tiemzone_cd eq '213002'}">
                            <option value="${list.cd_id}" selected>${list.cd_val1}</option>
                          </c:if>
                          <c:if test="${tiemzone_cd eq '213003'}">
                            <option value="${list.cd_id}" selected>${list.cd_val2}</option>
                          </c:if>
                          <c:if test="${tiemzone_cd eq '213004'}">
                            <option value="${list.cd_id}" selected>${list.cd_val3}</option>
                          </c:if>
                        </c:if>
                        <c:if test="${consult_to_time ne list.cd_id}">
                          <c:if test="${tiemzone_cd eq '213001'}">
                            <option value="${list.cd_id}">${list.cd_nm}</option>
                          </c:if>
                          <c:if test="${tiemzone_cd eq '213002'}">
                            <option value="${list.cd_id}">${list.cd_val1}</option>
                          </c:if>
                          <c:if test="${tiemzone_cd eq '213003'}">
                            <option value="${list.cd_id}">${list.cd_val2}</option>
                          </c:if>
                          <c:if test="${tiemzone_cd eq '213004'}">
                            <option value="${list.cd_id}">${list.cd_val3}</option>
                          </c:if>
                        </c:if>
                      </c:forEach>
                    </select>  
                  </div>

                  <div class="col-md-auto col-sm-12 pt-1">
                    <button type="button" class="btn-outline-primary form-control form-control-sm" style="width: 6rem;" id="btnSettime">설정</button>
                  </div>

                </div>

                <div class="table-responsive pb-1 d-flex justify-content-between">
                  <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" style="cursor:pointer" class="bi bi-arrow-left-circle btn-outline-primary" viewBox="0 0 16 16" id="left-circle">
                    <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-4.5-.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5z"/>
                  </svg>
                  <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" style="cursor:pointer" class="bi bi-arrow-right-circle btn-outline-primary" viewBox="0 0 16 16" id="right-circle">
                    <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z"/>
                  </svg>
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
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1" style="width:12%;" id="div_${list.k2_scheduleId}" onClick="scheduleClick('${list.k2_scheduleId}')">
                          <c:if test="${not empty list.k2_scheduleId}">
                          <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10" fill="currentColor" id="svg_${list.k2_scheduleId}" style="cursor:hand" class="bi bi-lightbulb-fill <c:choose><c:when test='${list.k2_consultAvailYn eq "Y"}'>text-warning</c:when> <c:otherwise>text-muted</c:otherwise></c:choose>" viewBox="0 0 16 16"><path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/></svg>
                          </c:if>
                        </div>
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1" style="width:12%;" id="div_${list.k3_scheduleId}" onClick="scheduleClick('${list.k3_scheduleId}')">
                          <c:if test="${not empty list.k3_scheduleId}">
                          <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10" fill="currentColor" id="svg_${list.k3_scheduleId}" style="cursor:hand" class="bi bi-lightbulb-fill <c:choose><c:when test='${list.k3_consultAvailYn eq "Y"}'>text-warning</c:when> <c:otherwise>text-muted</c:otherwise></c:choose>" viewBox="0 0 16 16"><path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/></svg>
                          </c:if>
                        </div>
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1" style="width:12%;" id="div_${list.k4_scheduleId}" onClick="scheduleClick('${list.k4_scheduleId}')">
                          <c:if test="${not empty list.k4_scheduleId}">
                          <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10" fill="currentColor" id="svg_${list.k4_scheduleId}" style="cursor:hand" class="bi bi-lightbulb-fill <c:choose><c:when test='${list.k4_consultAvailYn eq "Y"}'>text-warning</c:when> <c:otherwise>text-muted</c:otherwise></c:choose>" viewBox="0 0 16 16"><path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/></svg>
                          </c:if>
                        </div>
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1" style="width:12%;" id="div_${list.k5_scheduleId}" onClick="scheduleClick('${list.k5_scheduleId}')">
                          <c:if test="${not empty list.k5_scheduleId}">
                          <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10" fill="currentColor" id="svg_${list.k5_scheduleId}" style="cursor:hand" class="bi bi-lightbulb-fill <c:choose><c:when test='${list.k5_consultAvailYn eq "Y"}'>text-warning</c:when> <c:otherwise>text-muted</c:otherwise></c:choose>" viewBox="0 0 16 16"><path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/></svg>
                          </c:if>
                        </div>
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1" style="width:12%;" id="div_${list.k6_scheduleId}" onClick="scheduleClick('${list.k6_scheduleId}')">
                          <c:if test="${not empty list.k6_scheduleId}">
                          <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10" fill="currentColor" id="svg_${list.k6_scheduleId}" style="cursor:hand" class="bi bi-lightbulb-fill <c:choose><c:when test='${list.k6_consultAvailYn eq "Y"}'>text-warning</c:when> <c:otherwise>text-muted</c:otherwise></c:choose>" viewBox="0 0 16 16"><path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/></svg>
                          </c:if>
                        </div>
                        <div class="border border-top-0 border-right-0 text-center pt-1 pb-1" style="width:12%;" id="div_${list.k7_scheduleId}" onClick="scheduleClick('${list.k7_scheduleId}')">
                          <c:if test="${not empty list.k7_scheduleId}">
                          <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10" fill="currentColor" id="svg_${list.k7_scheduleId}" style="cursor:hand" class="bi bi-lightbulb-fill <c:choose><c:when test='${list.k7_consultAvailYn eq "Y"}'>text-warning</c:when> <c:otherwise>text-muted</c:otherwise></c:choose>" viewBox="0 0 16 16"><path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/></svg>
                          </c:if>
                        </div>
                        <div class="border border-top-0 text-center pt-1 pb-1" style="width:12%;" id="div_${list.k8_scheduleId}" onClick="scheduleClick('${list.k8_scheduleId}')">
                          <c:if test="${not empty list.k8_scheduleId}">
                          <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10" fill="currentColor" id="svg_${list.k8_scheduleId}" style="cursor:hand" class="bi bi-lightbulb-fill <c:choose><c:when test='${list.k8_consultAvailYn eq "Y"}'>text-warning</c:when> <c:otherwise>text-muted</c:otherwise></c:choose>" viewBox="0 0 16 16"><path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/></svg>
                          </c:if>
                        </div>
                      </div>
                      <!--list.k8_consultAvailYn eq "Y"}'>background-color:#e9ecef; --> 
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
    <jsp:include page="myc06_js.jsp"></jsp:include>   

  </body>
</html>