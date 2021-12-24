<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="ko">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/mHeader.jsp"></jsp:include>
  </head>
  <body>

  <!-- top Menu -->
  <jsp:include page="/WEB-INF/jsp/include/mTopMenu.jsp"></jsp:include>
   
    <!-- CONTENT
    ================================================== -->
    <section class="section pt-7 pl-5 pr-5">
      <div class="container_fluid">

        <div class="row">
          <div class="col-md-2">
            
            <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/mLeftMenu.jsp"></jsp:include>
           
          </div>
          <div class="col-md-10">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mt-4 mb-4">
                <strong>
                  관심 뱃지 내역
                </strong>
              </h3>


              <div class="form-styled">

                <!--검색조건-->
                <form class="pt-4 pb-3">
                  <input type="hidden" name="page_current" id="page_current"/>
                  <div class="form-row align-items-center pb-2">
                      <div class="col-2 text-center form-control-sm">
                        엑스포명
                      </div>                  
                      <div class="col">
                        <div class="form-inline">

                          <select class="form-control form-control-sm mb-2" id="ev_expo_id" name="ev_expo_id" style="width:100%">
                            <c:forEach var="expoCdList" items="${expoCdList}">
                              <option value="${expoCdList.ev_expo_id}" <c:if test="${expo_id eq expoCdList.ev_expo_id}">selected</c:if>>${expoCdList.ev_expo_nm}</option>
                            </c:forEach>
                          </select>

                        </div>
                      </div>
                  </div>
                  <div class="form-row align-items-center pb-2">
                      <div class="col-2 text-center form-control-sm">
                        부스선택
                      </div>                  
                      <div class="col">
                        <div class="form-inline">

                          <select class="form-control form-control-sm mb-2 mr-2" id="cust_clsf_sh" name="cust_clsf_sh" style="width:7rem">
                            <option value="202001" <c:if test="${cust_clsf_sh eq '' || cust_clsf_sh eq '202001'}">selected</c:if>>참관고객</option>
                            <option value="202002" <c:if test="${cust_clsf_sh eq '202002'}">selected</c:if>>참가고객</option>
                          </select>

                          <select class="form-control form-control-sm mb-2" id="category_sh" name="category_sh" style="width:8rem">
                            <option value="" <c:if test="${category_sh eq ''}">selected</c:if>>전체</option>
                            <c:forEach var="category" items="${category}">
                              <option value="${category.cd_id}" <c:if test="${category_sh eq category.cd_id}">selected</c:if>>${category.cd_nm}</option>
                            </c:forEach>
                          </select>

                        </div>
                      </div>

                      <div class="col-2 text-center form-control-sm">
                        부스명
                      </div>    
                      <div class="col">
                        <div class="form-inline">
                          <input type="text" class="form-control form-control-sm mb-2" id="category_nm_sh" name="category_nm_sh" value="${category_nm_sh}" style="width:100%">
                        </div>
                      </div>

                  </div>

                  <div class="form-row align-items-center pb-2">
                      <div class="col-2 text-center form-control-sm">
                        검색기간
                      </div>                  
                      <div class="col">
                        <div class="form-inline">
                          <input type="date" class="form-control form-control-sm mb-2" id="ins_dt_fr" name="ins_dt_fr" value="${ins_dt_fr}"> <span class="pl-2 pr-2">~</span>
                          <input type="date" class="form-control form-control-sm mb-2" id="ins_dt_to" name="ins_dt_to" value="${ins_dt_to}">
                        </div>
                      </div>
                      <div class="col-4 d-flex justify-content-end pr-2">
                        <button type="button" class="btn-outline-primary form-control form-control-sm mb-2 mr-2" style="width: 6rem;" id="btnSearch">조회</button>
                        <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 6rem;" id="btnExcel">엑셀다운</button>
                      </div>                        
                  </div>                  

                </form>            
                <div class="table-responsive" style="overflow-x: auto; white-space:nowrap">
                <table class="table table-striped table-hover table-sm border-bottom">
                  <c:if test="${cust_clsf_sh eq '' || cust_clsf_sh eq '202001'}">
                    <thead class="table-light">
                      <tr>
                        <th scope="col" class="text-center" style="width:50px">번호</th>
                        <th scope="col" class="text-left"   style="width:110px">회원명</th>
                        <th scope="col" class="text-center" style="width:80px">뱃지지급</th>
                        <th scope="col" class="text-center" style="width:80px">사용뱃지</th>
                        <th scope="col" class="text-center" style="width:80px">잔여뱃지</th>
                        <th scope="col" class="text-center" style="width:80px">피추천수</th>
                        <th scope="col" class="text-left"   style="width:200px">사용기간</th>
                        <th scope="col" class="text-left"   style="width:80px">부여일</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="list" items="${list}">
                      <tr>
                        <td class="text-center">${list.rn}</td>
                        <td class="text-left" style="white-space:pre-line;word-break: break-all;">${list.cust_nm}</td>
                        <td class="text-center">${list.tot_badge_paid_cnt}</td>
                        <td class="text-center">${list.tot_badge_use_cnt}</td>
                        <td class="text-center">${list.tot_badge_rmin_cnt}</td>
                        <td class="text-center">${list.tot_badge_rcmd_cnt}</td>
                        <td class="text-left">${list.expo_consult_prod}</td>
                        <td class="text-left">${list.ins_dt}</td>
                      </tr>   
                      </c:forEach>
                      <c:if test="${fn:length(list) == 0}">
                      <tr>
                        <th scope="row" class="text-center" colspan="8">조회된 내용이 없습니다.</th>
                      </tr>
                      </c:if>                                                                                                                                                                                                                 
                    </tbody>
                  </c:if>

                  <c:if test="${cust_clsf_sh eq '202002'}">
                    <thead class="table-light">
                      <tr>
                        <th scope="col" class="text-center">번호</th>
                        <th scope="col" class="text-left">회원명</th>
                        <th scope="col" class="text-center">총뱃지</th>
                        <th scope="col" class="text-center">뱃지부여</th>
                        <th scope="col" class="text-center">뱃지회수</th>
                        <th scope="col" class="text-left"   style="width:200px">사용기간</th>
                        <th scope="col" class="text-left">부여일</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="list" items="${list}">
                      <tr>
                        <td class="text-center">${list.rn}</td>
                        <td class="text-left" style="white-space:pre-line;word-break: break-all;">${list.cust_nm}</td>
                        <td class="text-center">${list.tot_badge}</td>
                        <td class="text-center">${list.tot_rcv}</td>
                        <td class="text-center">${list.tot_recall}</td>
                        <td class="text-left">${list.expo_consult_prod}</td>
                        <td class="text-left">${list.ins_dt}</td>
                      </tr>   
                      </c:forEach>
                      <c:if test="${fn:length(list) == 0}">
                      <tr>
                        <th scope="row" class="text-center" colspan="7">조회된 내용이 없습니다.</th>
                      </tr>
                      </c:if>                                                                                                                                                                                                                 
                    </tbody>
                  </c:if>

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

    <jsp:include page="/WEB-INF/jsp/include/footer_mgnt.jsp"></jsp:include>
    <jsp:include page="mgnt01_js.jsp"></jsp:include>

  </body>
</html>