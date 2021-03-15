<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
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
              상담문의 내역
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="#">Home</a>
            </span>
            <span class="breadcrumb-item active">
              마이페이지
            </span>
            <span class="breadcrumb-item active">
              상담문의 내역
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>
    
    <!-- CONTENT
    ================================================== -->
    <section class="section pt-4">
      <div class="container">
        <div class="row">
          <div class="col-md-2">
            
             <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/cLeftMenu.jsp"></jsp:include>

          </div>
          <div class="col-md-10">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mb-4">
                상담문의 내역
              </h3>

              <form class="form-styled">
                <div class="form-row col-sm-12 border-bottom pt-2 pl-2">
                  <div class="col-sm-12"> <span>입력된 제목이 표시됩니다.</span> </div>
                </div>
                
                <div class="form-row col-sm-12 border-bottom p-2">
                  <div class="col-sm-3 small">부스명 | <span>주제 색션 A</span> </div>
                  <div class="col-sm-3 small">회원명 | <span>홍길동</span> </div>
                  <div class="col-sm-3 small">등록일 | <span>2021-04-01</span></div>
                  <div class="col-sm-3 small">상태 | <span>답변완료</span></div>
                </div>

                <div class="form-row col-sm-12  p-2">
                  <textarea class="form-control" name="contact-message" rows="7">Lorem ipsum dolor sit amet consectetur adipisicing elit. Quam deleniti cumque ea magnam laboriosam numquam quidem est iste labore recusandae non aperiam facere veniam asperiores impedit laborum, harum natus vero?
                  </textarea>
                </div>              

                
                <div class="form-row col-sm-12 border-bottom pt-3 pl-2">
                  <div class="col-sm-12"> <strong>답변내용</strong></div>
                </div>  
                
                <div class="form-row col-sm-12 border-bottom p-2">
                  <div class="col-sm-3 small">답변일자 | <span>2021-04-01</span></div>
                </div>    
                
                <div class="form-row col-sm-12 border-bottom p-2">
                    <div class="form-group col-12">
                      <!-- Message -->
                      <textarea class="form-control" name="contact-message" rows="7">Lorem ipsum dolor sit amet consectetur adipisicing elit. Quam deleniti cumque ea magnam laboriosam numquam quidem est iste labore recusandae non aperiam facere veniam asperiores impedit laborum, harum natus vero?
                      </textarea>
                    </div>
                </div>    
                
                <div class="form-row col-sm-12 pt-3 justify-content-between">
                  <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;">목록</button>
                  <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;">저장</button>
                </div>                

              </div>

            </form>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>

  </body>
</html>