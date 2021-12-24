<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

    <nav id="navMgntTop" class="navbar navbar-expand-xl navbar-light fixed-top p-1" style="width:100%;height:90px;min-width:1500px">
        <div class="container-fluid">
            <h1 class="logo m-0" id="h1MgntTopLogo">
                <a href="/mgnt/expo">
                    <img src="/assets/img/icons/header_logo.png" alt="">
                </a>
            </h1>
            <!-- Brand -->

            <!-- Collapse -->
            <div style="width:83%;">
                <div class="pt-3 pr-3" style="width:100%; text-align:right">
                    ${sessionScope.login_mgnt_session.cust_nm}님 로그인 하였습니다. | 
                    <a href="/logout" class="pt-0 pb-0" style="color:#000000">
                        <strong>로그아웃</strong>
                    </a>
                </div> 
                <div id="mgntTopMenu" class="pt-2" style="width:100%;">

                    <!-- Links -->
                    <ul class="navbar-nav d-flex justify-content-between">
                        <c:forEach var="list" items="${sessionScope.MGNT_TOP_MENU}">
                        <li>
                            <a href="${list.menu_url}" class="nav-link pt-0" style="font-size:18px !important">
                                <strong>${list.upper_menu_nm}</strong>
                            </a>
                        </li>
                        </c:forEach>
                    </ul>
                </div> <!-- / .navbar-collapse -->
            </div>
        </div> <!-- / .container -->
    </nav>

    <script>
        $(function(){
            $(".m-menu-depth li a").on("click", function(){
                $(this).toggleClass("on");
                if($(this).hasClass("on")){
                    $(this).next().slideDown(300);
                } else {
                    $(this).next().slideUp(300);
                }
            });
        });
    </script>

    <jsp:include page="topMenu_js.jsp"></jsp:include>
    <div id="mainBody"></div>