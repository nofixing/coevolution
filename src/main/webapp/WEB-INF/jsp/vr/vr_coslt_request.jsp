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
    .blue-200 {
      background-color : #9ec5fe;
    }
    .gray-500 {
      background-color : #adb5bd;
    }

    .yellow-200-color {
      color : #ffe69c;
    }
    .purple-100-color {
      color : #e2d9f3;
    }
    .blue-200-color {
      color : #9ec5fe;
    }
    .gray-500-color {
      color : #adb5bd;
    }

    
  </style>

  </head>
  <body>    
    <div id="mainBody"></div>
    <form class="form-styled p-0 border-0 overflow-hidden" style="scroll-color:red">
      <input type="hidden" name="consult_time_id" id="consult_time_id"/>
      <input type="hidden" name="consult_rsv_cust_id" id="consult_rsv_cust_id" value="${sessionScope.login_session.cust_id}"/>
      <input type="hidden" name="sunday" id="sunday" value="${sunday}"/>
      <input type="hidden" name="sh_cls_cd" id="sh_cls_cd"/>
      <input type="hidden" name="consult_from_dt" id="consult_from_dt" value="${consult_from_dt}"/>
      <input type="hidden" name="consult_to_dt" id="consult_to_dt" value="${consult_to_dt}"/>
      <input type="hidden" name="consultCustId" id="consultCustId"  value="${consultCustId}">

      <div class="col-md col-sm-12 pt-1 pr-0 d-flex justify-content-end">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill blue-200-color" style="cursor:pointer;" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M4 0h8a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2z"/>
          </svg> <spring:message code="form.meet.req.available" text="상담가능"/>
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill purple-100-color" style="cursor:pointer;" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M4 0h8a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2z"/>
          </svg> <spring:message code="form.meet.req" text="상담신청"/>
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill yellow-200-color" style="cursor:pointer;" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M4 0h8a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2z"/>
          </svg> <spring:message code="form.meet.fix.meet" text="상담확정"/>
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill gray-500-color" style="cursor:pointer;" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M4 0h8a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2z"/>
          </svg> <spring:message code="form.meet.req.unavailable" text="상담불가"/>
      </div>

      <!--상담시간설정-->
      <div class="form-row align-items-center pb-3">
          <div class="col-md-2 col-sm-12 pt-1">
              <span class="form-control form-control-sm" style="background-color:#f7f7f7"><spring:message code="form.meet.timezone" text="타임존"/></span>
          </div>

          <div class="col-md-3 col-sm-12 pt-1">
              <select name="tiemzone_cd" id="tiemzone_cd" class="form-control form-control-sm" style="width: 11rem;">
                <c:forEach var="list" items="${timezoneList}">
                  <c:if test="${tiemzone_cd eq list.cd_id}">
                      <c:if test="${sessionScope.LANG ne 'en'}">
                      <option value="${list.cd_id}" selected>${list.cd_nm}</option>
                    </c:if>
                    <c:if test="${sessionScope.LANG eq 'en'}">
                      <option value="${list.cd_id}" selected>${list.cd_nm_en}</option>
                    </c:if> 
                  </c:if>
                  <c:if test="${tiemzone_cd ne list.cd_id}">
                    <c:if test="${sessionScope.LANG ne 'en'}">
                      <option value="${list.cd_id}">${list.cd_nm}</option>
                    </c:if>
                    <c:if test="${sessionScope.LANG eq 'en'}">
                      <option value="${list.cd_id}">${list.cd_nm_en}</option>
                    </c:if> 
                  </c:if>
                </c:forEach>
              </select>
          </div>
      </div>

      <div class="table-responsive pb-1 d-flex justify-content-between">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" style="cursor:pointer" class="bi bi-arrow-left-circle btn-outline-primary" style="cursor:pointer;" viewBox="0 0 16 16" id="left-circle">
          <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-4.5-.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5z"/>
        </svg>
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" style="cursor:pointer" class="bi bi-arrow-right-circle btn-outline-primary" style="cursor:pointer;" viewBox="0 0 16 16" id="right-circle">
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
              <div class="border border-top-0 border-right-0 text-center pt-1 pb-1" style="width:12%;" id="div_${list.k2_scheduleId}" <c:if test="${list.k2_consultRsvCustId eq sessionScope.login_session.cust_id || empty list.k2_consultRsvCustId}">onClick="scheduleClick('${list.k2_scheduleId}','${list.k2_consultRsvStatCd}')" </c:if>>
                <c:choose>
                  <c:when test = "${list.k2_consultRsvStatCd eq '215001' && list.k2_consultRsvCustId eq sessionScope.login_session.cust_id}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill purple-100-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${list.k2_consultRsvStatCd eq '215002' && list.k2_consultRsvCustId eq sessionScope.login_session.cust_id}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill yellow-200-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${(list.k2_expoYn eq 'Y' && empty list.k2_scheduleId && !empty consultCustId) ||list.k2_consultAvailYn eq 'N'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill gray-500-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${list.k2_expoYn eq 'Y'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill blue-200-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                </c:choose>
              </div>
              <div class="border border-top-0 border-right-0 text-center pt-1 pb-1" style="width:12%;" id="div_${list.k3_scheduleId}" <c:if test="${list.k3_consultRsvCustId eq sessionScope.login_session.cust_id || empty list.k3_consultRsvCustId}">onClick="scheduleClick('${list.k3_scheduleId}','${list.k3_consultRsvStatCd}')" </c:if>>
                <c:choose>
                  <c:when test = "${list.k3_consultRsvStatCd eq '215001' && list.k3_consultRsvCustId eq sessionScope.login_session.cust_id}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill purple-100-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${list.k3_consultRsvStatCd eq '215002' && list.k3_consultRsvCustId eq sessionScope.login_session.cust_id}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill yellow-200-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${(list.k3_expoYn eq 'Y' && empty list.k3_scheduleId && !empty consultCustId) ||list.k3_consultAvailYn eq 'N'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill gray-500-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${list.k3_expoYn eq 'Y'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill blue-200-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                </c:choose>
              </div>
              <div class="border border-top-0 border-right-0 text-center pt-1 pb-1" style="width:12%;" id="div_${list.k4_scheduleId}" <c:if test="${list.k4_consultRsvCustId eq sessionScope.login_session.cust_id || empty list.k4_consultRsvCustId}">onClick="scheduleClick('${list.k4_scheduleId}','${list.k4_consultRsvStatCd}')" </c:if>>
                <c:choose>
                  <c:when test = "${list.k4_consultRsvStatCd eq '215001' && list.k4_consultRsvCustId eq sessionScope.login_session.cust_id}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill purple-100-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${list.k4_consultRsvStatCd eq '215002' && list.k4_consultRsvCustId eq sessionScope.login_session.cust_id}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill yellow-200-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${(list.k4_expoYn eq 'Y' && empty list.k4_scheduleId && !empty consultCustId) ||list.k4_consultAvailYn eq 'N'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill gray-500-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${list.k4_expoYn eq 'Y'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill blue-200-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                </c:choose>
              </div>
              <div class="border border-top-0 border-right-0 text-center pt-1 pb-1" style="width:12%;" id="div_${list.k5_scheduleId}" <c:if test="${list.k5_consultRsvCustId eq sessionScope.login_session.cust_id || empty list.k5_consultRsvCustId}">onClick="scheduleClick('${list.k5_scheduleId}','${list.k5_consultRsvStatCd}')" </c:if>>
                <c:choose>
                  <c:when test = "${list.k5_consultRsvStatCd eq '215001' && list.k5_consultRsvCustId eq sessionScope.login_session.cust_id}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill purple-100-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${list.k5_consultRsvStatCd eq '215002' && list.k5_consultRsvCustId eq sessionScope.login_session.cust_id}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill yellow-200-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${(list.k5_expoYn eq 'Y' && empty list.k5_scheduleId && !empty consultCustId) ||list.k5_consultAvailYn eq 'N'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill gray-500-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${list.k5_expoYn eq 'Y'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill blue-200-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                </c:choose>
              </div>
              <div class="border border-top-0 border-right-0 text-center pt-1 pb-1" style="width:12%;" id="div_${list.k6_scheduleId}" <c:if test="${list.k6_consultRsvCustId eq sessionScope.login_session.cust_id || empty list.k6_consultRsvCustId}">onClick="scheduleClick('${list.k6_scheduleId}','${list.k6_consultRsvStatCd}')" </c:if>>
                <c:choose>
                  <c:when test = "${list.k6_consultRsvStatCd eq '215001' && list.k6_consultRsvCustId eq sessionScope.login_session.cust_id}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill purple-100-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${list.k6_consultRsvStatCd eq '215002' && list.k6_consultRsvCustId eq sessionScope.login_session.cust_id}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill yellow-200-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${(list.k6_expoYn eq 'Y' && empty list.k6_scheduleId && !empty consultCustId) ||list.k6_consultAvailYn eq 'N'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill gray-500-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${list.k6_expoYn eq 'Y'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill blue-200-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                </c:choose>
              </div>
              <div class="border border-top-0 border-right-0 text-center pt-1 pb-1" style="width:12%;" id="div_${list.k7_scheduleId}" <c:if test="${list.k7_consultRsvCustId eq sessionScope.login_session.cust_id || empty list.k7_consultRsvCustId}">onClick="scheduleClick('${list.k7_scheduleId}','${list.k7_consultRsvStatCd}')" </c:if>>
                <c:choose>
                  <c:when test = "${list.k7_consultRsvStatCd eq '215001' && list.k7_consultRsvCustId eq sessionScope.login_session.cust_id}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill purple-100-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${list.k7_consultRsvStatCd eq '215002' && list.k7_consultRsvCustId eq sessionScope.login_session.cust_id}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill yellow-200-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${(list.k7_expoYn eq 'Y' && empty list.k7_scheduleId && !empty consultCustId) ||list.k7_consultAvailYn eq 'N'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill gray-500-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${list.k7_expoYn eq 'Y'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill blue-200-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                </c:choose>
              </div>
              <div class="border border-top-0 text-center pt-1 pb-1" style="width:12%;" id="div_${list.k8_scheduleId}" <c:if test="${list.k8_consultRsvCustId eq sessionScope.login_session.cust_id|| empty list.k8_consultRsvCustId}">onClick="scheduleClick('${list.k8_scheduleId}','${list.k8_consultRsvStatCd}')" </c:if>>
                <c:choose>
                  <c:when test = "${list.k8_consultRsvStatCd eq '215001' && list.k8_consultRsvCustId eq sessionScope.login_session.cust_id}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill purple-100-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${list.k8_consultRsvStatCd eq '215002' && list.k8_consultRsvCustId eq sessionScope.login_session.cust_id}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill yellow-200-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${(list.k8_expoYn eq 'Y' && empty list.k8_scheduleId && !empty consultCustId) ||list.k8_consultAvailYn eq 'N'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill gray-500-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                  <c:when test = "${list.k8_expoYn eq 'Y'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lightbulb-fill blue-200-color" style="cursor:pointer;" viewBox="0 0 16 16">
                      <path d="M2 6a6 6 0 1 1 10.174 4.31c-.203.196-.359.4-.453.619l-.762 1.769A.5.5 0 0 1 10.5 13h-5a.5.5 0 0 1-.46-.302l-.761-1.77a1.964 1.964 0 0 0-.453-.618A5.984 5.984 0 0 1 2 6zm3 8.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1l-.224.447a1 1 0 0 1-.894.553H6.618a1 1 0 0 1-.894-.553L5.5 15a.5.5 0 0 1-.5-.5z"/>
                    </svg>
                  </c:when>
                </c:choose>
              </div>
            </div>

          </c:if>

        </c:forEach>
      </div>
    
    </form>


    <jsp:include page="/WEB-INF/jsp/include/footer_vr.jsp"></jsp:include>
    <jsp:include page="vr_coslt_request_js.jsp"></jsp:include>   

  </body>
</html>