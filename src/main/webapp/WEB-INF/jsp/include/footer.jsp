<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

    <!-- FOOTER
    ================================================== -->
    <c:if test="${sessionScope.LANG ne 'en'}">
        <footer class="footer">
            <div class="container">
                <div class="footer_menu clearfix">
                    <div class="footer_link">
                        <ul>
                            <li>
                                <a href="/index/pirvatePolicy" style="hover {background-color:#FFF}">개인정보처리방침</a>
                            </li>
                            <li>
                                <a href="/index/terms">이용약관</a>
                            </li>
                            <li>
                                <a href="/index/map">오시는 길</a>
                            </li>
                        </ul>
                    </div>
                    <div class="footer_sns">
                        <ul>
                            <li>
                                <a href="#!">
                                    <img src="/assets/img/icons/footer_facebook.png" alt="">
                                </a>
                            </li>
                            <li>
                                <a href="#!">
                                    <img src="/assets/img/icons/footer_youtube.png" alt="">
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="footer_info">
                    <div class="footer_inner">
                        <div class="footer_address">
                            <div class="footer_logo">
                                <a href="/">
                                    <img src="/assets/img/icons/foot_logo.png" alt="">
                                </a>
                            </div>
                            <ul>
                                <li>
                                    <span>(우) 63309 제주특별자치도 제주시 첨단로 213-3,215호 국제전기자동차엑스포(영평동, 스마트빌딩)</span>
                                </li>
                                <li>
                                    <span>국제전기자동차엑스포 사업자등록번호 : 136-82-03165</span>
                                    <span>대표자 : 김대환</span>
                                </li>
                                <li>
                                    <span>TEL：064-702-1580</span>
                                    <span>Fax : 064-702-1576</span>
                                    <span>E-mail：ieve@ievexpo.org</span>
                                </li>
                            </ul>
                        </div>
                        <div class="footer_partner_logo">
                            <span>VR 전시 주관사 <img src="/assets/img/icons/logo.png" alt=""></span>
                        </div>
                    </div>
                    <div class="copyright">
                        <p>Copyright 2021 ⓒ IEVE. ALL RIGHTS RESERVED.</p>
                    </div>
                </div>
            </div>
        </footer>
    </c:if>

    <c:if test="${sessionScope.LANG eq 'en'}">
        <footer class="footer">
            <div class="container">
                <div class="footer_menu clearfix">
                    <div class="footer_link">
                        <ul>
                            <li>
                                <a href="/index/pirvatePolicy">Privacy Policy</a>
                            </li>
                            <li>
                                <a href="/index/terms">Terms and Conditions</a>
                            </li>
                            <li>
                                <a href="/index/map">Exhibition Location</a>
                            </li>
                        </ul>
                    </div>
                    <div class="footer_sns">
                        <ul>
                            <li>
                                <a href="#!">
                                    <img src="/assets/img/icons/footer_facebook.png" alt="">
                                </a>
                            </li>
                            <li>
                                <a href="#!">
                                    <img src="/assets/img/icons/footer_youtube.png" alt="">
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="footer_info">
                    <div class="footer_inner">
                        <div class="footer_address">
                            <div class="footer_logo">
                                <a href="/">
                                    <img src="/assets/img/icons/foot_logo.png" alt="">
                                </a>
                            </div>
                            <ul>
                                <li>
                                    <span>Rm 215, IEVE Expo Office (Smart Bldg.), Cheonmdam-ro, Jeju-si, Jeju Special Self-Governing Province</span>
                                </li>
                                <li>
                                    <span>International Electric Vehicle Expo Business license number：136-82-03165</span>
                                    <span>Chairman Kim Dae Hwan</span>
                                </li>
                                <li>
                                    <span>TEL： +82-64-702-1580</span>
                                    <span>Fax : +82-64-702-1576</span>
                                    <span>E-mail：ieve@ievexpo.org</span>
                                </li>
                            </ul>
                        </div>
                        <div class="footer_partner_logo" style="width:250px">
                            <span>EV Exhibition by <img src="/assets/img/icons/logo.png" alt=""></span>
                        </div>
                    </div>
                    <div class="copyright">
                        <p>Copyright 2021 ⓒ IEVE. ALL RIGHTS RESERVED.</p>
                    </div>
                </div>
            </div>
        </footer>
    </c:if>    

    <!-- JAVASCRIPT
    ================================================== -->
    <!-- Global JS -->
    <script src="/assets/libs/jquery/dist/jquery.min.js"></script>

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
