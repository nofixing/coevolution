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
              참관등록
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="/index">Home</a>
            </span>
            <span class="breadcrumb-item active">
              참관등록
            </span>
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>    

    <section class="section section-full section-top">
      <!-- Form -->
      <form>
        <div class="form">
            <div class="form_head">
                <p>참관등록</p>
            </div>
            <div class="join_inner">
                <div class="register_head clearfix">
                    <!-- <p class="register_head_tit">약관동의<span>* 회원가입약관 및 개인정보처리방침안내의 내용에 동의하셔야 회원가입 하실 수 있습니다.</span></p> -->
                    <ul class="register_seq">
                      <li  class="on"><span>Step 01</span> 약관동의</li>
                      <li><span>Step 02</span> 정보입력</li>
                      <li><span>Step 03</span> 가입완료</li>
                    </ul>
                </div>
                <div class="form_inner">
                    <div class="register_section">
                        <h4><strong>이용약관(필수)</strong></h4>
                        <div class="register_section_area">
                            ${agree1_contents}
                        </div>
                      <div class="custom-control custom-checkbox">
                        <input type="checkbox" id="agree_1" name="agree_1" value="Y" class="custom-control-input">
                        <label class="custom-control-label" for="agree_1">이용약관에 동의합니다.(필수)</label>
                      </div>
                    </div>
                    <div class="register_section">
                      <h4><strong>개인정보처리방침안내(필수)</strong></h4>
                        <div class="register_section_area">
                            ${agree2_contents}
                        </div>
                        <div class="custom-control custom-checkbox">
                          <input type="checkbox" id="agree_2" name="agree_2" value="Y" class="custom-control-input">
                          <label class="custom-control-label" for="agree_2">개인정보처리방침에 동의합니다.(필수)</label>
                        </div>
                    </div>
                    <div class="register_section">
                        <h4><strong>개인정보 마케팅 활용 동의(선택)</strong></h4>
                        <div class="register_section_area">
                          ${agree3_contents}
                        </div>
                        <div class="custom-control custom-checkbox">
                          <input type="checkbox" id="agree_3" name="agree_3" value="Y" class="custom-control-input">
                          <label class="custom-control-label" for="agree_3">개인정보 마케팅 활용에 동의합니다.(선택)</label>
                        </div>
                    </div>
                    <div class="register_section">
                      <div class="custom-control custom-checkbox">
                        <input type="checkbox" id="agree-all" class="custom-control-input">
                        <label class="custom-control-label" for="agree-all"><strong>모든 약관을 확인하고 전체 동의합니다.</strong></label>
                      </div>
                    </div>
                    <div class="register_page">
                        <button type="button" class="register_page_submit" id="btnSignUp">
                          회원가입
                        </button>                        
                    </div>
                </div>
            </div>
        </div>
      </form>
    </section>


    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="join_form2_js.jsp"></jsp:include>

  </body>
</html>