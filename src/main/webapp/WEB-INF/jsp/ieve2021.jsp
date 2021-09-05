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
    
    <c:choose>
        <c:when test = "${param.c eq '106014' || param.c eq '106015' || param.c eq '106016' || param.c eq '106017' || param.c eq '106018' || param.c eq '106019' || param.c eq '106020' || param.c eq '106021' || param.c eq '106022' || param.c eq '106023' || param.c eq '106024' || param.c eq '106025' || param.c eq '106026'}"> <!-- 버추얼 공항 106001, 106014 -->
            <iframe id="iframe" src="/vr21/eng/ieve2021_${param.c}/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
        </c:when>
        <c:when test = "${param.c eq '106001' || param.c eq '106002' || param.c eq '106003' || param.c eq '106004' || param.c eq '106015' || param.c eq '106006' || param.c eq '106007' || param.c eq '106008' || param.c eq '106009' || param.c eq '106010' || param.c eq '106011' || param.c eq '106012' || param.c eq '106013'}"> <!-- 버추얼 공항 106001, 106014 -->
            <iframe id="iframe" src="/vr21/kor/ieve2021_${param.c}/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
        </c:when>
        <c:otherwise>
            <iframe id="iframe" src="/vr21/kor/ieve2021/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
        </c:otherwise>
    </c:choose>
  
  </body>

    <!-- JAVASCRIPT
    ================================================== -->
    <!-- Global JS -->
    <script src="/assets/libs/jquery/dist/jquery.min.js"></script>

    <!-- jQuery Modal -->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <!-- Plugins JS -->
    <script src="/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/assets/libs/flickity/dist/flickity.pkgd.min.js"></script>
    <script src="/assets/libs/flickity-fade/flickity-fade.js"></script>
    <script src="/assets/libs/jquery-parallax.js/parallax.min.js"></script>
    <script src="/assets/libs/waypoints/lib/jquery.waypoints.min.js"></script>
    <script src="/assets/libs/waypoints/lib/shortcuts/inview.min.js"></script>
    <script src="/assets/libs/fullpage.js/vendors/scrolloverflow.min.js"></script>
    <script src="/assets/libs/fullpage.js/dist/fullpage.min.js"></script>
    <script src="/assets/libs/highlightjs/highlight.pack.min.js"></script>

    <!-- Theme JS -->
    <script src="/assets/js/theme.min.js"></script>

    <script>
        $(function () {
            // $(".hamburger").click(function () {
            //     $(this).toggleClass("is-active");
            // });
            $(".hamburger").click(function () {
                if ($(".m-menu").css("display") == "none") {
                    $(".m-menu").show().animate({
                        "left": "0"
                    });
                    $(".m-menu-bg").show();
                    $(".m-menu").show();
                    //            $("m-menu-bg").css("position","fixed");
                } else {
                    $("html, body").css("position", "static");
                    $(".m-menu").stop().animate({
                        "left": "-100%"
                    }, 400);
                    $(".m-menu-bg").hide();
                    setTimeout(function () {
                        $(".m-menu").css("display", "none");
                    }, 400);
                    //            $('m-menu-bg').css({"overflow": "", "position" : "static"});
                }
            });
            $(".m-menu-top a").click(function () {
                if ($(".m-menu").css("display") == "block") {
                    $("html, body").css("position", "static");
                    $(".m-menu").stop().animate({
                        "left": "-100%"
                    }, 400);
                    $(".m-menu-bg").hide();
                    setTimeout(function () {
                        $(".m-menu").css("display", "none");
                    }, 400);
                }
            });


            // modal dropdown 

            $(".collapse-btn").click(function(){
                $(this).toggleClass("on");
                if($(this).hasClass("on")){
                    $(this).find("span").css("transform", "rotate(180deg) translateY(50%)");
                } else {
                    $(this).find("span").css("transform", "rotate(0) translateY(-50%)");
                }
            });

        });
    </script>

<!-- Common JS -->
<script src="/js/common.js"></script>

</html>