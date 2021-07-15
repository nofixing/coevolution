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
                <div class="form_inner member page-area">
                    <div class="join-form-area">
                      <input type="hidden" id="cust_clsf_cd" name="cust_clsf_cd" value="202002"/>

                        <table class="basic-table">
                          <tr>
                              <th>* 아이디</th>
                              <td>
                                  <div class="form-inline">
                                      <input type="text" style="ime-mode:disabled" minlength="6" maxlength="50" id="cust_id" name="cust_id" class="input-box col-lg-6 col-9" placeholder="아이디를 입력하세요">
                                      <div class="chk-btn idchk-btn p-1 m-1"> 
                                        <button type="button" class="basic-btn" id="btnDupCheck">중복확인</button>
                                      </div>
                                  </div>
                              </td>
                          </tr>
                          <tr>
                              <th>* 비밀번호</th>
                              <td>
                                <input type="password" id="cust_pw" name="cust_pw" minlength="6" maxlength="20" class="input-box col-lg-6" placeholder="비밀번호를 입력하세요">
                              </td>
                          </tr>
                          <tr>
                              <th>* 비밀번호 확인</th>
                              <td>
                                <input type="password" id="cust_pw2" name="cust_pw2" minlength="6" maxlength="20" class="input-box col-lg-6" placeholder="비밀번호를 입력하세요.">
                              </td>
                          </tr>                            
                          <tr>
                              <th>* 기업명</th>
                              <td>
                                <input type="text" name="cust_nm" id="cust_nm" maxlength="50" class="input-box col-lg-6" placeholder="기업명을 입력하세요">
                              </td>
                          </tr>
                          <tr>
                              <th>부서</th>
                              <td>
                                  <input type="text" name="dept_nm" id="dept_nm" maxlength="50" class="input-box col-lg-6" placeholder="부서을 입력하세요">
                              </td>
                          </tr>
                          <tr>
                              <th>담당자</th>
                              <td>
                                  <input type="text" name="rep_nm" id="rep_nm" maxlength="50" class="input-box col-lg-6" placeholder="담당자를 입력하세요">
                              </td>
                          </tr>          
                          <tr>
                              <th>전화번호</th>
                              <td><input type="text" name="tel_no" id="tel_no" maxlength="13" class="input-box col-lg-6" placeholder="전화번호를 입력하세요"></td>
                          </tr>                   
                          <tr>
                              <th>휴대폰</th>
                              <td><input type="text" name="hp_no" id="hp_no" maxlength="13" class="input-box col-lg-6" placeholder="휴대폰을 입력하세요"></td>
                          </tr>
                          <tr>
                              <th>이메일</th>
                              <td>
                                  <input type="text" name="email_id" id="email_id" maxlength="50" class="input-box col-lg-6" placeholder="이메일을 입력하세요">
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
                        </table>

                        <div class="register_page text-right">
                          <button type="button" class="basic-btn" id="btnList">목록</button>
                          <button type="button" class="basic-btn" id="btnUpdate">참가신청등록</button>
                        </div>
                          
                    </div>
                </div>

            </div>
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

  </form>
  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="mgnt0302_js.jsp"></jsp:include>   

  </body>
</html>