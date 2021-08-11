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

    #tableList {
        border-collapse: collapse;
    }
    #tableList th {
        position: sticky;
        background-color:#e7e7e7;
        top: 0px;
    }
    .basic-table-fix td {
        padding:5px 10px;
        border-bottom:1px solid #e7e7e7;
        border-left:0px solid #e7e7e7;
        box-sizing:border-box;
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
              <spring:message code="left.menu.meeting.reservation" text="상담신청현황"/>
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
              <spring:message code="left.menu.meeting.reservation" text="상담신청현황"/>
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
                  <spring:message code="left.menu.meeting.reservation" text="상담신청현황"/>
                </strong>
              </h3>

              <form class="form-styled">
                <input type="hidden" name="page_current" id="page_current"/>
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
                        <div class="col-sm-6 pt-1 pl-1 pr-1">
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

                        <div class="col-sm-3 pt-1 pl-1 pr-1">
                          <select name="sh_consult_sts_cd" id="sh_consult_sts_cd" class="form-control form-control-sm" style="width:100%;">
                            <option value="" <c:if test="${sh_consult_sts_cd eq ''}">selected</c:if>>전체</option>
                            <c:forEach var="list" items="${consultStsList}">
                              <c:if test="${sh_consult_sts_cd eq list.cd_id}">
                                <option value="${list.cd_id}" selected>${list.cd_nm}</option>
                              </c:if>
                              <c:if test="${sh_consult_sts_cd ne list.cd_id}">
                                <option value="${list.cd_id}">${list.cd_nm}</option>
                              </c:if>
                            </c:forEach>
                          </select>
                        </div>

                        <div class="col-sm-3 pt-1 pl-1 pr-1">
                          <select name="form_clsf" id="form_clsf" class="form-control form-control-sm" style="width:100%;">
                            <option value="1">달력</option>
                            <option value="2" selected>리스트</option>
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
                        <input type="date" class="form-control form-control-sm mb-2" id="sh_consult_from_dt" name="sh_consult_from_dt" value="${sh_consult_from_dt}"> <span class="pl-2 pr-2">~</span>
                        <input type="date" class="form-control form-control-sm mb-2" id="sh_consult_to_dt" name="sh_consult_to_dt" value="${sh_consult_to_dt}">
                      </div>
                    </div>
                    <div class="col-4 form-inline d-flex justify-content-end">
                      <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnSearch">조회</button>
                    </div>
                </div>  

                <!-- Subheading -->
                <div class="table-responsive" style="overflow-x: auto; overflow-y: auto;white-space:nowrap; height: 30rem;">
                  <table class="table table-sm border-bottom basic-table-fix" id="tableList">
                    <thead>
                      <tr>
                        <th class="text-center">번호</th>
                        <th class="text-left">업체명</th>
                        <th class="text-center">상담일시</th>
                        <th class="text-center">상담상태</th>
                        <th class="text-center">처리일시</th>
                      </tr>               
                    </thead>
                    <tbody id="codeList">

                      <c:forEach var="list" items="${list}" varStatus="status">

                      <tr>
                        <td class="text-center">${list.rn}</td>
                        <td class="text-left">${list.consult_rsv_cust_nm}</td>
                        <td class="text-center">${list.consult_dt_dtm}</td>
                        <td class="text-center">
                          <c:if test="${list.consult_rsv_stat_cd eq '215003' || list.consult_rsv_stat_cd eq '215004'}">
                            ${list.consult_rsv_stat_nm}
                          </c:if>
                          <c:if test="${list.consult_rsv_stat_cd eq '215001' || list.consult_rsv_stat_cd eq '215002'}">
                            <a href="javascript:scheduleClick('${list.schedule_id}')">${list.consult_rsv_stat_nm}</a>
                          </c:if>
                        </td>
                        <td class="text-center">${list.mod_dtm}</td>
                      </tr>   

                      </c:forEach>

                      <c:if test="${fn:length(list) == 0}">
                      <tr>
                        <td scope="row" class="text-center" colspan="5">조회된 내용이 없습니다.</td>
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
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myp08P03_js.jsp"></jsp:include>   

  </body>
</html>