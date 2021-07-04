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
    
    <!-- FULLPAGE
    ================================================== -->
    <section class="section section-full section-top">

        <!-- Content -->
        <div class="container">
            <div class="">
                <div class="form login_form">
                    <div class="form_head">
                        <p>로그인</p>
                    </div>
                    <div class="login_inner">
                        <div class="form_inner">
                            <form>
                                <div class="login_form clearfix">
                                    <div class="login_input_area">
                                        <div class="id_area input_area">
                                            <input type="text" id="user_id" name="user_id" placeholder='<spring:message code="login.id" text="아이디"/>'>
                                        </div>
                                        <div class="pw_area input_area">
                                            <input type="password" id="user_pw" name="user_pw" placeholder='<spring:message code="login.pw" text="비밀번호"/>'>
                                        </div>
                                    </div>
                                </div>
                                <div class="check_area clearfix">
                                    <div class="check_id">
                                        <input type="checkbox" id="check_id">
                                        <label for="check_id"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check2-circle" viewBox="0 0 16 16">
                                            <path d="M2.5 8a5.5 5.5 0 0 1 8.25-4.764.5.5 0 0 0 .5-.866A6.5 6.5 0 1 0 14.5 8a.5.5 0 0 0-1 0 5.5 5.5 0 1 1-11 0z"/>
                                            <path d="M15.354 3.354a.5.5 0 0 0-.708-.708L8 9.293 5.354 6.646a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l7-7z"/>
                                          </svg><span><spring:message code="login.id.save" text="아이디 저장"/></span></label>
                                    </div>
                                    <div class="find_info">
                                        <a href="/member/id_sh_form1"><spring:message code="login.id.find" text="아이디찾기"/></a>
                                        <a href="/member/id_sh_form1#!"><spring:message code="login.pw.find" text="비밀번호찾기"/></a>
                                    </div>
                                    <!-- <div class="login_check">
                                        <input type="checkbox" id="auto_login" class="form_chk_btn">
                                        <label for="auto_login">자동로그인</label>
                                    </div> -->
                                </div>

                            </form>
                        </div>
                        <div class="form_inner">
                            <div class="login_form_btn">
                                <button type="button" class="login_form_submit" id="btnLogin"><spring:message code="login.pw.login" text="로그인"/></button>
                            </div>                
                        </div>
                        <div class="form_inner">        
                            <div class="login_member clearfix">
                                <a href="/member/join_form1" class="member_page"><spring:message code="login.pw.join" text="회원가입"/></a>
                            </div>
                        </div>                        
                        <div class="sns_login bg-light">
                            <div class="sns_login_inner">
                                <ul class="clearfix">
                                    <li>
                                        <a href="#" id="naver_login">
                                            <img src="/assets/img/icons/naver_icon.png"/>
                                            <span><spring:message code="login.naver" text="네이버"/></span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#" id="kakao_login">
                                            <img src="/assets/img/icons/kakao_icon.png" />
                                            <span><spring:message code="login.kakao" text="카카오톡"/></span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#" id="facebook_login">
                                            <img src="/assets/img/icons/facebook_icon.png" />
                                            <span><spring:message code="login.facebook" text="페이스북"/></span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#" id="google_login">
                                            <img src="/assets/img/icons/google_icon.png" alt="">
                                            <span><spring:message code="login.google" text="구글"/></span>
                                        </a>
                                    </li>
                                </ul>
                                <!-- <div class="text-center p-3"><h5 class="text-primary"><span><spring:message code="login.social" text=""/></span></h5></div> -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div> <!-- / .row -->
        </div> <!-- / .container -->

    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="login_form_js.jsp"></jsp:include>

  </body>
</html>
