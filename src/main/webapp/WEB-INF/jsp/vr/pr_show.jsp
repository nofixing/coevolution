<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/assets/custom/reset.css">
    <link rel="stylesheet" href="/assets/custom/modal.css">
    <script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE=" crossorigin="anonymous"></script>
</head>
<body>
    <div class="modal-wrap">
        <div class="modal-title">
            <div class="modal-title-logo">
                <span>
                    <img src="/images/ieve-youtube-logo.png" alt="" style="max-width:400px;">
                </span>
                <span>
                    <img src="/images/youtube_live.png" alt="" style="max-width:100px;">
                    <img src="/images/youtube_logo_littledeep.png" alt="" style="max-width:150px">
                </span>
            </div>
            <div class="modal-title-txt">
                <p><sup>*</sup>기업명 클릭 시, 해당 기업 PR쇼 영상을 다시 보실 수 있습니다. </p>
                <span>Click the company name, and watch the PR Show.</span>
            </div>
        </div>
        <div class="modal-youtube-list">
            <dl>
                <dt>
                    <span>기업 COMPANY</span>
                    <a href="#!" class="mobile-action-btn">
                        <img src="/images/arrow_down.png" alt="">
                    </a>
                </dt>
                <dd>
                    <ol>
                        <c:forEach var="list" items="${arShowList}" varStatus="status">
                        <li>
                            <c:choose>
                                <c:when test="${(list.cd_val1 eq '' || list.cd_val1 eq null) && list.cd_val2 eq 'COMPANY'}">
                                <a href="#!">
                                    <em>${list.priority}.</em>
                                    <span>${list.cd_nm}</span>
                                    <span>${list.cd_nm_en}</span>
                                </a>
                                </c:when>
                                <c:when test="${(list.cd_val1 ne '' && list.cd_val1 ne null) && list.cd_val2 eq 'COMPANY'}">
                                <a href="${list.cd_val1}" target="_blank">
                                    <em>${list.priority}.</em>
                                    <span><strong>${list.cd_nm}</strong></span>
                                    <span>${list.cd_nm_en}</span>
                                </a>
                                </c:when>
                            </c:choose>
                        </li>
                        </c:forEach>
                    </ol>
                </dd>
            </dl>
            <dl>
                <dt>
                    <span>기관 INSTITUTION</span>
                    <a href="#!" class="mobile-action-btn">
                        <img src="/images/arrow_down.png" alt="">
                    </a>
                </dt>
                <dd>
                    <ol>
                        <c:forEach var="list" items="${arShowList}" varStatus="status">
                        <li>
                            <c:choose>
                                <c:when test="${(list.cd_val1 eq '' || list.cd_val1 eq null) && list.cd_val2 eq 'INSTITUTION'}">
                                <a href="#!">
                                    <em>${list.priority}.</em>
                                    <span>${list.cd_nm}</span>
                                    <span>${list.cd_nm_en}</span>
                                </a>
                                </c:when>
                                <c:when test="${(list.cd_val1 ne '' && list.cd_val1 ne null) && list.cd_val2 eq 'INSTITUTION'}">
                                <a href="${list.cd_val1}" target="_blank">
                                    <em>${list.priority}.</em>
                                    <span>${list.cd_nm}</span>
                                    <span>${list.cd_nm_en}</span>
                                </a>
                                </c:when>
                            </c:choose>
                        </li>
                        </c:forEach>
                    </ol>
                </dd>
            </dl>
            <dl>
                <dt>
                    <span>교육 EDUCATION</span>
                    <a href="#!" class="mobile-action-btn">
                        <img src="/images/arrow_down.png" alt="">
                    </a>
                </dt>
                <dd>
                    <ol>
                        <c:forEach var="list" items="${arShowList}" varStatus="status">
                        <li>
                            <c:choose>
                                <c:when test="${(list.cd_val1 eq '' || list.cd_val1 eq null) && list.cd_val2 eq 'EDUCATION'}">
                                <a href="#!">
                                    <em>${list.priority}.</em>
                                    <span>${list.cd_nm}</span>
                                    <span>${list.cd_nm_en}</span>
                                </a>
                                </c:when>
                                <c:when test="${(list.cd_val1 ne '' && list.cd_val1 ne null) && list.cd_val2 eq 'EDUCATION'}">
                                <a href="${list.cd_val1}" target="_blank">
                                    <em>${list.priority}.</em>
                                    <span>${list.cd_nm}</span>
                                    <span>${list.cd_nm_en}</span>
                                </a>
                                </c:when>
                            </c:choose>
                        </li>
                        </c:forEach>
                    </ol>
                </dd>
            </dl>
        </div>
    </div>
    <script>
        $(function(){
            $(".mobile-action-btn").on("click", function(){
                $(this).toggleClass("on");
                if($(this).hasClass("on")){
                    $(this).parent().next().slideUp(300);
                } else {
                    $(this).parent().next().slideDown(300);
                }
            });
        });
    </script>
</body>
</html>