<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>

    <style type="text/css">
     .li_txt_line {
        width:200px;
        padding:0 5px;
        overflow:hidden;
        text-overflow:ellipsis;
        white-space:nowrap;
        list-style-position:inside;
      }
    </style>

  </head>
  <body>

<!-- 모달 영역 -->
<div class="bd-example-modal-lg" id="myModal" tabindex="-1">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-body p-0">

        <!-- Form -->
        <form class="form-styled bg-white pt-2 pb-2">

          <!-- NAV -->
          <nav class="nav nav-tabs mb-5" id="nav">
            <!-- Content -->
            <a class="nav-item nav-link active" data-toggle="tab" href="#nav1">
              기업정보
            </a>
            <a class="nav-item nav-link" data-toggle="tab" href="#nav2" onClick="doPdfViewer()">
              자료소개
            </a>
            <a class="nav-item nav-link" data-toggle="tab" href="#nav3">
              갤러리
            </a>

          </nav>

          <div class="tab-content">
            <!-- 기업젇보 -->
            <div class="tab-pane fade active show pb-5 boot-tab-pane" id="nav1">
              <div class="row">
                <div class="col-sm-3 pl-0"></div>
                <div class="col-sm-9">
                  <div class="row">
                    <div class="col-md-12 pl-0 pr-0 ml-0 mr-0">
                
                      <!-- Card -->
                      <div class="row col-md-12 pl-0 pr-0">
      
                        <div class="row col-md-12 col-lg-9 text-left pr-0">
                          <!-- Image -->
                          <div class="col-sm-4 d-flex align-items-center pr-0">
                            <img src="${ci_image}" width="150px"/>
                          </div>
                          <div class="col-sm-auto d-flex align-items-center">
                            ${custInfo.cust_nm}
                          </div>  
      
                        </div>
      
                        <div class="col-lg-3 col-md-12 d-flex align-items-end pl-0 pr-0 ml-0 mr-0">
                          <div class="col-sm-12  d-flex align-items-center pl-0 pr-0">
                            
                            <div class="col-sm-6 p-1">
                              <div class="d-flex justify-content-center pb-2">
                                <a href="#!">
                                  <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-bookmark-star <c:if test="${favorit_yn eq 'Y'}">text-warning</c:if>" viewBox="0 0 16 16" id="corpFavorit">                 
                                    <path d="M7.84 4.1a.178.178 0 0 1 .32 0l.634 1.285a.178.178 0 0 0 .134.098l1.42.206c.145.021.204.2.098.303L9.42 6.993a.178.178 0 0 0-.051.158l.242 1.414a.178.178 0 0 1-.258.187l-1.27-.668a.178.178 0 0 0-.165 0l-1.27.668a.178.178 0 0 1-.257-.187l.242-1.414a.178.178 0 0 0-.05-.158l-1.03-1.001a.178.178 0 0 1 .098-.303l1.42-.206a.178.178 0 0 0 .134-.098L7.84 4.1z"></path>                 
                                    <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z"></path>             
                                  </svg>
                                </a>
                              </div>
                              <span style="height:24px; display:block;"></span>
                              <div class="d-flex justify-content-center">즐겨찾기</div> 
                            </div>   
                            
                            <div class="col-sm-6 p-1 text-center">
                              <div class="d-flex justify-content-center pb-2">
                                <a href="#!">
                                  <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-award <c:if test="${badge_yn eq 'Y'}">text-warning</c:if>" viewBox="0 0 16 16" id="corpBadge">
                                    <path d="M9.669.864L8 0 6.331.864l-1.858.282-.842 1.68-1.337 1.32L2.6 6l-.306 1.854 1.337 1.32.842 1.68 1.858.282L8 12l1.669-.864 1.858-.282.842-1.68 1.337-1.32L13.4 6l.306-1.854-1.337-1.32-.842-1.68L9.669.864zm1.196 1.193l.684 1.365 1.086 1.072L12.387 6l.248 1.506-1.086 1.072-.684 1.365-1.51.229L8 10.874l-1.355-.702-1.51-.229-.684-1.365-1.086-1.072L3.614 6l-.25-1.506 1.087-1.072.684-1.365 1.51-.229L8 1.126l1.356.702 1.509.229z"/>
                                    <path d="M4 11.794V16l4-1 4 1v-4.206l-2.018.306L8 13.126 6.018 12.1 4 11.794z"/>
                                  </svg>
                                </a>
                              </div>
                              <span style="height:24px; display:block;">(<span id="tot_badge">${tot_badge}</span>)</span>
                              <div class="d-flex justify-content-center">관심뱃지</div> 
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
                        <span>${boothInfo.homepage_url}</span>            
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
                        <p>${custInfo.email_id}</p>            
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
                        <span>회사소개</span>       
                        <pre><p>${boothInfo.about_company_kor}</p></pre>
                      </div>
                    </div>
      
                    <!-- ABOUT COMPANY -->
                    <div class="row col-sm-12">
                      <div class="col-sm-1 pl-0 pr-0">
                        
                      </div>   
                      <div class="col-sm-11 pl-0">
                        <span>About Company</span>       
                        <pre><p>${boothInfo.about_company_eng}</p></pre>
                      </div>
                    </div>
      
      
                    <!-- 제품개요 
                    <div class="row col-sm-12">
                      <div class="col-sm-1 pl-0 pr-0">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cpu-fill" viewBox="0 0 16 16">
                          <path d="M6.5 6a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3z"/>
                          <path d="M5.5.5a.5.5 0 0 0-1 0V2A2.5 2.5 0 0 0 2 4.5H.5a.5.5 0 0 0 0 1H2v1H.5a.5.5 0 0 0 0 1H2v1H.5a.5.5 0 0 0 0 1H2v1H.5a.5.5 0 0 0 0 1H2A2.5 2.5 0 0 0 4.5 14v1.5a.5.5 0 0 0 1 0V14h1v1.5a.5.5 0 0 0 1 0V14h1v1.5a.5.5 0 0 0 1 0V14h1v1.5a.5.5 0 0 0 1 0V14a2.5 2.5 0 0 0 2.5-2.5h1.5a.5.5 0 0 0 0-1H14v-1h1.5a.5.5 0 0 0 0-1H14v-1h1.5a.5.5 0 0 0 0-1H14v-1h1.5a.5.5 0 0 0 0-1H14A2.5 2.5 0 0 0 11.5 2V.5a.5.5 0 0 0-1 0V2h-1V.5a.5.5 0 0 0-1 0V2h-1V.5a.5.5 0 0 0-1 0V2h-1V.5zm1 4.5h3A1.5 1.5 0 0 1 11 6.5v3A1.5 1.5 0 0 1 9.5 11h-3A1.5 1.5 0 0 1 5 9.5v-3A1.5 1.5 0 0 1 6.5 5z"/>
                        </svg>
                      </div>   
                      <div class="col-sm-11 pl-0">
                        <span>제품개요</span>       
                        <pre><p></p></pre>
                      </div>
                    </div>  
                    -->
      
                    <!-- Product outline 
                    <div class="row col-sm-12">
                      <div class="col-sm-1 pl-0 pr-0">
                      </div>   
                      <div class="col-sm-11 pl-0">
                        <span>Product outline</span>       
                        <p></p>
                      </div>
                    </div>  
                    -->

                  </div>
                </div>
              </div>
            </div>


            <!-- 자료소개 -->
            <div class="tab-pane fade boot-tab-pane pb-5" id="nav2">
              <div class="row">
                <div class="col-sm-3 pl-0 border-right">
                  <ul class="pl-4 basic-tab">
                    <c:forEach var="prod" items="${prodList}" varStatus="status">
                    <li class="li_txt_line"><a href="javascript:doPdfViewer('/files${prod.file_path}')">${prod.org_file_name}</a></li>
                    </c:forEach>
                  </ul>
                </div>
                <div class="col-sm-9" id="pdfViewer"></div>
              </div>
            </div>     
            
            

            <!-- 갤러리 -->
            <div class="tab-pane fade boot-tab-pane pb-5" id="nav3">
              <div class="row">
                <div class="col-sm-3 pl-0 border-right">
                  <ul class="pl-4 basic-tab">
                    <c:forEach var="gallery" items="${galleryList}" varStatus="status">
                      <c:if test="${status.index eq 0}">
                        <li class="li_txt_line" data-target="#carouselExampleControls" data-slide-to="${status.index}"><a href="#!" >${gallery.org_file_name}</a></li> <!-- class="on"-->
                      </c:if>
                      <c:if test="${status.index ne 0}">
                        <li class="li_txt_line" data-target="#carouselExampleControls" data-slide-to="${status.index}"><a href="#!" >${gallery.org_file_name}</a></li>
                      </c:if>                      
                    </c:forEach>
                  </ul>
                </div>
                <div class="col-sm-9 pl-5 pr-5">
                  <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner">
                      <c:forEach var="gallery" items="${galleryList}" varStatus="status">

                        <c:if test="${status.index eq 0}">
                        <div class="carousel-item active">
                        </c:if>
                        <c:if test="${status.index ne 0}">
                        <div class="carousel-item">
                        </c:if>                  

                          <img src="/files${gallery.file_path}" />
                        </div>
                      </c:forEach>
                    </div>
                  </div>
                  <div class="carouse-btn">
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
    </div>
  </div>
</div>
          
<jsp:include page="/WEB-INF/jsp/include/footer_vr.jsp"></jsp:include>
<jsp:include page="vr_corp_form_js.jsp"></jsp:include>

  </body>
</html>