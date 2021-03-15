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
              관심 뱃지 내역
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
              관심 뱃지 내역
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
                관심 뱃지 내역
              </h3>


              <div class="form-styled">
                
                <!-- Subheading -->
                <div class="text-center border p-4">
                  <h4 class="text-muted m-0">
                    <img src="/image/medal.png".png" width="16rem" /> 관심뱃지 <strong>12</strong>개
                  </h4>
                </div>


                <!--검색조건-->
                <form class="pt-4 pb-3">
                  <div class="form-row align-items-center">
                    <div class="col-auto">
                      <input type="date" class="form-control form-control-sm mb-2" id="inlineFormInput" >
                    </div>
                    <div class="col-auto">
                      <input type="date" class="form-control form-control-sm mb-2" id="inlineFormInput" >
                    </div>
                    <div class="col-auto">
                      <select class="form-control form-control-sm mb-2" style="width: 6rem;" id="inlineFormCustomSelect">
                        <option selected>전체</option>
                        <option value="1">부여</option>
                        <option value="2">회수</option>
                        <option value="3">사용</option>
                      </select>
                    </div>
                    <div class="col-auto">
                      <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;">조회</button>
                    </div>
                  </div>
                </form>            

                <table class="table table-striped table-hover table-sm border-bottom">
                  <thead class="table-light">
                    <tr>
                      <th scope="col" width="10%" class="text-center">번호</th>
                      <th scope="col" width="20%" class="text-center">부여일(유효기간)</th>
                      <th scope="col" width="40%" class="text-center">내용</th>
                      <th scope="col" width="15%" class="text-center">뱃지 부여/회수</th>
                      <th scope="col" width="15%" class="text-center">뱃지 사용</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-center">2021.04.01</td>
                      <td class="text-center">
                        <div class="text-danger">회수</div>
                      </td>
                      <td class="text-center">+1</td>
                      <td class="text-center"></td>
                    </tr>        
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-center">2021.04.01</td>
                      <td class="text-center">
                        <div class="text-danger">회수</div>
                      </td>
                      <td class="text-center"></td>
                      <td class="text-center">-1</td>
                    </tr>    
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-center">2021.04.01</td>
                      <td class="text-center">
                        <div class="text-danger">회수</div>
                      </td>
                      <td class="text-center">+1</td>
                      <td class="text-center"></td>
                    </tr>        
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-center">2021.04.01</td>
                      <td class="text-center">
                        <div class="text-danger">회수</div>
                      </td>
                      <td class="text-center"></td>
                      <td class="text-center">-1</td>
                    </tr>
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-center">2021.04.01</td>
                      <td class="text-center">
                        <div class="text-danger">회수</div>
                      </td>
                      <td class="text-center">+1</td>
                      <td class="text-center"></td>
                    </tr>        
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-center">2021.04.01</td>
                      <td class="text-center">
                        <div class="text-danger">회수</div>
                      </td>
                      <td class="text-center"></td>
                      <td class="text-center">-1</td>
                    </tr>
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-center">2021.04.01</td>
                      <td class="text-center">
                        <div class="text-danger">회수</div>
                      </td>
                      <td class="text-center">+1</td>
                      <td class="text-center"></td>
                    </tr>        
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-center">2021.04.01</td>
                      <td class="text-center">
                        <div class="text-danger">회수</div>
                      </td>
                      <td class="text-center"></td>
                      <td class="text-center">-1</td>
                    </tr>
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-center">2021.04.01</td>
                      <td class="text-center">
                        <div class="text-danger">회수</div>
                      </td>
                      <td class="text-center">+1</td>
                      <td class="text-center"></td>
                    </tr>        
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-center">2021.04.01</td>
                      <td class="text-center">
                        <div class="text-danger">회수</div>
                      </td>
                      <td class="text-center"></td>
                      <td class="text-center">-1</td>
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
              
              </div>

            </div>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>

  </body>
</html>