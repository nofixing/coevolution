<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
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

    <!-- 모달 영역 -->
<div id="myModal" tabindex="-1">
  <!-- div class="modal-dialog" role="document" -->
  <div class="p-3" role="document" style="max-width:100%; max-height:100%;">
    <div class="modal-content">
      <div class="modal-body p-0">

        <form class="form-styled bg-white pt-2 pb-2">

          <!-- NAV -->
          <nav class="nav nav-tabs mb-5" id="nav">
            <!-- Content -->
            <a class="nav-item nav-link active" data-toggle="tab" href="#nav1">
              Q & A
            </a>
            <a class="nav-item nav-link" data-toggle="tab" href="#nav2" onClick="doConsultView()">
              상담신청
            </a>
          </nav>

          <div class="tab-content">

            <div class="tab-pane fade show pb-5 boot-tab-pane active" id="nav1">
              <!-- Heading -->
              <div class="modal-header p-3  text-center">
                <h2 class="text-center" style="width:100%;">Q & A<span class="mobile-text"></span></h2>
              </div>              

              <h6 class="text-left mb-2 pb-2">
                <small style="font-size:16px;">궁금하신 점이나 의견을 남겨주세요.</small></br>
                <small style="font-size:16px;">문의하신 내용은 담당자가 확인하여 친절하게 답변 드리겠습니다.</small>
              </h6>              

              <small>* 당일 16시 이후 문의 건은 익일 오전 9시 이후 답변 가능합니다.(단, 주말 공휴일 제외)</small>
              <!-- 제목 -->
              <table class="basic-table">
                <tr>
                  <th><label>제목</label></th>
                  <td><input type="text" class="form-control form-control-sm" id="board_subject" name="board_subject"></td>
                </tr>
                <tr>
                  <th><label>내용</label></th>
                  <td><textarea class="form-control form-control-sm" rows="10" id="board_content" name="board_content"></textarea></td>
                </tr>
              </table>
              <small>* 로그인 후 등록 가능합니다.</small>
              <!-- 내용 -->
              <div class="form-group bt-1">
                <div class="text-center text-md-center" style="padding-top: 1.0rem;">
                  <button type="button" class="basic-btn" style="width: 7rem;" id="btnSave">
                    등록
                  </button>
                </div> 

              </div>
            </div>

            <div class="tab-pane fade boot-tab-pane pb-5" id="nav2">
              <div class="p-0" id="iframeConsult"></div>
            </div>

          </div>

        </form>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/jsp/include/footer_vr.jsp"></jsp:include>
<jsp:include page="vr_coslt_form_js.jsp"></jsp:include>

  </body>
</html>