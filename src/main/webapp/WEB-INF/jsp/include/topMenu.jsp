<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

    <!-- M 메뉴 -->
    <div class="m-menu">
        <div class="m-menu-top">
            <a href="#!">
                <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x"
                    viewBox="0 0 16 16">
                    <path
                        d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z" />
                </svg>
            </a>
            <!-- <div class="m-menu-close">
                <a href="#!"> <i class="close-btn icon"></i>
                </a>
            </div> -->
            <span>
            <c:choose>
                <c:when test="${empty sessionScope.login_session.cust_nm}">
                    <spring:message code="login.please.log.in" text="로그인 해주세요"/>
                </c:when>
                <c:otherwise>
                  <c:if test="${sessionScope.LANG ne 'en'}">
                    ${sessionScope.login_session.cust_nm}님 반갑습니다.
                  </c:if>
                  <c:if test="${sessionScope.LANG eq 'en'}">
                    Welcome to ${sessionScope.login_session.cust_nm}
                  </c:if>
                </c:otherwise>
            </c:choose>
            
            </span>
        </div>
        <div class="m-menu-body">
            <div class="m-menu-box">
                <div class="m-menu-shop">
                    <ul class="clearfix">

                        <c:choose>
                            <c:when test="${empty sessionScope.login_session.cust_nm}">
                                <li><a href="/member/login_form"><span><spring:message code="top.login" text="로그인"/></span></a></li>
                            </c:when>

                            <c:otherwise>
                                <li><a href="/logout"><span><spring:message code="top.logout" text="로그아웃"/></span></a></li>
                            </c:otherwise>
                        </c:choose>

                        
                        <c:choose>
                            <c:when test="${empty sessionScope.login_session.cust_nm}">
                                <li><a href="/member/join_form1"><span><spring:message code="top.visit.reg" text="참관등록"/></span></a></li>
                            </c:when>

                            <c:otherwise>
                                <li>
                                    <c:if test="${sessionScope.login_session.cust_clsf_cd eq '202001'}">
                                    <a href="/mypage/favorts" class="nav-link nav-item-font">
                                    </c:if>
                                    <c:if test="${sessionScope.login_session.cust_clsf_cd eq '202002'}">
                                    <a href="/mypage/myc01" class="nav-link nav-item-font">
                                    </c:if>    
                                    <c:if test="${sessionScope.login_session.cust_clsf_cd eq '202003'}">
                                    <a href="/mgnt/badge" class="nav-link nav-item-font">
                                    </c:if>   

                                    <span><spring:message code="top.mypage" text="마이페이지"/></span>

                                    </a>
                                </li>

                            </c:otherwise>
                        </c:choose>

                        
                    </ul>
                </div>
            </div>
            <div class="m-menu-box" >
                <div class="m-menu-list">
                    <ul class="m-menu-depth">
                        <li>
                            <a href="#!"><spring:message code="top.view.guid" text="관람가이드"/></a>
                            <div class="m-menu-list-sub">
                                <a href="/index/guide?c=guide"><spring:message code="top.all.register.guide" text="사전등록 가이드"/></a>
                                <a href="/index/guide?c=virtual"><spring:message code="top.all.register.viewing.guide" text="버추얼전시회 관람 가이드"/></a>
                                <a href="/index/guide?c=question"><spring:message code="top.all.register.viewing.question" text="상담예약신청 안내"/></a>
                            </div>
                        </li>
                        <li>
                            <a href="#!"><strong><spring:message code="top.vr.exhibition.hall" text="버추얼전시회"/></strong></a>
                            <div class="m-menu-list-sub">
                                <a href="/index/ieve2021"><spring:message code="top.all.menu.Entrance" text="입장하기"/></a>
                            </div>
                        </li>
                        <!--li id="topEvent1">
                            <a href="#!"><strong><spring:message code="top.view.event" text="이벤트"/></strong></a>
                            <div class="m-menu-list-sub">
                                <a href="javascript:event_click()">이벤트 참여하기</a>
                            </div>
                        </li-->
                        <li>
                            <a href="#!"><strong><spring:message code="top.cust.search" text="참여기업검색"/></strong></a>
                            <div class="m-menu-list-sub" id="top_corp_search3">
                                <a href="#!" data-toggle="modal" data-target="#myModal"><spring:message code="top.cust.search" text="참여기업검색"/></a>
                            </div>
                        </li>
                        <c:choose>
                        <c:when test="${sessionScope.login_session.cust_clsf_cd eq '202002'}">
                        <li>
                            <a href="#!"><strong><spring:message code="top.mypage" text="마이페이지"/></strong></a>
                            <div class="m-menu-list-sub">
                                <a href="/mypage/myc01"><strong><spring:message code="top.mypage.register.booth.information" text="내 부스 정보 등록"/></strong></a>
                                <a href="/mypage/favortscorp"><spring:message code="top.all.menu.favorite.history2" text="즐겨찾기 내역"/></a>
                                <a href="/mypage/badgecorp"><spring:message code="top.all.menu.badge.accrual.history" text="뱃지 적립 내역"/></a>
                                <a href="/mypage/conslt_list"><spring:message code="top.all.menu.consultation" text="1:1 상담"/></a>
                                <a href="/mypage/myc07"><spring:message code="top.all.menu.meeting.reservation" text="상담예약현황"/></a>
                                <a href="/mypage/myc08"><spring:message code="left.menu.meeting.history" text="상담이력"/></a>
                                <a href="/mypage/myc05"><spring:message code="top.all.menu.modify.my.information" text="내 정보 수정"/></a>
                                <a href="/mypage/myp05"><spring:message code="top.all.menu.modify.my.password" text="비밀번호변경"/></a>
                                <a href="/mypage/myp06"><spring:message code="top.all.menu.re-agree.privacy" text="개인정보 재동의"/></a>
                                <a href="/mypage/myp07"><spring:message code="top.all.menu.membership.withdrawal" text="회원탈퇴"/></a>
                            </div>
                        </li>
                        </c:when>
                        <c:otherwise>
                        <li>
                            <a href="#!"><strong><spring:message code="top.mypage" text="마이페이지"/></strong></a>
                            <div class="m-menu-list-sub">
                                <a href="/mypage/favorts"><spring:message code="left.menu.favorite.booths" text="부스 즐겨찾기 내역"/></a>
                                <a href="/mypage/badge"><spring:message code="left.menu.badges.history" text="관심 뱃지 내역"/></a>

                                <c:if test="${sessionScope.LANG ne 'en'}">
                                <a href="/mypage/myp11">이벤트 참여 내역</a>
                                </c:if>

                                <a href="/mypage/conslt_list"><spring:message code="left.menu.consultation" text="1:1 상담"/></a>
                                <a href="/mypage/myp08"><spring:message code="left.menu.meeting.reservation" text="상담신청현황"/></a>
                                <a href="/mypage/myp09"><spring:message code="left.menu.meeting.request" text="상담신청"/></a>
                                <a href="/mypage/myp10"><spring:message code="left.menu.meeting.history" text="상담이력"/></a>

                                <a href="/mypage/myp04"><spring:message code="left.menu.edit.personal.info" text="정보 수정"/></a>
                                <a href="/mypage/myp05"><spring:message code="left.menu.change.password" text="비밀번호변경"/></a>
                                <a href="/mypage/myp06"><spring:message code="left.menu.extend.privacy" text="개인정보 재동의"/></a>
                                <a href="/mypage/myp07"><spring:message code="left.menu.withdrawal" text="회원탈퇴"/></a>
                            </div>
                        </li>
                        </c:otherwise>
                    </c:choose>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- M 메뉴 -->
    <!-- 커스텀 모달 -->
    <div class="customModal">
        <div class="customModal-header">
            <div class="customModal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
                        <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                    </svg>
                </button>
            </div>
        </div>
        <div class="customModal-content">
            <p><strong><sup>★</sup>이벤트 참여 방법(관심 뱃지 사용 방법 안내)</strong></p>
            <p>본 이벤트에 참여하려면 버추얼전시회(VR) 를 관람하면서 <em>'관심 뱃지'</em> 를 사용하셔야 합니다.</p>
            <p>관심 뱃지는 다음과 같은 방법으로 사용 할 수 있습니다.</p>
            <ol>
                <li>참관등록을 하고, '관심뱃지' <strong>10개</strong>를 부여받는다.</li>
                <li>사이트 우측 상단에 있는 검색 돋보기<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-search" id="top_corp_search" viewBox="0 0 16 16">
                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                  </svg>아이콘을 클릭하여 참여기업을 검색한다.</li>
                <li>관심이 있는 기업의 부스를 둘러보고, 관심뱃지 <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-award" viewBox="0 0 16 16" id="top_badge_EX210099">                 <path d="M9.669.864L8 0 6.331.864l-1.858.282-.842 1.68-1.337 1.32L2.6 6l-.306 1.854 1.337 1.32.842 1.68 1.858.282L8 12l1.669-.864 1.858-.282.842-1.68 1.337-1.32L13.4 6l.306-1.854-1.337-1.32-.842-1.68L9.669.864zm1.196 1.193l.684 1.365 1.086 1.072L12.387 6l.248 1.506-1.086 1.072-.684 1.365-1.51.229L8 10.874l-1.355-.702-1.51-.229-.684-1.365-1.086-1.072L3.614 6l-.25-1.506 1.087-1.072.684-1.365 1.51-.229L8 1.126l1.356.702 1.509.229z"></path><path d="M4 11.794V16l4-1 4 1v-4.206l-2.018.306L8 13.126 6.018 12.1 4 11.794z"></path></svg>아이콘을 클릭하여 <strong>3개</strong> 이상 사용한다. 
                    <p>(관심뱃지는 각 기업에 1개씩만 부여할 수 있습니다.)</p>
                </li>
                <li>
                    관심뱃지 3개 이상 사용 조건을 만족했다면?
                    <p>이벤트 페이지(https://vrutopia.in/index/event) 에서 ‘PUSH’ 버튼을 눌러<br>
                    <em>전기차 관련 주식 1주</em>를 추첨 받는다! </p>
                </li>
            </ol>
        </div>
    </div>


    <!-- 참여기업검색 -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
                            <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                          </svg>
                    </button>
                </div>

                <!-- 참여기업 검색 -->

                <div class="modal-body">
                    <div class="modal-tit">
                        <h3><spring:message code="top.cust.search" text="참여기업 검색"/></h3>
                    </div>
                    <div class="pb-3">
                        <div class="form-inline">
                            <div class="input-group col-sm-4 pl-0 pr-1 mb-2">
                                <select class="glyphicon glyphicon-menu-down form-control dropdown-btn" id="top_category"></select>
                            </div>
                            <div class="input-group col-sm-8 pl-0 pr-1 mb-2">
                                <input type="text" name="top_keyword" id="top_keyword" class="form-control" placeholder="<c:if test="${sessionScope.LANG eq 'en'}">Enter Company Name</c:if><c:if test="${sessionScope.LANG ne 'en'}">기업명을 입력해 주세요</c:if>">
                                <span class="input-group-text bg-white" id="searchCategori">
                                    <a href="#!">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                            class="bi bi-search" viewBox="0 0 16 16">
                                            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
                                        </svg>
                                    </a>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-8 text-left">
                            <span class="small">
                                <c:if test="${sessionScope.LANG eq 'en'}">It is arranged in the order in which the badges were acquired.</c:if>
                                <c:if test="${sessionScope.LANG ne 'en'}">[기준] 부스 별 관심 뱃지 순위</c:if>
                            </span>
                        </div>
                        <div class="col-sm-4 text-right">
                            <div class="mobile-flex">
                            <c:if test="${sessionScope.LANG ne 'en'}">
                                <span class="small mobile-flex-item" >즐겨찾기</span>
                                <span class="small mobile-flex-item" style="margin:0 25px 0 15px">관심뱃지</span>
                            </c:if>

                            <c:if test="${sessionScope.LANG eq 'en'}">
                                <span class="small mobile-flex-item">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-bookmark-star text-primary" viewBox="0 0 16 16">                 
                                        <path d="M7.84 4.1a.178.178 0 0 1 .32 0l.634 1.285a.178.178 0 0 0 .134.098l1.42.206c.145.021.204.2.098.303L9.42 6.993a.178.178 0 0 0-.051.158l.242 1.414a.178.178 0 0 1-.258.187l-1.27-.668a.178.178 0 0 0-.165 0l-1.27.668a.178.178 0 0 1-.257-.187l.242-1.414a.178.178 0 0 0-.05-.158l-1.03-1.001a.178.178 0 0 1 .098-.303l1.42-.206a.178.178 0 0 0 .134-.098L7.84 4.1z"></path>                 
                                        <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z"></path>             
                                    </svg> Favorite</span>
                                <span class="small mobile-flex-item">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-award text-primary" viewBox="0 0 16 16">                 
                                        <path d="M9.669.864L8 0 6.331.864l-1.858.282-.842 1.68-1.337 1.32L2.6 6l-.306 1.854 1.337 1.32.842 1.68 1.858.282L8 12l1.669-.864 1.858-.282.842-1.68 1.337-1.32L13.4 6l.306-1.854-1.337-1.32-.842-1.68L9.669.864zm1.196 1.193l.684 1.365 1.086 1.072L12.387 6l.248 1.506-1.086 1.072-.684 1.365-1.51.229L8 10.874l-1.355-.702-1.51-.229-.684-1.365-1.086-1.072L3.614 6l-.25-1.506 1.087-1.072.684-1.365 1.51-.229L8 1.126l1.356.702 1.509.229z"></path>                 
                                        <path d="M4 11.794V16l4-1 4 1v-4.206l-2.018.306L8 13.126 6.018 12.1 4 11.794z"></path>             
                                    </svg>
                                    Badge of Interest
                                </span>
                            </c:if>

                            </div>
                            
                        </div>
                    </div>
                    <div class="modal-scroll">
                        <div class="col-sm-12 pl-0 pr-0">

                            <hr class="my-2">
                            <!-- 1 row -->
                            <div id = "div_categori"></div>

                        </div>
                    </div>
                    <!-- paging -->
                    <div class="table-responsive d-flex justify-content-center">
                        <nav aria-label="Page navigation">
                            <ul class="pagination pt-3" id="top_corp_page"></ul>
                        </nav>
                    </div>

                </div>

                <!-- / .참여기업 검색 -->

            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    
    <!-- 참여기업검색 끝 -->

    <div class="modal fade" id="menuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
                            <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                          </svg>
                    </button>
                </div>
                <div class="modal-body">
                <c:choose>
                    <c:when test="${sessionScope.LANG ne 'en'}">
                        <div class="sitemap clearfix">
                    </c:when>
                    <c:otherwise>
                        <div class="sitemap sitemap-en clearfix">
                    </c:otherwise>
                </c:choose>
                        <ul>
                            <li>
                                <a href="#!"><strong><spring:message code="top.view.guid" text="관람가이드"/></strong></a>
                            </li>
                            <li>
                                <a href="/index/guide?c=guide"><spring:message code="top.all.register.guide" text="사전등록 가이드"/></a>
                            </li>
                            <li>
                                <a href="/index/guide?c=virtual"><spring:message code="top.all.register.viewing.guide" text="버추얼전시회 관람 가이드"/></a>
                            </li>
                            <li>
                                <a href="/index/guide?c=question"><spring:message code="top.all.register.viewing.question" text="상담예약신청 안내"/></a>
                            </li>
                        </ul>
                        <ul>
                            <li>
                                <a href="#!"><strong><spring:message code="top.all.menu.virtual.island" text="버추얼 전시회"/></strong></a>
                            </li>
                            <li>
                                <a class="collapse-btn" href="/index/ieve2021"><spring:message code="top.all.menu.Entrance" text="입장하기"/><span></span></a>
                            </li>                                                  
                        </ul>
                        <!--ul id="topEvent2">
                            <li>
                                <a href="#!"><strong><spring:message code="top.view.event" text="이벤트"/></strong></a>
                            </li>
                            <li>
                                <a href="javascript:event_click()">이벤트 참여하기</a>
                            </li>
                        </ul-->
                        <ul>
                            <li>
                                <a href="#!"><strong><spring:message code="top.cust.search" text="참여기업검색"/></strong></a>
                            </li>
                            <li id="top_corp_search1">
                                <a href="!#" data-toggle="modal" data-target="#myModal"><spring:message code="top.cust.search" text="참여기업검색"/></a>
                            </li>
                        </ul>
                        
                        <ul>
                            <c:choose>
                                <c:when test="${sessionScope.login_session.cust_clsf_cd eq '202002'}">
                                <li>
                                    <a href="/mypage/myc01"><strong><spring:message code="top.mypage" text="마이페이지"/></strong></a>
                                </li>
                                <li>
                                    <a href="/mypage/favortscorp"><spring:message code="top.all.menu.favorite.history2" text="즐겨찾기 내역"/></a>
                                </li>
                                <li>
                                    <a href="/mypage/badgecorp"><spring:message code="top.all.menu.badge.accrual.history" text="뱃지 적립 내역"/></a>
                                </li>
                                <li>
                                    <a href="/mypage/conslt_list"><spring:message code="top.all.menu.consultation" text="Q & A"/></a>
                                </li>
                                <li>
                                    <a href="/mypage/myc07"><spring:message code="top.all.menu.meeting.reservation" text="상담예약현황"/></a>
                                </li>
                                <li>
                                    <a href="/mypage/myc05"><spring:message code="top.all.menu.modify.my.information" text="내 정보 수정"/></a>
                                </li>
                                </c:when>
                                <c:otherwise>
                                <li>
                                    <a href="/mypage/favorts"><strong><spring:message code="top.mypage" text="마이페이지"/></strong></a>
                                </li>
                                <li>
                                    <a href="/mypage/favorts"><spring:message code="left.menu.favorite.booths" text="부스 즐겨찾기 내역"/></a>
                                </li>
                                <li>
                                    <a href="/mypage/badge"><spring:message code="left.menu.badges.history" text="뱃지 사용 내역"/></a>
                                </li>

                                <c:if test="${sessionScope.LANG ne 'en'}">
                                <li>
                                    <a href="/mypage/myp11">이벤트 참여 내역</a>
                                </li>
                                </c:if>

                                <li>
                                    <a href="/mypage/conslt_list"><spring:message code="left.menu.consultation" text="Q & A"/></a>
                                </li>
                                <li>
                                    <a href="/mypage/myp09"><spring:message code="top.all.menu.meeting.request" text="상담신청"/></a>
                                </li>
                                <li>
                                    <a href="/mypage/myp04"><spring:message code="left.menu.edit.personal.info" text="내 정보 수정"/></a>
                                </li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <!-- NAVBAR
    ================================================= -->
    <nav class=" fixed-top">
        
         <c:if test="${sessionScope.LANG ne 'en' && vr_yn ne 'Y' && 1 ne 1}">
            <div class="pc-topBanner">
                <div class="container">
                    <map name="t">
                        <area shape="rect" coords="891,13,1123,56" href="javascript:event_click()">
                    </map>
                    
                        <img src="/images/pc-topBanner.jpg" usemap="#t" />
                    
                </div>
            </div>
             
            <div class="mobile-topBanner">
                    <div class="container">
                        <a href="javascript:event_click()">
                            <img src="/images/mobile-topBanner.jpg">
                        </a>
                    </div>
                </div>
            </div>
        </c:if>

        <div class="navbar navbar-expand-xl navbar-light p-1">
            <div class="hamburger" id="hamburger-6">
                <a href="#!">
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-list"
                        viewBox="0 0 16 16">
                        <path fill-rule="evenodd"
                            d="M2.5 11.5A.5.5 0 0 1 3 11h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4A.5.5 0 0 1 3 7h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4A.5.5 0 0 1 3 3h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z" />
                    </svg>
                </a>
            </div>
            <!-- M 서브 메뉴 -->
            <div class="mobile-submenu">
                <ul>
                    <li class="nav-item ">
                        <a href="#" data-toggle="modal" data-target="#myModal">
                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                                class="bi bi-search" viewBox="0 0 16 16">
                                <path
                                    d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z">
                                </path>
                            </svg>
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="dropdown-toggle" href="#" id="navbarWelcome" role="button" data-toggle="dropdown"
                            aria-haspopup="true" aria-expanded="false">
                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                                class="bi bi-globe" viewBox="0 0 16 16">
                                <path
                                    d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm7.5-6.923c-.67.204-1.335.82-1.887 1.855A7.97 7.97 0 0 0 5.145 4H7.5V1.077zM4.09 4a9.267 9.267 0 0 1 .64-1.539 6.7 6.7 0 0 1 .597-.933A7.025 7.025 0 0 0 2.255 4H4.09zm-.582 3.5c.03-.877.138-1.718.312-2.5H1.674a6.958 6.958 0 0 0-.656 2.5h2.49zM4.847 5a12.5 12.5 0 0 0-.338 2.5H7.5V5H4.847zM8.5 5v2.5h2.99a12.495 12.495 0 0 0-.337-2.5H8.5zM4.51 8.5a12.5 12.5 0 0 0 .337 2.5H7.5V8.5H4.51zm3.99 0V11h2.653c.187-.765.306-1.608.338-2.5H8.5zM5.145 12c.138.386.295.744.468 1.068.552 1.035 1.218 1.65 1.887 1.855V12H5.145zm.182 2.472a6.696 6.696 0 0 1-.597-.933A9.268 9.268 0 0 1 4.09 12H2.255a7.024 7.024 0 0 0 3.072 2.472zM3.82 11a13.652 13.652 0 0 1-.312-2.5h-2.49c.062.89.291 1.733.656 2.5H3.82zm6.853 3.472A7.024 7.024 0 0 0 13.745 12H11.91a9.27 9.27 0 0 1-.64 1.539 6.688 6.688 0 0 1-.597.933zM8.5 12v2.923c.67-.204 1.335-.82 1.887-1.855.173-.324.33-.682.468-1.068H8.5zm3.68-1h2.146c.365-.767.594-1.61.656-2.5h-2.49a13.65 13.65 0 0 1-.312 2.5zm2.802-3.5a6.959 6.959 0 0 0-.656-2.5H12.18c.174.782.282 1.623.312 2.5h2.49zM11.27 2.461c.247.464.462.98.64 1.539h1.835a7.024 7.024 0 0 0-3.072-2.472c.218.284.418.598.597.933zM10.855 4a7.966 7.966 0 0 0-.468-1.068C9.835 1.897 9.17 1.282 8.5 1.077V4h2.355z" />
                            </svg>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarWelcome">
                            <a class="dropdown-item " href="/index/lang?lang=ko">
                                KOR
                            </a>
                            <a class="dropdown-item " href="/index/lang?lang=en">
                                ENG
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- M 서브 메뉴 -->
            <div class="container">
                <h1 class="logo m-0">
                    <a href="/">
                        <img src="/assets/img/icons/header_logo.png" alt="">
                    </a>
                </h1>
                <!-- Brand -->

                <!-- Collapse -->
                <div class="collapse navbar-collapse" id="navbarCollapse">

                    <div class="collapse navbar-collapse" id="navbarCollapse">

                        <!-- Links -->
                        <c:choose>
                            <c:when test="${sessionScope.LANG eq 'en'}">
                                <ul class="navbar-nav ml-auto en-navbar-nav">
                            </c:when>
                            <c:otherwise>
                                <ul class="navbar-nav ml-auto ">
                            </c:otherwise>
                        </c:choose>
                            <li class="nav-item ">
                                <a href="/index/guide" class="nav-link nav-item-font">
                                    <strong><spring:message code="top.view.guid" text="관람가이드"/></strong>
                                </a>
                            </li>
                            <li class="nav-item ">
                                <a href="/index/ieve2021" class="nav-link nav-item-font">
                                    <strong><spring:message code="top.vr.exhibition.hall" text="버추얼전시관"/></strong>
                                </a>
                            </li>
                            <li class="nav-item" id="top_corp_search2">
                                <!--a href="javascript:event_click()" class="nav-link nav-item-font">
                                    <strong><spring:message code="top.vr.exhibition.event" text="이벤트"/></strong>
                                </a-->
                                <a href="!#" data-toggle="modal" data-target="#myModal" class="nav-link nav-item-font">
                                    <strong><spring:message code="top.cust.search" text="참여기업검색"/></strong>
                                </a>
                            </li>

                            <c:choose>
                                <c:when test="${empty sessionScope.login_session.cust_nm}">
                                    <li class="nav-item nav-item-small">
                                        <a href="/member/login_form" class="nav-link nav-item-font">
                                            <strong><spring:message code="top.login" text="로그인"/></strong>
                                        </a>
                                    </li>
                                </c:when>

                                <c:otherwise>
                                    <li class="nav-item nav-item-small">
                                        <a href="/logout" class="nav-link nav-item-font">
                                            <strong><spring:message code="top.logout" text="로그아웃"/></strong>
                                        </a>
                                    </li>
                                </c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${empty sessionScope.login_session.cust_nm}">
                                    <li class="nav-item nav-item-small">
                                        <a href="/member/join_form1" class="nav-link nav-item-font">
                                            <strong><spring:message code="top.visit.reg" text="참관등록"/></strong>
                                        </a>
                                    </li>
                                </c:when>

                                <c:otherwise>
                                    <li class="nav-item nav-item-small">
                                        <c:if test="${sessionScope.login_session.cust_clsf_cd eq '202001'}">
                                        <a href="/mypage/favorts" class="nav-link nav-item-font">
                                        </c:if>
                                        <c:if test="${sessionScope.login_session.cust_clsf_cd eq '202002'}">
                                        <a href="/mypage/myc01" class="nav-link nav-item-font">
                                        </c:if>
                                        <c:if test="${sessionScope.login_session.cust_clsf_cd eq '202003'}">
                                        <a href="/mgnt/badge" class="nav-link nav-item-font">
                                        </c:if>
                                            <strong><spring:message code="top.mypage" text="마이페이지"/></strong>
                                        </a>
                                    </li>
                                </c:otherwise>
                            </c:choose>


                            <li class="nav-item ">
                                <a href="#!" class="nav-link" data-toggle="modal"
                                    data-target="#menuModal">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="27" height="27" fill="currentColor" class="bi bi-list" viewBox="0 0 16 16" data="">
                                        <path fill-rule="evenodd" d="M2.5 11.5A.5.5 0 0 1 3 11h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4A.5.5 0 0 1 3 7h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4A.5.5 0 0 1 3 3h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z">
                                        </path>
                                    </svg>
                                </a>
                            </li>
                            <li class="nav-item" id="top_corp_search4">
                                <a href="#!" class="nav-link nav-item-svg" data-toggle="modal" data-target="#myModal">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                                      </svg>
                                </a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle nav-item-svg" href="#" id="navbarWelcome" role="button"
                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                                        class="bi bi-globe" viewBox="0 0 16 16">
                                        <path
                                            d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm7.5-6.923c-.67.204-1.335.82-1.887 1.855A7.97 7.97 0 0 0 5.145 4H7.5V1.077zM4.09 4a9.267 9.267 0 0 1 .64-1.539 6.7 6.7 0 0 1 .597-.933A7.025 7.025 0 0 0 2.255 4H4.09zm-.582 3.5c.03-.877.138-1.718.312-2.5H1.674a6.958 6.958 0 0 0-.656 2.5h2.49zM4.847 5a12.5 12.5 0 0 0-.338 2.5H7.5V5H4.847zM8.5 5v2.5h2.99a12.495 12.495 0 0 0-.337-2.5H8.5zM4.51 8.5a12.5 12.5 0 0 0 .337 2.5H7.5V8.5H4.51zm3.99 0V11h2.653c.187-.765.306-1.608.338-2.5H8.5zM5.145 12c.138.386.295.744.468 1.068.552 1.035 1.218 1.65 1.887 1.855V12H5.145zm.182 2.472a6.696 6.696 0 0 1-.597-.933A9.268 9.268 0 0 1 4.09 12H2.255a7.024 7.024 0 0 0 3.072 2.472zM3.82 11a13.652 13.652 0 0 1-.312-2.5h-2.49c.062.89.291 1.733.656 2.5H3.82zm6.853 3.472A7.024 7.024 0 0 0 13.745 12H11.91a9.27 9.27 0 0 1-.64 1.539 6.688 6.688 0 0 1-.597.933zM8.5 12v2.923c.67-.204 1.335-.82 1.887-1.855.173-.324.33-.682.468-1.068H8.5zm3.68-1h2.146c.365-.767.594-1.61.656-2.5h-2.49a13.65 13.65 0 0 1-.312 2.5zm2.802-3.5a6.959 6.959 0 0 0-.656-2.5H12.18c.174.782.282 1.623.312 2.5h2.49zM11.27 2.461c.247.464.462.98.64 1.539h1.835a7.024 7.024 0 0 0-3.072-2.472c.218.284.418.598.597.933zM10.855 4a7.966 7.966 0 0 0-.468-1.068C9.835 1.897 9.17 1.282 8.5 1.077V4h2.355z" />
                                    </svg>
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navbarWelcome">
                                    <a class="dropdown-item dropdown-item-font" href="/index/lang?lang=ko">
                                        KOR
                                    </a>
                                    <a class="dropdown-item dropdown-item-font" href="/index/lang?lang=en">
                                        ENG
                                    </a>
                                </div>
                            </li>

                        </ul>
                    </div>

                </div> <!-- / .navbar-collapse -->

            </div> <!-- / .container -->
        </div>
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