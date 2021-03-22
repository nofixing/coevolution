<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <div class="hamburger" id="hamburger-6">
        <a href="#!">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-list"
                viewBox="0 0 16 16">
                <path fill-rule="evenodd"
                    d="M2.5 11.5A.5.5 0 0 1 3 11h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4A.5.5 0 0 1 3 7h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4A.5.5 0 0 1 3 3h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z" />
            </svg>
        </a>
    </div>
    <div class="m-menu">
        <div class="m-menu-top clearfix">
            <a href="#!">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-x"
                    viewBox="0 0 16 16">
                    <path
                        d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z" />
                </svg>
            </a>
            <!-- <div class="m-menu-close">
                <a href="#!"> <i class="close-btn icon"></i>
                </a>
            </div> -->
        </div>
        <div class="m-menu-body">
            <div class="m-menu-box">
                <div class="m-menu-shop">
                    <ul class="clearfix">
                        <li><a href=""><span>참가신청</span>
                            </a></li>
                        <li><a href=""><span>참관신청</span>
                            </a></li>
                    </ul>
                </div>
            </div>
            <div class="m-menu-box">
                <div class="m-menu-cate">
                    <ul class="clearfix">
                        <li><a href="#!">관람가이드</a></li>
                        <li><a href="#!">버추얼 전시관</a></li>
                        <li><a href="#!">메뉴3(미구현)</a></li>
                        <li><a href="#!">메뉴4(미구현)</a></li>
                        <li><a href="#!">메뉴5(미구현)</a></li>
                        <li><a href="#!">메뉴6(미구현)</a></li>
                        <li><a href="#!">메뉴7(미구현)</a></li>
                        <li><a href="#!">메뉴8(미구현)</a></li>
                    </ul>
                </div>

            </div>
            <div class="m-menu-box">
                <div class="m-menu-list">
                    <ul class="clearfix">
                        <li><a href="#!">
                                공지사항
                            </a></li>
                        <li><a href="#!">
                                자주묻는질문
                            </a></li>
                        <li><a href="#!">
                                회원가입
                            </a></li>
                        <li><a href="/member/login_form">
                                로그인
                            </a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="mobile-submenu">
        <ul>
            <li class="nav-item ">
                <a href="javascript:modalCorpSh()" data-toggle="modal" data-target="#myModal">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                        class="bi bi-search" viewBox="0 0 16 16">
                        <path
                            d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z">
                        </path>
                    </svg>
                </a>
            </li>
            <li class="nav-item dropdown">
                <a class=" dropdown-toggle" href="#" id="navbarWelcome" role="button" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="false">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
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
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <div class="modal-tit">
                        <h3>참여기업 검색</h3>
                    </div>
                    <div class="input-group pb-3">
                        <input type="text" class="form-control" placeholder="기업명을 입력해 주세요">
                        <span class="input-group-text bg-white" id="basic-addon2">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                class="bi bi-search" viewBox="0 0 16 16">
                                <path
                                    d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
                            </svg>
                        </span>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 text-left">
                            <sapn class="small">[기준]부스별 관심 뱃지 순위</sapn>
                        </div>
                        <div class="col-sm-6 text-right mobile-hidden">
                            <sapn class="small" style="margin-right:20px;">바로가기/즐겨찾기/관심뱃지</sapn>
                        </div>
                    </div>
                    <div class="modal-scroll">
                        <div class="col-sm-12 pl-0 pr-0">

                            <hr class="my-2">

                            <!-- 1 row -->
                            <div class="row search-item align-items-center text-nounderline">
                                <div class="col-12 col-sm-3 text-center">

                                    <!-- Image -->
                                    <img src="/assets/img/22.jpg" class="mb-3" style="width: 110px;">

                                </div>

                                <div class="col-12 col-sm-6 mb-0">

                                    <!-- Heading -->
                                    <h5 class="mb-0">
                                        SAMSUNG SDI (삼성SDI)
                                    </h5>

                                    <!-- Meta -->
                                    <p class="mb-0 text-xs text-muted">
                                        <strong class="text-body">서비스 품목</strong>
                                    </p>

                                    <!-- Text -->
                                    <p class="mb-0 text-sm text-muted">
                                    <h4><span class="badge bg-info "><small class="text-white">기자재</small></span></h4>
                                    </p>

                                </div>

                                <div class="col-12 col-sm-3 text-left pr-0">
                                    <!-- 즐겨찾기/관심뱃지 -->
                                    <div class="row col-12 justify-content-between">

                                        <img src="link.png" width="30rem" />
                                        <img src="star.png" width="30rem" />
                                        <img src="medal.png" width="30rem" />

                                    </div>
                                </div>

                            </div> <!-- / .row -->

                            <hr class="my-1">

                            <!-- 2 row -->
                            <div class="row align-items-center text-nounderline">
                                <div class="col-12 col-sm-3">

                                    <!-- Image -->
                                    <img src="/assets/img/22.jpg" class="mb-3" style="width: 110px;">

                                </div>

                                <div class="col-12 col-sm-6 mb-0">

                                    <!-- Heading -->
                                    <h5 class="mb-0">
                                        SAMSUNG SDI (삼성SDI)
                                    </h5>

                                    <!-- Meta -->
                                    <p class="mb-0 text-xs text-muted">
                                        <strong class="text-body">서비스 품목</strong>
                                    </p>

                                    <!-- Text -->
                                    <p class="mb-0 text-sm text-muted">
                                    <h4><span class="badge bg-info "><small class="text-white">기자재</small></span></h4>
                                    </p>

                                </div>

                                <div class="col-12 col-sm-3 text-left pr-0">
                                    <!-- 즐겨찾기/관심뱃지 -->
                                    <div class="row col-sm-12 justify-content-between">

                                        <img src="link.png" width="30rem" />
                                        <img src="star.png" width="30rem" />
                                        <img src="medal.png" width="30rem" />

                                    </div>
                                </div>

                            </div> <!-- / .row -->

                            <hr class="my-1">


                            <!-- 3 row -->
                            <div class="row align-items-center text-nounderline">
                                <div class="col-12 col-sm-3">

                                    <!-- Image -->
                                    <img src="/assets/img/22.jpg" class="mb-3" style="width: 110px;">

                                </div>

                                <div class="col-12 col-sm-6 mb-0">

                                    <!-- Heading -->
                                    <h5 class="mb-0">
                                        SAMSUNG SDI (삼성SDI)
                                    </h5>

                                    <!-- Meta -->
                                    <p class="mb-0 text-xs text-muted">
                                        <strong class="text-body">서비스 품목</strong>
                                    </p>

                                    <!-- Text -->
                                    <p class="mb-0 text-sm text-muted">
                                    <h4><span class="badge bg-info "><small class="text-white">기자재</small></span></h4>
                                    </p>

                                </div>

                                <div class="col-12 col-sm-3 text-left pr-0">
                                    <!-- 즐겨찾기/관심뱃지 -->
                                    <div class="row col-sm-12 justify-content-between">

                                        <img src="link.png" width="30rem" />
                                        <img src="star.png" width="30rem" />
                                        <img src="medal.png" width="30rem" />

                                    </div>
                                </div>

                            </div> <!-- / .row -->

                            <hr class="my-1">


                            <!-- 4 row -->
                            <div class="row align-items-center text-nounderline">
                                <div class="col-12 col-sm-3">

                                    <!-- Image -->
                                    <img src="/assets/img/22.jpg" class="mb-3" style="width: 110px;">

                                </div>

                                <div class="col-12 col-sm-6 mb-0">

                                    <!-- Heading -->
                                    <h5 class="mb-0">
                                        SAMSUNG SDI (삼성SDI)
                                    </h5>

                                    <!-- Meta -->
                                    <p class="mb-0 text-xs text-muted">
                                        <strong class="text-body">서비스 품목</strong>
                                    </p>

                                    <!-- Text -->
                                    <p class="mb-0 text-sm text-muted">
                                    <h4><span class="badge bg-info "><small class="text-white">기자재</small></span></h4>
                                    </p>

                                </div>

                                <div class="col-12 col-sm-3 text-left pr-0">
                                    <!-- 즐겨찾기/관심뱃지 -->
                                    <div class="row col-sm-12 justify-content-between">

                                        <img src="link.png" width="30rem" />
                                        <img src="star.png" width="30rem" />
                                        <img src="medal.png" width="30rem" />

                                    </div>
                                </div>

                            </div> <!-- / .row -->

                            <hr class="my-1">
                            <!-- 4 row -->
                            <div class="row align-items-center text-nounderline">
                                <div class="col-12 col-sm-3">

                                    <!-- Image -->
                                    <img src="/assets/img/22.jpg" class="mb-3" style="width: 110px;">

                                </div>

                                <div class="col-12 col-sm-6 mb-0">

                                    <!-- Heading -->
                                    <h5 class="mb-0">
                                        SAMSUNG SDI (삼성SDI)
                                    </h5>

                                    <!-- Meta -->
                                    <p class="mb-0 text-xs text-muted">
                                        <strong class="text-body">서비스 품목</strong>
                                    </p>

                                    <!-- Text -->
                                    <p class="mb-0 text-sm text-muted">
                                    <h4><span class="badge bg-info "><small class="text-white">기자재</small></span></h4>
                                    </p>

                                </div>

                                <div class="col-12 col-sm-3 text-left pr-0">
                                    <!-- 즐겨찾기/관심뱃지 -->
                                    <div class="row col-sm-12 justify-content-between">

                                        <img src="link.png" width="30rem" />
                                        <img src="star.png" width="30rem" />
                                        <img src="medal.png" width="30rem" />

                                    </div>
                                </div>

                            </div> <!-- / .row -->
                            <hr class="my-1">
                            <!-- 4 row -->
                            <div class="row align-items-center text-nounderline">
                                <div class="col-12 col-sm-3">

                                    <!-- Image -->
                                    <img src="/assets/img/22.jpg" class="mb-3" style="width: 110px;">

                                </div>

                                <div class="col-12 col-sm-6 mb-0">

                                    <!-- Heading -->
                                    <h5 class="mb-0">
                                        SAMSUNG SDI (삼성SDI)
                                    </h5>

                                    <!-- Meta -->
                                    <p class="mb-0 text-xs text-muted">
                                        <strong class="text-body">서비스 품목</strong>
                                    </p>

                                    <!-- Text -->
                                    <p class="mb-0 text-sm text-muted">
                                    <h4><span class="badge bg-info "><small class="text-white">기자재</small></span></h4>
                                    </p>

                                </div>

                                <div class="col-12 col-sm-3 text-left pr-0">
                                    <!-- 즐겨찾기/관심뱃지 -->
                                    <div class="row col-sm-12 justify-content-between">

                                        <img src="link.png" width="30rem" />
                                        <img src="star.png" width="30rem" />
                                        <img src="medal.png" width="30rem" />

                                    </div>
                                </div>

                            </div> <!-- / .row -->
                            <hr class="my-1">
                            <!-- 4 row -->
                            <div class="row align-items-center text-nounderline">
                                <div class="col-12 col-sm-3">

                                    <!-- Image -->
                                    <img src="/assets/img/22.jpg" class="mb-3" style="width: 110px;">

                                </div>

                                <div class="col-12 col-sm-6 mb-0">

                                    <!-- Heading -->
                                    <h5 class="mb-0">
                                        SAMSUNG SDI (삼성SDI)
                                    </h5>

                                    <!-- Meta -->
                                    <p class="mb-0 text-xs text-muted">
                                        <strong class="text-body">서비스 품목</strong>
                                    </p>

                                    <!-- Text -->
                                    <p class="mb-0 text-sm text-muted">
                                    <h4><span class="badge bg-info "><small class="text-white">기자재</small></span></h4>
                                    </p>

                                </div>

                                <div class="col-12 col-sm-3 text-left pr-0">
                                    <!-- 즐겨찾기/관심뱃지 -->
                                    <div class="row col-sm-12 justify-content-between">

                                        <img src="link.png" width="30rem" />
                                        <img src="star.png" width="30rem" />
                                        <img src="medal.png" width="30rem" />

                                    </div>
                                </div>

                            </div> <!-- / .row -->
                            <hr class="my-1">
                            <!-- 4 row -->
                            <div class="row align-items-center text-nounderline">
                                <div class="col-12 col-sm-3">

                                    <!-- Image -->
                                    <img src="/assets/img/22.jpg" class="mb-3" style="width: 110px;">

                                </div>

                                <div class="col-12 col-sm-6 mb-0">

                                    <!-- Heading -->
                                    <h5 class="mb-0">
                                        SAMSUNG SDI (삼성SDI)
                                    </h5>

                                    <!-- Meta -->
                                    <p class="mb-0 text-xs text-muted">
                                        <strong class="text-body">서비스 품목</strong>
                                    </p>

                                    <!-- Text -->
                                    <p class="mb-0 text-sm text-muted">
                                    <h4><span class="badge bg-info "><small class="text-white">기자재</small></span></h4>
                                    </p>

                                </div>

                                <div class="col-12 col-sm-3 text-left pr-0">
                                    <!-- 즐겨찾기/관심뱃지 -->
                                    <div class="row col-sm-12 justify-content-between">

                                        <img src="link.png" width="30rem" />
                                        <img src="star.png" width="30rem" />
                                        <img src="medal.png" width="30rem" />

                                    </div>
                                </div>

                            </div> <!-- / .row -->
                            <hr class="my-1">
                            <!-- 4 row -->
                            <div class="row align-items-center text-nounderline">
                                <div class="col-12 col-sm-3">

                                    <!-- Image -->
                                    <img src="/assets/img/22.jpg" class="mb-3" style="width: 110px;">

                                </div>

                                <div class="col-12 col-sm-6 mb-0">

                                    <!-- Heading -->
                                    <h5 class="mb-0">
                                        SAMSUNG SDI (삼성SDI)
                                    </h5>

                                    <!-- Meta -->
                                    <p class="mb-0 text-xs text-muted">
                                        <strong class="text-body">서비스 품목</strong>
                                    </p>

                                    <!-- Text -->
                                    <p class="mb-0 text-sm text-muted">
                                    <h4><span class="badge bg-info "><small class="text-white">기자재</small></span></h4>
                                    </p>

                                </div>

                                <div class="col-12 col-sm-3 text-left pr-0">
                                    <!-- 즐겨찾기/관심뱃지 -->
                                    <div class="row col-sm-12 justify-content-between">

                                        <img src="link.png" width="30rem" />
                                        <img src="star.png" width="30rem" />
                                        <img src="medal.png" width="30rem" />

                                    </div>
                                </div>

                            </div> <!-- / .row -->
                            <hr class="my-1">
                            <!-- 4 row -->
                            <div class="row align-items-center text-nounderline">
                                <div class="col-12 col-sm-3">

                                    <!-- Image -->
                                    <img src="/assets/img/22.jpg" class="mb-3" style="width: 110px;">

                                </div>

                                <div class="col-12 col-sm-6 mb-0">

                                    <!-- Heading -->
                                    <h5 class="mb-0">
                                        SAMSUNG SDI (삼성SDI)
                                    </h5>

                                    <!-- Meta -->
                                    <p class="mb-0 text-xs text-muted">
                                        <strong class="text-body">서비스 품목</strong>
                                    </p>

                                    <!-- Text -->
                                    <p class="mb-0 text-sm text-muted">
                                    <h4><span class="badge bg-info "><small class="text-white">기자재</small></span></h4>
                                    </p>

                                </div>

                                <div class="col-12 col-sm-3 text-left pr-0">
                                    <!-- 즐겨찾기/관심뱃지 -->
                                    <div class="row col-sm-12 justify-content-between">

                                        <img src="link.png" width="30rem" />
                                        <img src="star.png" width="30rem" />
                                        <img src="medal.png" width="30rem" />

                                    </div>
                                </div>

                            </div> <!-- / .row -->

                        </div>
                    </div>
                    <!-- paging -->
                    <div class="table-responsive d-flex justify-content-center">
                        <nav aria-label="Page navigation">
                            <ul class="pagination pt-3">
                                <li class="page-item">
                                    <a class="page-link" href="#">&lt;</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#">1</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#">2</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#">3</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#">&gt;</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <div class="modal fade" id="menuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <div class="sitemap clearfix">
                        <ul>
                            <li>
                                <a href="#!"><strong>관람가이드</strong></a>
                            </li>
                            <li>
                                <a href="#!">가이드 영상</a>
                            </li>
                        </ul>
                        <ul>
                            <li>
                                <a href="#!"><strong>비주얼 아일랜드</strong></a>
                            </li>
                            <li>
                                <a class="collapse-btn" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample">주제별<span><i class="bi bi-chevron-down"></i></span></a>
                                <div class="collapse collapse-item" id="collapseExample">
                                    <a href="#!">test1</a>                                            
                                    <a href="#!">test2</a>
                                    <a href="#!">test3</a>
                                </div>
                            </li>
                            <li>
                                <a class="collapse-btn" data-toggle="collapse" href="#collapseExample2" aria-expanded="false" aria-controls="collapseExample2">주제별 <span><i class="bi bi-chevron-down"></i></span></a>
                                <div class="collapse collapse-item" id="collapseExample2">
                                    <a href="#!">test1</a>                                            
                                    <a href="#!">test2</a>
                                    <a href="#!">test3</a>
                                </div>
                            </li>
                        </ul>
                        <ul>
                            <li>
                                <a href="#!"><strong>마이페이지</strong></a>
                            </li>
                            <li>
                                <a href="#!">부스 즐겨찾기 내역</a>
                            </li>
                            <li>
                                <a href="#!">뱃지 사용 내역</a>
                            </li>
                            <li>
                                <a href="#!">문의 내역</a>
                            </li>
                            <li>
                                <a href="#!">내 정보 수정</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <!-- NAVBAR
    ================================================= -->
    <nav class="navbar navbar-expand-xl navbar-light  fixed-top">
        <div class="container">
            <h1 class="logo">
                <a href="/">
                    <img src="/assets/img/icons/header_logo.png" alt="">
                </a>
            </h1>
            <!-- Brand -->

            <!-- Collapse -->
            <div class="collapse navbar-collapse" id="navbarCollapse">

                <div class="collapse navbar-collapse" id="navbarCollapse">

                    <!-- Links -->
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item ">
                            <a href="#" class="nav-link nav-item-font">
                                <strong><spring:message code="top.view.guid" text="관람가이드"/></strong>
                            </a>
                        </li>
                        <li class="nav-item ">
                            <a href="#" class="nav-link nav-item-font">
                                <strong><spring:message code="top.vr.exhibition.hall" text="버추얼전시관"/></strong>
                            </a>
                        </li>
                        <c:choose>
                            <c:when test="${empty sessionScope.login_session.cust_nm}">
                                <li class="nav-item ">
                                    <a href="/member/login_form" class="nav-link nav-item-font">
                                        <strong><spring:message code="top.login" text="로그인"/></strong>
                                    </a>
                                </li>
                            </c:when>

                            <c:otherwise>
                                <li class="nav-item ">
                                    <a href="/logout" class="nav-link nav-item-font">
                                        <strong><spring:message code="top.logout" text="로그아웃"/></strong>
                                    </a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                        <li class="nav-item ">
                            <a href="/member/join_form1" class="nav-link nav-item-font">
                                <strong><spring:message code="top.visit.reg" text="참관등록"/></strong>
                            </a>
                        </li>
                        <li class="nav-item ">
                            <a href="javascript:modalMenu()" class="nav-link nav-item-svg" data-toggle="modal"
                                data-target="#menuModal">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                                    class="bi bi-list" viewBox="0 0 16 16" data>
                                    <path fill-rule="evenodd"
                                        d="M2.5 11.5A.5.5 0 0 1 3 11h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4A.5.5 0 0 1 3 7h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4A.5.5 0 0 1 3 3h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z">
                                    </path>
                                </svg>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="javascript:modalCorpSh()" class="nav-link nav-item-svg" data-toggle="modal"
                                data-target="#myModal">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                                    class="bi bi-search" viewBox="0 0 16 16">
                                    <path
                                        d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z">
                                    </path>
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

            </div> <!-- / .navbar-collapse -->

        </div> <!-- / .container -->
    </nav>