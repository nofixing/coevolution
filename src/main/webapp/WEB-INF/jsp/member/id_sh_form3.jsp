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
                <p>비밀번호 찾기</p>
            </div>
            <div class="form_body">
              <div class="form_icon text-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-person-lines-fill" viewBox="0 0 16 16">
                  <path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm-5 6s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zM11 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5zm.5 2.5a.5.5 0 0 0 0 1h4a.5.5 0 0 0 0-1h-4zm2 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2zm0 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2z"/>
                </svg>
                <div class="find_text text-center mt-3">
                  <h5>임시 비밀번호가 발급되어 회원님의 이메일로 전송되었습니다..</h5>
                  <h5>임시 비밀번호를 통해 로그인이 가능 하며, 로그인 하신 후 꼭 비밀번호를 변경해 주시기 바랍니다.</h5>
                </div>
                <div class="form_btn">
                  <button class="form_btn_inline" id="btnLogin">로그인</button>
              </div>
              </div>
            </div>
        </div>
        </div>
      </div> <!-- / .container -->
      
    </section>


  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="id_sh_form3_js.jsp"></jsp:include>

  </body>
</html>