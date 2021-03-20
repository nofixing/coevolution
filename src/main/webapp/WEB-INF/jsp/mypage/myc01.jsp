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
              즐겨찾기 내역
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
              즐겨찾기 내역
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
            <jsp:include page="/WEB-INF/jsp/include/cLeftMenu.jsp"></jsp:include>

          </div>
          <div class="col-md-10">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mb-4">
                내 부스 즐겨찾기 내역
              </h3>

              <form class="form-styled">
                <!-- Subheading -->
                <p class="text-muted">
                  <img src="/image/star.png" width="16rem" /> 8명이 즐겨찾기 등록 했습니다.
                </p>

                <!--검색조건-->
                <div class="form-row align-items-center pb-3">
                  <div class="col-auto">
                    <input type="date" class="form-control form-control-sm mb-2" id="inlineFormInput" >
                  </div>
                  <div class="col-auto">~</div>                  
                  <div class="col-auto">
                    <input type="date" class="form-control form-control-sm mb-2" id="inlineFormInput" >
                  </div>
                  <div class="col-auto">
                    <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 8rem;">조회</button>
                  </div>
                  <div class="col-auto">
                    <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 8rem;">부스 바로가기</button>
                  </div>                  
                </div>              

                <table class="table table-striped table-hover table-sm border-bottom">
                  <thead class="table-light">
                    <tr>
                      <th scope="col" width="10%" class="text-center">번호</th>
                      <th scope="col" width="40%" class="text-left">내 부스명</th>
                      <th scope="col" width="25%" class="text-center">회원명</th>
                      <th scope="col" width="25%" class="text-center">즐겨찾기 설정일</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">Mark</td>
                      <td class="text-center">홍길동(sfdsfsd)</td>
                      <td class="text-center">2021-04-01</td>
                    </tr>
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">Mark</td>
                      <td class="text-center">홍길동(sfdsfsd)</td>
                      <td class="text-center">2021-04-01</td>
                    </tr>    
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">Mark</td>
                      <td class="text-center">홍길동(sfdsfsd)</td>
                      <td class="text-center">2021-04-01</td>
                    </tr>
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">Mark</td>
                      <td class="text-center">홍길동(sfdsfsd)</td>
                      <td class="text-center">2021-04-01</td>
                    </tr>    
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">Mark</td>
                      <td class="text-center">홍길동(sfdsfsd)</td>
                      <td class="text-center">2021-04-01</td>
                    </tr>
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">Mark</td>
                      <td class="text-center">홍길동(sfdsfsd)</td>
                      <td class="text-center">2021-04-01</td>
                    </tr>    
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">Mark</td>
                      <td class="text-center">홍길동(sfdsfsd)</td>
                      <td class="text-center">2021-04-01</td>
                    </tr>
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">Mark</td>
                      <td class="text-center">홍길동(sfdsfsd)</td>
                      <td class="text-center">2021-04-01</td>
                    </tr>    
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">Mark</td>
                      <td class="text-center">홍길동(sfdsfsd)</td>
                      <td class="text-center">2021-04-01</td>
                    </tr>
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">Mark</td>
                      <td class="text-center">홍길동(sfdsfsd)</td>
                      <td class="text-center">2021-04-01</td>
                    </tr>                                                                                                                                                                                                          
                  </tbody>
                </table>


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

  </body>
</html>