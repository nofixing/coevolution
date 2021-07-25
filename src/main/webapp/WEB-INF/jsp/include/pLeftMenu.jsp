<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

  <!-- Title -->
  <div class="bg-light p-4 member-info">
    <h6 class="text-center member-name"><strong>${sessionScope.login_session.cust_nm}</strong></h6>
    <dl>
      <dt class="d-flex justify-content-start"><spring:message code="left.menu.login.id" text="아이디"/></dt>
      <dd class="d-flex justify-content-start pl-3">${sessionScope.login_session.cust_id}</dd>
    </dl>
    <dl>
      <dt class="d-flex justify-content-start"><spring:message code="left.menu.login.reg.date" text="가입일"/></dt>
      <dd class="d-flex justify-content-start pl-3">${sessionScope.login_session.ins_dt}</dd>
    </dl>
    <!--정보수정-->
    <div class="text-center text-md-center pt-3">
      <a href="/mypage/myp04" class="btn btn-outline-primary" style="padding:0 15px; box-sizing:border-box;">
        <strong><spring:message code="left.menu.login.edit" text="정보수정"/></strong>
      </a>
    </div>
                          
  </div>

  <!-- List -->
  <ul class="list-unstyled sidenav-list">

  <c:if test="${sessionScope.login_session.cust_clsf_cd eq '202001'}">

    <li class="text-xs text-uppercase border p-2" style="font-family:none">
      <a href="/mypage/favorts" <c:if test="${page_clsf eq 'myp01'}">class="on"</c:if> ><strong><spring:message code="left.menu.favorite.booths" text="부스 즐겨찾기 내역"/></strong></a>
    </li>
    <li class="text-xs text-uppercase border p-2" style="font-family:none">
      <a href="/mypage/badge" <c:if test="${page_clsf eq 'myp02'}">class="on"</c:if> ><strong><spring:message code="left.menu.badges.history" text="관심 뱃지 내역"/></strong></a>
    </li>

    <li class="text-xs text-uppercase border p-2" style="font-family:none">
      <a href="/mypage/conslt_list" <c:if test="${page_clsf eq 'myp03'}">class="on"</c:if> ><strong><spring:message code="left.menu.consultation" text="Q & A"/></strong></a>
    </li>


    <li class="text-xs text-uppercase border p-2" style="font-family:none">
      <a href="#conslt" data-toggle="collapse"><strong><spring:message code="left.menu.meeting" text="상담문의"/></strong></a>
      <div id="conslt" class="collapse show pl-3">
        <ul class="list-group">
          <li class="list-group"><a href="/mypage/myp08" <c:if test="${page_clsf eq 'myp08'}">class="on"</c:if> ><strong><spring:message code="left.menu.meeting.reservation" text="상담신청현황"/></strong></a></li>
          <li class="list-group"><a href="/mypage/myp09" <c:if test="${page_clsf eq 'myp09'}">class="on"</c:if> ><strong><spring:message code="left.menu.meeting.request" text="상담신청"/></strong></a></li>
          <li class="list-group"><a href="/mypage/myp10" <c:if test="${page_clsf eq 'myp10'}">class="on"</c:if> ><strong><spring:message code="left.menu.meeting.history" text="상담이력"/></strong></a></li>
        </ul>
      </div>
    </li>  

    <li class="text-xs text-uppercase border p-2" style="font-family:none">
      <a href="#update" data-toggle="collapse"><strong><spring:message code="left.menu.edit.my.info" text="내정보수정"/></strong></a>
      <div id="update" class="collapse show pl-3">
        <ul class="list-group">
          <li class="list-group"><a href="/mypage/myp04" <c:if test="${page_clsf eq 'myp04'}">class="on"</c:if>><strong><spring:message code="left.menu.edit.personal.info" text="정보수정"/></strong></a></li>
          <li class="list-group"><a href="/mypage/myp05" <c:if test="${page_clsf eq 'myp05'}">class="on"</c:if>><strong><spring:message code="left.menu.change.password" text="비밀번호변경"/></strong></a></li>
        </ul>
      </div>
    </li>              
    
  </c:if>

  <c:if test="${sessionScope.login_session.cust_clsf_cd eq '202002'}">

    <li class="text-xs text-uppercase border p-2" style="font-family:none">
      <a href="/mypage/myc01" <c:if test="${page_clsf eq 'myc01'}">class="on"</c:if> ><strong>내 부스 정보 등록</strong></a>
    </li>
    <li class="text-xs text-uppercase border p-2" style="font-family:none">
      <a href="/mypage/favortscorp" <c:if test="${page_clsf eq 'myc02'}">class="on"</c:if> ><strong>즐겨찾기 내역</strong></a>
    </li>
    <li class="text-xs text-uppercase border p-2" style="font-family:none">
      <a href="/mypage/badgecorp" <c:if test="${page_clsf eq 'myc03'}">class="on"</c:if> ><strong>뱃지 적립 내역</strong></a>
    </li>
    <li class="text-xs text-uppercase border p-2" style="font-family:none">
      <a href="/mypage/conslt_list" <c:if test="${page_clsf eq 'myc04'}">class="on"</c:if> ><strong>삼담문의 내역</strong></a>
    </li>

    <li class="text-xs text-uppercase border p-2" style="font-family:none">
      <a href="#update" data-toggle="collapse"><strong>내정보수정</strong></a>
      <div id="update" class="collapse show pl-3">
        <ul class="list-group">
          <li class="list-group"><a href="/mypage/myc05" <c:if test="${page_clsf eq 'myc05'}">class="on"</c:if> ><strong>정보수정</strong></a></li>
          <li class="list-group"><a href="/mypage/myp05" <c:if test="${page_clsf eq 'myp05'}">class="on"</c:if> ><strong>비밀번호변경</strong></a></li>
        </ul>
      </div>
    </li>            
    
  </c:if>            

    <li class="text-xs text-uppercase border p-2" style="font-family:none">
      <a href="/mypage/myp06" <c:if test="${page_clsf eq 'myp06'}">class="on"</c:if> ><strong><spring:message code="left.menu.extend.privacy" text="개인정보 재동의"/></strong></a>
    </li>
    <li class="text-xs text-uppercase border p-2" style="font-family:none">
      <a href="/mypage/myp07" <c:if test="${page_clsf eq 'myp07'}">class="on"</c:if> ><strong><spring:message code="left.menu.withdrawal" text="회원탈퇴"/></strong></a>
    </li>
  </ul>


