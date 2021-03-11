<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>
  </head>
  <body>
  <form>
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
              기업 참가(부스) 등록
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="index.html">Home</a>
            </span>
            <span class="breadcrumb-item active">
              기업 참가(부스) 등록
            </span>
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>    

<!-- 진행순서
    ================================================== -->
    <section class="section pb-0">
      <div class="container">
        <div class="row">

          <div class="col-md-2">
            
            <!-- Title -->
            <h6 class="title">
              기업참가(부스)등록
            </h6>

          </div>

          <div class="form-row col-md-10"> 

            <div class="col-md-3">
              
              <!-- Card -->
              <div class="card card-mg mb-3 mb-lg-4 card-active">
                
                <!-- Body -->
                <div class="card-body text-center">
  
                  <!-- Title -->
                  <h4 class="card-title">
                    Step1. 약관동의
                  </h4>
  
                </div>
                
              </div> <!-- / .card -->
  
            </div>
            <div class="col-md-1"></div>
  
             <div class="col-md-3">
              
              <!-- Card -->
              <div class="card card-mg mb-3 mb-lg-4">
                
                <!-- Body -->
                <div class="card-body text-center">
  
                  <!-- Title -->
                  <h4 class="card-title">
                    Step2. 정보입력
                  </h4>
  
                </div>
                
              </div> <!-- / .card -->
  
            </div>
            <div class="col-md-1"></div>
  
            <div class="col-md-3">
              
              <!-- Card -->
              <div class="card card-mg mb-3 mb-lg-4">
                
                <!-- Body -->
                <div class="card-body text-center">
  
                  <!-- Title -->
                  <h4 class="card-title">
                    Step3. 가입완료
                  </h4>
  
                </div>
                
              </div> <!-- / .card -->
  
            </div>
            <div class="col-md-1"></div>






          </div> <!-- / .row -->

          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>


    <!-- FORM
    ================================================== -->
    <section class="section pb-0 py-0">

      <!-- Content -->
      <div class="container">
        <div class="row">
          <div class="col-md-2">

            <!-- Title -->
            <h6 class="title">
              이용약관 (필수)
            </h6>
            
          </div>
          <div class="col-md-10">
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
                      <input type="checkbox" class="custom-control-input" id="agree_1" name="agree_1" value="Y">
                      <label class="custom-control-label" for="agree_1">
                        이용약관에 동의합니다.(필수)
                      </label>
                    </div>

                </div>
              </div>
           
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->

    </section>

    <!-- OFFICES
    ================================================== -->
    <section class="section pb-0">

      <!-- Content -->
      <div class="container">
        <div class="row">
          <div class="col-md-2">
            
            <!-- Title -->
            <h6 class="title">
              개인정보처리방침 (필수)
            </h6>

          </div>
          <div class="col-md-10">

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
                      <input type="checkbox" class="custom-control-input" id="agree_2" name="agree_2" value="Y">
                      <label class="custom-control-label" for="agree_2">
                        개인정보처리방침에 동의합니다. (필수 )
                      </label>
                    </div>

                </div>
              </div>
            </form>            

          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->

    </section>

    <section class="section">

      <!-- Content -->
      <div class="container">
        <div class="row">
          <div class="col-md-2">
            
            <!-- Title -->
            <h6 class="title">
              개인정보 마케팅 활용 동의 (선택)
            </h6>

          </div>
          <div class="col-md-10">

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
                      <input type="checkbox" class="custom-control-input" id="agree_3" name="agree_3" value="Y">
                      <label class="custom-control-label" for="agree_3">
                        개인정보 마케팅 활용에 동의합니다. (선택)
                      </label>
                    </div>

                </div>
              </div>

              <div class="form-row">
                <div class="col-12">
                  <div class="text-center text-md-center">
                    <button type="button" class="btn btn-outline-primary" id="btnSignUp">
                      회원가입
                    </button>
                  </div>
                </div>
              </div>
            

          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->

    </section>    

  </form>
  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="join_form4_js.jsp"></jsp:include>   

  </body>
</html>