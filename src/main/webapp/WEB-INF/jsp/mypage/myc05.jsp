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
              정보 수정
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
              내정보수정
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>



  <!-- 진행순서
    ================================================== -->
    <section class="section pt-0">
      <div class="containe mt-block">

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
                  내 정보 수정
                  </strong>
              </h3>

              <div class="form_inner member page-area">
                <div class="join-form-area">
                  <form action="">
                    <table class="basic-table">
                      <tr>
                          <th>아이디</th>
                          <td><div id="cust_id"></div></td>
                      </tr>
                      <tr>
                          <th>비밀번호</th>
                          <td>
                              <a href="/mypage/myp05" class="basic-btn">비밀번호 변경</a>
                          </td>
                      </tr>
                      <tr>
                          <th>기업명</th>
                          <td><div id="cust_nm"></div></td>
                      </tr>
                      <tr>
                          <th>이메일</th>
                          <td>
                              <input type="text" name="email_id" id="email_id" maxlength="50" style="width:50%" class="input-box">
                          </td>
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
                              <select name="country_cd" class="custom-select-sm" style="width:40%;height:32px" id="country_cd"></select>
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

                    </table>
                    <div class="register_page text-center">
                      <button type="button" class="register_page_submit" id="btnUpdate">정보수정</button>
                    </div>
                  </form>
                </div>
              </div>

            </div>
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

  </form>
  
  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="myc05_js.jsp"></jsp:include>   

  </body>
</html>