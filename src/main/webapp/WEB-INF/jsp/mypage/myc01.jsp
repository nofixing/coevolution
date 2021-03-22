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
              내 부스 정보 등록
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
                내 부스 정보 등록
              </h3>

              <form class="form-styled">

                <div class="form-group">
                  
                  <div class="input-group">
                    <div class="col-sm-4 input-group-text border-0" style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small;" >기업CI</div>
                    <div class="col-sm-8 input-group-text border-0 bg-white " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" >
                      <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" data-toggle="modal" data-target="#fileModal" style="width: 8rem;" id="btn_corp_ci">파일선택</button>
                    </div>
                  </div>   

                  <div class="input-group">
                    <div class="col-sm-4 input-group-text border-0" style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small;" >홈페이지</div>
                    <div class="col-sm-8 input-group-text border-0 bg-white " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" >
                      <input type="text" class="form-control" id="homepage_url" name="homepage_url"/>
                    </div>
                  </div>  

                  <div class="input-group">
                    <div class="col-sm-4 input-group-text border-0" style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small;" >기업소개(한)</div>
                    <div class="col-sm-8 input-group-text border-0 bg-white " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" >
                      <textarea rows="3" class="form-control" style="width: 100%;" id="about_company_kor" name="about_company_kor"></textarea>
                    </div>
                  </div>     
                  
                  <div class="input-group">
                    <div class="col-sm-4 input-group-text border-0" style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small;" >기업소개(영)</div>
                    <div class="col-sm-8 input-group-text border-0 bg-white " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" >
                      <textarea rows="3" class="form-control" style="width: 100%;" id="about_company_eng" name="about_company_eng"></textarea>
                    </div>
                  </div>   
                  
                  <div class="input-group">
                    <div class="col-sm-4 input-group-text border-0" style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small;" >기업영상</div>
                    <div class="col-sm-8 input-group-text border-0 bg-white " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small"  >
                      <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 8rem;" id="btnVideoRrl">파일선택</button>
                      <input type="text" class="form-control" id="video_url"/>
                    </div>
                  </div>
                  
                  <div class="input-group">
                    <div class="col-sm-4 input-group-text border-0" style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small;" >홍보동영상</div>
                    <div class="col-sm-8 input-group-text border-0 bg-white " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" >
                      <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 8rem;" id="btnPromtnIrl">파일선택</button>
                      <input type="text" class="form-control" id="promtn_url"/>
                    </div>
                  </div>     

                  <div class="input-group">
                    <div class="col-sm-4 input-group-text border-0" style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small;" >제품소개</div>
                    <div class="col-sm-8 input-group-text border-0 bg-white " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" >
                      <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 8rem;" id="btnProductItem">파일선택</button>
                    </div>
                  </div>         
                  
                  <div class="input-group">
                    <div class="col-sm-4 input-group-text border-0" style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small;" >갤러리</div>
                    <div class="col-sm-8 input-group-text border-0 bg-white " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" >
                      <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 8rem;" id="btnGallery">파일선택</button>
                    </div>
                  </div>     
                  

                  <div class="input-group">
                    <div class="col-sm-4 input-group-text border-0" style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small;" >3D스캐닝</div>
                    <div class="col-sm-8 input-group-text border-0 bg-white " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" >
                        <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 8rem;" id="btnScan3d">파일선택</button>
                        <input type="text" class="form-control" id="scan_3d_url"/>
                    </div>
                  </div>
                  
                  <div class="input-group">
                    <div class="col-sm-4 input-group-text border-0" style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small;" >커머스 연결</div>
                    <div class="col-sm-8 input-group-text border-0 bg-white " style="border-top:1px solid rgba(0,0,0,.1)!important; font-size: small" >
                      <input type="text" class="form-control" id="comrce_url"/>
                    </div>
                  </div>                  

                </div>  

                <div class="input-group">
                  <div class="col-sm-12 d-flex justify-content-center">
                    <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 8rem;" id="btnSave">저장</button>
                  </div>   
                </div>

              </form>

            </div>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>




    <div class="modal fade" id="fileModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <form id="fileForm" method="post" enctype="multipart/form-data">
        <input type="hidden" id="file_clsf_cd" name="file_clsf_cd" value="101008"/> <!-- 내부스정보등록 -->
        <input type="hidden" id="file_clsf_dtl_cd" name="file_clsf_dtl_cd"/> <!-- upper_cd : 101008 -->
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="sitemap clearfix pt-0 pb-3">
                        <ul>
                            <li>
                                <strong>파일업로드</strong>
                            </li>
                        </ul>
                    </div>
                    <div>
                      <input type="file" id="fileUpload" name="fileUpload" class="form-control" accept=".jpg, .jpeg, .png" multiple/>
                    </div>
                </div>

                <div class="input-group">
                  <div class="col-sm-12 d-flex justify-content-center">
                    <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 8rem;" id="btnFileSave">저장</button>
                  </div>   
                </div>

            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </form>
    </div><!-- /.modal -->    

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myc01_js.jsp"></jsp:include>

  </body>
</html>