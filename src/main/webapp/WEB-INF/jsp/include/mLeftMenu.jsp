<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


  <!-- List -->
  <ul class="list-unstyled sidenav-list pt-4">

    <c:forEach var="list1" items="${sessionScope.MGNT_MENU_LEVL1}">
        <li class="text-xs text-uppercase border p-2">
          <c:if test="${list1.cnt eq '0'}">
          <a href="${list1.menu_url}" <c:if test="${list1.menu_on_clsf eq page_clsf}">class="on"</c:if>><strong>${list1.menu_nm}</strong></a>
          </c:if>

          <c:if test="${list1.cnt ne '0'}">
            <a href="#MENU_${list1.menu_id}" data-toggle="collapse"><strong>${list1.menu_nm}</strong></a>
            <div id="MENU_${list1.menu_id}" class="collapse pl-3">
              <ul class="list-group">
                <c:forEach var="list2" items="${sessionScope.MGNT_MENU_LEVL2}">
                  <c:if test="${list1.menu_id eq list2.upper_menu_id}">
                    <li class="list-group"><a href="${list2.menu_url}" <c:if test="${list2.target ne ''}">target="${list2.target}"</c:if> <c:if test="${list2.menu_on_clsf eq page_clsf}">class="on"</c:if>><strong>${list2.menu_nm}</strong></a></li>
                    <c:if test="${list2.menu_on_clsf eq page_clsf}">
                      <script>
                        $("#MENU_${list1.menu_id}").addClass("show");
                      </script>
                    </c:if>
                  </c:if>
                </c:forEach>
              </ul>
            </div>  
          </c:if>

        </li>
    </c:forEach>
