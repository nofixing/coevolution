<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
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
              상담문의 내역
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
              상담문의 내역
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>
    
    <!-- CONTENT
    ================================================== -->
    <section class="section pt-0">
      <div class="container">

        <div class="row">
          <div class="col-md-3">
            
             <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/cLeftMenu.jsp"></jsp:include>
           
          </div>
          <div class="col-md-9">
            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mt-4 mb-4">
                <strong>
                  상담문의 내역
                </strong>
              </h3>

              <div class="form-styled">

                  
                <!--검색조건-->
                <form class="pt-4 pb-3">
                
                  <input type="hidden" name="page_current" id="page_current"/>
                  
                  <div class="form-row align-items-center">
                    <div class="col-sm-2">
                      <select class="form-control form-control-sm mb-2" id="board_stat_cd" name="board_stat_cd">
                        <option value="" <c:if test="${board_stat_cd eq ''}">selected</c:if>>진행상태</option>
                        <option value="104001" <c:if test="${board_stat_cd eq '104001'}">selected</c:if>>답변대기</option>
                        <option value="104002" <c:if test="${board_stat_cd eq '104002'}">selected</c:if>>답변완료</option>
                      </select>
                    </div>

                    <div class="col-sm-2">
                      <select class="form-control form-control-sm mb-2" id="keyword_clsf_cd" name="keyword_clsf_cd">
                        <option value="" <c:if test="${keyword_clsf_cd eq ''}">selected</c:if>>전체</option>
                        <option value="subject" <c:if test="${keyword_clsf_cd eq 'subject'}">selected</c:if>>제목</option>
                        <option value="content" <c:if test="${keyword_clsf_cd eq 'content'}">selected</c:if>>내용</option>
                      </select>
                    </div>

                    <div class="col-sm-6">
                      <input type="text" class="form-control form-control-sm mb-2" id="keyword" name="keyword" value="${keyword}">
                    </div>

                    <div class="col-sm-2">
                      <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" id="btnSearch">검색</button>
                    </div>
                  </div>
                </form>            

                <!-- 총건수 -->
                <span class="text-muted small">
                  (총 ${row_count} 건)
                </span>
                <div class="table-responsive">
                  <table class="table table-striped table-hover table-sm border-bottom">
                    <thead class="table-light">
                      <tr>
                        <th scope="col" class="text-center">번호</th>
                        <th scope="col" class="text-left">제목</th>
                        <th scope="col" class="text-center">부스명</th>
                        <th scope="col" class="text-center">회원</th>
                        <th scope="col" class="text-center">등록일</th>
                        <th scope="col" class="text-center">진행상태</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="list" items="${list}">
                      <tr>
                        <th scope="row" class="text-center">${list.rn}</th>
                        <td class="text-left">
                          <div style="overflow: hidden;text-overflow: ellipsis; white-space: nowrap; width:150px;">
                            <a href="javascript:doDetail('${list.board_id}')">${list.board_subject}</a>
                          </div>
                        </td>
                        <td class="text-center">${list.conslt_cust_nm}</td>
                        <td class="text-center">${list.reg_user_nm}</td>
                        <td class="text-center">${list.reg_dt}</td>
                        <td class="text-center">${list.board_stat_nm}</td>
                      </tr> 
                      </c:forEach>    
                      <c:if test="${fn:length(list) == 0}">
                      <tr>
                        <th scope="row" class="text-center" colspan="6">조회된 내용이 없습니다.</th>
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
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
    <jsp:include page="myc04_js.jsp"></jsp:include>
  </body>
</html>