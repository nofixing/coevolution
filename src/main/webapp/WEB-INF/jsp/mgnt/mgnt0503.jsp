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

  <!-- 진행순서
    ================================================== -->
    <section class="section pt-7 pl-5 pr-5">
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
                                    <input type="hidden" id="mgnt_id" name="mgnt_id" value="${mgnt_id}"/>
                                    ${mgnt_id}
                                  </div>
                              </td>
                          </tr>
                          <tr>
                              <th>관리자명</th>
                              <td>
                                  <div class="form-inline">
                                      <input type="text" id="mgnt_nm" name="mgnt_nm" class="input-box col-lg-6 col-9" placeholder="관리자명 입력하세요" value="${mgnt_nm}">
                                  </div>
                              </td>
                          </tr>                          
                          <tr>
                              <th>비밀번호</th>
                              <td>
                                <div class="chk-btn idchk-btn">
                                  <button type="button" class="basic-btn" id="btnPasswd" data-toggle="modal" data-target="#passwdChange">비밀번호수정</button>
                                </div>
                              </td>
                          </tr>  
                          <tr>
                              <th>부서명</th>
                              <td><input type="text" name="dept_nm" id="dept_nm" maxlength="13" class="input-box col-lg-6" placeholder="부서명을 입력하세요" value="${dept_nm}"></td>
                          </tr>                                                  
                          <tr>
                              <th>전화번호</th>
                              <td><input type="text" name="hp_no" id="hp_no" maxlength="13" class="input-box col-lg-6" placeholder="전화번호을 입력하세요" value="${hp_no}"></td>
                          </tr>
                          <tr>
                              <th>이메일</th>
                              <td>
                                  <input type="text" name="email_id" id="email_id" maxlength="50" class="input-box col-lg-6" placeholder="이메일을 입력하세요" value="${email_id}">
                              </td>
                          </tr>
                          <tr>
                              <th>사용여부</th>
                              <td>
                                <div class="tb-td">
                                    <input type="radio" value="Y" name="use_yn" id="use_yn-1" <c:if test="${use_yn eq 'Y'}">checked</c:if> ><label for="use_yn-1"><span></span> 사용</label>
                                    <input type="radio" value="N" name="use_yn" id="use_yn-2" <c:if test="${use_yn eq 'N'}">checked</c:if> ><label for="use_yn-2"><span></span> 미사용</label>
                                </div>                            
                              </td>
                          </tr>
                          <tr>
                              <th>권한</th>
                              <td>
                                <div class="tb-td">
                                  <div class="general_chk_box">
                                  <div class="general_chk_box">
                                    <c:forEach var="codeList1" items="${codeList1}">
                                      <div><strong>※ ${codeList1.menu_nm}</strong></div>
                                      <div class="input-chk pb-2">
                                        <c:forEach var="codeList2" items="${codeList2}">
                                          <c:if test="${codeList2.upper_menu_id eq codeList1.menu_id}">

                                            <c:set var="checked" value=""/>
                                            <c:forEach var="listPrms" items="${listPrms}">
                                              <c:if test="${codeList2.menu_id eq listPrms.menu_id && listPrms.use_yn eq 'Y'}">
                                                <c:set var="checked" value="checked"/>
                                              </c:if>
                                            </c:forEach>

                                            <input type="checkbox" value="Y" name="S${codeList2.menu_id}" id="S${codeList2.menu_id}" ${checked}><label for="S${codeList2.menu_id}" style="width:200px"><span></span> ${codeList2.menu_nm}</label>
                                          </c:if>
                                        </c:forEach>
                                      </div>  
                                    </c:forEach>                                  
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

<div class="modal fade" id="passwdChange" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document" style="width:500px">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
              <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"></path>
            </svg>
        </button>
      </div>
      <div class="modal-body">

        <div class="form-styled">
          <div class="form-style-small">

            <div class="form-group">
              <div class="input-group">
                <input type="password" id="mgnt_passwd1" name="mgnt_passwd1" class="form-control order-1" placeholder="새 비밀번호">
                <div class="input-group-append order-0">
            <div class="input-group-text">
              <svg class="input-group-icon icon-offset icon icon-lock" viewBox="0 0 106 106" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <path transform="translate(3 3)" d="M25 50 V 20 A 25 25 0 0 1 50 0 A 25 25 0 0 1 75 20 V 50 H 90 V 100 H 10 V 50 H 75 M50 85 A 5 5 0 0 1 45 80 V 70 A 5 5 0 0 1 50 65 A 5 5 0 0 1 55 70 V 80 A 5 5 0 0 1 50 85"></path>
              </svg>
            </div>
                </div>
              </div>     
            </div>

            <div class="form-group">
              <div class="input-group">
                <input type="password" id="mgnt_passwd2" name="mgnt_passwd2" class="form-control order-1" placeholder="새 비밀번호 확인">
                <div class="input-group-append order-0">
                <div class="input-group-text">
                  <svg class="input-group-icon icon-offset icon icon-lock" viewBox="0 0 106 106" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path transform="translate(3 3)" d="M25 50 V 20 A 25 25 0 0 1 50 0 A 25 25 0 0 1 75 20 V 50 H 90 V 100 H 10 V 50 H 75 M50 85 A 5 5 0 0 1 45 80 V 70 A 5 5 0 0 1 50 65 A 5 5 0 0 1 55 70 V 80 A 5 5 0 0 1 50 85"></path>
                  </svg>
                </div>
                </div>
              </div>    
            </div>
          </div>

          <div class="form-row justify-content-center">
              <!-- Button -->
              <div class="text-center text-md-right p-1">
                <button type="button" class="basic-btn" style="width:7rem" id="btnPasswdChange">변경하기</button>
              </div>
          </div> <!-- / .form-row -->     
        </div>

      </div>
    </div>
  </div>
</div>


  <jsp:include page="/WEB-INF/jsp/include/footer_mgnt.jsp"></jsp:include>
  <jsp:include page="mgnt0503_js.jsp"></jsp:include>   

  </body>
</html>