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
        <div class="form find_inner">
            <div class="find_wrap">
              <div class="form_head">
                  <span>버추얼 아일랜드</span>
                  <span>임시 비밀번호가 발급되었습니다.</span>
              </div>
              <div class="form_body">
                <div class="form_icon text-center">
                  <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
                    <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2zm13 2.383l-4.758 2.855L15 11.114v-5.73zm-.034 6.878L9.271 8.82 8 9.583 6.728 8.82l-5.694 3.44A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.739zM1 11.114l4.758-2.876L1 5.383v5.73z"/>
                  </svg>
                  <div class="find_text text-left mt-3">
                    <h5><strong>홍길동님</strong>, 안녕하세요!</h5>
                    <h5>임시 비밀번호가 발급되었습니다.</h5>
                    <h5>아래 비밀번호를 통해 로그인이 가능 하며, 로그인 하신 후 꼭 비밀번호를 변경해 주시기 바랍니다.</h5>
                  </div>
                  <div class="form_inner">
                    <div class="input-group">
                      <span class="col-sm-3 input-group-text border-0" id="basic-addon3">임시비밀번호</span>
                      <span class="col-sm-9 input-group-text border-0 bg-white" id="basic-addon3">ASDFQERAFASDZFFAFSDFADF</span>
                    </div>
                    <div class="input-group">
                      <span class="col-sm-3 input-group-text border-0" id="basic-addon3">발급일시</span>
                      <span class="col-sm-9 input-group-text border-0 bg-white" id="basic-addon3">2021-05-07 17:00:00</span>
                    </div>
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

  <jsp:include page="/WEB-INF/jsp/include/footer_email.jsp"></jsp:include>
  <jsp:include page="pw_sh_form2_js.jsp"></jsp:include>

  </body>
</html>