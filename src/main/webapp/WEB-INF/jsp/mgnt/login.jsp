<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자페이지</title>
    <link rel="stylesheet" href="/assets/mgnt/css/reset.css">
    <link rel="stylesheet" href="/assets/mgnt/css/style.css">
    <script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE=" crossorigin="anonymous"></script>
</head>

<body>
    <div class="modal">
        <div class="modal-wrap">
            <div class="modal-title">
                <p>비밀번호 변경</p>
                <a href="#!" class="modal-close"><i class="bi bi-x-lg"></i></a>
            </div>
            <div class="modal-content">
                <form action="">
                    <p><sup>*</sup>필수 입력</p>
                    <table class="base-table">
                        <colgroup>
                            <col width="35%">
                        </colgroup>
                        <tr>
                            <th>기존 비밀번호<sup>*</sup></th>
                            <td>
                                <input type="password" class="w-100" id="bf_user_pw" name="bf_user_pw">
                            </td>
                        </tr>
                        <tr>
                            <th>새비밀번호<sup>*</sup></th>
                            <td>
                                <input type="password" class="w-100"  id="tobe_passwd1" name="tobe_passwd1">
                            </td>
                        </tr>
                        <tr>
                            <th>새비밀번호 확인<sup>*</sup></th>
                            <td>
                                <input type="password" class="w-100"  id="tobe_passwd2" name="tobe_passwd2">
                            </td>
                        </tr>
                    </table>
                    <button type="button" id="btnChgPw">비밀번호 변경하기</button>
                </form>
            </div>
        </div>
    </div>
    <section>
        <div id="content">
            <div class="form login_form admin-form">
                <div class="form_head">
                    <p><img src="/assets/mgnt/img/login_logo.png" alt=""></p>
                    <small>버추얼 전시회 관리자 페이지입니다. </small>
                    <small>로그인 하시려면 아이디와 비밀번호를 입력해주세요.</small>
                </div>
                <div class="login_inner">
                    <div class="form-inner">
                        <form>
                            <div class="login_form clearfix">
                                <div class="login_input_area">
                                    <div class="id_area input_area">
                                        <input type="text" id="user_id" name="user_id" placeholder="아이디">
                                    </div>
                                    <div class="pw_area input_area">
                                        <input type="password" id="user_pw" name="user_pw" placeholder="비밀번호">
                                    </div>
                                </div>
                            </div>                                
                            <div class="login_form_btn">
                                <button type="button" class="login_form_submit" id="btnLogin">로그인</button>
                            </div>
                        </form>
                    </div>
                    <div class="form-inner">                            
                        <div class="check_area">
                            <div class="check_id">
                                <input type="checkbox" id="check_id">
                                <label for="check_id"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" style="cursor:pointer" fill="currentColor" class="bi bi-check2-circle" viewBox="0 0 16 16">
                                    <path d="M2.5 8a5.5 5.5 0 0 1 8.25-4.764.5.5 0 0 0 .5-.866A6.5 6.5 0 1 0 14.5 8a.5.5 0 0 0-1 0 5.5 5.5 0 1 1-11 0z"/>
                                    <path d="M15.354 3.354a.5.5 0 0 0-.708-.708L8 9.293 5.354 6.646a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l7-7z"/>
                                    </svg><span>아이디 저장</span></label>
                            </div>
                            <div class="check_pw">
                                <a href="#!" class="modal-on">비밀번호 재설정</a>
                            </div>
                        </div>
                        <div class="check_info">
                            <p>* 아이디 및 비밀번호 분실 시 <strong>02-6672-0405</strong>로 문의헤주시기 바랍니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer_mgnt.jsp"></jsp:include>
    <jsp:include page="login_js.jsp"></jsp:include>

</body>

</html>