<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>
  <body>

        <!-- FULLPAGE
    ================================================== -->
    <section class="section section-full section-top bg-light pb-3 pt-3">

      <!-- Content -->
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-sm-12">

            <!-- Form -->
            <form class="form-styled bg-white pt-2 pb-2">

              <!-- NAV -->
              <nav class="nav nav-tabs mb-5" id="nav">
                <!-- Content -->
                <a class="nav-item nav-link active" data-toggle="tab" href="#nav1">
                  기업정보
                </a>
                <a class="nav-item nav-link" data-toggle="tab" href="#nav2">
                  자료소개
                </a>
                <a class="nav-item nav-link" data-toggle="tab" href="#nav3">
                  갤러리
                </a>

              </nav>

              <div class="tab-content">
                <!-- 기업젇보 -->
                <div class="tab-pane fade active show" id="nav1">
                  
                  <div class="col-md-12 pl-0 pr-0 ml-0 mr-0">
                    
                    <!-- Card -->
                    <div class="row col-md-12 pl-0 pr-0">

                      <div class="row col-sm-9 text-left pr-0">
                        <!-- Image -->
                        <div class="col-sm-3 d-flex align-items-center pr-0">
                          <svg class="bd-placeholder-img rounded" width="100" height="100" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 100x100" preserveAspectRatio="xMidYMid slice" focusable="false">
                            <title>Placeholder</title>
                            <rect width="100%" height="100%" fill="#868e96"></rect>
                            <text x="15%" y="50%" fill="#dee2e6" dy=".3em">100x100</text>
                          </svg>
                        </div>
                        <div class="col-sm-auto d-flex align-items-center pl-0 pr-0">
                          주식회사 어쩌구 저쩌구
                        </div>  

                      </div>

                      <div class="col-sm-3 d-flex align-items-end pl-0 pr-0 ml-0 mr-0">
                        <div class="col-sm-12  d-flex align-items-center pl-0 pr-0">
                          
                          <div class="col-sm-6 p-1">
                            <div class="d-flex justify-content-center pb-2">
                              <img src="/image/star.png" width="30rem"/>
                            </div>
                            <div class="d-flex justify-content-center">즐겨찾기</div> 
                          </div>   
                          
                          <div class="col-sm-6 p-1">
                            <div class="d-flex justify-content-center pb-2">
                              <img src="/image/medal.png" width="30rem"/>
                            </div>
                            <div class="d-flex justify-content-center">뱃지</div> 
                          </div>                       
                          
                        </div>
                      </div>

                    </div>

                  </div>

                  <!-- home -->
                  <div class="row col-sm-12 pt-4">
                    <div class="col-sm-1 pl-0 pr-0">
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-door-fill" viewBox="0 0 16 16">
                        <path d="M6.5 14.5v-3.505c0-.245.25-.495.5-.495h2c.25 0 .5.25.5.5v3.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 .5-.5z"/>
                      </svg>     
                    </div>   
                    <div class="col-sm-11 pl-0">
                      <span>http://wwww.abcd.com</span>            
                    </div>
                  </div>
  
                  <!-- email -->
                  <div class="row col-sm-12">
                    <div class="col-sm-1 pl-0 pr-0">
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope-fill" viewBox="0 0 16 16">
                        <path d="M.05 3.555A2 2 0 0 1 2 2h12a2 2 0 0 1 1.95 1.555L8 8.414.05 3.555zM0 4.697v7.104l5.803-3.558L0 4.697zM6.761 8.83l-6.57 4.027A2 2 0 0 0 2 14h12a2 2 0 0 0 1.808-1.144l-6.57-4.027L8 9.586l-1.239-.757zm3.436-.586L16 11.801V4.697l-5.803 3.546z"/>
                      </svg>    
                    </div>   
                    <div class="col-sm-11 pl-0">
                      <p>test@test.com</p>            
                    </div>
                  </div>
  
                  <!-- 회사소개 -->
                  <div class="row col-sm-12">
                    <div class="col-sm-1 pl-0 pr-0">
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-building" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M14.763.075A.5.5 0 0 1 15 .5v15a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5V14h-1v1.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V10a.5.5 0 0 1 .342-.474L6 7.64V4.5a.5.5 0 0 1 .276-.447l8-4a.5.5 0 0 1 .487.022zM6 8.694L1 10.36V15h5V8.694zM7 15h2v-1.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 .5.5V15h2V1.309l-7 3.5V15z"/>
                        <path d="M2 11h1v1H2v-1zm2 0h1v1H4v-1zm-2 2h1v1H2v-1zm2 0h1v1H4v-1zm4-4h1v1H8V9zm2 0h1v1h-1V9zm-2 2h1v1H8v-1zm2 0h1v1h-1v-1zm2-2h1v1h-1V9zm0 2h1v1h-1v-1zM8 7h1v1H8V7zm2 0h1v1h-1V7zm2 0h1v1h-1V7zM8 5h1v1H8V5zm2 0h1v1h-1V5zm2 0h1v1h-1V5zm0-2h1v1h-1V3z"/>
                      </svg> 
                    </div>   
                    <div class="col-sm-11 pl-0">
                      <span>회사소개 (About Company)</span>       
                      <p>회사소개회사소개회사소개회사소개회사소개회사소개</p>
                    </div>
                  </div>
  
  
                  <!-- 제품개요 -->
                  <div class="row col-sm-12">
                    <div class="col-sm-1 pl-0 pr-0">
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cpu-fill" viewBox="0 0 16 16">
                        <path d="M6.5 6a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3z"/>
                        <path d="M5.5.5a.5.5 0 0 0-1 0V2A2.5 2.5 0 0 0 2 4.5H.5a.5.5 0 0 0 0 1H2v1H.5a.5.5 0 0 0 0 1H2v1H.5a.5.5 0 0 0 0 1H2v1H.5a.5.5 0 0 0 0 1H2A2.5 2.5 0 0 0 4.5 14v1.5a.5.5 0 0 0 1 0V14h1v1.5a.5.5 0 0 0 1 0V14h1v1.5a.5.5 0 0 0 1 0V14h1v1.5a.5.5 0 0 0 1 0V14a2.5 2.5 0 0 0 2.5-2.5h1.5a.5.5 0 0 0 0-1H14v-1h1.5a.5.5 0 0 0 0-1H14v-1h1.5a.5.5 0 0 0 0-1H14v-1h1.5a.5.5 0 0 0 0-1H14A2.5 2.5 0 0 0 11.5 2V.5a.5.5 0 0 0-1 0V2h-1V.5a.5.5 0 0 0-1 0V2h-1V.5a.5.5 0 0 0-1 0V2h-1V.5zm1 4.5h3A1.5 1.5 0 0 1 11 6.5v3A1.5 1.5 0 0 1 9.5 11h-3A1.5 1.5 0 0 1 5 9.5v-3A1.5 1.5 0 0 1 6.5 5z"/>
                      </svg>
                    </div>   
                    <div class="col-sm-11 pl-0">
                      <span>제품개요 (Product Outline)</span>       
                      <p>제품개요 제품개요 제품개요 제품개요 제품개요</p>
                    </div>
                  </div>  

                </div>


                <!-- 자료소개 -->
                <div class="tab-pane fade" id="nav2">
                  <div class="row">
                    <div class="col-sm-3 pl-0 border-right">
                      <ul class="pl-4">
                        <li><a href="#">자료소개1</a></li>
                        <li><a href="#">자료소개2</a></li>
                        <li><a href="#">자료소개3</a></li>
                      </ul>
                    </div>
                    <div class="col-sm-8 pl-2">
                      <iframe src="/js/pdfjs/web/viewer.html?compressed.tracemonkey-pldi-09.pdf" style="position: relative;   top: 0;  bottom: 0; left: 0;   width: 100%;   height: 500px;  border: 0"></iframe>
                    </div>
                  </div>
                </div>     
                
                

                <!-- 갤러리 -->
                <div class="tab-pane fade" id="nav3">
                  <div class="row">
                    <div class="col-sm-3 pl-0 border-right">
                      <ul class="pl-4">
                        <li><a href="#">갤러리목록1</a></li>
                        <li><a href="#">갤러리목록2</a></li>
                        <li><a href="#">갤러리목록3</a></li>
                      </ul>
                    </div>
                    <div class="col-sm-8 pl-2">
                      <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                          <div class="carousel-item active">
                            <img class="d-block w-100" src="/assets/img/83.jpg" alt="First slide">
                          </div>
                          <div class="carousel-item">
                            <img class="d-block w-100" src="/assets/img/84.jpg" alt="Second slide">
                          </div>
                          <div class="carousel-item">
                            <img class="d-block w-100" src="/assets/img/85.jpg" alt="Third slide">
                          </div>
                        </div>
                        <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        </a>
                        <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                          <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        </a>
                      </div>
                    </div>
                  </div>
                </div>        
                
                

              </div>

            </form>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
      
    </section>              

    <jsp:include page="/WEB-INF/jsp/include/footer_vr.jsp"></jsp:include>

  </body>
</html>