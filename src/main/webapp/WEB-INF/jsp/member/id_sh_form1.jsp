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
                아이디 찾기
              </h2>

              <!-- 아이디 -->
              <div class="form-group" style="border: 1px solid #a9a9a9;padding: 10px;">
                
                <label>회원님의 아이디를 알려드립니다.</label>
                <label>입력하신 정보와 일치하는 아이디는 아래와 같습니다</label>
                <label><strong>홍길동</strong> 님의 아이디는 <strong>kkeju5137</strong> 입니다.</label>
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
                  비밀번호가 기억나지 않는 경우에는 '<a href="03.비밀번호찾기.html">비밀번호 찾기</a>'를 이용해 주세요.
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

  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>

  </body>
</html>