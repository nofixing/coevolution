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

    <c:forEach var="list1" items="${sessionScope.MGNT_MENU_LEVL1}">
        <li class="text-xs text-uppercase border p-2">
          <c:if test="${list1.cnt eq '0'}">
          <a href="${list1.menu_url}" <c:if test="${list1.menu_on_clsf eq page_clsf}">class="on"</c:if>><strong>${list1.menu_nm}</strong></a>
          </c:if>

          <c:if test="${list1.cnt ne '0'}">
            <a href="#MENU_${list1.menu_id}" data-toggle="collapse"><strong>${list1.menu_nm}</strong></a>
            <div id="MENU_${list1.menu_id}" class="collapse show pl-3">
              <ul class="list-group">
                <c:forEach var="list2" items="${sessionScope.MGNT_MENU_LEVL2}">
                  <c:if test="${list1.menu_id eq list2.upper_menu_id}">
                    <li class="list-group"><a href="${list2.menu_url}" <c:if test="${list2.target ne ''}">target="${list2.target}"</c:if> <c:if test="${list2.menu_on_clsf eq page_clsf}">class="on"</c:if>><strong>${list2.menu_nm}</strong></a></li>
                  </c:if>
                </c:forEach>
              </ul>
            </div>  
          </c:if>

        </li>
    </c:forEach>


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

<!--li class="list-group"><a href="#" <c:if test="${page_clsf eq ''}">class="on"</c:if>><strong>휴면회원-4순위</strong></a></li-->
<!--li class="list-group"><a href="#" <c:if test="${page_clsf eq ''}">class="on"</c:if>><strong>탈퇴회원-3순위</strong></a></li-->