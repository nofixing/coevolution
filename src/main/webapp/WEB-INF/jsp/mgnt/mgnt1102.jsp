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
                  엑스포참가업체관리
                </strong>
              </h3>
              <form name="form1" class="form-styled">
                
                <div class="form-inline d-flex justify-content-between">
                  <input type="text" class="form-control form-control-sm mb-2" id="ev_expo_nm" name="ev_expo_nm" value="${expo_dtl.ev_expo_nm}" style="width: 20rem;" readonly>
                  <input type="hidden" id="ev_expo_id" name="ev_expo_id" value="${expo_dtl.ev_expo_id}">
                  <div class="form-inline">
                    <button type="button" class="btn-outline-primary form-control form-control-sm ml-2 mb-2" style="width: 12rem;" id="btnConsultTime">상담시간 미설정 일괄생성</button>
                    <button type="button" class="btn-outline-primary form-control form-control-sm ml-2 mb-2" style="width: 6rem;" id="btnUpdate">저장</button>
                    <button type="button" class="btn-outline-primary form-control form-control-sm ml-2 mb-2" style="width: 6rem;" id="btnList">목록</button>
                  </div>
                </div>  

                <div class="table-responsive" style="overflow-x: auto; overflow-y: auto;white-space:nowrap; height: 30rem;">
                  <table class="table table-sm border-bottom basic-table-fix" id="tableList">
                    <thead>
                      <tr>
                        <th class="text-center">번호</th>
                        <th class="text-center"><a href="javascript:listCheck()">선택</a></th>
                        <th class="text-center">아이디</th>
                        <th class="text-left">참가업체명</th>
                        <th class="text-center">상태</th>
                        <th class="text-center">상시간설정여부</th>
                      </tr>               
                    </thead>
                    <tbody id="codeList">

                      <c:forEach var="list" items="${list}" varStatus="status">

                      <tr>
                        <td class="text-center">${list.rn}</td>
                        <td class="text-center"><input type="checkbox" id="chk_${list.cust_id}" name="chk_${list.cust_id}" value="Y" <c:if test="${list.reg_stat eq 'Y'}">checked</c:if>/></td>
                        <td class="text-center">${list.cust_id}</td>
                        <td class="text-left">${list.cust_nm}</td>
                        <td class="text-center"><c:if test="${list.reg_stat eq 'Y'}">등록</c:if><c:if test="${list.reg_stat eq 'N'}">미등록</c:if></td>
                        <td class="text-center"><c:if test="${list.consult_time_stat eq 'Y'}">등록</c:if><c:if test="${list.consult_time_stat eq 'N'}">미등록</c:if></td>
                      </tr>   

                      </c:forEach>

                      <c:if test="${fn:length(list) == 0}">
                      <tr>
                        <td scope="row" class="text-center" colspan="6">조회된 내용이 없습니다.</td>
                      </tr>                
                      </c:if> 
                    </tbody>
                  </table>

              </form>
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

  <jsp:include page="/WEB-INF/jsp/include/footer_mgnt.jsp"></jsp:include>
  <jsp:include page="mgnt1102_js.jsp"></jsp:include>   

  </body>
</html>