<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>
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
              <a href="/index">Home</a>
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
    <section class="section">
      <div class="container">
        <div class="form join_form">
          <div class="form_head">
            <p>참관등록</p>
          </div>
          <div class="join_inner">
            <div class="register_head clearfix">
              <ul class="register_seq">
                <li><span>Step 01</span> 약관동의</li>
                <li class="on"><span>Step 02</span> 정보입력</li>
                <li><span>Step 03</span> 가입완료</li>
              </ul>
            </div>
            <div class="form_inner member page-area">
                <div class="join-form-area">
                  <form action="">
                      <div class="form-box">
                          <div class="top-txt"><span>*</span> 필수 작성 항목 입니다</div>
                          <div class="join-form-tb">
                              <div class="tb-tr tr-half">
                                  <div class="half-box">
                                      <div class="tb-th"><span>*</span> 이름</div>
                                      <div class="tb-td">
                                          <input type="text" maxlength="20" class="input-box" placeholder="이름을 입력하세요" id="cust_nm" name="cust_nm">
                                      </div>
                                  </div>
                                  <div class="half-box">
                                      <div class="tb-th"><span>*</span> 성별</div>
                                      <div class="tb-td">
                                          <input type="radio" name="gender_cd" id="gender_cd_203001" value="203001" checked><label for="gender_cd_203001"><span></span> <p>남자</p></label>
                                          <input type="radio" name="gender_cd" id="gender_cd_203002" value="203002"><label for="gender_cd_203002"><span></span> <p>여자</p></label>
                                      </div>
                                  </div>
                              </div>
                              
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 연령대</div>
                                  <div class="tb-td">
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204001" value="204001" checked>
                                      <label for="age_cd_204001"><span></span> <p>20대 미만</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204002" value="204002">
                                      <label for="age_cd_204002"><span></span> <p>20대</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204003" value="204003">
                                      <label for="age_cd_204003"><span></span> <p>30대</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204004" value="204004">
                                      <label for="age_cd_204004"><span></span> <p>40대</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204005" value="204005">
                                      <label for="age_cd_204005"><span></span> <p>50대</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204006" value="204006">
                                      <label for="age_cd_204006"><span></span> <p>60대</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204007" value="204007">
                                      <label for="age_cd_204007"><span></span> <p>60대 초과</p></label>
                                      
                                  </div>
                              </div>
      
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span>소속</div>
                                  <div class="tb-td">
                                          <input type="text" name="company_nm" id="company_nm" maxlength="50" class="input-box" placeholder="소속을 입력하세요">
                                  </div>
                              </div>						
                              <div class="tb-tr tr-half">
                                  <div class="half-box">
                                      <div class="tb-th"><span>*</span>부서</div>
                                      <div class="tb-td">
                                          <input type="text" name="dept_nm" id="dept_nm" maxlength="50" class="input-box" placeholder="부서을 입력하세요">
                                      </div>
                                  </div>
                                  <div class="half-box">
                                      <div class="tb-th">직급</div>
                                      <div class="tb-td">
                                          <input type="text" name="posn_nm" id="posn_nm" maxlength="50" class="input-box" placeholder="직급을 입력하세요">
                                      </div>
                                  </div>
                              </div>
                              <div class="tb-tr tr-half">
                                <div class="half-box">
                                  <div class="tb-th"><span>*</span> 휴대폰번호</div>
                                  <div class="tb-td">
                                      <input type="text" name="hp_no" id="hp_no" maxlength="13" class="input-box" placeholder="-없이 숫자만 입력하세요">
                                  </div>
                                </div>
                                <div class="half-box">
                                  <div class="tb-th"> 연락처</div>
                                  <div class="tb-td">
                                      <input type="text" name="tel_no" id="tel_no" maxlength="13" class="input-box" placeholder="연락처를 입력하세요">
                                  </div>
                                </div>
                              </div>
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 이메일 주소</div>
                                  <div class="tb-td">
                                      <div class="input-email">
                                          <div class="in-box"><input type="text" name="email_id1" id="email_id1" value="${email_id1}" maxlength="50" class="input-box"></div>
                                          <div class="in-box"><input type="text" name="email_id2" id="email_id2" value="${email_id2}" maxlength="50" class="input-box"></div>
                                          <div class="select-box">
                                              <select class="custom-select-sm" id="email_clsf">
                                                  <option value="" selected>직접입력</option>
                                                  <option value="naver.com"> naver.com</option>
                                                  <option value="hanmail.net"> hanmail.net</option>
                                                  <option value="daum.net"> daum.net</option>
                                                  <option value="nate.com"> nate.com</option>
                                                  <option value="gmail.com"> gmail.com</option>
                                              </select>
                                          </div>									
                                      </div>
                                  </div>
                              </div>
                              <div class="tb-tr tr-half">
                                  <div class="half-box">
                                      <div class="tb-th"><span>*</span> 국가</div>
                                      <div class="tb-td">
                                          <div class="select-box">
                                              <select name="country_cd" class="custom-select-sm" id="country_cd"></select>
                                          </div>	
                                      </div>
                                  </div>
                                  <div class="half-box">
                                      <div class="tb-th"><span>*</span> 지역(시/도)</div>
                                      <div class="tb-td">
                                          <input type="text" name="city_nm" id="city_nm" maxlength="50" class="input-box" placeholder="지역(시/도)을 입력하세요">
                                      </div>
                                  </div>
                              </div>
                              <div class="tb-tr">
                                  <div class="tb-th">주소</div>
                                  <div class="tb-td">
                                      <input type="text" name="addr_1" id="addr_1" maxlength="100" class="input-box input-w" placeholder="주소">
                                      <input type="hidden" name="addr_2" id="addr_2" class="input-box input-w" placeholder="주소">
                                  </div>
                              </div>
                              
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 방문타입</div>
                                  <div class="tb-td">
                                      <input type="radio" name="visit_pups_cd" id="visit_pups_cd_205001" value="205001" checked><label for="visit_pups_cd_205001"><span></span> <p>일반관람</p></label>
                                      <input type="radio" name="visit_pups_cd" id="visit_pups_cd_205002" value="205002"><label for="visit_pups_cd_205002"><span></span> <p>비즈니스</p></label>
                                      <input type="radio" name="visit_pups_cd" id="visit_pups_cd_205003" value="205003"><label for="visit_pups_cd_205003"><span></span> <p>기자(취재)</p></label>
                                      <input type="radio" name="visit_pups_cd" id="visit_pups_cd_205004" value="205004"><label for="visit_pups_cd_205004"><span></span> <p>혁신제품상담</p></label>
                                  </div>
                              </div>
                              <div class="tb-tr">
                                <div class="tb-th">추천인(ID) 등록</div>
                                <div class="tb-td">
                                    <input type="text"  name="rcmder_cust_id" id="rcmder_cust_id" maxlength="20" class="input-box" placeholder="">
                                    <div class="chk-btn idchk-btn" name="search_rcmder_cust_id" id="search_rcmder_cust_id"><a href="#!">추천인 검색</a></div>
                                    <p class="notice">※ 추천인(ID) 등록 시 이벤트 참여 가능한 뱃지를 제공해드립니다.</p>
                                </div>
                            </div>
                          </div>
                      </div>
                      <div class="form-box">
                          <div class="top-txt"><span>*</span> 아래 질문을 모두 체크해 주십시오</div>
                          <div class="join-form-tb">
                              <!-- 201117추가-->
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 관심분야</div>
                                  <div class="tb-td">
                                      <div class="general_chk_box">
                                          <ul class="input-chk" id="list1"></ul>
                                      </div>
                                  </div>
                              </div>
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 종사분야</div>
                                  <div class="tb-td">
                                      <div class="general_chk_box">
                                          <ul class="input-chk" id="list2"></ul>
                                      </div>
                                  </div>
                              </div>
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 업무(구매)권한</div>
                                  <div class="tb-td">
                                      <div class="general_chk_box">
                                          <ul class="input-chk" id="list3"></ul>
                                      </div>
                                  </div>
                              </div>
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 방문목적</div>
                                  <div class="tb-td">
                                      <div class="general_chk_box">
                                          <ul class="input-chk" id="list4"></ul>
                                      </div>
                                  </div>
                              </div>
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 인지경로</div>
                                  <div class="tb-td">
                                      <div class="general_chk_box">
                                          <ul class="input-chk" id="list5"></ul>
                                      </div>
                                  </div>
                              </div>
                              <!-- 201117추가-->
                          </div>
                      </div>
                      <div class="register_page">
                        <button type="button" class="register_page_submit" id="btnSignUp">확인</button>
                        <button type="button" class="register_page_btn" id="btnCncl">취소</button>
                      </div>
                  </form>
                </div>
            </div>
          </div>
        </div>
      </div> <!-- / .container -->
    </section>

  </form>

  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="join_form31_js.jsp"></jsp:include>

  </body>
</html>