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
                        <p>관람가이드</p>
                    </div>
                    <div class="guide-content">
                        <ul class="guide-tab">
                            <li><a href="#!" class="on">사전 등록 가이드</a></li>
                            <li><a href="#!">버추얼전시회 관람가이드</a></li>
                            <li><a href="#!">상담예약신청 안내</a></li>
                        </ul>
                        <div class="guide-tab-contnet">
                            <div class="guide-item">
                                <div class="guide-item-tit">
                                    <p>사전등록(참관등록) 절차 안내</p>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>STEP1</span>
                                        <p>사전등록 시 회원가입 페이지에서 
                                            <strong>'참관등록'</strong> 아이콘을 클릭, 회원가입 절차를 시작합니다.
                                            </p>
                                        <p>이미 회원가입이 되어 있을 경우 SNS 계정을 통해 로그인 가능합니다.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img1-1.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>STEP2</span>
                                        <p>가입 절차에 필요한 약관에 동의 후 <strong>'회원가입'</strong> 버튼을 클릭합니다.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img1-2.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>step3</span>
                                        <p>등록하시는 분의 필수항목 정보 입력 및 질문 문항에 체크 후 
                                            <strong>'확인'</strong> 버튼을 클릭합니다.<br>
                                            *필수 작성 항목의 경우 기입하지 않으면 등록이 진행되지 않습니다.
                                
                                            </p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img1-3.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>step4</span>
                                        <p>회원가입과 함께 <strong>'참관등록'</strong>이 완료됩니다.<br>
                                           * 참관등록 완료 시 각 부스에 사용 가능한 '관심뱃지 10개'를 부여해드립니다.
                                
                                            </p>
                                        <div class="guide-import">
                                            <p>★ [뱃지 부여 및 사용 방법]</p>
                                            <ul>
                                                <li><span>1.</span> 마이페이지 > '관심 뱃지 내역'에서 확인가능합니다.</li>
                                                <li><span>2.</span> 제공 받으신 뱃지는 <strong>VR전시회 각 기업부스에 1개씩 부여할</strong> 수 있습니다.</li>
                                                <li><span>3.</span> 각 기업은 관람객으로부터 받은 뱃지 수에 따라 '기업검색' 창에 우선 노출되며 순위 변동은 실시간으로 반영됩니다.</li>
                                                <li><span>4.</span> 관람객들은 뱃지 투표를 활용해 이벤트에 참여할 수 있습니다.</li>
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
                                        <span>step5</span>
                                        <p>등록 완료 시 <strong>'마이페이지'</strong>가 생성되며 부스 즐겨찾기 내역, 관심 뱃지 내역, 1:1 상담신청내역, 상담예약신청현황 등을 확인할 수 있습니다.
                                            </p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img1-5.png" alt="">
                                    </div>
                                </div>
                            </div>
                            <div class="guide-item">
                                <div class="guide-item-tit">
                                    <p>버추얼전시관(VR) 관람가이드 안내</p>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>STEP1</span>
                                        <p>버추얼전시회 메뉴 버튼을 클릭하여 버추얼전시관(VR) 메인 화면으로 이동합니다.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img2-1.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>STEP2</span>
                                        <p>버추얼전시관(VR)으로 입장합니다.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img2-2.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>step3</span>
                                        <p>버추얼전시관(VR) 입장 후 부스별 기업 정보, 소개영상, 자료, 상담문의, 제품사진, 3D, 쇼핑몰 바로가기 등 관람가능합니다.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img2-3.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>step4</span>
                                        <p>특정 장소 및 전시관으로 바로 이동을 원할 경우 미니맵을 클릭합니다.
                                            </p>
                                        <p>미니맵에서는 자신의 위치 및 시선 방향을 확인할 수 있으며 다른 전시관을 클릭 시<br /> 바로 이동이 가능합니다.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img2-4.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>step5</span>
                                        <p>참가기업의 부스를 검색할 수 있습니다.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img2-5.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>step6</span>
                                        <p>관람 중에도 사이트 및 버추얼전시회 서비스 언어(KOR/ENG)를 변경할 수 있습니다.</p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img2-6.png" alt="">
                                    </div>
                                </div>
                            </div>
                            <div class="guide-item">
                                <div class="guide-item-tit">
                                    <p>상담예약신청 안내</p>
                                    <span>마이페이지 > 상담예약신청페이지를 통해 신청가능하며 상담신청 시 예약된 시간에 해당 부스의 참여업체 실무자로 부터 직접 상담을 받으실 수 있습니다.
                                    </span>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>STEP1</span>
                                        <p>상담문의 <small>></small> 상담신청 메뉴에서 '참가업체' 버튼 클릭, 참가업체 검색하여 업체를 선택합니다.
                                        </p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img3-1.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>STEP2</span>
                                        <p>상담시간 지정 전 자신이 위치한 타임존을 클릭, 선택합니다.
                                        </p>
                                    </div>
                                    <div class="guide-item-img">
                                        <img src="/images/guide-img3-2.png" alt="">
                                    </div>
                                </div>
                                <div class="guide-item-box clearfix">
                                    <div class="guide-item-step">
                                        <span>step3</span>
                                        <p>타임존 선택 후 상담 시간대를 선택하여 상담예약을 신청합니다.
                                            </p>
                                        <p>선택 가능한 시간대는 노란색으로 표시, 예약완료된 시간대는 회색조로 표시됩니다.</p>
                                        <span>step4</span>
                                        <p>상담문의 <small>></small> 상담신청현황 메뉴를 통해 시간대별 상담예약 현황 확인 가능합니다.</p>
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
                    var test = $(this).parent().index(); 
                    
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
