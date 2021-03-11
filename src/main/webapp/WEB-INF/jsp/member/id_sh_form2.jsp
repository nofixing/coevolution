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
              <div class="form-group">
                
                <!-- 아이디 -->
                <label>아이디</label>
                <div class="input-group">
                  <input type="email" class="form-control order-1">
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
                  <input type="email" class="form-control order-1">
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
                    <button type="button" class="btn btn-outline-primary" onclick="javascript:document.location.href='02.아이디찾기결과.html'">
                      아이디 찾기
                    </button>
                  </div>

                </div>
              </div> <!-- / .form-row -->

                      

              <!-- Link -->
              <p class="text-center text-muted mt-3 mb-0">
                <small>
                   <a href="03.비밀번호찾기.html">비밀번호 찾기</a>
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