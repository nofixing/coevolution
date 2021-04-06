<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>


<!doctype html>
<html lang="en">

<head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>
</head>

<body>
    <jsp:include page="/WEB-INF/jsp/include/topMenu.jsp"></jsp:include>

    <!-- FULLPAGE
    ================================================== -->
    <section class="section section-full section-top">
        <!-- Content -->
        <div class="container">
            <div class="">
                <div class="secret-info">
                    <h4 class="secret-info-tit text-center"><strong>오시는 길</strong></h4>
                    <div class="register_section_area">
						<!-- * 카카오맵 - 지도퍼가기 -->
						<!-- 1. 지도 노드 -->
						<div id="daumRoughmapContainer1617686911048" style="width: 100%;" class="root_daum_roughmap root_daum_roughmap_landing"></div>

						<!--
							2. 설치 스크립트
							* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
						-->
						<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>

						<!-- 3. 실행 스크립트 -->
						<script charset="UTF-8">
							new daum.roughmap.Lander({
								"timestamp" : "1617686911048",
								"key" : "258gz",
								"mapHeight" : "500"
							}).render();
						</script>
                    	
						<div class="join-form-tb">
						  	<div class="tb-tr">
							  	<div class="tb-th"><h5>제주공항에서 오시는 방법</h5></div>
						  	</div>
						  	<div class="tb-tr tr-half">
							  	<div class="half-box">
								  	<div class="tb-th">자가용</div>
								  	<div class="tb-td">
									  	공항입구 > 공항로 우측도로(32.7KM 이동) > 창천 삼거리 > 예래 입구 > 중문관광단지 > ICC 제주국제컨벤션센터
								  	</div>
							  	</div>
							  	<div class="half-box">
								  	<div class="tb-th">대중교통</div>
								  	<div class="tb-td">
									  	[공항버스 600번], [2400번, 1002(심야), 500번, 200번 → 시외버스 782번 환승]
								  	</div>
							  	</div>
						  	</div>
					  	</div>
					
					</div>
                </div>
            </div>
            </div> <!-- / .row -->
        </div> <!-- / .container -->

    </section>

    <!-- FOOTER
    ================================================== -->
    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>


</body>

</html>
