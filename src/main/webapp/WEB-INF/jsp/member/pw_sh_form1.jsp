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
    
    <!-- FULLPAGE
    ================================================== -->
    <section class="section section-full section-top bg-light">

      <!-- Content -->
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-md-8 col-lg-6">

            <!-- Form -->
            <form class="form-styled bg-white">

              <!-- Heading -->
              <h2 class="text-center mb-4">
                비밀번호 찾기
              </h2>

              <!-- 아이디 -->
              <div class="form-group">
                
                <!-- 아이디 -->
                <label>아이디</label>
                <div class="input-group">
                  <input type="text" name="cust_id" class="form-control order-1">
                  <div class="input-group-append order-0">
                    <div class="input-group-text">
                      <svg class="input-group-icon icon-offset icon icon-person" viewBox="0 0 106 106" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path transform="translate(3 3)" d="M0 100 A 50 50 0 0 1 50 60 A 20 20 0 0 1 50 0 A 20 20 0 0 1 50 60 A 50 50 0 0 1 100 100"></path>
                      </svg>
                    </div>
                  </div>
                </div>

              </div>

              <!-- 이름 -->
              <div class="form-group">

                <!-- 이름 -->
                <label>이름</label>
                <div class="input-group">
                  <input type="text" name="cust_nm" class="form-control order-1">
                  <div class="input-group-append order-0">
                    <div class="input-group-text">
                      <svg class="input-group-icon icon-offset icon icon-person" viewBox="0 0 106 106" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path transform="translate(3 3)" d="M0 100 A 50 50 0 0 1 50 60 A 20 20 0 0 1 50 0 A 20 20 0 0 1 50 60 A 50 50 0 0 1 100 100"></path>
                      </svg>
                    </div>
                  </div>
                </div>

              </div>

              <!-- 이메일 -->
              <div class="form-group">
                
                <!-- Email -->
                <label>이메일</label>
                <div class="input-group">
                  <input type="email" name="email_id" class="form-control order-1">
                  <div class="input-group-append order-0">
                    <div class="input-group-text">
                      <svg class="input-group-icon icon-offset icon icon-envelope" viewBox="0 0 106 106" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path transform="translate(3 3)" d="
                          M0 30 V 10 H 100 V 90 H 0 V 30 L 50 60 L 100 30">
                        </path>
                      </svg>
                    </div>
                  </div>
                </div>

              </div>

              <!-- Footer -->
              <div class="form-row align-items-center">
                <div class="col-md">

                  <!-- Button -->
                  <div class="text-center text-md-right">
                    <button type="button" class="btn btn-outline-primary" id="btnPwInit">
                      비밀번호 찾기
                    </button>
                  </div>

                </div>
              </div> <!-- / .form-row -->

                      

              <!-- Link -->
              <p class="text-center text-muted mt-3 mb-0">
                <small>
                   <a href="/member/id_sh_form1">아이디 찾기</a>
                </small>
              </p>

            </form>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
      
    </section>

  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="pw_sh_form1_js.jsp"></jsp:include>

  </body>
</html>