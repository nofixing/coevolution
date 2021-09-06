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
      select {
        background-image:none;
      }
    </style>
        
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
             <spring:message code="left.menu.edit.my.info" text="내정보수정"/>
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="/index">Home</a>
            </span>
            <span class="breadcrumb-item active">
              <spring:message code="left.menu.mypage" text="마이페이지"/>
            </span>
            <span class="breadcrumb-item active">
              <spring:message code="left.menu.edit.my.info" text="내정보수정"/>
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
            <jsp:include page="/WEB-INF/jsp/include/pLeftMenu.jsp"></jsp:include>
           
          </div>
          <div class="col-xl-9">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
                <!-- Heading -->
                <h3 class="mt-4 mb-4">
                    <strong>
                    <spring:message code="left.menu.edit.my.info" text="내정보수정"/>
                    </strong>
                </h3>
                <div class="form_inner member page-area">
                    <div class="join-form-area">
                      <form action="">
                          <table class="basic-table">
                            <tr>
                                <th><spring:message code="join_form3.id" text="아이디"/></th>
                                <td><div id="cust_id"></div></td>
                            </tr>
                            <tr>
                                <th><spring:message code="join_form3.pw" text="비밀번호"/></th>
                                <td>
                                    <a href="/mypage/myp05" class="basic-btn"><spring:message code="left.menu.change.password" text="비밀번호변경"/></a>
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="join_form3.name" text="이름"/></th>
                                <td><div id="cust_nm"></div></td>
                            </tr>
                            <tr>
                                <th><spring:message code="join_form3.e-mail" text="이메일 주소"/></th>
                                <td>
                                    <input type="text" name="email_id" id="email_id" maxlength="50" style="width:50%" class="input-box">
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="join_form3.address" text="주소"/></th>
                                <td>
                                  <input type="text" name="addr_1" id="addr_1" maxlength="100" class="input-box">
                                  <input type="hidden" name="addr_2" id="addr_2">
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="join_form3.tel" text="연락처"/></th>
                                <td><input type="text" name="tel_no" id="tel_no" maxlength="13" style="width:50%" class="input-box"></td>
                            </tr>
                            <tr>
                                <th><spring:message code="join_form3.mobile" text="휴대폰번호"/></th>
                                <td><input type="text" name="hp_no" id="hp_no" maxlength="13" style="width:50%" class="input-box"></td>
                            </tr>
                            <tr>
                                <th><spring:message code="join_form3.gender" text="성별"/></th>
                                <td>
                                    <input type="radio" name="gender_cd" id="gender_cd_203001" value="203001"><label for="gender_cd_203001"><span></span> <p class="mb-0"><spring:message code="join_form3.gender1" text="남자"/></p></label>
                                    <input type="radio" name="gender_cd" id="gender_cd_203002" value="203002"><label for="gender_cd_203002"><span></span> <p class="mb-0"><spring:message code="join_form3.gender2" text="여자"/></p></label>
                                </td>
                            </tr>                             
                            <tr>
                                <th><spring:message code="join_form3.age.group" text="연령대"/></th>
                                <td>

                                      <c:forEach var="list" items="${ageList}" varStatus="status">
                                            <c:if test="${status.first}">
                                                <input type="radio" name="age_cd" id="age_cd_${list.cd_id}" value="${list.cd_id}" checked>
                                            </c:if>
                                            <c:if test="${!status.first}">
                                                <input type="radio" name="age_cd" id="age_cd_${list.cd_id}" value="${list.cd_id}">
                                            </c:if>
                                            <label for="age_cd_${list.cd_id}"><span></span> 
                                                <p class="mb-0">
                                                    <c:if test="${sessionScope.LANG ne 'en'}">
                                                        ${list.cd_nm}
                                                    </c:if>
                                                    <c:if test="${sessionScope.LANG eq 'en'}">
                                                        ${list.cd_nm_en}
                                                    </c:if>
                                                </p>
                                            </label>
                                      </c:forEach>

                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="join_form3.affiliation" text="소속"/> / <spring:message code="join_form3.department" text="부서"/> / <spring:message code="join_form3.position" text="직급"/></th>
                                <td>
                                    <input type="text" name="company_nm" id="company_nm" maxlength="50" style="width:25%" class="input-box">
                                    <input type="text" name="dept_nm" id="dept_nm" maxlength="50" style="width:25%" class="input-box">
                                    <input type="text" name="posn_nm" id="posn_nm" maxlength="50" style="width:25%" class="input-box">
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="join_form3.nationality" text="국가"/> / <spring:message code="join_form3.region" text="지역(시/도)"/></th>
                                <td>
                                    <select name="country_cd" class="custom-select-sm" style="width:40%;height:32px" id="country_cd"></select>
                                    <input type="text" name="city_nm" id="city_nm" maxlength="50" style="width:40%" class="input-box">
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="join_form3.visit" text="방문타입"/></th>
                                <td>
                                      <c:forEach var="list" items="${visitPupsList}" varStatus="status">
                                            <c:if test="${status.first}">
                                                <input type="radio" name="visit_pups_cd" id="visit_pups_cd_${list.cd_id}" value="${list.cd_id}" checked>
                                            </c:if>
                                            <c:if test="${!status.first}">
                                                <input type="radio" name="visit_pups_cd" id="visit_pups_cd_${list.cd_id}" value="${list.cd_id}">
                                            </c:if>
                                            <label for="visit_pups_cd_${list.cd_id}"><span></span> 
                                                <p class="mb-0">
                                                    <c:if test="${sessionScope.LANG ne 'en'}">
                                                        ${list.cd_nm}
                                                    </c:if>
                                                    <c:if test="${sessionScope.LANG eq 'en'}">
                                                        ${list.cd_nm_en}
                                                    </c:if>
                                                </p>
                                            </label>
                                      </c:forEach>
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="form.myinfo.update.recommender" text="추천인ID"/></th>
                                <td><div id="rcmder_cust_id"></div></td>
                            </tr>                            
                            <tr>
                                <th><spring:message code="form.myinfo.update.privacy.policy.Agree" text="개인정보 수집이용"/></th>
                                <td><div id="agree_1"></div></td>
                            </tr>
                            <tr>
                                <th><spring:message code="form.myinfo.update.marketing.Agree" text="마케팅 활용 동의"/></th>
                                <td><div id="agree_3"></div></td>
                            </tr>
                            <tr>
                                <th><spring:message code="form.myinfo.update.registration.date" text="가입일자"/></th>
                                <td><div id="ins_dt"></div></td>
                            </tr>
                            <!--tr>
                                <th>최근방문일시</th>
                                <td>yyyy-mm-dd 15:00:00</td>
                            </tr-->
                            <tr>
                                <th><spring:message code="form.myinfo.update.status" text="상태"/></th>
                                <td><div id="cust_sts_nm"></div></td>
                            </tr>

                          </table>
                          <div class="form-box">
                              <div class="top-txt"><span>*</span> <spring:message code="join_form3.questions.message" text="아래 질문을 모두 체크해 주십시오"/></div>
                              <div class="join-form-tb">
                                  <!-- 201117추가-->
                                  <div class="tb-tr">
                                      <div class="tb-th"><span>*</span> <spring:message code="join_form3.areas.interest" text="관심분야"/></div>
                                      <div class="tb-td">
                                          <div class="general_chk_box">
                                              <ul class="input-chk pl-0" id="list1"></ul>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="tb-tr">
                                      <div class="tb-th"><span>*</span> <spring:message code="join_form3.occupation.field" text="종사분야"/></div>
                                      <div class="tb-td">
                                          <div class="general_chk_box">
                                              <ul class="input-chk pl-0" id="list2"></ul>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="tb-tr">
                                      <div class="tb-th"><span>*</span> <spring:message code="join_form3.business.authority" text="업무(구매)권한"/></div>
                                      <div class="tb-td">
                                          <div class="general_chk_box">
                                              <ul class="input-chk pl-0" id="list3"></ul>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="tb-tr">
                                      <div class="tb-th"><span>*</span> <spring:message code="join_form3.purpose.visit" text="방문목적"/></div>
                                      <div class="tb-td">
                                          <div class="general_chk_box">
                                              <ul class="input-chk pl-0" id="list4"></ul>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="tb-tr">
                                      <div class="tb-th"><span>*</span> <spring:message code="join_form3.how.to" text="인지경로"/></div>
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
                            <button type="button" class="register_page_submit" id="btnUpdate"><spring:message code="form.myinfo.update.information" text="정보수정"/></button>
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