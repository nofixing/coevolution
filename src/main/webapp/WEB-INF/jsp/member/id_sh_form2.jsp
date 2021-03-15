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
                  비밀번호가 기억나지 않는 경우에는 '<a href="/member/pw_sh_form1">비밀번호 찾기</a>'를 이용해 주세요.
                </small>
              </p>

            </form>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
      
    </section>


  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>

  </body>
</html>