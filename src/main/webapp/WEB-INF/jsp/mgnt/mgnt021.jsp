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
                  상담문의
                </strong>
              </h3>

              <form class="form-styled">
                <div class="form-row col-sm-12 pt-2 pl-2" style="border-bottom: solid 1px;">
                  <div class="col-sm-12"> <span id="board_subject"></span> </div>
                </div>
                
                <div class="form-row col-sm-12 border-bottom p-2">
                  <div class="col-sm-3 border-right">등록자</div>
                  <div class="col-sm-9" id="conslt_cust_nm"></div>
                </div>

                <div class="form-row col-sm-12 border-bottom p-2">
                  <div class="col-sm-3 border-right">이메일</div>
                  <div class="col-sm-9" id="email_id"></div>
                </div>     

                <div class="form-row col-sm-12 border-bottom p-2">
                  <div class="col-sm-3 border-right">등록일</div>
                  <div class="col-sm-9" id="reg_dt"></div>
                </div>         

                <div class="form-row col-sm-12 border-bottom p-2">
                  <div class="col-sm-3 border-right">답변여부</div>
                  <div class="col-sm-9" id="board_stat_nm"></div>
                </div>       

                <div class="form-row col-sm-12 border-bottom p-2">
                  <div class="col-sm-3 border-right">제목</div>
                  <div class="col-sm-9" id="board_subject"></div>
                </div>                                                    

                <pre><div class="form-row col-sm-12 p-2" id="board_content" style="border-bottom: solid 1px;"></div></pre>       

                <div class="form-row col-sm-12 pl-2 pt-5" style="border-bottom: solid 1px;">
                  <div class="col-sm-3 border-right">답변일자</div>
                  <div class="col-sm-9" id="board_reply_ins_dtm"></div>
                </div>  

                <div class="form-row col-sm-12 pt-2 border-bottom pl-2">
                  <div class="col-sm-12"> <strong>답변내용</strong></div>
                </div>  

                <div class="form-row col-sm-12 p-2" style="border-bottom: solid 1px;">
                  <textarea class="form-control" name="contact-message" rows="7" id="board_reply_content"></textarea>
                </div>               

                <div class="form-row col-sm-12 pt-3 pr-0 justify-content-end">
                  <button type="button" class="btn-outline-primary form-control form-control-sm mb-2 mr-2" style="width: 6rem;" id="btnList">목록</button>
                  <button type="button" class="btn-outline-primary form-control form-control-sm mb-2 mr-2" style="width: 6rem;" id="btnDel">삭제</button>
                  <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnSave">답변하기</button>
                </div>

              </div>

            </form>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer_mgnt.jsp"></jsp:include>
    <jsp:include page="mgnt021_js.jsp"></jsp:include>

  </body>
</html>