<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>
  </head>
  <body>

    <!-- 이메일용
    ================================================== -->
    <section class="section section-full section-top bg-light">

      <!-- Content -->
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-md-8 col-lg-6">

            <!-- Form -->
            <form class="form-styled bg-white">

              <!-- Heading -->
              <h2 class="text-center mb-1">
                버추얼 아일랜드
              </h2>
              <h6 class="text-center"><small>(임시 비밀번호가 발급되었습니다.)</small></h6>

              <!-- 아이디 -->
              <div class="form-group" style="border: 1px solid #a9a9a9;padding: 10px;">
                
                <label>홍길동님, 안녕하세요! </label>
                <label>임시 비밀번호가 발급되었습니다.</label>
                <label>아래 비밀번호를 통해 로그인이 가능 하며, 로그인 하신 후 꼭 비밀번호를 변경해 주시기 바랍니다.</label>
              </div>


              <!-- 임시비밀번호 -->
              <div class="form-group">
                
                <!-- 임시비밀번호 -->
                <label>임시비밀번호</label>
                <div class="input-group">
                  <input type="text" class="form-control order-1" readonly>
                  <div class="input-group-append order-0">
                    <div class="input-group-text">
                      <svg class="input-group-icon icon-offset icon icon-lock" viewBox="0 0 106 106" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path transform="translate(3 3)" d="M25 50 V 20 A 25 25 0 0 1 50 0 A 25 25 0 0 1 75 20 V 50 H 90 V 100 H 10 V 50 H 75 M50 85 A 5 5 0 0 1 45 80 V 70 A 5 5 0 0 1 50 65 A 5 5 0 0 1 55 70 V 80 A 5 5 0 0 1 50 85"></path>
                      </svg>
                    </div>
                  </div>
                </div>

              </div>


              <!-- Footer -->
              <div class="form-row align-items-center">
                <div class="col-md">

                  <!-- Button -->
                  <div class="text-center text-md-center">
                    <button type="button" class="btn btn-outline-primary" style="width: 100%;">
                      로그인
                    </button>
                  </div>

                </div>
              </div> <!-- / .form-row -->

                      

              <!-- Link -->
              <p class="text-center text-muted mt-3 mb-0">
                <small>
                  * 본 메일은 발신전용으로 회신 되지 않습니다.
                </small>
              </p>

            </form>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
      
    </section>

    <!-- FOOTER
    ================================================== -->
    <footer class="section bg-dark">

      <!-- Triangles -->
      <div class="bg-triangle bg-triangle-light bg-triangle-bottom bg-triangle-left"></div>
      <div class="bg-triangle bg-triangle-light bg-triangle-bottom bg-triangle-right"></div>

      <!--Content -->
      <div class="container">
        <div class="row align-self-center">
          <div class="col-md-auto">

            <!-- Brand -->
            <p>
              <a href="#" class="footer-brand text-white">
                <svg class="footer-brand-svg" viewBox="0 0 235 80" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                  <path d="M0 0 L 20 10 L 0 20 Z" class="text-primary" fill="currentColor"></path>
                  <path d="M0 30 L 20 40 L 0 50 Z M20 45 L 0 55 L 20 65 Z M0 60 L 20 70 L 0 80 Z" fill="currentColor"></path>
                  <text x="40" y="70" font-family="Arial, sans-serif" font-size="60" font-weight="bold" letter-spacing="-.025em" fill="currentColor">incline.</text>
                </svg>
              </a>
            </p>
        
          </div>
          <div class="col-md">
        
            <!-- Links -->
            <ul class="list-unstyled list-inline text-md-right">
              <li class="list-inline-item mr-2">
                <a href="#" class="text-white">
                  Terms and conditions
                </a>
              </li>
              <li class="list-inline-item mr-2">
                <a href="#" class="text-white">
                  Privacy policy
                </a>
              </li>
              <li class="list-inline-item">
                <a href="#" class="text-white">
                  Contact us
                </a>
              </li>
            </ul>

          </div>
        </div> <!-- / .row -->
        <div class="row align-items-center">
          <div class="col-md">
        
            <!-- Copyright -->
            <p class="text-white text-muted">
              <small>
                &copy; Copyright <span class="current-year"></span> Simpleqode. All rights reserved.
              </small>
            </p>

          </div>
          <div class="col-md">
        
            <!-- Social links -->
            <ul class="list-inline list-unstyled text-md-right">
              <li class="list-inline-item">
                <a href="#">
                  <i class="fab fa-github"></i>
                </a>
              </li>
              <li class="list-inline-item ml-3">
                <a href="#">
                  <i class="fab fa-twitter"></i>
                </a>
              </li>
              <li class="list-inline-item ml-3">
                <a href="#">
                  <i class="fab fa-instagram"></i>
                </a>
              </li>
            </ul>

          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->

    </footer>

  <jsp:include page="/WEB-INF/jsp/include/footer_email.jsp"></jsp:include>

  </body>
</html>