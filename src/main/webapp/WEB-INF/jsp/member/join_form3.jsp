<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
  <input type="hidden" id="agree_1" name="agree_1" value="${agree_1}"/>
  <input type="hidden" id="agree_2" name="agree_2" value="${agree_2}"/>
  <input type="hidden" id="agree_3" name="agree_3" value="${agree_3}"/>
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
              참관등록
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="index.html">Home</a>
            </span>
            <span class="breadcrumb-item active">
              참관등록
            </span>
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>    



<!-- 진행순서
    ================================================== -->
    <section class="section pb-0">
      <div class="container">

        <div class="row">

          <div class="col-md-2">
            
            <!-- Title -->
            <h6 class="title">
              참관등록
            </h6>

          </div>

          <div class="form-row col-md-10"> 

            <div class="col-md-3">
              
              <!-- Card -->
              <div class="card card-mg mb-3 mb-lg-4 ">
                
                <!-- Body -->
                <div class="card-body text-center">
  
                  <!-- Title -->
                  <h4 class="card-title">
                    Step1. 약관동의
                  </h4>
  
                </div>
                
              </div> <!-- / .card -->
  
            </div>
            <div class="col-md-1"></div>
  
             <div class="col-md-3">
              
              <!-- Card -->
              <div class="card card-mg mb-3 mb-lg-4">
                
                <!-- Body -->
                <div class="card-body text-center card-active">
  
                  <!-- Title -->
                  <h4 class="card-title">
                    Step2. 정보입력
                  </h4>
  
                </div>
                
              </div> <!-- / .card -->
  
            </div>
            <div class="col-md-1"></div>
  
            <div class="col-md-3">
              
              <!-- Card -->
              <div class="card card-mg mb-3 mb-lg-4">
                
                <!-- Body -->
                <div class="card-body text-center">
  
                  <!-- Title -->
                  <h4 class="card-title">
                    Step3. 가입완료
                  </h4>
  
                </div>
                
              </div> <!-- / .card -->
  
            </div>
            <div class="col-md-1"></div>

          </div> <!-- / .row -->

          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>


<!-- 진행순서
    ================================================== -->
    <section class="section pb-0">
      <div class="container">
        <div class="row">

          <div class="col-md-2">
            
            <!-- Title -->
            <h6 class="title">
              정보입력
            </h6>

          </div>

          <div class="col-md-10">
            
              <div class="form-row">
                  <div class="form-group col-md-3">
                    <label>아이디</label> <label class="text-danger">*</label>
                    <input type="text" class="form-control form_height1" style="ime-mode:disabled;" maxlength="10" id="cust_id" name="cust_id">
                  </div>
                  <div class="form-group col-md-9">
                      <label style="visibility: visible;">.</label>
                      <div class="text-left text-md-left form_height1">
                        <button type="button" class="btn btn-outline-primary form_height1" style="padding: 0rem 2rem;margin-right: 1rem;" id="btnDupCheck">중복확인</button>
                        <label>※ 아이디는 6자 이상, 10자 이하 영문 소문자와 숫자만 사용 가능합니다.</label>
                      </div>
                  </div>
              </div> <!-- / .form-row -->

              <div class="form-row">
                <div class="form-group col-md-3">
                  <label>비밀번호</label> <label class="text-danger">*</label>
                  <input type="password" class="form-control form_height1" id="cust_pw" name="cust_pw" maxlength="20">
                </div>
                <div class="form-group col-md-3">
                  <label>비밀번호 확인</label> <label class="text-danger">*</label>
                  <input type="password" class="form-control form_height1" id="cust_pw2" name="cust_pw2" maxlength="20">
                </div>
                <div class="form-inline col-md-6">
                  <label>※ 비밀번호는 영문, 숫자 혼용하여 6~10자 이내로 입력해주세요.</label>             
                </div>
              </div> <!-- / .form-row -->

              <div class="form-row">
                <div class="form-group col-md-3">
                  <label>이름</label> <label class="text-danger">*</label>
                  <input type="text" class="form-control form_height1" id="cust_nm" name="cust_nm" maxlength="20">
                </div>
                <div class="form-group col-md-auto">
                  <label>성별</label> <label class="text-danger">*</label>
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="gender_cd" id="gender_cd_203001" value="203001" checked>
                      <label class="form-check-label" for="gender_cd">남성</label>
                    </div>  
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="gender_cd" id="gender_cd_203002" value="203002">
                      <label class="form-check-label" for="gender_cd">여성</label>
                    </div>  
                  </div>
                </div>
              </div> <!-- / .form-row -->


              <div class="form-row">
                <div class="form-group col-md-auto">
                  <label>연령대</label> <label class="text-danger">*</label>
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="age_cd" id="age_cd_204001" value="204001" checked>
                      <label class="form-check-label" for="age_cd_204001">20대 미만</label>
                    </div>  
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="age_cd" id="age_cd_204002" value="204002">
                      <label class="form-check-label" for="age_cd_204002">20대</label>
                    </div>  
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="age_cd" id="age_cd_204003" value="204003">
                      <label class="form-check-label" for="age_cd_204003">30대</label>
                    </div>  
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="age_cd" id="age_cd_204004" value="204004">
                      <label class="form-check-label" for="age_cd_204004">40대</label>
                    </div>
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="age_cd" id="age_cd_204005" value="204005">
                      <label class="form-check-label" for="age_cd_204005">50대</label>
                    </div>
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="age_cd" id="age_cd_204006" value="204006">
                      <label class="form-check-label" for="age_cd_204006">60대</label>
                    </div>
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="age_cd" id="age_cd_204007" value="204007">
                      <label class="form-check-label" for="age_cd_204007">60대 초과</label>
                    </div>
                  </div>
                </div>
              </div> <!-- / .form-row -->


              <div class="form-row">
                <div class="form-group col-md-3">
                  <label>소속</label> <label class="text-danger">*</label>
                  <input type="text" class="form-control form_height1" name="company_nm" id="company_nm" maxlength="50">
                </div>
              </div> <!-- / .form-row -->


              <div class="form-row">
                <div class="form-group col-md-3">
                  <label>부서</label> <label class="text-danger">*</label>
                  <input type="text" class="form-control form_height1" name="dept_nm" id="dept_nm" maxlength="50">
                </div>
                <div class="form-group col-md-3">
                  <label>직급</label>
                  <input type="text" class="form-control form_height1" name="posn_nm" id="posn_nm" maxlength="50">
                </div>
              </div> <!-- / .form-row -->

              <div class="form-row">
                <div class="form-group col-md-3">
                  <label>휴대전화번호</label> <label class="text-danger">*</label>
                  <input type="text" class="form-control form_height1" name="hp_no" id="hp_no" maxlength="13">
                </div>
                <div class="form-group col-md-3">
                  <label>연락처</label>
                  <input type="text" class="form-control form_height1" name="tel_no" id="tel_no" maxlength="13">
                </div>
              </div> <!-- / .form-row -->

              <div class="form-row">
                <div class="form-group col-md-12">
                  <label>이메일주소</label>
                  <div class="form-row align-items-center">
                    <div class="col-md-3">
                      <input type="text" class="form-control form_height1" name="email_id1" id="email_id1" maxlength="50">
                    </div>
                    <div class="col-md-3">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <div class="input-group-text form_height1">@</div>
                        </div>
                        <input type="text" class="form-control form_height1" name="email_id2" id="email_id2" maxlength="50">
                      </div>
                    </div>
                    <div class="col-md-3">
                      <select class="custom-select custom-select-sm form_height1" id="email_clsf">
                        <option value="" selected>직접입력</option>
                        <option value="naver.com">naver.com</option>
                        <option value="daum.net">daum.net</option>
                        <option value="gmail.com">gmail.com</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div> <!-- / .form-row -->


              <div class="form-row">
                <div class="form-group col-md-3">
                  <label>국가</label> <label class="text-danger">*</label>
                  <select class="custom-select custom-select-sm form_height1" name="country_cd" id="country_cd">
                    <option selected value="212001">대한민국</option>
                    <option value="212002">국가1</option>
                    <option value="212003">국가2</option>
                    <option value="212004">국가3</option>
                  </select>
                </div>
                <div class="form-group col-md-3">
                  <label>지역(시도)</label> <label class="text-danger">*</label>
                  <input type="text" class="form-control form_height1" name="city_nm" id="city_nm" maxlength="50">
                </div>
              </div> <!-- / .form-row -->

              <div class="form-row">
                <div class="form-group col-md-12">
                  <label>주소</label> 
                  <div class="form-row align-items-center">
                    <div class="col-md-1.5">
                      <input type="text" class="form-control form_height1" name="zip_code" id="zip_code" maxlength="50">
                    </div>
                    <div class="col-md-1.5">
                      <div class="text-center text-md-center form_height1">
                        <button type="button" class="btn btn-outline-primary form_height1" style="padding: 0rem 2rem;" name="search_zip_code" id="search_zip_code">찾기</button>
                      </div>
                    </div>
                    <div class="col-md-4">
                      <input type="text" class="form-control form_height1" name="addr_1" id="addr_1" maxlength="50">
                    </div>
                    <div class="col-md-4">
                      <input type="text" class="form-control form_height1" name="addr_2" id="addr_2" maxlength="50">
                    </div>
                  </div>
                </div>
              </div> <!-- / .form-row -->


              <div class="form-row">
                <div class="form-group col-md-auto">
                  <label>방문타입</label> <label class="text-danger">*</label>
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="visit_pups_cd" id="visit_pups_cd_205001" value="205001" checked>
                      <label class="form-check-label" for="visit_pups_cd_205001">일반관람</label>
                    </div>  
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="visit_pups_cd" id="visit_pups_cd_205002" value="205002">
                      <label class="form-check-label" for="visit_pups_cd_205002">비지니스</label>
                    </div>  
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="visit_pups_cd" id="visit_pups_cd_205003" value="205003">
                      <label class="form-check-label" for="visit_pups_cd_205003">기자(취재)</label>
                    </div>  
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="visit_pups_cd" id="visit_pups_cd_205004" value="205004">
                      <label class="form-check-label" for="visit_pups_cd_205004">혁신제품상담</label>
                    </div>
                  </div>
                </div>
              </div> <!-- / .form-row -->


              <div class="form-row">
                <div class="form-group col-md-3">
                  <label>추천인(ID)</label> 
                  <input type="text" class="form-control form_height1" name="rcmder_cust_id" id="rcmder_cust_id" maxlength="20">
                </div>
                <div class="form-group col-md-9">
                    <label style="visibility: visible;">.</label>
                    <div class="text-left text-md-left form_height1">
                      <button type="button" class="btn btn-outline-primary form_height1" style="padding: 0rem 2rem;margin-right: 1rem;" name="search_rcmder_cust_id" id="search_rcmder_cust_id">추천인 검색</button>
                      <label>※ 추천인(ID) 등록 시 이벤트 참여 가능한 뱃지를 제공해드립니다. </label>
                    </div>
                </div>
            </div> <!-- / .form-row -->              

          </div> <!-- / .row -->

        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>



    <section class="section pb-0">

      <!-- Content -->
      <div class="container">
        <div class="row">
          <div class="col-md-2">
            
            <!-- Title -->
            <h6 class="title">
              관심분야 <label class="text-danger">*</label>
            </h6>

          </div>
          <div class="col-md-10">
            
              <div class="form-row">

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="S206000" id="S206001" value="206001">
                      <label class="form-check-label" for="S206001">전기자동차 국가별관</label>
                    </div>  
                  </div>
                </div>

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="S206000" id="S206002" value="206002">
                      <label class="form-check-label" for="S206002">전기자동차 주제별관</label>
                    </div>  
                  </div>
                </div>   
                
                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="S206000" id="S206003" value="206003">
                      <label class="form-check-label" for="S206003">전기자동차</label>
                    </div>  
                  </div>
                </div>   

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="S206000" id="S206004" value="206004">
                      <label class="form-check-label" for="S206004">관람가이드</label>
                    </div>  
                  </div>
                </div>   

              </div> <!-- / .form-row -->

              <div class="form-row">

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="S206000" id="S206005" value="206005">
                      <label class="form-check-label" for="S206005">부스</label>
                    </div>  
                  </div>
                </div>

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="S206000" id="S206006" value="206006">
                      <label class="form-check-label" for="S206006">기타</label>
                    </div>  
                  </div>
                </div>   

              </div> <!-- / .form-row -->


          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->

    </section>  



    <section class="section pb-0">

      <!-- Content -->
      <div class="container">
        <div class="row">
          <div class="col-md-2">
            
            <!-- Title -->
            <h6 class="title">
              종사분야 <label class="text-danger">*</label>
            </h6>

          </div>
          <div class="col-md-10">
            
              <div class="form-row">

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="S207000" id="S207001" value="207001">
                      <label class="form-check-label" for="S207001">제조업</label>
                    </div>  
                  </div>
                </div>

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="S207000" id="S207002" value="207002">
                      <label class="form-check-label" for="S207002">무역업</label>
                    </div>  
                  </div>
                </div>   
                
                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="S207000" id="S207003" value="207003">
                      <label class="form-check-label" for="S207003">유통업</label>
                    </div>  
                  </div>
                </div>   

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="S207000" id="S207004" value="207004">
                      <label class="form-check-label" for="S207004">정부/공공기관</label>
                    </div>  
                  </div>
                </div>   

              </div> <!-- / .form-row -->

              <div class="form-row">

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="S207000" id="S207005" value="207005">
                      <label class="form-check-label" for="S207005">금융/투자업</label>
                    </div>  
                  </div>
                </div>

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="S207000" id="S207006" value="207006">
                      <label class="form-check-label" for="S207006">대학/연구/교육기관</label>
                    </div>  
                  </div>
                </div>   
                
                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="S207000" id="S207007" value="207007">
                      <label class="form-check-label" for="S207007">언론/출판업</label>
                    </div>  
                  </div>
                </div>   

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="S207000" id="S207008" value="207008">
                      <label class="form-check-label" for="S207008">서비스업</label>
                    </div>  
                  </div>
                </div>   

              </div> <!-- / .form-row -->



              <div class="form-row">

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="S207000" id="S207009" value="207009">
                      <label class="form-check-label" for="S207009">학생</label>
                    </div>  
                  </div>
                </div>

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="S207000" id="S207010" value="207010">
                      <label class="form-check-label" for="S207010">기타</label>
                    </div>  
                  </div>
                </div>   
                
              </div> <!-- / .form-row -->
              
              


          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->

    </section>      



    <section class="section pb-0">

      <!-- Content -->
      <div class="container">
        <div class="row">
          <div class="col-md-2">
            
            <!-- Title -->
            <h6 class="title">
              업무(구매)권한 <label class="text-danger">*</label>
            </h6>

          </div>
          <div class="col-md-10">
            
              <div class="form-row">

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="208000" id="S208001" value="208001">
                      <label class="form-check-label" for="S208001">기업가/대표자/프리랜서</label>
                    </div>  
                  </div>
                </div>

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="208000" id="S208002" value="208002">
                      <label class="form-check-label" for="S208002">부사장/공공기관장</label>
                    </div>  
                  </div>
                </div>   
                
                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="208000" id="S208003" value="208003">
                      <label class="form-check-label" for="S208003">임원/지점장/공공기관임원</label>
                    </div>  
                  </div>
                </div>   

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="208000" id="S208004" value="208004">
                      <label class="form-check-label" for="S208004">부서장/그룹장/팀장</label>
                    </div>  
                  </div>
                </div>   

              </div> <!-- / .form-row -->

              <div class="form-row">

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="208000" id="S208005" value="208005">
                      <label class="form-check-label" for="S208005">직원/공무원/기능공</label>
                    </div>  
                  </div>
                </div>

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="208000" id="S208006" value="208006">
                      <label class="form-check-label" for="S208006">교수/교사/강사/연구원</label>
                    </div>  
                  </div>
                </div>   
                
                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="208000" id="S208007" value="208007">
                      <label class="form-check-label" for="S208007">학생/수강생</label>
                    </div>  
                  </div>
                </div>   

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="208000" id="S208008" value="208008">
                      <label class="form-check-label" for="S208008">업무권한없음</label>
                    </div>  
                  </div>
                </div>   

              </div> <!-- / .form-row -->

          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->

    </section>      
    


    <section class="section pb-0">

      <!-- Content -->
      <div class="container">
        <div class="row">
          <div class="col-md-2">
            
            <!-- Title -->
            <h6 class="title">
              방문목적 <label class="text-danger">*</label>
            </h6>

          </div>
          <div class="col-md-10">
            
              <div class="form-row">

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="209000" id="S209001" value="209001">
                      <label class="form-check-label" for="S209001">구매/비지니스상담</label>
                    </div>  
                  </div>
                </div>

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="209000" id="S209002" value="209002">
                      <label class="form-check-label" for="S209002">일반관람</label>
                    </div>  
                  </div>
                </div>   
                
                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="209000" id="S209003" value="209003">
                      <label class="form-check-label" for="S209003">시장조사</label>
                    </div>  
                  </div>
                </div>   

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="209000" id="S209004" value="209004">
                      <label class="form-check-label" for="S209004">수출입알선</label>
                    </div>  
                  </div>
                </div>   

              </div> <!-- / .form-row -->

              <div class="form-row">

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="209000" id="S209005" value="209005">
                      <label class="form-check-label" for="S209005">기술/정보수집</label>
                    </div>  
                  </div>
                </div>

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="209000" id="S209006" value="209006">
                      <label class="form-check-label" for="S209006">기타</label>
                    </div>  
                  </div>
                </div>   

              </div> <!-- / .form-row -->

          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->

    </section>          
    

    <section class="section">

      <!-- Content -->
      <div class="container">
        <div class="row">
          <div class="col-md-2">
            
            <!-- Title -->
            <h6 class="title">
              인지경로 <label class="text-danger">*</label>
            </h6>

          </div>
          <div class="col-md-10">
            
              <div class="form-row">

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="209000" id="S210001" value="210001">
                      <label class="form-check-label" for="S210001">온라인 초청장, 브로슈어</label>
                    </div>  
                  </div>
                </div>

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="209000" id="S210002" value="210002">
                      <label class="form-check-label" for="S210002">홈페이지/검색</label>
                    </div>  
                  </div>
                </div>   
                
                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="209000" id="S210003" value="210003">
                      <label class="form-check-label" for="S210003">광고</label>
                    </div>  
                  </div>
                </div>   

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="209000" id="S210004" value="210004">
                      <label class="form-check-label" for="S210004">뉴스레터</label>
                    </div>  
                  </div>
                </div>   

              </div> <!-- / .form-row -->

              <div class="form-row">

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="209000" id="S210005" value="210005">
                      <label class="form-check-label" for="S210005">소셜미디어</label>
                    </div>  
                  </div>
                </div>

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="209000" id="S210006" value="210006">
                      <label class="form-check-label" for="S210006">참가업체추천</label>
                    </div>  
                  </div>
                </div>   

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="209000" id="S210007" value="210007">
                      <label class="form-check-label" for="S210007">주관기관 추천</label>
                    </div>  
                  </div>
                </div>

                <div class="form-group col-3">
                  <div class="text-left text-md-left form_height1">
                    <div class="form-check form-chec">
                      <input class="form-check-input" type="checkbox" name="209000" id="S210008" value="210008">
                      <label class="form-check-label" for="S210008">기타</label>
                    </div>  
                  </div>
                </div>                   
                
              </div> <!-- / .form-row -->

          </div>
        </div> <!-- / .row -->

        <div class="row">
          <div class="col-12">
            <div class="text-center text-md-center" style="padding-top: 2.5rem;">

              <button type="button" class="btn btn-outline-primary" style="width: 8rem;" id="btnSignUp">
                확인
              </button>
    
              <button type="button" class="btn btn-outline-primary" style="width: 8rem;" id="btnCncl">
                취소
              </button>                    

            </div>             
          </div>
        </div>

      </div> <!-- / .container -->

    </section>   

  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="join_form3_js.jsp"></jsp:include>   

  </form>
  </body>
</html>