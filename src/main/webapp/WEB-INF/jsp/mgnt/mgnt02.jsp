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
              상담문의
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="/index">Home</a>
            </span>
            <span class="breadcrumb-item active">
              관리자페이지
            </span>
            <span class="breadcrumb-item active">
              상담문의
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
            <jsp:include page="/WEB-INF/jsp/include/mLeftMenu.jsp"></jsp:include>
           
          </div>
          <div class="col-md-9">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mt-4 mb-4">
                <strong>
                  상담문의
                </strong>
              </h3>


              <div class="form-styled">

                <!--검색조건-->
                <form class="pt-4 pb-3">

                  <input type="hidden" id="page_current" name="page_current">

                  <div class="form-row align-items-center pb-2">
                      <div class="col-2 text-center form-control-sm">
                        답변여부
                      </div>                  
                      <div class="col">
                        <div class="form-inline">
                          <select class="form-control form-control-sm mb-2" id="board_stat_cd" name="board_stat_cd">
                            <option value="">전체</option>
                            <option value="104001" <c:if test="${board_stat_cd eq '104001'}">selected</c:if>>답변대기</option>
                            <option value="104002" <c:if test="${board_stat_cd eq '104002'}">selected</c:if>>답변완료</option>
                          </select>
                        </div>
                      </div>
                      <div class="col-2 text-center form-control-sm">
                        키워드
                      </div>    
                      <div class="col">
                        <div class="form-inline">
                          <select class="form-control form-control-sm mb-2" id="keyword_clsf_cd" name="keyword_clsf_cd" >
                            <option value="">전체</option>
                            <option value="subject" <c:if test="${keyword_clsf_cd eq 'subject'}">selected</c:if>>제목</option>
                            <option value="content" <c:if test="${keyword_clsf_cd eq 'content'}">selected</c:if>>내용</option>
                            <option value="insuser" <c:if test="${keyword_clsf_cd eq 'insuser'}">selected</c:if>>등록자</option>
                          </select>

                          <input type="text" class="form-control form-control-sm mb-2" id="keyword" name="keyword" value="${keyword}">

                        </div>
                      </div>                                          
                  </div>

                  <div class="form-row align-items-center pb-2">
                      <div class="col-2 text-center form-control-sm">
                        등록일자
                      </div>                  
                      <div class="col">
                        <div class="form-inline">
                          <input type="date" class="form-control form-control-sm mb-2" id="ins_dt_fr" name="ins_dt_fr" value="${ins_dt_fr}"> <span class="pl-2 pr-2">~</span>
                          <input type="date" class="form-control form-control-sm mb-2" id="ins_dt_to" name="ins_dt_to" value="${ins_dt_to}">
                        </div>
                      </div>
                      <div class="col-2 d-flex justify-content-end">
                        <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnSearch">조회</button>
                      </div>                        
                  </div>                  

                </form>            
                <div class="table-responsive">
                <table class="table table-striped table-hover table-sm border-bottom">
                  <thead class="table-light">
                    <tr>
                      <th scope="col" class="text-center">번호</th>
                      <th scope="col" class="text-left">제목</th>
                      <th scope="col" class="text-center">등록자</th>
                      <th scope="col" class="text-left">상담업체</th>
                      <th scope="col" class="text-center">등록일</th>
                      <th scope="col" class="text-center">답변여부</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="list" items="${list}">
                    <tr>
                      <td class="text-center">${list.rn}</td>
                      <td class="text-left"><a href="javascript:doDetail('${list.board_id}')">${list.board_subject}</a></td>
                      <td class="text-center">${list.reg_user_nm}</td>
                      <td class="text-left">${list.conslt_cust_nm}</td>
                      <td class="text-center">${list.reg_dt}</td>
                      <td class="text-center">${list.board_stat_nm}</td>
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
    <jsp:include page="mgnt02_js.jsp"></jsp:include>

  </body>
</html>