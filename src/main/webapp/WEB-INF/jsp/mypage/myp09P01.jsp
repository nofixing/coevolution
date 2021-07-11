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
        <!-- https://usang0810.tistory.com/30 -->
        #tbList {
            border-collapse: collapse;
        }
        #tbList th {
            position: sticky;
            top: 0px;
        }
        .basic-table-fix td{
            padding:5px 10px;
            border-bottom:1px solid #e7e7e7;
            border-left:0px solid #e7e7e7;
            box-sizing:border-box;
        }
        
    </style>

  </head>
  <body>

    <div class="modal-body">
        <form class="form-styled bg-white pt-2 pb-2" style="height:36.5rem">

            <!-- Heading -->
            <div class="modal-header p-3  text-center">
                <h2 class="text-center" style="width:100%;"><spring:message code="form.meet.exhibitor.booth" text="참가업체"/> <spring:message code="form.search" text="조회"/></h2>
            </div>              

            <div class="input-group pb-3">
                <input type="text" class="form-control form-control-sm p-1" id="consultCustNm" name="consultCustNm" value="${consultCustNm}">
                <input type="hidden" id="search_yn" name="search_yn" value="Y"/>
                <div class="input-group-append">
                    <button class="basic-btn" type="button" id="btnCustInfo"><spring:message code="form.meet.company.search" text="참가업체조회"/></button>
                </div>
            </div>

            <!-- 제목 -->
            <div style="overflow: auto;height:360px">
                <table class="basic-table-fix table-sm" id="tbList">
                    <tr>
                        <th style="width:15%"><span><spring:message code="form.favorite.booths.no" text="번호"/></span></th>
                        <th style="width:55%"><span><spring:message code="form.meet.exhibitor" text="업체명"/></span></th>
                        <th style="width:30%"><span><spring:message code="left.menu.login.id" text="아이디"/></span></th>
                    </tr>

                    <c:forEach var="list" items="${custList}" varStatus="status">
                    <tr>
                        <input type="hidden" name="consult_time_id" id="consult_time_id" value="<c:out value='${list.consult_time_id}'/>"/>
                        <input type="hidden" name="ev_expo_id" id="ev_expo_id" value="<c:out value='${list.ev_expo_id}'/>"/>
                        <td class="text-center"><c:out value="${list.rn}"/></td>
                        <td class="text-left"><a href="javascript:fnDetail('<c:out value="${list.cust_id}"/>','<c:out value="${list.cust_nm}"/>')"><c:out value="${list.cust_nm}"/></a></td>
                        <td class="text-center"><c:out value="${list.cust_id}"/></td>
                    </tr>
                    </c:forEach>

                    <c:if test="${fn:length(custList) eq 0}">
                    <tr>
                        <td class="text-center" colspan="3"><spring:message code="form.no.search" text="조회된 내용이 없습니다."/></td>
                    </tr>
                    </c:if>
                    
                </table>
            </div>

            <!-- 내용 -->
            <div class="form-group bt-1">
                <div class="text-center text-md-center" style="padding-top: 1.0rem;">
                    <button type="button" class="basic-btn" style="width: 7rem;background:#bebebe" id="btnClose">
                        <spring:message code="form.close" text="닫기"/>
                    </button>
                </div> 
            </div>
            </div>

        </form>

    </div>

    <jsp:include page="/WEB-INF/jsp/include/footer_vr.jsp"></jsp:include>
    <jsp:include page="myp09P01_js.jsp"></jsp:include>   

  </body>
</html>