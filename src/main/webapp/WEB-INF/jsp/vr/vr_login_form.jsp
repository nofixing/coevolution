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
            <form class="form-styled bg-white pt-4">

              <!-- Heading -->
              <h2 class="text-center mb-2">
                로 그 인
              </h2>

              <!-- 아이디 -->
              <div class="form-group">
                
                <!-- 아이디 -->
                <label>아이디</label>
                <div class="input-group">
                  <input type="text" class="form-control order-1">
                  <div class="input-group-append order-0">
                    <div class="input-group-text">
                      <svg class="input-group-icon icon-offset icon icon-person" viewBox="0 0 106 106" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path transform="translate(3 3)" d="M0 100 A 50 50 0 0 1 50 60 A 20 20 0 0 1 50 0 A 20 20 0 0 1 50 60 A 50 50 0 0 1 100 100"></path>
                      </svg>
                    </div>
                  </div>
                </div>

              </div>

              <!-- Password -->
              <div class="form-group">
                
                <!-- Name -->
                <label>비밀번호</label>
                <div class="input-group">
                  <input type="password" class="form-control order-1">
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
                <div class="col-md-auto">

                  <!-- Checkbox -->
                  <div class="custom-control custom-checkbox mb-3 mb-md-0">
                    <input type="checkbox" class="custom-control-input" id="sign-in-checkbox">
                    <label class="custom-control-label" for="sign-in-checkbox">
                      아이디 저장
                    </label>
                  </div>

                </div>
                <div class="col-md">

                  <!-- Button -->
                  <div class="text-center text-md-right">
                    <button type="button" class="btn btn-outline-primary">
                      로그인
                    </button>
                  </div>

                </div>
              </div> <!-- / .form-row -->

              <!-- 소셜로그인 -->
                <div class="form-row align-items-center mt-3">
                  <div class="col-md-3">

                    <div class="extended-radio">
                      <input class="extended-radio-input" id="sizeInputOne" type="radio" name="sizeInput">
                      <label class="extended-radio-label text-xs" for="sizeInputOne">
                        네이버
                      </label>
                    </div>

                  </div>

                  <div class="col-md-3">

                    <div class="extended-radio">
                      <input class="extended-radio-input" id="sizeInputOne" type="radio" name="sizeInput">
                      <label class="extended-radio-label text-xs" for="sizeInputOne">
                        카카오
                      </label>
                    </div>

                  </div>
                    
                  <div class="col-md-3">

                    <div class="extended-radio">
                      <input class="extended-radio-input" id="sizeInputOne" type="radio" name="sizeInput">
                      <label class="extended-radio-label text-xs" for="sizeInputOne">
                        구글
                      </label>
                    </div>
                    
                  </div>

                  <div class="col-md-3">

                    <div class="extended-radio">
                      <input class="extended-radio-input" id="sizeInputOne" type="radio" name="sizeInput">
                      <label class="extended-radio-label text-xs" for="sizeInputOne">
                        페이스북
                      </label>
                    </div>   

                  </div>

              </div> <!-- / .form-row -->              

              <!-- Link -->
              <p class="text-center text-muted mt-3 mb-0">
                <small>
                   <a href="/member/join_form1">회원가입</a> | <a href="02.아이디찾기.html">아이디 찾기</a> | <a href="03.비밀번호찾기.html">비밀번호 찾기</a>
                </small>
              </p>

            </form>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
      
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer_vr.jsp"></jsp:include>

  </body>
</html>