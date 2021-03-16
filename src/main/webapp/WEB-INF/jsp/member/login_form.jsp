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
                로 그 인
              </h2>

              <!-- 아이디 -->
              <div class="form-group">
                
                <!-- 아이디 -->
                <label>아이디</label>
                <div class="input-group">
                  <input type="text" class="form-control order-1" id="user_id" name="user_id">
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
                  <input type="password" class="form-control order-1" id="user_pw" name="user_pw">
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
                    <button type="button" class="btn btn-outline-primary" id="btnLogin">
                      로그인
                    </button>
                    
                    <button type="button" class="btn btn-outline-primary" id="btnJoin">
                      회원가입
                    </button>

                  </div>

                </div>
              </div> <!-- / .form-row -->

              <!-- 소셜로그인 -->
                <div class="form-row align-items-center mt-3">

                  <div class="col-md-3">

                    <div class="extended-radio">
                      <input class="extended-radio-input" id="naver_login" type="radio" name="naver_login">
                      <label class="extended-radio-label text-xs" for="naver_login">
                        네이버
                      </label>
                    </div>

                  </div>

                  <div class="col-md-3">

                    <div class="extended-radio">
                      <input class="extended-radio-input" id="kakao_login" type="radio" name="kakao_login">
                      <label class="extended-radio-label text-xs" for="kakao_login">
                        카카오
                      </label>
                    </div>

                  </div>
                    
                  <div class="col-md-3">

                    <div class="extended-radio">
                      <input class="extended-radio-input" id="google_login" type="radio" name="google_login">
                      <label class="extended-radio-label text-xs" for="google_login">
                        구글
                      </label>
                    </div>

                  </div>

                  <div class="col-md-3">

                    <div class="extended-radio">
                      <input class="extended-radio-input" id="facebook_login" type="radio" name="facebook_login">
                      <label class="extended-radio-label text-xs" for="facebook_login">
                        페이스북
                      </label>
                    </div>

                  </div>

              </div> <!-- / .form-row -->              

              <!-- Link -->
              <p class="text-center text-muted mt-3 mb-0">
                <small>
                   <a href="/member/join_form1">회원가입</a> | <a href="/member/id_sh_form1">아이디 찾기</a> | <a href="/member/pw_sh_form1">비밀번호 찾기</a>
                </small>
              </p>

            </form>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
      
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="login_form_js.jsp"></jsp:include>

  </body>
</html>
