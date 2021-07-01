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

    <div class="modal-body">
        <form class="form-styled bg-white pt-2 pb-2">

            <!-- Heading -->
            <div class="modal-header p-3  text-center">
                <h2 class="text-center" style="width:100%;">상담예약 반려</h2>
            </div>              

            <!-- 제목 -->
            <table class="basic-table-fix">
            <tr>
                <input type="hidden" name="schedule_id" id="schedule_id" value="<c:out value='${schedule_id}'/>"/>
                <input type="hidden" name="consult_rsv_stat_cd" id="consult_rsv_stat_cd" value="<c:out value='${consult_rsv_stat_cd}'/>"/>
                <td class="text-center">반려사유</td>
                <td class="text-center"><input type="text" class="form-control form-control-sm" id="remarks" name="remarks" maxlength="200"></td>
            </tr>
            </table>

            <!-- 내용 -->
            <div class="form-group bt-1">
                <div class="text-center text-md-center" style="padding-top: 1.0rem;">
                    
                    <button type="button" class="basic-btn" style="width: 7rem;" id="btnReturnConfirm">
                        반려확정
                    </button>
                    <button type="button" class="basic-btn" style="width: 7rem;background:#bebebe" id="btnReturnCncl">
                        반려취소
                    </button>

                </div> 
            </div>
            </div>

        </form>

    </div>

    <jsp:include page="/WEB-INF/jsp/include/footer_vr.jsp"></jsp:include>
    <jsp:include page="myc07P02_js.jsp"></jsp:include>   

  </body>
</html>