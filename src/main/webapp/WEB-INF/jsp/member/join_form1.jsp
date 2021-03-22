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
        <div class="form login_form">
            <div class="form_head">
                <p>회원가입</p>
                <h5 class="text-center mb-3">
                    <small>회원으로 가입하시면 <strong>버추얼 전시관</strong> 정보 및 </small><br/>
                    <small>다양한 서비스를 편리하게 이용하실 수 있습니다.</small>
                  </h5>
            </div>
            <div class="member_inner">
                
                <div class="form_inner">
                    <div class="form-group">
                
                        <div class="row">
                          <div class="col-lg-6">
                            
                            <!-- Card -->
                            <a href="/member/join_form2" class="card">
                              
                              <!-- Body -->
                              <div class="form_card">
                
                                <!-- Icon -->
                                <div class="form_card_img text-primary text-center">
                                  <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="currentColor" class="bi bi-person-check" viewBox="0 0 16 16">
                                    <path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H1s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C9.516 10.68 8.289 10 6 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
                                    <path fill-rule="evenodd" d="M15.854 5.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 0 1 .708-.708L12.5 7.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
                                  </svg>
                                </div>
                                
                                <div class="card-item-name text-center">
                                    <h5>참관등록</h5>
                                </div>
                              
                              </div>
                              <!-- Title -->
                
                            </a> <!-- / .card -->
                
                          </div>
                          <div class="col-lg-6">
                
                            <!-- Card -->
                            <a href="/member/join_form4" class="card">
                              
                              <!-- Body -->
                              <div class="form_card">
                
                                <!-- Icon -->
                                <div class="form_card_img text-primary text-center">
                                  <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                    <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456l-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                                    <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
                                  </svg>
                                </div>
                                
                                <!-- Title -->
                                <div class="card-item-name text-center bg-dark">
                                    <h5>기업 참가(부스) 등록</h5>
                                </div>
                              
                              </div>
                
                            </a> <!-- / .card -->
                
                          </div>
        
                        </div> <!-- / .row -->
        
                      </div>
                </div>
                <div class="sns_login bg-light">
                  <div class="sns_login_inner">
                      <ul class="clearfix">
                          <li>
                              <a href="#!">
                                  <img src="/assets/img/icons/naver_icon.png" id="naver_login" name="naver_login"/>
                                  <span>네이버</span>
                              </a>
                          </li>
                          <li>
                              <a href="#!">
                                  <img src="/assets/img/icons/kakao_icon.png" id="kakao_login" name="kakao_login"/>
                                  <span>카카오톡</span>
                              </a>
                          </li>
                          <li>
                              <a href="#!">
                                  <img src="/assets/img/icons/facebook_icon.png" id="facebook_login" name="facebook_login"/>
                                  <span>페이스북</span>
                              </a>
                          </li>
                          <li>
                              <a href="#!">
                                  <img src="/assets/img/icons/google_icon.png" id="google_login" name="google_login">
                                  <span>구글</span>
                              </a>
                          </li>
                      </ul>
                  </div>
              </div>
            </div>
        </div>
      </div> <!-- / .container -->
      
    </section>

  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="join_form1_js.jsp"></jsp:include>

  </body>
</html>