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

    <!-- BREADCRUMB
    ================================================== -->
    <nav class="breadcrumb">
      <div class="container">
        <div class="row align-items-center">
          <div class="col">
            
            <!-- Heading -->
            <h5 class="breadcrumb-heading">
              개인정보 재동의
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="#">Home</a>
            </span>
            <span class="breadcrumb-item active">
              마이페이지
            </span>
            <span class="breadcrumb-item active">
              개인정보 재동의
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>
    
    <!-- CONTENT
    ================================================== -->
    <section class="section pt-4">
      <div class="container">
        <div class="row">
          <div class="col-md-2">
            
            <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/pLeftMenu.jsp"></jsp:include>

          </div>
          <div class="col-md-10">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mb-4">
                개인정보 재동의
              </h3>

              <div class="form-group col-sm-12 pt-2 pl-2 border" style="background-color: #FFF;">
                <div class="col-sm-12 pb-2" > 
                  <span class="small">● 개인정보 재동의 시행 안내 </span>
                </div>
                <div class="col-sm-12"> 
                  <span class="small">버추얼 전시관 홈페이지는 개인정보 보호법에 따른 2년주기 개인정보 재동의 절차를 시행합니다.</span><br>
                  <span class="small">홍길동 님께서는 2022년 05월 02일 까지 재동의 하지 않을 경우 자동으로 회원 탈퇴 처리됨을 알려드립니다.</span>
                </div>
              </div>
              
              <form class="form-styled">

                <div class="form-group">
                  <!-- 개인정보 재동의 내용 -->
                  <div class="input-group">
                    <span class="col-sm-4 input-group-text border-0" style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small;" id="basic-addon3">주요내용</span>
                    <span class="col-sm-8 input-group-text border-0 bg-white " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" id="basic-addon3">
                      2021년 05월 02일까지 정보제공 재동의 하지 않은 경우 회원 개인정보 삭제 및 자동 탈퇴처리
                    </span>
                  </div>   
                  <div class="input-group">
                    <span class="col-sm-4 input-group-text border-0" style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" id="basic-addon3">
                      개인정보 파기 및 탈퇴 처리 시행일자
                    </span>
                    <span class="col-sm-8 input-group-text border-0 bg-white "  style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" id="basic-addon3">
                      2021년 05월 03일
                    </span>
                  </div>     
                  <div class="input-group">
                    <span class="col-sm-4 input-group-text border-0 " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" id="basic-addon3">제목</span>
                    <span class="col-sm-8 input-group-text border-0 bg-white " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" id="basic-addon3">
                      제목입니다.
                    </span>
                  </div>     
                  <div class="input-group">
                    <span class="col-sm-4 input-group-text border-0 " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" id="basic-addon3">
                      파기 대상 개인정보 항목
                    </span>
                    <span class="col-sm-8 input-group-text border-0 bg-white text-left" style="white-space:normal;border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" id="basic-addon3">
                      회원가입 시 입력한 모든 정보는 삭제 처리되고 아이디는 재사용 및 복구 불가능합니다.<br>
                      제③항 정책고객, 홈페이지회원 등의 홍보 및 대국민서비스 목적의 외부고객 명부는 특별한 경우를 제외하고는 2년을 주기로 정보주체의 재동의 절차를 거쳐 동의한 경우에만 계속하여 보유할 수 있다.
                    </span>
                  </div>    
                  <div class="input-group mb-3">
                    <span class="col-sm-4 input-group-text border-0 " style="border-top:1px solid rgba(0,0,0,.1)!important; border-bottom:1px solid rgba(0,0,0,.1)!important; font-size: small" id="basic-addon3">
                      동의 일시
                    </span>
                    <span class="col-sm-8 input-group-text border-0 bg-white text-left" style="white-space:normal;border-top:1px solid rgba(0,0,0,.1)!important; border-bottom:1px solid rgba(0,0,0,.1)!important; font-size: small" id="basic-addon3">
                      2021-05-03 00:00:00
                    </span>
                  </div>                      

                  <!--이용약관-->                  
                  <div class="form-row">
                    <div class="form-group col-12">
                      <!-- Message -->
                      <textarea class="form-control" name="contact-message" rows="7"></textarea>
                    </div>
                  </div> <!-- / .form-row -->
                  <div class="form-row">
                    <div class="col-12">

                        <!-- Checkbox -->
                        <div class="custom-control custom-checkbox mb-3 mb-md-0">
                          <input type="checkbox" class="custom-control-input" id="sign-in-checkbox">
                          <label class="custom-control-label" for="sign-in-checkbox">
                            이용약관 (필수)
                          </label>
                        </div>

                    </div>
                  </div>

                  <!--개인정보수집 및 이용안내-->                  
                  <div class="form-row">
                    <div class="form-group col-12">
                      <!-- Message -->
                      <textarea class="form-control" name="contact-message" rows="7"></textarea>
                    </div>
                  </div> <!-- / .form-row -->
                  <div class="form-row">
                    <div class="col-12">

                        <!-- Checkbox -->
                        <div class="custom-control custom-checkbox mb-3 mb-md-0">
                          <input type="checkbox" class="custom-control-input" id="sign-in-checkbox">
                          <label class="custom-control-label" for="sign-in-checkbox">
                            개인정보처리방침에 동의합니다. (필수)
                          </label>
                        </div>

                    </div>
                  </div>                  

                  <div class="form-row justify-content-center">
  
                    <!-- Button -->
                    <div class="text-center text-md-right p-1">
                      <button type="button" class="btn btn-outline-primary" style="width:7rem">
                        재동의 하기
                      </button>
                    </div>

                  </div> <!-- / .form-row -->   

                </div>  


              </form>

         

          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>

  </body>
</html>