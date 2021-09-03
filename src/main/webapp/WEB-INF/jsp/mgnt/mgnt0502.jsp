<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/mHeader.jsp"></jsp:include>

    <style>
      .form_height1 {
        height:calc(1.9rem + 2px);
      }
    </style>

  </head>
  <body>

  <form>

    <!-- top Menu -->
    <jsp:include page="/WEB-INF/jsp/include/mTopMenu.jsp"></jsp:include>

    <!-- BREADCRUMB
    ================================================== -->
    <nav class="breadcrumb" style="width:100%">
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
              관리자 등록
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>



  <!-- 진행순서
    ================================================== -->
    <section class="section pt-0 pl-5 pr-5">
      <div class="container_fluid">

        <div class="row">
          <div class="col-md-2">
            
            <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/mLeftMenu.jsp"></jsp:include>
           
          </div>
          <div class="col-md-10">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
                <!-- Heading -->
                <h3 class="mt-4 mb-4">
                    <strong>
                    관리자 등록
                    </strong>
                </h3>
                <div class="form_inner member page-area">
                    <div class="join-form-area">

                        <table class="basic-table">
                          <tr>
                              <th>아이디</th>
                              <td>
                                  <div class="form-inline">
                                      <input type="text" style="ime-mode:disabled" minlength="6" maxlength="10" id="mgnt_id" name="mgnt_id" class="input-box col-lg-6 col-9" placeholder="아이디를 입력하세요">
                                      <div class="chk-btn idchk-btn"><a href="#!" id="btnDupCheck" class="p-2">중복확인</a></div>
                                  </div>
                              </td>
                          </tr>
                          <tr>
                              <th>관리자명</th>
                              <td>
                                  <div class="form-inline">
                                      <input type="text" id="mgnt_nm" name="mgnt_nm" class="input-box col-lg-6 col-9" placeholder="관리자명 입력하세요">
                                  </div>
                              </td>
                          </tr>                          
                          <tr>
                              <th>비밀번호</th>
                              <td>
                                <input type="password" id="mgnt_pw" name="mgnt_pw" minlength="6" maxlength="10" class="input-box col-lg-6" placeholder="비밀번호를 입력하세요">
                              </td>
                          </tr>
                          <tr>
                              <th>비밀번호 확인</th>
                              <td>
                                <input type="password" id="mgnt_pw2" name="mgnt_pw2" minlength="6" maxlength="10" class="input-box col-lg-6" placeholder="비밀번호를 입력하세요.">
                              </td>
                          </tr>     
                          <tr>
                              <th>부서명</th>
                              <td><input type="text" name="dept_nm" id="dept_nm" maxlength="13" class="input-box col-lg-6" placeholder="부서명을 입력하세요"></td>
                          </tr>                                                  
                          <tr>
                              <th>전화번호</th>
                              <td><input type="text" name="hp_no" id="hp_no" maxlength="13" class="input-box col-lg-6" placeholder="전화번호을 입력하세요"></td>
                          </tr>
                          <tr>
                              <th>이메일</th>
                              <td>
                                  <input type="text" name="email_id" id="email_id" maxlength="50" class="input-box col-lg-6" placeholder="이메일을 입력하세요">
                              </td>
                          </tr>
                          <tr>
                              <th>사용여부</th>
                              <td>
                                <div class="tb-td">
                                    <input type="radio" value="Y" name="use_yn" id="use_yn-1" checked><label for="use_yn-1"><span></span> 사용</label>
                                    <input type="radio" value="N" name="use_yn" id="use_yn-2" ><label for="use_yn-2"><span></span> 미사용</label>
                                </div>                            
                              </td>
                          </tr>
                          <tr>
                              <th>권한</th>
                              <td>
                                <div class="tb-td">
                                  <div class="general_chk_box">
                                    <div class="input-chk">
                                      <input type="checkbox" value="Y" name="S10001" id="S10001" ><label for="S10001" style="width:200px"><span></span> 뱃지관리</label>
                                      <input type="checkbox" value="Y" name="S10002" id="S10002" ><label for="S10002" style="width:200px"><span></span> 1:1상담</label>
                                      <input type="checkbox" value="Y" name="S10017" id="S10017" ><label for="S10017" style="width:200px"><span></span> 상담신청현황</label>
                                      <input type="checkbox" value="Y" name="S10004" id="S10004" ><label for="S10004" style="width:200px"><span></span> 참관회원</label>
                                      <input type="checkbox" value="Y" name="S10005" id="S10005" ><label for="S10005" style="width:200px"><span></span> 참가회원</label>
                                      <input type="checkbox" value="Y" name="S10018" id="S10018" ><label for="S10018" style="width:200px"><span></span> 관리자등록</label>
                                      <input type="checkbox" value="Y" name="S10019" id="S10019" ><label for="S10019" style="width:200px"><span></span> 엑스포관리</label>
                                      <input type="checkbox" value="Y" name="S10020" id="S10020" ><label for="S10020" style="width:200px"><span></span> 엑스포참가업체관리</label>
                                      <input type="checkbox" value="Y" name="S10008" id="S10008" ><label for="S10008" style="width:200px"><span></span> 부스현황</label>
                                      <input type="checkbox" value="Y" name="S10009" id="S10009" ><label for="S10009" style="width:200px"><span></span> 구글애널리틱스</label>
                                      <input type="checkbox" value="Y" name="S10011" id="S10011" ><label for="S10011" style="width:200px"><span></span> 코드관리</label>
                                      <input type="checkbox" value="Y" name="S10010" id="S10010" ><label for="S10010" style="width:200px"><span></span> 접속현황</label>
                                      <input type="checkbox" value="Y" name="S10013" id="S10013" ><label for="S10013" style="width:200px"><span></span> 개인정보처리방침</label>
                                      <input type="checkbox" value="Y" name="S10014" id="S10014" ><label for="S10014" style="width:200px"><span></span> 이용약관</label>
                                      <input type="checkbox" value="Y" name="S10015" id="S10015" ><label for="S10015" style="width:200px"><span></span> 구글애널리틱스</label>
                                    </div>                                    
                                  </div>
                                  </div>                                  
                                </div>  
                              </td>
                          </tr>                                       
                        </table>

                        <div class="text-right pt-3">
                          <button type="button" class="basic-btn" id="btnList">목록</button>
                          <button type="button" class="basic-btn" id="btnUpdate">저장</button>
                        </div>
                          
                    </div>
                </div>

            </div>
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

  </form>
  <jsp:include page="/WEB-INF/jsp/include/footer_mgnt.jsp"></jsp:include>
  <jsp:include page="mgnt0502_js.jsp"></jsp:include>   

  </body>
</html>