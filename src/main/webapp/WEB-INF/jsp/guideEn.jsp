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

    <!-- FULLPAGE
    ================================================== -->
    <section class="section section-full section-top">

        <!-- Content -->
        <div class="container">
            <div class="">
                <div class="layout-form">
                    <div class="form_head">
                        <p>Visitor Guide</p>
                    </div>
                    <div class="guide-content">
                        <div class="guide-tab">
                            <a href="#!" class="on">Visitor Registration Guide</a>
                            <a href="#!">Virtual IEVE Viewing Guide</a>
                            <a href="#!">Meeting Request Guide</a>
                        </div>
                        <div class="guide-tab-contnet">
                            <div class="guide-item">
                                <div class="guide-item-tit">
                                    <p>Visitor Registration Guide</p>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>Step1</span>
                                        <p>Click ‘Visitor Registration’ icon on the Join Membership page.</p>
                                        <p>If you are already registered, you can log in with your SNS account.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img1-1.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>Step2</span>
                                        <p>Please agree to our terms and conditions, and click ‘Register’ button.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img1-2.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>Step3</span>
                                        <p>Enter the required information and check all the required question below. 
                                            Then click <strong>‘confirm’</strong> button.<br>
                                            *Registration will not proceed if you don’t fill out the required information.
                                            </p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img1-3.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>Step4</span>
                                        <p>Registration will be completed with joining membership.<br>
                                           * We provide 10 badges that can be used at the booths for those who registered.
                                            </p>
                                        <div class="guide-import">
                                            <p>★ [How to use Interest Badges]</p>
                                            <ul>
                                                <li><span>1.</span> You can check how many badges you have on ‘My Page > Badges History’.</li>
                                                <li><span>2.</span> You can give 1 Interest Badges to 1 booth at the 8th Virtual IEVE.</li>
                                                <li><span>3.</span> Each company will be exposed to the ‘Booth Search' window first according to the number of badges received from visitors, and ranking changes are reflected in real time.</li>
                                                <li><span>4.</span> The visitors can join the event by voting through badges.</li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img1-4.png" alt="">
                                        <img src="/images/guide-img1-4-1.png" alt="">
                                        <img src="/images/guide-img1-4-2.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>Step5</span>
                                        <p>If you are registered successfully, you can access to My Page, and enjoy our services like Favortie Booths, Badges History, QnA, Meeting Reservation Status etc.
                                            </p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img1-5.png" alt="">
                                    </div>
                                </div>
                            </div>
                            <div class="guide-item">
                                <div class="guide-item-tit">
                                    <p>Virtual IEVE Viewing Guide</p>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>Step1</span>
                                        <p>Click ‘Virtual IEVE’ button.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img2-1.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>Step2</span>
                                        <p>Enter the Virtual IEVE Exhibition Hall.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img2-2.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>Step3</span>
                                        <p>After the entrance, you can see company information, introduction video, product photos, 3D and materials etc.. Also, you can leave a question or request real time meeting.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img2-3.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>Step4</span>
                                        <p>If you want to go directly to a specific place and exhibition hall, click Minimap. You can check your location and direction of view on the mini-map, and you can move immediately when you click on another exhibition hall.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img2-4.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>Step5</span>
                                        <p>You can search the exhibitor and booth.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img2-5-1.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>Step6</span>
                                        <p>You can change the service language(KOR/ENG) anytime even if while viewing.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img2-6.png" alt="">
                                    </div>
                                </div>
                            </div>
                            <div class="guide-item">
                                <div class="guide-item-tit">
                                    <p>Meeting Request Guide</p>
                                    <span>You can request meeting through My Page > Meeting Request page, and you can directly consult with the person who in charge of company at the scheduled time.
                                    </span>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>Step1</span>
                                        <p>Click ‘Exhibitor/Booth’ button on ‘Meeting>Meeting Request’ page and search the company you want.
                                        </p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img3-1.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>Step2</span>
                                        <p>Before selecting the meeting time, select your Timezone.
                                        </p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img3-2.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>Step3</span>
                                        <p>If you select the Timezone, select the meeting time you want and request a meeting. Yellow color means available, and gray color means fully booked.</p>
                                        <span>Step4</span>
                                        <p>You can confirm your meeting schedule on ‘Meeting>Meeting Reservation Status’ page.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img3-3.png" alt="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div> <!-- / .row -->
        </div> <!-- / .container -->
        <script>
            $(function(){
                console.log("asdf");
                $(".guide-tab-contnet > div").hide(); 
                $(".guide-tab-contnet > div:first").show(); 

                // 클릭 이벤트 발생
                $(".guide-tab a").click(function () { 
                    // 클릭 이벤트 한 영역 css 변경
                    $(".guide-tab a").removeClass("on"); 
                    $(this).addClass("on"); 
                    
                    // 클릭 한 요소의 인덱스 담기 (li의 인덱스)
                    var test = $(this).index();
                    
                    // 나타내기
                    $(".guide-tab-contnet > div").hide(); 
                    $(".guide-tab-contnet > div").eq(test).fadeIn(200); 
                });
            });
        </script>

    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>

  </body>
</html>
