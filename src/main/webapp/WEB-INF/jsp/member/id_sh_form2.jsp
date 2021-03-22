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
    <section class="section section-full section-top">

      <!-- Content -->
      <div class="container">
        <div class="form find_inner">
          <div class="find_wrap">
            <div class="form_head">
                <p>아이디 찾기</p>
            </div>
            <div class="form_body">
              <div class="form_icon text-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-person-lines-fill" viewBox="0 0 16 16">
                  <path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm-5 6s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zM11 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5zm.5 2.5a.5.5 0 0 0 0 1h4a.5.5 0 0 0 0-1h-4zm2 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2zm0 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2z"/>
                </svg>
                <div class="find_text text-center mt-3">
                  <h5>회원님의 아이디를 알려 드립니다.</h5>
                  <h5>입력하신 정보와 일치하는 아이디는 아래와 같습니다.</h5>
                  <p><strong>홍길동</strong> 님의 아이디는 <strong>kkeju5137</strong> 입니다.</p>
                </div>
                <div class="form_bordert mt-3 p-3">
                  <span>비밀번호가 기억나지 않는 경우에는 <a href="#!">'비밀번호 찾기'</a>를 이용해 주세요.</span>
                </div>
                <div class="form_btn">
                  <button class="form_btn_inline">로그인</button>
              </div>
              </div>
            </div>
        </div>
        </div>
      </div> <!-- / .container -->
      
    </section>


  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="id_sh_form2_js.jsp"></jsp:include>

  </body>
</html>