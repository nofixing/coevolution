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

        <c:when test = "${param.c eq '106001' || param.c eq '106014' }"> <!-- 버추얼 공항 106001, 106014 -->
            <c:if test="${sessionScope.LANG ne 'en'}">
                <iframe id="iframe" src="/vr21/kor/ieve2021_106001/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
            <c:if test="${sessionScope.LANG eq 'en'}">
                <iframe id="iframe" src="/vr21/eng/ieve2021_106014/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
        </c:when>

        <c:when test = "${param.c eq '106002' || param.c eq '106015' }"> <!-- ICC 로비홀 106002, 106015 -->
            <c:if test="${sessionScope.LANG ne 'en'}">
                <iframe id="iframe" src="/vr21/kor/ieve2021_106002/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
            <c:if test="${sessionScope.LANG eq 'en'}">
                <iframe id="iframe" src="/vr21/eng/ieve2021_106015/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
        </c:when>

        <c:when test = "${param.c eq '106003' || param.c eq '106016' }"> <!-- Components 106003, 106016 -->
            <c:if test="${sessionScope.LANG ne 'en'}">
                <iframe id="iframe" src="/vr21/kor/ieve2021_106003/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
            <c:if test="${sessionScope.LANG eq 'en'}">
                <iframe id="iframe" src="/vr21/eng/ieve2021_106016/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
        </c:when>

        <c:when test = "${param.c eq '106004' || param.c eq '106017' }"> <!-- Charging Infra 106004, 106017 -->
            <c:if test="${sessionScope.LANG ne 'en'}">
                <iframe id="iframe" src="/vr21/kor/ieve2021_106004/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
            <c:if test="${sessionScope.LANG eq 'en'}">
                <iframe id="iframe" src="/vr21/eng/ieve2021_106017/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
        </c:when>

        <c:when test = "${param.c eq '106005' || param.c eq '106018' }"> <!-- E-Mobility 106005, 106018 -->
            <c:if test="${sessionScope.LANG ne 'en'}">
                <iframe id="iframe" src="/vr21/kor/ieve2021_106005/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
            <c:if test="${sessionScope.LANG eq 'en'}">
                <iframe id="iframe" src="/vr21/eng/ieve2021_106018/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
        </c:when>

        <c:when test = "${param.c eq '106006' || param.c eq '106019' }"> <!-- Energy&Technology 106006, 106019 -->
            <c:if test="${sessionScope.LANG ne 'en'}">
                <iframe id="iframe" src="/vr21/kor/ieve2021_106006/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
            <c:if test="${sessionScope.LANG eq 'en'}">
                <iframe id="iframe" src="/vr21/eng/ieve2021_106019/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
        </c:when>

        <c:when test = "${param.c eq '106007' || param.c eq '106020' }"> <!-- Association&Institute 106007, 106020 -->
            <c:if test="${sessionScope.LANG ne 'en'}">
                <iframe id="iframe" src="/vr21/kor/ieve2021_106007/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
            <c:if test="${sessionScope.LANG eq 'en'}">
                <iframe id="iframe" src="/vr21/eng/ieve2021_106020/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
        </c:when>

        <c:when test = "${param.c eq '106008' || param.c eq '106021' }"> <!-- 한국전력공사관 106008, 106021 -->
            <c:if test="${sessionScope.LANG ne 'en'}">
                <iframe id="iframe" src="/vr21/kor/ieve2021_106008/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
            <c:if test="${sessionScope.LANG eq 'en'}">
                <iframe id="iframe" src="/vr21/eng/ieve2021_106021/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
        </c:when>

        <c:when test = "${param.c eq '106009' || param.c eq '106022' }"> <!-- 빅데이터 기반 자동차전장부품 신뢰성기술 고도화사업 기업홍보관 106009, 106022 -->
            <c:if test="${sessionScope.LANG ne 'en'}">
                <iframe id="iframe" src="/vr21/kor/ieve2021_106009/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
            <c:if test="${sessionScope.LANG eq 'en'}">
                <iframe id="iframe" src="/vr21/eng/ieve2021_106022/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
        </c:when>

        <c:when test = "${param.c eq '106010' || param.c eq '106023' }"> <!-- 고용 안정 선제 대응 패키지 지원사업 기업 홍보관 106010, 106023 -->
            <c:if test="${sessionScope.LANG ne 'en'}">
                <iframe id="iframe" src="/vr21/kor/ieve2021_106010/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
            <c:if test="${sessionScope.LANG eq 'en'}">
                <iframe id="iframe" src="/vr21/eng/ieve2021_106023/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
        </c:when>

        <c:when test = "${param.c eq '106011' || param.c eq '106024' }"> <!-- 실리콘밸리관 106011, 106024 -->
            <c:if test="${sessionScope.LANG ne 'en'}">
                <iframe id="iframe" src="/vr21/kor/ieve2021_106011/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
            <c:if test="${sessionScope.LANG eq 'en'}">
                <iframe id="iframe" src="/vr21/eng/ieve2021_106024/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
        </c:when>

        <c:when test = "${param.c eq '106012' || param.c eq '106025' }"> <!-- 영국관 106012, 106025 -->
            <c:if test="${sessionScope.LANG ne 'en'}">
                <iframe id="iframe" src="/vr21/kor/ieve2021_106012/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
            <c:if test="${sessionScope.LANG eq 'en'}">
                <iframe id="iframe" src="/vr21/eng/ieve2021_106025/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
        </c:when>

        <c:when test = "${param.c eq '106013' || param.c eq '106026' }"> <!-- 중국관 106013, 106026 -->
            <c:if test="${sessionScope.LANG ne 'en'}">
                <iframe id="iframe" src="/vr21/kor/ieve2021_106013/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
            <c:if test="${sessionScope.LANG eq 'en'}">
                <iframe id="iframe" src="/vr21/eng/ieve2021_106026/index.htm" style="display:block; width:100vw; height: 100vh"></iframe>
            </c:if>
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