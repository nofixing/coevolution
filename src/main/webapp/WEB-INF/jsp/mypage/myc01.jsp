<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
              내 부스 정보 등록
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
              내 부스 정보 등록
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>
    
    <!-- CONTENT
    ================================================== -->
    <section class="section pt-0 mt-block">
      <div class="container">

        <div class="row">
          <div class="col-xl-3" id="gLeftMenu">
            
             <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/cLeftMenu.jsp"></jsp:include>
           
          </div>
          <div class="col-xl-9">


            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mt-4 mb-4">
                <strong>
                  내 부스 정보 등록
                </strong>
              </h3>              
              <form class="form-styled">
                <input type="hidden" name="attach_id" id="attach_id"/>

                <div class="form-group">
                  
                  <div class="form-row justify-content-center">
                    <table class="basic-table">
                      <tr>
                        <th>기업CI</th>
                        <td colspan="3">
                          <div class="col-sm-12 input-group-text border-0 bg-white">
                            <button type="button" class="basic-btn" id="btn_corp_ci">파일선택</button>
                            <div id="imgCorpCi" class="col-sm-auto input-group-text border-0 bg-white"></div>
                          </div>
                        </td>
                      </tr>
                      <tr>
                        <th>홈페이지</th>
                        <td colspan="3">
                          <input type="text" placeholder="url을 입력해 주세요." id="homepage_url" name="homepage_url" maxlength="100">
                        </td>
                      </tr>
                      <tr>
                        <th>기업소개<br>(KOR)</th>
                        <td colspan="3">
                          <textarea id="about_company_kor" name="about_company_kor" cols="30" rows="5"></textarea>
                        </td>
                      </tr>
                      <tr>
                        <th>기업소개<br>(ENG)</th>
                        <td colspan="3">
                          <textarea id="about_company_eng" name="about_company_eng" cols="30" rows="5"></textarea>
                        </td>
                      </tr>
                      <!--tr>
                        <th>기업영상</th>
                        <td colspan="3">
                          <input type="text" placeholder="url을 입력해 주세요." id="video_url" name="video_url" maxlength="100">
                        </td>
                      </tr-->
                      <input type="hidden" id="video_url" name="video_url">
                      <!--tr>
                        <th>홍보동영상</th>
                        <td colspan="3">
                          <input type="text" placeholder="url을 입력해 주세요." id="promtn_url" name="promtn_url" maxlength="100">
                        </td>
                      </tr-->
                      <input type="hidden" id="promtn_url" name="promtn_url">
                      <tr>
                        <th>제품소개</th>
                        <td colspan="3">
                          <div class="col-sm-12 border-0 bg-white">
                            <button type="button" class="basic-btn" id="btn_corp_product">파일선택</button>
                            <div id="corpProduct" class="col-sm-auto input-group-text border-0 bg-white"></div>
                          </div>
                        </td>
                      </tr>
                      <tr>
                        <th rowspan="3">갤러리</th>
                        <td colspan="3">
                          <div class="col-sm-12 border-0 bg-white">
                            <button type="button" class="basic-btn" id="btnGallery">파일선택</button>
                            <div id="corpGallery" class="col-sm-auto input-group-text border-0 bg-white"></div>
                          </div>
                        </td>
                      </tr>
                      <!--tr>
                        <th>3D 스캐닝</th>
                        <td colspan="3">
                          <input type="text" name="scan_3d_url" id="scan_3d_url" placeholder="url을 입력해 주세요." maxlength="100">
                        </td>
                      </tr-->
                      <input type="hidden" id="scan_3d_url" name="scan_3d_url">
                      <!--tr>
                        <th>커머스 연결</th>
                        <td colspan="3">
                          <input type="text" name="comrce_url" id="comrce_url" placeholder="url을 입력해 주세요." maxlength="100">
                        </td>
                      </tr-->
                      <input type="hidden" id="comrce_url" name="comrce_url">
                      <!--tr>
                        <th>줌 URL</th>
                        <td colspan="3">
                          <input type="hidden" name="zoom_mgnt_id" id="zoom_mgnt_id">
                          <input type="hidden" name="use_yn" id="use_yn">
                          <input type="text" name="zoom_url" id="zoom_url" placeholder="줌 URL을 입력해 주세요." maxlength="100">
                        </td>
                      </tr-->
                      <input type="hidden" name="zoom_mgnt_id" id="zoom_mgnt_id">
                      <input type="hidden" name="use_yn" id="use_yn">
                      <input type="hidden" id="zoom_url" name="zoom_url">

                    </table>
                    <!-- Button -->
                    <div class="text-right text-md-right p-3">
                      <button type="button" class="basic-btn" id="btnSave">저장</button>
                    </div>
                    <!--div class="text-right text-md-right pt-3">
                      <button type="button" class="basic-btn" id="btnZoom">ZOOM 미사용</button>
                    </div-->                    

                  </div> <!-- / .form-row -->   

                </div>  


              </form>

            </div>

          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <form id="fileForm" method="post" enctype="multipart/form-data">
      <input type="hidden" id="file_clsf_cd" name="file_clsf_cd" value="101008"/> <!-- 내부스정보등록 -->
      <input type="hidden" id="file_clsf_dtl_cd" name="file_clsf_dtl_cd"/> <!-- upper_cd : 101008 -->
      <div id="divFileModal"></div>
    </form>  

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myc01_js.jsp"></jsp:include>

  </body>
</html>