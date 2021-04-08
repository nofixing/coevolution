<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


    <!-- Title -->
    <div class="bg-light p-4 member-info">
      <h6 class="text-center member-name"><strong>${sessionScope.login_session.cust_nm}</strong>님</h6>
      <dl>
        <dt>아이디</dt>
        <dd>${sessionScope.login_session.cust_id}</dd>
      </dl>                            
    </div>

  <!-- List -->
  <ul class="list-unstyled sidenav-list">

    <li class="text-xs text-uppercase border p-2">
      <a href="/mgnt/badge" <c:if test="${page_clsf eq 'mgnt01'}">class="on"</c:if> ><strong>뱃지관리</strong></a>
    </li>
    <li class="text-xs text-uppercase border p-2">
      <a href="/mgnt/conslt" <c:if test="${page_clsf eq 'mgnt02'}">class="on"</c:if> ><strong>상담문의내역</strong></a>
    </li>

    <li class="text-xs text-uppercase border p-2">
      <a href="#member" data-toggle="collapse" <c:if test="${page_clsf eq ''}">class="on"</c:if> ><strong>회원관리</strong></a>
      <div id="member" class="collapse show pl-3">
        <ul class="list-group">
          <li class="list-group"><a href="/mgnt/m_member_search" <c:if test="${page_clsf eq 'mgnt0401'}">class="on"</c:if> ><strong>참관회원</strong></a></li>
          <li class="list-group"><a href="/mgnt/m_corp_search" <c:if test="${page_clsf eq 'mgnt0301'}">class="on"</c:if>><strong>참가회원</strong></a></li>
          <!--li class="list-group"><a href="#" <c:if test="${page_clsf eq ''}">class="on"</c:if>><strong>휴면회원-4순위</strong></a></li-->
          <!--li class="list-group"><a href="#" <c:if test="${page_clsf eq ''}">class="on"</c:if>><strong>탈퇴회원-3순위</strong></a></li-->
        </ul>
      </div>      
    </li>

    <!--li class="text-xs text-uppercase border p-2">
      <!a href="#agree" data-toggle="collapse" <c:if test="${page_clsf eq ''}">class="on"</c:if> ><strong>회원동의관리-3순위</strong></a>
      <div id="agree" class="collapse show pl-3">
        <ul class="list-group">
          <li class="list-group"><a href="#" <c:if test="${page_clsf eq ''}">class="on"</c:if>><strong>개인정보처리방침</strong></a></li>
          <li class="list-group"><a href="#" <c:if test="${page_clsf eq ''}">class="on"</c:if>><strong>이용약관-보류</strong></a></li>
          <li class="list-group"><a href="#" <c:if test="${page_clsf eq ''}">class="on"</c:if>><strong>마케팅활용동의</strong></a></li>
        </ul>
      </div>      
    </li--> 

    <li class="text-xs text-uppercase border p-2">
      <a href="#stats" data-toggle="collapse" <c:if test="${page_clsf eq ''}">class="on"</c:if> ><strong>통계</strong></a>
      <div id="stats" class="collapse show pl-3">
        <ul class="list-group">
          <li class="list-group"><a href="#" <c:if test="${page_clsf eq ''}">class="on"</c:if> ><strong>부스현황</strong></a></li>
          <li class="list-group"><a href="#" <c:if test="${page_clsf eq ''}">class="on"</c:if>><strong>구글애널리틱스</strong></a></li>
          <li class="list-group"><a href="#" <c:if test="${page_clsf eq ''}">class="on"</c:if>><strong>접속현황</strong></a></li>
        </ul>
      </div>      
    </li> 

  </ul>


