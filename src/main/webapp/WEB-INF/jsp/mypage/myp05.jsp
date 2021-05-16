<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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
              비밀번호 변경
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="/index">Home</a>
            </span>
            <span class="breadcrumb-item active">
              마이페이지
            </span>
            <span class="breadcrumb-item active">
              비밀번호 변경
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>
    
    <!-- CONTENT
    ================================================== -->
    <section class="section pt-0">
      <div class="container">

        <div class="row">
          <div class="col-xl-3" id="gLeftMenu">
            <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/pLeftMenu.jsp"></jsp:include>
          </div>

          <div class="col-xl-9">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mt-4 mb-4">
                <strong>
                  비밀번호 변경
                </strong>
              </h3>

              <div class="form-row col-sm-12 pt-2 pl-2 mb-4">
                <div class="col-sm-12 text-center"> 
                  고객님의 개인정보보호와 안전한 사용을 위해 90일 마다
                </div>
                <div class="col-sm-12 text-center"> 
                  비밀번호 변경을 권장하고 있으니 비밀번호를 변경해 주시기 바랍니다.
                </div>
              </div>
              
              <form class="form-styled">
                <div class="form-style-small">
                  <div class="form-group">
                    <div class="input-group">
                      <input type="password" class="form-control order-1" placeholder="현재 비밀번호" id="user_current_pw">
                      <div class="input-group-append order-0">
                        <div class="input-group-text">
                          <svg class="input-group-icon icon-offset icon icon-lock" viewBox="0 0 106 106" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                            <path transform="translate(3 3)" d="M25 50 V 20 A 25 25 0 0 1 50 0 A 25 25 0 0 1 75 20 V 50 H 90 V 100 H 10 V 50 H 75 M50 85 A 5 5 0 0 1 45 80 V 70 A 5 5 0 0 1 50 65 A 5 5 0 0 1 55 70 V 80 A 5 5 0 0 1 50 85"></path>
                          </svg>
                        </div>
                      </div>
                    </div>
                  </div>
  
                  <div class="form-group">
                    <div class="input-group">
                      <input type="password" class="form-control order-1" placeholder="새 비밀번호" id="user_change_pw1">
                      <div class="input-group-append order-0">
                        <div class="input-group-text">
                          <svg class="input-group-icon icon-offset icon icon-lock" viewBox="0 0 106 106" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                            <path transform="translate(3 3)" d="M25 50 V 20 A 25 25 0 0 1 50 0 A 25 25 0 0 1 75 20 V 50 H 90 V 100 H 10 V 50 H 75 M50 85 A 5 5 0 0 1 45 80 V 70 A 5 5 0 0 1 50 65 A 5 5 0 0 1 55 70 V 80 A 5 5 0 0 1 50 85"></path>
                          </svg>
                        </div>
                      </div>
                    </div>     
                  </div>
  
                  <div class="form-group">
                    <div class="input-group">
                      <input type="password" class="form-control order-1" placeholder="새 비밀번호 확인" id="user_change_pw2">
                      <div class="input-group-append order-0">
                        <div class="input-group-text">
                          <svg class="input-group-icon icon-offset icon icon-lock" viewBox="0 0 106 106" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                            <path transform="translate(3 3)" d="M25 50 V 20 A 25 25 0 0 1 50 0 A 25 25 0 0 1 75 20 V 50 H 90 V 100 H 10 V 50 H 75 M50 85 A 5 5 0 0 1 45 80 V 70 A 5 5 0 0 1 50 65 A 5 5 0 0 1 55 70 V 80 A 5 5 0 0 1 50 85"></path>
                          </svg>
                        </div>
                      </div>
                    </div>    
                  </div>
                </div>

                <div class="form-group">
                  <div class="input-group">
                    <li>비밀번호는 영문, 숫자, 특수문자를 혼용하여 6~12자 이내로 입력해주세요.</li>
                  </div>  
                  <div class="input-group">
                    <li>아이디와 동일한 비밀번호는 사용할 수 없습니다.</li>
                  </div>
                  <div class="input-group">
                    <li>현재 비밀번호와 다른 비밀번호를 사용하세요.</li>
                  </div>                                        
                </div>                
              

                <div class="form-row justify-content-center">
  
                    <!-- Button -->
                    <div class="text-center text-md-right p-1">
                      <button type="button" class="basic-btn" style="width:7rem" id="btnChange">
                        변경하기
                      </button>
                    </div>
  
                    <!-- Button 
                    <div class="text-center text-md-right p-1" >
                      <button type="button" class="basic-btn-default" style="width:7rem">
                        다음에 하기
                      </button>
                    </div>
                    -->

                </div> <!-- / .form-row -->     


              </form>

         

          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myp05_js.jsp"></jsp:include>

  </body>
</html>