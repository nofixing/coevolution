<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="ko">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>
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
              뱃지 적립 내역
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
              뱃지 적립 내역
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>
    
    <!-- CONTENT
    ================================================== -->
    <section class="section pt-0">
      <div class="container mt-block">

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
                  관심 뱃지 내역
                </strong>
              </h3>


              <div class="form-styled">
                
                <!-- Subheading -->
                <div class="text-center border p-4">
                  <h4 class="text-muted m-0">
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-bookmark-star" viewBox="0 0 16 16">
                      <path d="M7.84 4.1a.178.178 0 0 1 .32 0l.634 1.285a.178.178 0 0 0 .134.098l1.42.206c.145.021.204.2.098.303L9.42 6.993a.178.178 0 0 0-.051.158l.242 1.414a.178.178 0 0 1-.258.187l-1.27-.668a.178.178 0 0 0-.165 0l-1.27.668a.178.178 0 0 1-.257-.187l.242-1.414a.178.178 0 0 0-.05-.158l-1.03-1.001a.178.178 0 0 1 .098-.303l1.42-.206a.178.178 0 0 0 .134-.098L7.84 4.1z"/>
                      <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z"/>
                    </svg> 관심뱃지 <strong><span id="badgeCnt">${tot_badge}</span></strong>개
                  </h4>
                </div>


                <!--검색조건-->
                <form class="pt-4 pb-3">

                  <input type="hidden" name="page_current" id="page_current"/>

                  <div class="form-row align-items-center">
                    <div class="col-md-auto col-sm-12">
                      <input type="date" class="form-control form-control-sm mb-2" id="ins_dt_fr" name="ins_dt_fr" value="${ins_dt_fr}">
                    </div>
                    <div class="col-md-auto col-sm-12">
                      <input type="date" class="form-control form-control-sm mb-2" id="ins_dt_to" name="ins_dt_to" value="${ins_dt_to}">
                    </div>
                    <div class="col-md-auto col-sm-12">
                      <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnSearch">조회</button>
                    </div>
                    <div class="col-md-auto col-sm-12 ml-auto text-right search-tab">
                      <input type="hidden" name="slt_badge_clsf" id="slt_badge_clsf" value="${slt_badge_clsf}">
                      <a id="slt_badge_clsf1" href="javascript:setBadgeClsf('', 'slt_badge_clsf1')"      <c:if test="${slt_badge_clsf eq '' || slt_badge_clsf eq null}">class="on"</c:if>>전체</a>
                      <a id="slt_badge_clsf2" href="javascript:setBadgeClsf('211001','slt_badge_clsf2')" <c:if test="${slt_badge_clsf eq '211003'}">class="on"</c:if>>받음</a>
                      <a id="slt_badge_clsf3" href="javascript:setBadgeClsf('211004','slt_badge_clsf3')" <c:if test="${slt_badge_clsf eq '211004'}">class="on"</c:if>>회수</a>
                      <!--a id="slt_badge_clsf4" href="javascript:setBadgeClsf('211003','slt_badge_clsf4')" <c:if test="${slt_badge_clsf eq '211003'}">class="on"</c:if>>사용</a-->
                    </div>
                  </div>
                </form>            
                <div class="table-responsive">
                <table class="table table-striped table-hover table-sm border-bottom">
                  <thead class="table-light">
                    <tr>
                      <th scope="col" width="20%" class="text-center">부여일(유효기간)</th>
                      <th scope="col" width="35%" class="text-center">내용</th>
                      <th scope="col" width="15%" class="text-center">적립회원명</th>
                      <th scope="col" width="15%" class="text-center">뱃지받음</th>
                      <th scope="col" width="15%" class="text-center">뱃지회수</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="list" items="${list}">
                    <tr>
                      <td class="text-center">${list.ins_dt}</td>
                      <td class="text-left">
                        <p class="text-danger">${list.badge_clsf_nm}</p>
                        ${list.badge_conts}
                      </td>
                      <td class="text-center">${list.cust_nm}</td>
                      <td class="text-center">${list.badge_recv_cnt}</td>
                      <td class="text-center">${list.badge_use_cnt}</td>
                    </tr>   
                    </c:forEach>
                    <c:if test="${fn:length(list) == 0}">
                    <tr>
                      <th scope="row" class="text-center" colspan="5">조회된 내용이 없습니다.</th>
                    </tr>
                    </c:if>                                                                                                                                                                                                                             
                  </tbody>
                </table>
                </div>

                <!-- paging -->
                <div class="table-responsive d-flex justify-content-center">
                  <nav aria-label="Page navigation">
                    <ul class="pagination pt-3" id="pagingList"></ul>
                  </nav>
                </div>


              </div>

            </div>

            </div>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myc03_js.jsp"></jsp:include>

  </body>
</html>