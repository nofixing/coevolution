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
              <h2 class="text-center mb-3">
                회 원 가 입
              </h2>

              <h5 class="text-center mb-3">
                <small>회원으로 가입하시면 버추얼 전시관 정보 및 </small><br/>
                <small>다양한 서비스를 편리하게 이용하실 수 있습니다.</small>
              </h5>

              <!-- Password -->
              <div class="form-group">
                
                <div class="row">
                  <div class="col-lg-6">
                    
                    <!-- Card -->
                    <a href="/member/join_form2" class="card">
                      
                      <!-- Body -->
                      <div class="card-body">
        
                        <!-- Icon -->
                        <div class="card-icon text-primary">
                          <span class="icon icon-at"></span>
                        </div>
                        
                        <!-- Title -->
                        <h5 class="card-title">
                          참관신청
                        </h5>
        
                        <!-- Text -->
                        <p class="card-text text-muted">
                          이미지
                        </p>
                      
                      </div>
        
                    </a> <!-- / .card -->
        
                  </div>
                  <div class="col-lg-6">
        
                    <!-- Card -->
                    <a href="/member/join_form4" class="card">
                      
                      <!-- Body -->
                      <div class="card-body">
        
                        <!-- Icon -->
                        <div class="card-icon text-primary">
                          <span class="icon icon-edit"></span>
                        </div>
                        
                        <!-- Title -->
                        <h5 class="card-title">
                          참가신청
                        </h5>
        
                        <!-- Text -->
                        <p class="card-text text-muted">
                          이미지
                        </p>
                      
                      </div>
        
                    </a> <!-- / .card -->
        
                  </div>

                </div> <!-- / .row -->

              </div>

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

            </form>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
      
    </section>

  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="join_form1_js.jsp"></jsp:include>

  </body>
</html>