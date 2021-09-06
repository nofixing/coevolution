<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="ko">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>

  <style>
    .div-sum {
      height:5rem;
      display:block;
      text-align:center;
      width:15rem;
      border-radius:25px;
      background-color:#EDEDED
    }
    
  </style>

  </head>
  <body>

    <!-- top Menu -->
    <jsp:include page="/WEB-INF/jsp/include/topMenu.jsp"></jsp:include>

    <!-- BREADCRUMB
    ================================================== -->
    <nav class="breadcrumb">
      <div class="container">
        <div class="row align-items-center">
          <div class="col">
            
            <!-- Heading -->
            <h5 class="breadcrumb-heading">
              상담이력
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="/index">Home</a>
            </span>
            <span class="breadcrumb-item active">
              마이페이지
            </span>
            <span class="breadcrumb-item active">
              상담이력
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>
    
    <!-- CONTENT
    ================================================== -->
    <section class="section pt-0 mt-block">
      <div class="container">

        <div class="row">
          <div class="col-xl-3" id="gLeftMenu">
            
            <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/cLeftMenu.jsp"></jsp:include>
           
          </div>

          <div class="col-xl-9">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mt-4 mb-4">
                <strong>
                  상담이력
                </strong>
              </h3>

              <form class="form-styled">
                <input type="hidden" name="consult_time_id" id="consult_time_id" value="${consult_time_id}"/>
                <input type="hidden" name="cust_id" id="cust_id" value="${cust_id}"/>
                <!-- 건수 -->
                 <div class="d-flex justify-content-between pb-3">

                    <div class="border m-2 pt-3 div-sum">
                        <div style="height:4.5rem">                                
                            <h6 class="m-0"><b><span>채팅수</span></b></h6>
                            <h3 class="m-0"><b><span id="chat_cnt"></span></b></h3>
                        </div>
                    </div>

                    <div class="border m-2 pt-3 div-sum">
                        <div style="height:4.5rem">
                            <h6 class="m-0"><b><span>상담 예약 건수</span></b></h6>
                            <h3 class="m-0"><b><span id="consult_cnt"></span></b></h3>
                        </div>
                    </div>

                    <div class="border m-2 pt-3 div-sum">
                        <div style="height:4.5rem">
                            <h6 class="m-0"><b><span>상담 예약 총 시간</span></b></h6>
                            <h3 class="m-0"><b><span id="consult_time"></span></b></h3>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-4">
                        <div class="list-group border" id="custList" role="tablist" style="overflow:auto;height:400px"></div>
                    </div>
                    <div class="col-8 pl-0">
                        <div class="tab-content border" id="speech_bubble" style="overflow-y:auto;height:400px"></div>
                        <div class="pt-2" id="nav-tabContent">
                            <textarea class="form-control form-control-sm" id="taMsgSnd" maxlength=1000 row=3></textarea>
                        </div>
                        <div class="pt-2 d-flex justify-content-end" id="nav-tabContent">
                            <button type="button" class="basic-btn" style="width: 6rem;" id="btnMsgSnd">전송</button>
                        </div>
                    </div>
                </div>

              </form>

            </div>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myc08_js.jsp"></jsp:include>   

  </body>
</html>