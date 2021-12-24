<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
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
                  이벤트관리
                </strong>
              </h3>
              <form name="form1" class="form-styled">
                <input type="hidden" id="page_current" name="page_current">
                <input type="hidden" id="board_id" name="board_id">
                <article>
                  <div class="form-search">
                    <table>
                      <colgroup>
                          <col class="form-search-1">
                          <col class="form-search-2">
                          <col class="form-search-3">
                          <col class="form-search-4">
                      </colgroup>
                      <tr>
                        <th>이벤트 선택</th>
                        <td>
                            <select name="board_clsf_dtl_cd" id="board_clsf_dtl_cd">
                                <option value="" <c:if test="${board_clsf_dtl_cd eq '' || board_clsf_dtl_cd eq null}">selected</c:if>>이벤트 선택</option>
                                <c:forEach var="list" items="${boardClsfDtlCdList}">
                                <option value="${list.cd_id}" <c:if test="${board_clsf_dtl_cd eq list.cd_id}">selected</c:if>>${list.cd_nm}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <th>기간검색</th>
                        <td>
                            <input type="date" class="form-control-sm" id="ins_dt_fr" name="ins_dt_fr" value="${ins_dt_fr}">
                            <span class="pl-2 pr-2">~</span>
                            <input type="date" class="form-control-sm" id="ins_dt_to" name="ins_dt_to" value="${ins_dt_to}">
                        </td>
                      </tr>
                      <tr>
                          <th>이벤트명</th>
                          <td colspan="3">
                              <input type="text" id="keyword" name="keyword" value="${keyword}">
                          </td>
                      </tr>
                    </table>

                    <div class="form-search-btn">
                        <button type="button" id="btnSearch">조회</button>
                    </div>

                  </div>
                </article>

                <article>
                  <div class="board-list">
                    <div class="board-excel" id="btnExcel">
                        <a href="#!">엑셀 다운로드</a>
                    </div>
                    <table class="board-table">
                        <thead>
                            <tr style="text-align:center">
                                <th>번호</th>
                                <th>이벤트명</th>
                                <th>이벤트 기간</th>
                                <th>참여자</th>
                                <th>등록자</th>
                                <th>등록일</th>
                                <th>조회수</th>
                                <th>노출여부</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="list" items="${list}">
                            <tr>
                                <td>${list.rn}</td>
                                <td><a href="javascript:doDetail('${list.board_id}')">${list.board_subject}</a></td>
                                <td>${list.evnt_prod_dt}</td>
                                <td></td>
                                <td>${list.ins_user}</td>
                                <td>${list.ins_dtm}</td>
                                <td>${list.board_cnt}</td>
                                <td>${list.use_yn}</td>
                            </tr>
                          </c:forEach>
                          <c:if test="${fn:length(list) == 0}">
                          <tr>
                            <td class="text-center" colspan="8">조회된 내용이 없습니다.</td>
                          </tr>
                          </c:if>  

                        </tbody>
                    </table>
                    <div class="board-btn" id="btnInsert">
                        <a href="#!">등록</a>
                    </div>
                  </div>

                  <div>
                    <nav aria-label="Page navigation" class="d-flex justify-content-center" style="width:100%">
                      <ul class="pagination pt-3" id="pagingList"></ul>
                    </nav>
                  </div>

                </article>
                
              </form>
            </div>
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

  <jsp:include page="/WEB-INF/jsp/include/footer_mgnt.jsp"></jsp:include>
  <jsp:include page="mgnt1301_js.jsp"></jsp:include>   

  </body>
</html>