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
              부스 즐겨찾기 내역
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
              부스 즐겨찾기 내역
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
                부스 즐겨찾기 내역
              </h3>

              <form class="form-styled">
                <!-- Subheading -->
                <p class="text-muted">
                  <img src="/image/star.png" width="16rem" /> <span id="spCnt"></span>개 부스를 즐겨찾기 했습니다.
                </p>

                <div class="col-sm-12" id="divFavorit">
                  <table class="table table-striped table-hover table-sm border-bottom" id="tbFavorit">
                    <thead class="table-light">
                      <tr>
                        <th scope="col" width="10%" class="text-center">번호</th>
                        <th scope="col" width="40%" class="text-left">부스명</th>
                        <th scope="col" width="25%" class="text-center">즐겨찾기내역</th>
                        <th scope="col" width="25%" class="text-center">부스바로가기</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <th cope="row" class="text-center">1</th>
                        <td class="text-left">Mark</td>
                        <td class="text-center"><img src="/image/star.png" width="20rem" /></td>
                        <td class="text-center"><img src="/image/medal.png" width="20rem" /></td>
                      </tr>                                                                                                                          
                    </tbody>
                  </table>
                </div>

                <!-- paging -->
                <div class="table-responsive d-flex justify-content-center">
                  <nav aria-label="Page navigation">
                    <ul class="pagination pt-3">
                      <li class="page-item">
                        <a class="page-link" href="#">Previous</a>
                      </li>
                      <li class="page-item">
                        <a class="page-link" href="#">1</a>
                      </li>
                      <li class="page-item">
                        <a class="page-link" href="#">2</a>
                      </li>
                      <li class="page-item">
                        <a class="page-link" href="#">3</a>
                      </li>
                      <li class="page-item">
                        <a class="page-link" href="#">Next</a>
                      </li>
                    </ul>
                  </nav>
                </div>



              </form>

            </div>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myp01_js.jsp"></jsp:include>

  </body>
</html>