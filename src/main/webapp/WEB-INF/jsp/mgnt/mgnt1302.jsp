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

    <!-- BREADCRUMB
    ================================================== -->
    <nav class="breadcrumb" style="width:100%">
      <div class="container">
        <div class="row align-items-center">
          <div class="col">
            
            <!-- Heading -->
            <h5 class="breadcrumb-heading">
              이벤트관리
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
              프로그램관리
            </span>       
            <span class="breadcrumb-item active">
              이벤트관리
            </span>            
          
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>
    
    <!-- CONTENT
    ================================================== -->
    <section class="section pt-0 pl-5 pr-5">
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
                    <div class="write">
                        <form action="">
                            <table class="base-table">
                                <colgroup>
                                    <col width="20%">
                                </colgroup>
                                <tr>
                                    <th>구분<sup>*</sup></th>
                                    <td>
                                      <select name="board_clsf_dtl_cd" id="board_clsf_dtl_cd" class="w-100">
                                          <option value="">선택</option>
                                          <c:forEach var="list" items="${boardClsfDtlCdList}">
                                          <option value="${list.cd_id}" >${list.cd_nm}</option>
                                          </c:forEach>
                                      </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>이벤트 명<sup>*</sup></th>
                                    <td>
                                        <input type="text" class="w-100" name="board_subject" id="board_subject" maxlength="50">
                                    </td>
                                </tr>
                                <tr>
                                    <th>이벤트 기간<sup>*</sup></th>
                                    <td>
                                        <input type="date" class="form-control-sm" name="evnt_fr_dt" id="evnt_fr_dt">
                                        <span class="pl-2 pr-2">~</span>
                                        <input type="date" class="form-control-sm" name="evnt_to_dt" id="evnt_to_dt">
                                    </td>
                                </tr>
                                <tr>
                                    <th>신청 기간<sup>*</sup></th>
                                    <td>
                                        <span>
                                            <input type="date" class="form-control-sm" name="req_fr_dt" id="req_fr_dt">
                                            <select name="req_fr_hhmm" id="req_fr_hhmm">
                                                <option value="00">00시</option>
                                                <option value="01">01시</option>
                                                <option value="02">02시</option>
                                                <option value="03">03시</option>
                                                <option value="04">04시</option>
                                                <option value="05">05시</option>
                                                <option value="06">06시</option>
                                                <option value="07">07시</option>
                                                <option value="08">08시</option>
                                                <option value="09">09시</option>
                                                <option value="10">10시</option>
                                                <option value="11">11시</option>
                                                <option value="12">12시</option>
                                                <option value="13">13시</option>
                                                <option value="14">14시</option>
                                                <option value="15">15시</option>
                                                <option value="16">16시</option>
                                                <option value="17">17시</option>
                                                <option value="18">18시</option>
                                                <option value="19">19시</option>
                                                <option value="20">20시</option>
                                                <option value="21">21시</option>
                                                <option value="22">22시</option>
                                                <option value="23">23시</option>
                                            </select>
                                        </span>
                                        <span class="pl-2 pr-2">~</span>
                                        <span>
                                            <input type="date" class="form-control-sm" name="req_to_dt" id="req_to_dt">
                                            <select name="req_to_hhmm" id="req_to_hhmm">
                                                <option value="00">00시</option>
                                                <option value="01">01시</option>
                                                <option value="02">02시</option>
                                                <option value="03">03시</option>
                                                <option value="04">04시</option>
                                                <option value="05">05시</option>
                                                <option value="06">06시</option>
                                                <option value="07">07시</option>
                                                <option value="08">08시</option>
                                                <option value="09">09시</option>
                                                <option value="10">10시</option>
                                                <option value="11">11시</option>
                                                <option value="12">12시</option>
                                                <option value="13">13시</option>
                                                <option value="14">14시</option>
                                                <option value="15">15시</option>
                                                <option value="16">16시</option>
                                                <option value="17">17시</option>
                                                <option value="18">18시</option>
                                                <option value="19">19시</option>
                                                <option value="20">20시</option>
                                                <option value="21">21시</option>
                                                <option value="22">22시</option>
                                                <option value="23">23시</option>
                                            </select>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>노출 상태<sup>*</sup></th>
                                    <td>
                                        <span>
                                            <input type="radio" id="use_yn1" name="use_yn" value="Y" checked>
                                            <label for="use_yn1">노출</label>
                                        </span>
                                        <span>
                                            <input type="radio" id="use_yn2" name="use_yn" value="N">
                                            <label for="use_yn2">비노출</label>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>노출 구분<sup>*</sup></th>
                                    <td>
                                        <span>
                                            <input type="radio" id="event_show_clsf1" name="event_show_clsf" value="109001" checked>
                                            <label for="event_show_clsf1">알림 메시지 노출</label>
                                        </span>
                                        <span>
                                            <input type="radio" id="event_show_clsf2" name="event_show_clsf" value="109002">
                                            <label for="event_show_clsf2">이벤트 내용 노출</label>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>이벤트URL</th>
                                    <td>
                                        <input type="text" id="ref_url" name="ref_url" class="w-100" maxlength="500">
                                    </td>
                                </tr>
                                <tr>
                                    <th>이벤트알림메시지</th>
                                    <td>
                                        <textarea name="event_alert" id="event_alert" cols="30" rows="3" maxlength="500"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th>소개</th>
                                    <td>
                                        <textarea name="board_content" id="board_content" cols="30" rows="10"></textarea>
                                    </td>
                                </tr>
                            </table>
                            <div class="write-btn" style="justify-content:right">
                                <button type="button" id="btnList">목록</button>
                                <button type="button" id="btnSave">저장</button>
                                <button type="button" id="btnDelete">삭제</button>
                            </div>
                        </form>
                    </div>
                </article>

                
              </form>
            </div>
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

  <jsp:include page="/WEB-INF/jsp/include/footer_mgnt.jsp"></jsp:include>
  <jsp:include page="mgnt1302_js.jsp"></jsp:include>   

  </body>
</html>