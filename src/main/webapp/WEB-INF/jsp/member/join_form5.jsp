<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>

    <style>
      .form_height1 {
        height:calc(1.9rem + 2px);
      }
    </style>

  </head>
  <body>
  <form>
    <input type="hidden" id="agree_1" name="agree_1" value="${agree_1}"/>
    <input type="hidden" id="agree_2" name="agree_2" value="${agree_2}"/>
    <input type="hidden" id="agree_3" name="agree_3" value="${agree_3}"/>
    <input type="hidden" id="cust_clsf_cd" name="cust_clsf_cd" value="202002"/>

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
              <div class="card card-mg mb-3 mb-lg-4 ">
                
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
              <div class="card card-mg mb-3 mb-lg-4 card-active">
                
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


    

<!-- 진행순서
    ================================================== -->
    <section class="section">
      <div class="container">
        <div class="row">

          <div class="col-md-2">
            
            <!-- Title -->
            <h6 class="title">
              정보입력
            </h6>

          </div>

          <div class="col-md-10">
            
              <div class="form-row">
                  <div class="form-group col-md-3">
                    <label>아이디(ID)</label> <label class="text-danger">*</label>
                    <input type="text" class="form-control form_height1" style="ime-mode:disabled;" maxlength="10" id="cust_id" name="cust_id">
                  </div>
                  <div class="form-group col-md-9">
                      <label style="visibility: visible;">.</label>
                      <div class="text-left text-md-left form_height1">
                        <button type="button" class="btn btn-outline-primary form_height1" style="padding: 0rem 2rem;margin-right: 1rem;" id="btnDupCheck">중복확인</button>
                        <label>※ 아이디는 6자 이상, 10자 이하 영문 소문자와 숫자만 사용 가능합니다.</label>
                      </div>
                  </div>
              </div> <!-- / .form-row -->

              <div class="form-row">
                <div class="form-group col-md-3">
                  <label>비밀번호(Password)</label> <label class="text-danger">*</label>
                  <input type="password" class="form-control form_height1" id="cust_pw" name="cust_pw" maxlength="20">
                </div>
                <div class="form-group col-md-3">
                  <label>비밀번호 확인(Password Check)</label> <label class="text-danger">*</label>
                  <input type="password" class="form-control form_height1" id="cust_pw2" name="cust_pw2" maxlength="20">
                </div>
                <div class="form-inline col-md-6">
                  <label>※ 비밀번호는 영문, 숫자 혼용하여 6~10자 이내로 입력해주세요.</label>             
                </div>
              </div> <!-- / .form-row -->

              <div class="form-row">
                <div class="form-group col-md-3">
                  <label>기업명(Company)</label> <label class="text-danger">*</label>
                  <input type="text" class="form-control form_height1" name="cust_nm" id="cust_nm" maxlength="50">
                </div>
              </div> <!-- / .form-row -->

              <div class="form-row">
                <div class="form-group col-md-3">
                  <label>부서(Department)</label> <label class="text-danger">*</label>
                  <input type="text" class="form-control form_height1" name="dept_nm" id="dept_nm" maxlength="50">
                </div>
                <div class="form-group col-md-3">
                  <label>담당자명(Person in charge)</label> <label class="text-danger">*</label>
                  <input type="text" class="form-control form_height1" name="rep_nm" id="rep_nm" maxlength="50">
                </div>
              </div> <!-- / .form-row -->

              <div class="form-row">
                <div class="form-group col-md-3">
                  <label>휴대전화번호(Phone number)</label> <label class="text-danger">*</label>
                  <input type="text" class="form-control form_height1" name="hp_no" id="hp_no" maxlength="13">
                </div>
              </div> <!-- / .form-row -->

              <div class="form-row">
                <div class="form-group col-md-12">
                  <label>이메일주소(e-mail)</label> <label class="text-danger">*</label>
                  <div class="form-row align-items-center">
                    <div class="col-md-3">
                      <input type="text" class="form-control form_height1" name="email_id1" id="email_id1" maxlength="50">
                    </div>
                    <div class="col-md-3">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <div class="input-group-text form_height1">@</div>
                        </div>
                        <input type="text" class="form-control form_height1" name="email_id2" id="email_id2" maxlength="50">
                      </div>
                    </div>
                    <div class="col-md-3">
                      <select class="custom-select custom-select-sm form_height1" id="email_clsf">
                        <option value="" selected>직접입력</option>
                        <option value="naver.com">naver.com</option>
                        <option value="daum.net">daum.net</option>
                        <option value="gmail.com">gmail.com</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div> <!-- / .form-row -->


              <div class="form-row">
                <div class="form-group col-md-3">
                  <label>국가(Country)</label> <label class="text-danger">*</label>
                  <select class="custom-select custom-select-sm form_height1" name="country_cd" id="country_cd">
                    <option selected value="212001">대한민국</option>
                    <option value="212002">국가1</option>
                    <option value="212003">국가2</option>
                    <option value="212004">국가3</option>
                  </select>
                </div>
              </div> <!-- / .form-row -->

              <div class="form-row">
                <div class="col-12">
                  * 부스 정보 입력은 회원가입 후 마이페이지 ＇내 부스 정보 등록‘ 을 통해 가능합니다.
                </div>
              </div>

          </div> <!-- / .row -->

        </div> <!-- / .row -->


        <div class="row">
          <div class="col-12">
            <div class="text-center text-md-center" style="padding-top: 2.5rem;">

              <button type="button" class="btn btn-outline-primary" style="width: 8rem;" id="btnSignUp">
                확인
              </button>
    
              <button type="button" class="btn btn-outline-primary" style="width: 8rem;" id="btnCncl">
                취소
              </button>                    

            </div>             
          </div>
        </div>

      </div> <!-- / .container -->
    </section>

  </form>
  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="join_form5_js.jsp"></jsp:include>   

  </body>
</html>