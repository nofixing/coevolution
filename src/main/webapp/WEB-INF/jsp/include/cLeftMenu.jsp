<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

            <!-- Title -->
            <div class="bg-light p-4 member-info">
              <h6 class="text-center member-name"><strong>${sessionScope.login_session.cust_nm}</strong>님</h6>
              <dl>
                <dt class="d-flex justify-content-start">아이디</dt>
                <dd class="d-flex justify-content-start pl-3">${sessionScope.login_session.cust_id}</dd>
              </dl>
              <dl>
                <dt class="d-flex justify-content-start">가입일</dt>
                <dd class="d-flex justify-content-start pl-3">${sessionScope.login_session.ins_dt}</dd>
              </dl>
              <!--정보수정-->
              <div class="text-center text-md-center pt-3">
                <a href="/mypage/myc05" class="btn btn-outline-primary" style="padding:0 15px; box-sizing:border-box;">
                  <strong>정보수정</strong>
                </a>
              </div>
                                    
            </div>

            <!-- List -->
            <ul class="list-unstyled sidenav-list">
              <li class="text-xs text-uppercase border p-2">
                <a href="/mypage/myc01" <c:if test="${page_clsf eq 'myc01'}">class="on"</c:if> ><strong>내 부스 정보 등록</strong></a>
              </li>
              <li class="text-xs text-uppercase border p-2">
                <a href="/mypage/favortscorp" <c:if test="${page_clsf eq 'myc02'}">class="on"</c:if> ><strong>즐겨찾기 내역</strong></a>
              </li>
              <li class="text-xs text-uppercase border p-2">
                <a href="/mypage/badgecorp" <c:if test="${page_clsf eq 'myc03'}">class="on"</c:if> ><strong>뱃지 적립 내역</strong></a>
              </li>

              <li class="text-xs text-uppercase border p-2">
                <a href="/mypage/conslt_list" <c:if test="${page_clsf eq 'myc04'}">class="on"</c:if>><strong>Q & A</strong></a>
              </li>

              <li class="text-xs text-uppercase border p-2">
                <a href="#conslt" data-toggle="collapse"><strong>상담문의</strong></a>
                <div id="conslt" class="collapse show pl-3">
                  <ul class="list-group">
                    <li class="list-group"><a href="/mypage/consltset" <c:if test="${page_clsf eq 'myc06'}">class="on"</c:if> ><strong>상담시간설정</strong></a></li>
                    <li class="list-group"><a href="/mypage/myc07" <c:if test="${page_clsf eq 'myc07'}">class="on"</c:if> ><strong>상담예약현황</strong></a></li>
                    <li class="list-group"><a href="/mypage/myc08" <c:if test="${page_clsf eq 'myc08'}">class="on"</c:if> ><strong>상담이력</strong></a></li>
                  </ul>
                </div>
              </li>  

              <li class="text-xs text-uppercase border p-2">
                <a href="#update" data-toggle="collapse"><strong>내정보수정</strong></a>
                <div id="update" class="collapse show pl-3">
                  <ul class="list-group">
                    <li class="list-group"><a href="/mypage/myc05" <c:if test="${page_clsf eq 'myc05'}">class="on"</c:if> ><strong>정보수정</strong></a></li>
                    <li class="list-group"><a href="/mypage/myp05" <c:if test="${page_clsf eq 'myp05'}">class="on"</c:if> ><strong>비밀번호변경</strong></a></li>
                  </ul>
                </div>
              </li>              
              
              
              <li class="text-xs text-uppercase border p-2">
                <a href="/mypage/myp06" <c:if test="${page_clsf eq 'myp06'}">class="on"</c:if> ><strong>개인정보 재동의</strong></a>
              </li>
              <li class="text-xs text-uppercase border p-2">
                <a href="/mypage/myp07" <c:if test="${page_clsf eq 'myp07'}">class="on"</c:if> ><strong>회원탈퇴</strong></a>
              </li>
            </ul>