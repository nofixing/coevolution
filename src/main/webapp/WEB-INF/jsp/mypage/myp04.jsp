<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>
  </head>
  <body>
  <form>
    <input type="hidden" id="cust_clsf_cd" name="cust_clsf_cd" value="202001"/>

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



    <!-- CONTENT
    ================================================== -->
    <section class="section pt-0">
      <div class="container">

        <div class="row">
          <div class="col-xl-3" id="gLeftMenu">
            
            <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/pLeftMenu.jsp"></jsp:include>
           
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
                                <th>이름</th>
                                <td><div id="cust_nm"></div></td>
                            </tr>
                            <tr>
                                <th>이메일</th>
                                <td>
                                    <input type="text" name="email_id" id="email_id" maxlength="50" style="width:50%" class="input-box">
                                </td>
                            </tr>
                            <tr>
                                <th>주소</th>
                                <td>
                                  <input type="text" name="addr_1" id="addr_1" maxlength="100" class="input-box" placeholder="주소">
                                  <input type="hidden" name="addr_2" id="addr_2">
                                </td>
                            </tr>
                            <tr>
                                <th>연락처</th>
                                <td><input type="text" name="tel_no" id="tel_no" maxlength="13" style="width:50%" class="input-box" placeholder="연락처를 입력하세요"></td>
                            </tr>
                            <tr>
                                <th>휴대폰</th>
                                <td><input type="text" name="hp_no" id="hp_no" maxlength="13" style="width:50%" class="input-box" placeholder="-없이 숫자만 입력하세요"></td>
                            </tr>
                            <tr>
                                <th>성별</th>
                                <td>
                                    <input type="radio" name="gender_cd" id="gender_cd_203001" value="203001"><label for="gender_cd_203001"><span></span> <p class="mb-0">남자</p></label>
                                    <input type="radio" name="gender_cd" id="gender_cd_203002" value="203002"><label for="gender_cd_203002"><span></span> <p class="mb-0">여자</p></label>
                                </td>
                            </tr>                             
                            <tr>
                                <th>연령대별</th>
                                <td>
                                      <input type="radio" name="age_cd" id="age_cd_204001" value="204001">
                                      <label for="age_cd_204001"><span></span> <p class="mb-0">20대 미만</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204002" value="204002">
                                      <label for="age_cd_204002"><span></span> <p class="mb-0">20대</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204003" value="204003">
                                      <label for="age_cd_204003"><span></span> <p class="mb-0">30대</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204004" value="204004">
                                      <label for="age_cd_204004"><span></span> <p class="mb-0">40대</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204005" value="204005">
                                      <label for="age_cd_204005"><span></span> <p class="mb-0">50대</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204006" value="204006">
                                      <label for="age_cd_204006"><span></span> <p class="mb-0">60대</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204007" value="204007">
                                      <label for="age_cd_204007"><span></span> <p class="mb-0">60대 초과</p></label>                                
                                </td>
                            </tr>
                            <tr>
                                <th>소속 / 부서 / 직급</th>
                                <td>
                                    <input type="text" name="company_nm" id="company_nm" maxlength="50" style="width:25%" class="input-box" placeholder="소속을 입력하세요">
                                    <input type="text" name="dept_nm" id="dept_nm" maxlength="50" style="width:25%" class="input-box" placeholder="부서을 입력하세요">
                                    <input type="text" name="posn_nm" id="posn_nm" maxlength="50" style="width:25%" class="input-box" placeholder="직급을 입력하세요">
                                </td>
                            </tr>
                            <tr>
                                <th>국가 / 지역(시/도)</th>
                                <td>
                                    <select name="country_cd" class="custom-select-sm" style="width:40%;height:32px" id="country_cd"></select>
                                    <input type="text" name="city_nm" id="city_nm" maxlength="50" style="width:40%" class="input-box" placeholder="지역(시/도)을 입력하세요">
                                </td>
                            </tr>
                            <tr>
                                <th>방문타임</th>
                                <td>
                                      <input type="radio" name="visit_pups_cd" id="visit_pups_cd_205001" value="205001" checked><label for="visit_pups_cd_205001"><span></span> <p class="mb-0">일반관람</p></label>
                                      <input type="radio" name="visit_pups_cd" id="visit_pups_cd_205002" value="205002"><label for="visit_pups_cd_205002"><span></span> <p class="mb-0">비즈니스</p></label>
                                      <input type="radio" name="visit_pups_cd" id="visit_pups_cd_205003" value="205003"><label for="visit_pups_cd_205003"><span></span> <p class="mb-0">기자(취재)</p></label>
                                      <input type="radio" name="visit_pups_cd" id="visit_pups_cd_205004" value="205004"><label for="visit_pups_cd_205004"><span></span> <p class="mb-0">혁신제품상담</p></label>
                                </td>
                            </tr>
                            <tr>
                                <th>추천인ID</th>
                                <td><div id="rcmder_cust_id"></div></td>
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
                          <div class="form-box">
                              <div class="top-txt"><span>*</span> 아래 질문을 모두 체크해 주십시오</div>
                              <div class="join-form-tb">
                                  <!-- 201117추가-->
                                  <div class="tb-tr">
                                      <div class="tb-th"><span>*</span> 관심분야</div>
                                      <div class="tb-td">
                                          <div class="general_chk_box">
                                              <ul class="input-chk pl-0" id="list1"></ul>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="tb-tr">
                                      <div class="tb-th"><span>*</span> 종사분야</div>
                                      <div class="tb-td">
                                          <div class="general_chk_box">
                                              <ul class="input-chk pl-0" id="list2"></ul>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="tb-tr">
                                      <div class="tb-th"><span>*</span> 업무(구매)권한</div>
                                      <div class="tb-td">
                                          <div class="general_chk_box">
                                              <ul class="input-chk pl-0" id="list3"></ul>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="tb-tr">
                                      <div class="tb-th"><span>*</span> 방문목적</div>
                                      <div class="tb-td">
                                          <div class="general_chk_box">
                                              <ul class="input-chk pl-0" id="list4"></ul>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="tb-tr">
                                      <div class="tb-th"><span>*</span> 인지경로</div>
                                      <div class="tb-td">
                                          <div class="general_chk_box">
                                              <ul class="input-chk pl-0" id="list5"></ul>
                                          </div>
                                      </div>
                                  </div>
                                  <!-- 201117추가-->
                              </div>
                          </div>
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
  <jsp:include page="myp04_js.jsp"></jsp:include>   

  </body>
</html>