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
              관심 뱃지 내역
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="#">Home</a>
            </span>
            <span class="breadcrumb-item active">
              마이페이지
            </span>
            <span class="breadcrumb-item active">
              관심 뱃지 내역
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>
    
    <!-- CONTENT
    ================================================== -->
    <section class="section pt-4">
      <div class="container">
        <div class="row">
          <div class="col-md-2">
            
            <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/pLeftMenu.jsp"></jsp:include>

          </div>
          <div class="col-md-10">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mb-4">
                관심 뱃지 내역
              </h3>


              <div class="form-styled">
                
                <!-- Subheading -->
                <div class="text-center border p-4">
                  <h4 class="text-muted m-0">
                    <img src="/image/medal.png" width="16rem" /> 관심뱃지 <strong><span id="badgeCnt">${tot_badge}</span></strong>개
                  </h4>
                </div>


                <!--검색조건-->
                <form class="pt-4 pb-3">
                  <div class="form-row align-items-center">
                    <div class="col-auto">
                      <input type="date" class="form-control form-control-sm mb-2" id="ins_dt_fr" name="ins_dt_fr" value="${ins_dt_fr}">
                    </div>
                    <div class="col-auto">
                      <input type="date" class="form-control form-control-sm mb-2" id="ins_dt_to" name="ins_dt_to" value="${ins_dt_to}">
                    </div>
                    <div class="col-auto">
                      <select class="form-control form-control-sm mb-2" style="width: 6rem;" id="slt_badge_clsf" name="slt_badge_clsf">
                        <option value="" <c:if test="${slt_badge_clsf eq ''}">selected</c:if>>전체</option>
                        <option value="211001" <c:if test="${slt_badge_clsf eq '211001'}">selected</c:if>>부여</option>  <!-- 회원가입 211001, 추천인 211002 -->
                        <option value="211004" <c:if test="${slt_badge_clsf eq '211004'}">selected</c:if>>회수</option>  <!-- 뱃지회수 211004 -->
                        <option value="211003" <c:if test="${slt_badge_clsf eq '211003'}">selected</c:if>>사용</option>  <!-- 뱃지사용 211003 -->
                      </select>
                    </div>
                    <div class="col-auto">
                      <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnSearch">조회</button>
                    </div>
                  </div>
                </form>            

                <table class="table table-striped table-hover table-sm border-bottom">
                  <thead class="table-light">
                    <tr>
                      <th scope="col" width="10%" class="text-center">번호</th>
                      <th scope="col" width="20%" class="text-center">부여일(유효기간)</th>
                      <th scope="col" width="40%" class="text-center">내용</th>
                      <th scope="col" width="15%" class="text-center">뱃지 부여/회수</th>
                      <th scope="col" width="15%" class="text-center">뱃지 사용</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="list" items="${list}">
                    <tr>
                      <th scope="row" class="text-center">${list.rn}</th>
                      <td class="text-center">${list.ins_dt}</td>
                      <td class="text-center">
                        <div class="text-danger">${list.badge_clsf_nm}</div>
                      </td>
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


                <!-- paging -->
                <div class="table-responsive d-flex justify-content-center">
                  <nav aria-label="Page navigation">
                    <ul class="pagination pt-3" id="pagingList"></ul>
                  </nav>
                </div>
              
              </div>

            </div>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myp02_js.jsp"></jsp:include>

  </body>
</html>