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
						<!-- 지도를 표시할 div 입니다 -->
						<div id="map" style="width:100%;height:450px;"></div>

						<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=32212c1a9bac70b301c0825970db2292"></script>
						<script>
							var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
								mapOption = { 
									center: new kakao.maps.LatLng(33.453979, 126.572602), // 지도의 중심좌표
									level: 3 // 지도의 확대 레벨
								};

							// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
							var map = new kakao.maps.Map(mapContainer, mapOption);

							// 지도를 클릭한 위치에 표출할 마커입니다
							var marker = new kakao.maps.Marker({ 
								// 지도 중심좌표에 마커를 생성합니다 
								position: map.getCenter() 
							}); 
							// 지도에 마커를 표시합니다
							marker.setMap(map);

                            // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
                            var zoomControl = new kakao.maps.ZoomControl();
                            map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

                            // 지도 타입 변경 컨트롤을 생성한다
                            var mapTypeControl = new kakao.maps.MapTypeControl();

                            // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
                            map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
							
						</script>
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
