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
    <jsp:include page="/WEB-INF/jsp/include/topMenu.jsp"></jsp:include>

    <!-- FULLPAGE
    ================================================== -->
    <section class="section section-full section-top">
        <!-- Content -->
        <div class="container">
            <div class="">
                <div class="secret-info">
                    <h4 class="secret-info-tit text-center"><strong><spring:message code="map.location" text="오시는 길"/></strong></h4>
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
                    	
						<div class="form-box p-3 mt-3 border">
							<div class="join-form-tb">
								<div class="tb-tr">
									<div class="tb-th"><h3><strong><spring:message code="map.form.jeju" text="제주공항에서 오시는 방법"/></strong></h3></div>
								</div>
								<div class="tb-tr tr-half">
									<div class="half-box form-inline pt-3">
										<div class="tb-th p-1"><img src="/images/car_icon01.png"></div>
										<div class="tb-td pl-3">
											<h4>
												<c:if test="${sessionScope.LANG eq 'en'}">
												Airport Entrance > Airport Right Road (32.7KM) > Changcheon Three Way Intersection > <br>Yerae Entrance > Jungmun Tourist Complex > ICC JEJU
												</c:if>
												<c:if test="${sessionScope.LANG ne 'en'}">
												공항입구 > 공항로 우측도로(32.7KM 이동) > 창천 삼거리 > 예래 입구 > 중문관광단지 > ICC 제주국제컨벤션센터
												</c:if>
											</h4>
										</div>
									</div>
									<div class="half-box form-inline pt-3">
										<div class="tb-th p-1"><img src="/images/bus_icon01.png"></div>
										<div class="tb-td pl-3">
											<h4>
												<c:if test="${sessionScope.LANG eq 'en'}">
												[Airport bus 600], [No. 2400, No. 1002 (late night), No. 500, No. 200 → intercity bus No. 782 transfer]
												</c:if>
												<c:if test="${sessionScope.LANG ne 'en'}">
												[공항버스 600번], [2400번, 1002(심야), 500번, 200번 → 시외버스 782번 환승]
												</c:if>
											</h4>
										</div>
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
