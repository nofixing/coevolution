<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>
  </head>
  <body>

    <!-- FULLPAGE
    ================================================== -->
    <section class="section section-full section-top bg-light pb-3 pt-3">

      <!-- Content -->
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-sm-12">

            <!-- Form -->
            <form class="form-styled bg-white pt-2 pb-2">

              <!-- Heading -->
              <div class="modal-header pb-1">
                <h2 class="text-center">상담문의(Contact Us)</h2>
                <button type="button" class="btn-close"></button>
              </div>              

              <h6 class="text-left mb-2 pb-2">
                <small>* 궁금하신 점이나 의견을 남겨주세요.</small></br>
                <small>* 문의하신 내용은 담당자가 확인하여 친절하게 답변 드리겠습니다.</small>
              </h6>              

              <!-- 제목 -->
              <div class="form-group">
                
                <!-- 제목 -->
                <label>제목</label> <label class="text-danger">*</label>
                <div class="input-group">
                  <input type="text" class="form-control form-control-sm">
                </div>

              </div>

              <!-- 내용 -->
              <div class="form-group">
                
                <!-- 내용 -->
                <label>내용</label> <label class="text-danger">*</label>
                <div class="input-group">
                  <textarea class="form-control form-control-sm" rows="5"></textarea>
                </div>


                <div class="text-center text-md-center" style="padding-top: 1.0rem;">
                  <button type="button" class="btn btn-outline-primary form-control-sm pt-2" style="width: 7rem;" onclick="#">
                    등록
                  </button>
                </div> 

              </div>


            </form>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
      
    </section>


    <jsp:include page="/WEB-INF/jsp/include/footer_vr.jsp"></jsp:include>

  </body>
</html>