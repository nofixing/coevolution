<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/mHeader.jsp"></jsp:include>
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
                  ${page_clsf_nm}
                </strong>
              </h3>

              <form class="form-styled">

                <h5><li>국문</li></h5>
                <div class="form-row col-sm-12 p-2">
                  <textarea class="form-control" name="board_content" rows="10" id="board_content"></textarea>
                  <input type="hidden" name="board_id" id="board_id">
                </div>               
                <h5 class="mt-4"><li>영문</li></h5>
                <div class="form-row col-sm-12 p-2">
                  <textarea class="form-control" name="board_content2" rows="10" id="board_content2"></textarea>
                  <input type="hidden" name="board_id" id="board_id">
                </div>

                <div class="form-row col-sm-12 pt-3 pr-0 justify-content-end">
                  <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnSave">수정</button>
                </div>

              </form>
            
            </div>

          </div>

        </div> <!-- / .row -->
      </div> <!-- / .container -->

    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer_mgnt.jsp"></jsp:include>
    <jsp:include page="mgnt0702_js.jsp"></jsp:include>

  </body>
</html>