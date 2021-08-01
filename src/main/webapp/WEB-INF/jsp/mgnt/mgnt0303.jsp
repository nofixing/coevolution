<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>

    <style>
      .form_height1 {
        height:calc(1.9rem + 2px);
      }

      select {
        background-image:none;
      }
    </style>

  </head>
  <body>

  <form>

    <input type="hidden" id="cust_clsf_cd" name="cust_clsf_cd" value="202002"/>

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
              참가회원 정보입력
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="/index">Home</a>
            </span>
            <span class="breadcrumb-item active">
              관리자페이지
            </span>
            <span class="breadcrumb-item active">
              참가회원 정보입력
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>


  <!-- 진행순서
    ================================================== -->
    <section class="section pt-0">
      <div class="container">

        <div class="row">
          <div class="col-md-3">
            
            <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/mLeftMenu.jsp"></jsp:include>
           
          </div>
          <div class="col-md-9">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
                <!-- Heading -->
                <h3 class="mt-4 mb-4">
                    <strong>
                    참가회원 정보입력
                    </strong>
                </h3>

              <!-- tab-content -->
              <div class="tab-content">

                <!-- Nav tabs -->
                <ul class="nav nav-tabs">
                  <li class="nav-item">
                    <a class="nav-link active text-xs" data-toggle="tab" href="#custInfo"><strong>회원정보변경</strong></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link text-xs" data-toggle="tab" href="#custBooth"><strong>부스정보변경</strong></a>
                  </li>
                </ul>
                 <!-- / .Nav tabs -->

                <!-- 정보변경 -->
                <div id="custInfo" class="container tab-pane active pl-0 pr-0">

                  <div class="form_inner member page-area">
                    <div class="join-form-area">
                      <form name="custForm" id="custForm">
                        <table class="basic-table">
                          <tr>
                              <th>아이디</th>
                              <td><div id="cust_id"></div></td>
                          </tr>
                          <tr>
                              <th>비밀번호</th>
                              <td>
                                  <a href="javascript:pwReset()" class="basic-btn">비밀번호 초기화</a>
                              </td>
                          </tr>
                          <tr>
                              <th>기업명</th>
                              <td>
                                <input type="text" name="cust_nm" id="cust_nm" maxlength="50" style="width:50%" class="input-box">
                              </td>
                          </tr>
                          <tr>
                              <th>이메일</th>
                              <td>
                                  <input type="text" name="email_id" id="email_id" maxlength="50" style="width:50%" class="input-box">
                              </td>
                          </tr>
                          <tr>
                              <th>전화번호</th>
                              <td><input type="text" name="tel_no" id="tel_no" maxlength="13" style="width:50%" class="input-box" placeholder="전화번호를 입력하세요"></td>
                          </tr>  
                          <tr>
                              <th>휴대폰</th>
                              <td><input type="text" name="hp_no" id="hp_no" maxlength="13" style="width:50%" class="input-box" placeholder="-없이 숫자만 입력하세요"></td>
                          </tr>                            
                          <tr>
                              <th>부서</th>
                              <td>
                                  <input type="text" name="dept_nm" id="dept_nm" maxlength="50" style="width:50%" class="input-box" placeholder="부서을 입력하세요">
                              </td>
                          </tr>
                          <tr>
                              <th>담당자</th>
                              <td>
                                  <input type="text" name="rep_nm" id="rep_nm" maxlength="50" style="width:50%" class="input-box" placeholder="담당자를 입력하세요">
                              </td>
                          </tr>                            
                          <tr>
                              <th>국가</th>
                              <td>
                                  <select name="country_cd" class="custom-select-sm col-lg-6" style="height:32px" id="country_cd"></select>
                              </td>
                          </tr>     
                          <tr>
                              <th>카테고리</th>
                              <td>
                                  <select name="category1" class="custom-select-sm col-lg-6" style="height:32px" id="category1"></select>
                              </td>
                          </tr>                                               
                          <tr>
                              <th>개인정보 수집이용</th>
                              <td><div id="agree_1"></div></td>
                          </tr>
                          <tr>
                              <th>마케팅 활용 동의</th>
                              <td><div id="agree_3"></div></td>
                          </tr>
                          <tr>
                              <th>가입일자</th>
                              <td><div id="ins_dt"></div></td>
                          </tr>
                          <!--tr>
                              <th>최근방문일시</th>
                              <td>yyyy-mm-dd 15:00:00</td>
                          </tr-->
                          <tr>
                              <th>상태</th>
                              <td><div id="cust_sts_nm"></div></td>
                          </tr>

                          <tr>
                              <th>VR기업정보URL</th>
                              <td><pre><div id="vr_corpinfo_url"></div></pre></td>
                          </tr>  

                          <tr>
                              <th>VR Q&A URL</th>
                              <td><pre><div id="vr_corpcoslt_url"></div></pre></td>
                          </tr>                                                   

                        </table>
                        <div class="register_page text-right">
                          <button type="button" class="basic-btn" id="btnList1">목록</button>
                          <button type="button" class="basic-btn" id="btnUpdate">정보수정</button>
                        </div>
                      </form>
                    </div>
                  </div>

                </div>
                <!-- / .정보변경 -->


                <!-- 부스정보변경 -->
                <div id="custBooth" class="container tab-pane pl-0 pr-0">

                  <div class="form_inner member page-area">
                    <div class="join-form-area">
                      <form name="boothForm" id="boothForm">
                        <table class="basic-table">
                          <tr>
                            <th>기업CI</th>
                            <td colspan="3">
                              <div class="col-sm-12 input-group-text border-0 bg-white">
                                <button type="button" class="basic-btn" id="btn_corp_ci">파일선택</button>
                                <div id="imgCorpCi" class="col-sm-auto"></div>
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
                          <input type="hidden" placeholder="url을 입력해 주세요." id="video_url" name="video_url" maxlength="100">
                          <input type="hidden" placeholder="url을 입력해 주세요." id="promtn_url" name="promtn_url" maxlength="100">
                          <!-- tr>
                            <th>기업영상</th>
                            <td colspan="3">
                              <input type="text" placeholder="url을 입력해 주세요." id="video_url" name="video_url" maxlength="100">
                            </td>
                          </tr>
                          <tr>
                            <th>홍보동영상</th>
                            <td colspan="3">
                              <input type="text" placeholder="url을 입력해 주세요." id="promtn_url" name="promtn_url" maxlength="100">
                            </td>
                          </tr>
                          <tr -->
                            <th>제품소개</th>
                            <td colspan="3">
                              <div class="col-sm-12 input-group-text border-0 bg-white">
                                <button type="button" class="basic-btn" id="btn_corp_product">파일선택</button>
                                <div id="corpProduct" class="col-sm-auto input-group-text border-0 bg-white"></div>
                              </div>
                            </td>
                          </tr>
                          <tr>
                            <th rowspan="3">갤러리</th>
                            <td colspan="3">
                              <div class="col-sm-12 input-group-text border-0 bg-white">
                                <button type="button" class="basic-btn" id="btnGallery">파일선택</button>
                                <div id="corpGallery" class="col-sm-auto input-group-text border-0 bg-white"></div>
                              </div>
                            </td>
                          </tr>
                          <input type="hidden" name="scan_3d_url" id="scan_3d_url" placeholder="url을 입력해 주세요." maxlength="100">
                          <input type="hidden" name="comrce_url" id="comrce_url" placeholder="url을 입력해 주세요." maxlength="100">
                          <!-- tr>
                            <th>3D 스캐닝</th>
                            <td colspan="3">
                              <input type="text" name="scan_3d_url" id="scan_3d_url" placeholder="url을 입력해 주세요." maxlength="100">
                            </td>
                          </tr>
                          <tr>
                            <th>커머스 연결</th>
                            <td colspan="3">
                              <input type="text" name="comrce_url" id="comrce_url" placeholder="url을 입력해 주세요." maxlength="100">
                            </td>
                          </tr -->

                        </table>
                        <div class="register_page text-right">
                          <button type="button" class="basic-btn" id="btnList2">목록</button>
                          <button type="button" class="basic-btn" id="btnUpdateBooth">정보수정</button>
                        </div>

                        <input type="hidden" name="attach_id" id="attach_id"/>
                        
                      </form>
                    </div>
                  </div>

                </div>
                <!-- / .부스정보변경 -->                

              </div>
              <!-- / .tab-content -->
              

            </div>
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

  </form>

  <form id="fileForm" method="post" enctype="multipart/form-data">
    <input type="hidden" id="file_clsf_cd" name="file_clsf_cd" value="101008"/> <!-- 내부스정보등록 -->
    <input type="hidden" id="file_clsf_dtl_cd" name="file_clsf_dtl_cd"/> <!-- upper_cd : 101008 -->
    <input type="hidden" id="file_cust_id" name="file_cust_id"/> <!-- 고객id -->
    <div id="divFileModal"></div>
  </form>    


  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="mgnt0303_js.jsp"></jsp:include>   

  </body>
</html>