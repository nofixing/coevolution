<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <!-- NAVBAR
    ================================================= -->
    <nav class="navbar navbar-expand-xl navbar-light  fixed-top">
      <div class="container">

        <!-- Brand -->
        <a class="navbar-brand" href="/index">
          <svg class="navbar-brand-svg" viewBox="0 0 245 80" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <img src="/image/expo.png">
          </svg>
        </a>
  
        <!-- Toggler -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
  
        <!-- Collapse -->
        <div class="collapse navbar-collapse" id="navbarCollapse">

          <!-- Links -->
          <ul class="navbar-nav ml-auto">
            <li class="nav-item ">
              <a href="#" class="nav-link">
                <strong>관람가이드</strong>
              </a>
            </li>
            <li class="nav-item ">
              <a href="#" class="nav-link">
                <strong>버추얼전시관</strong>
              </a>
            </li>
            <li class="nav-item ">
              <a href="/member/login_form" class="nav-link">
                <strong>로그인</strong>
              </a>
            </li>
            <li class="nav-item ">
              <a href="/member/join_form1" class="nav-link">
                <strong>참관등록</strong>
              </a>
            </li>
            <li class="nav-item ">
              <a href="javascript:modalMenu()" class="nav-link">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-list" viewBox="0 0 16 16">
                  <path fill-rule="evenodd" d="M2.5 11.5A.5.5 0 0 1 3 11h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4A.5.5 0 0 1 3 7h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4A.5.5 0 0 1 3 3h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z"/>
                </svg>
              </a>
            </li>
            <li class="nav-item ">
              <a href="#" class="nav-link">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                </svg>
              </a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarWelcome" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                KOR
              </a>
              <div class="dropdown-menu" aria-labelledby="navbarWelcome">
                <a class="dropdown-item " href="#">
                 KOR
                </a>
                <a class="dropdown-item " href="#">
                  ENG
                </a>
              </div>
            </li>

        </div> <!-- / .navbar-collapse -->
  
      </div> <!-- / .container -->    
    </nav>
    <div class="container" id="mainBody"></div>

<script> 

function modalMenu() {
  gfnAlert ("alert", "ajax error", "관람가이드관람가이드관람가이드관람가이드관람가이드관람가이드관람가이드관람가이드", function(rtnValue){
  });
}

</script>