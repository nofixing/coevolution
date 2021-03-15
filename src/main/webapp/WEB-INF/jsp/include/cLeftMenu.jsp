<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

  <!-- Title -->
  <div class="bg-light p-3">
    <h6 class="text-center"><strong>홍길동</strong>님</h6>
    <label class="text-left mb-0">아이디</label>
    <div><label class="text-left pl-2">kdfdjkjdf</label></div>
    <label class="text-left mb-0">가입일</label>
    <div><label class="text-left pl-2">2021-04-01</label></div>
    <!--정보수정-->
    <div class="text-center text-md-center pt-3">
      <button type="button" class="btn btn-outline-primary p-0" style="width: 100%;">
        <strong>정보수정</strong>
      </button>
    </div>
                          
  </div>

  <!-- List -->
  <ul class="sidenav list-unstyled pt-3 mb-5 mb-md-0">
    <li class="text-xs text-uppercase mb-2">
      <a href="#/mypage/myc01"><strong>내 부스 정보 등록</strong></a>
    </li>
    <li class="text-xs text-uppercase mb-2">
      <a href="/mypage/myc02"><strong>즐겨찾기 내역</strong></a>
    </li>
    <li class="text-xs text-uppercase mb-2">
      <a href="/mypage/myc03"><strong>삼담문의 내역</strong></a>
    </li>

    <li class="text-xs text-uppercase mb-2">
      <a href="#update" data-toggle="collapse"><strong>내정보수정</strong></a>
      <div id="update" class="collapse show pl-3">
        <ul class="list-group">
          <li class="list-group"><a href="#/mypage/myc04"><strong>정보수정</strong></a></li>
          <li class="list-group"><a href="/mypage/myp05"><strong>비밀번호변경</strong></a></li>
        </ul>
      </div>
    </li>             
    
    
    <li class="text-xs text-uppercase mb-2">
      <a href="/mypage/myp06"><strong>개인정보 재동의</strong></a>
    </li>
    <li class="text-xs text-uppercase mb-2">
      <a href="/mypage/myp07"><strong>회원탈퇴</strong></a>
    </li>
  </ul>