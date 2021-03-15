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
              회원 탈퇴
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
              회원 탈퇴
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
                회원 탈퇴
              </h3>

              <div class="form-group col-sm-12 pt-2 pl-2 border" style="background-color: #FFF;">
                <div class="col-sm-12"> 
                  <span class="small">그 동안 버추얼 전시관를 이용해 주셔서 진심으로 감사합니다. </span><br>
                  <span class="small">사이트 이용 시 불편했거나 부족했던 부분을 알려주시면 더 좋은 모습으로 찾아 뵙기 위해 노력하겠습니다.</span>
                </div>
              </div>
              
              <form class="form-styled">

                <div class="form-group">
                  <!-- 회원 탈퇴 내용 -->
                  <div class="input-group">
                    <input type="text" class="form-control form-control-sm mb-4" id="inlineFormInput" placeholder="최대 100자 까지 입력 가능합니다.">
                  </div>   

                  <div class="form-row justify-content-center">
  
                    <!-- Button -->
                    <div class="text-center text-md-right p-1">
                      <button type="button" class="btn btn-outline-primary" style="width:7rem">
                        탈퇴하기
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