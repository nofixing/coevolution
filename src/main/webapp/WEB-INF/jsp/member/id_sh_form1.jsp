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
    
    <section class="section section-full section-top">

      <div class="container">
        <div class="form find_inner">
            <div class="find_wrap">
                <div class="find_tab clearfix">
                    <a href="" class="on"><spring:message code="login.id.find2" text="아이디 찾기"/></a>
                    <a href="#!"><spring:message code="login.pw.find2" text="비밀번호 찾기"/></a>
                </div>
                <div class="find_area">
                    <div class="find_box">
                        <h5 class="text-center"><spring:message code="login.id.find3" text="아이디가 생각나지 않으세요?"/></h5>
                        <h5 class="text-center"><spring:message code="login.id.find4" text="가입하신 이메일을 입력해주세요."/></h5>
                        <div class="find_form">
                            <form action="">
                                <div class="find_form_row">
                                    <div class="find_form_cell">
                                        <label for="cust_nm"><spring:message code="join_form3.name" text="이름"/></label>
                                    </div>
                                    <div class="find_form_cell find_form_cell2">
                                        <input type="text" name="cust_nm" id="cust_nm" placeholder="<spring:message code='login.id.find5' text='이름을 입력해주세요.'/>">
                                    </div>
                                </div>
                                <div class="find_form_row">
                                    <div class="find_form_cell">
                                        <label for="email_id"><spring:message code="login.id.find7" text="이메일"/></label>
                                    </div>
                                    <div class="find_form_cell find_form_cell2">
                                        <input type="email" name="email_id" id="email_id" placeholder="<spring:message code='login.id.find6' text='이메일을 입력해주세요.'/>">
                                    </div>
                                </div>
                                <div class="form_btn mt-3">
                                    <button class="form_btn_only" onclick="javascript:idFind(); return false;"><spring:message code="login.id.find2" text="아이디 찾기"/></button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="find_box">
                        <h5 class="text-center"><spring:message code="login.pw.find3" text="가입하신 이메일을 입력하시면"/><br> <spring:message code="login.pw.find4" text="해당 메일로 임시비밀번호를 발급해드립니다."/></h5>
                        <div class="find_form">
                            <form action="">
                                <div class="find_form_row">
                                    <div class="find_form_cell">
                                        <label for="cust_id_pw"><spring:message code="login.id" text="아이디"/></label>
                                    </div>
                                    <div class="find_form_cell find_form_cell2">
                                        <input type="text" name="cust_id_pw" id="cust_id_pw" placeholder="<spring:message code='login.pw.find5' text='아이디를 입력해주세요.'/>">
                                    </div>
                                </div>
                                <div class="find_form_row">
                                    <div class="find_form_cell">
                                        <label for="cust_nm_pw"><spring:message code="join_form3.name" text="이름"/></label>
                                    </div>
                                    <div class="find_form_cell find_form_cell2">
                                        <input type="text" name="cust_nm_pw" id="cust_nm_pw" placeholder="<spring:message code='login.id.find5' text='이름을 입력해주세요.'/>">
                                    </div>
                                </div>
                                <div class="find_form_row">
                                    <div class="find_form_cell">
                                        <label for="email_id_pw"><spring:message code="login.id.find7" text="이메일"/></label>
                                    </div>
                                    <div class="find_form_cell find_form_cell2">
                                        <input type="email" name="email_id_pw" id="email_id_pw" placeholder="<spring:message code='login.id.find6' text='이메일을 입력해주세요.'/>">
                                    </div>
                                </div>
                                <div class="form_btn mt-3">
                                    <button class="form_btn_only" onclick="javascript:pwFind(); return false;"><spring:message code="login.pw.find2" text="비밀번호 찾기"/></button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
      </div>
      
    </section>
    
  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="id_sh_form1_js.jsp"></jsp:include>
  </body>
</html>