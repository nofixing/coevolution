<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/mHeader.jsp"></jsp:include>

    <style>
      .form_height1 {
        height:calc(1.9rem + 2px);
      }

    </style>

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
              엑스포관리
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
              엑스포관리
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
                  엑스포관리
                </strong>
              </h3>
              <form>
                <div class="form_inner member page-area">
                  <div class="join-form-area">
                      <input type="hidden" name="ev_expo_id" id="ev_expo_id" value="${expo_dtl.ev_expo_id}"/>
                      <table class="basic-table">
                        <tr>
                            <th>엑스포 명칭</th>
                            <td>
                                <div class="form-inline">
                                    <input type="text" style="ime-mode:disabled" maxlength="100" id="ev_expo_nm" name="ev_expo_nm" class="input-box col-lg-6 col-9" placeholder="엑스포 명칭 입력하세요" value="${expo_dtl.ev_expo_nm}">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>엑스포 시작일시</th>
                            <td>
                                <div class="form-inline">
                                    <input type="date" class="form-control form-control-sm mb-2" id="expo_from_dt" name="expo_from_dt" value="${expo_dtl.expo_from_dt}" style="width:10rem">
                                    <select id="expo_from_hh" name="expo_from_hh" class="form-control form-control-sm mb-2" style="width:5rem">
                                      <c:forEach var="item" begin="0" end="23" step="1" varStatus="status">
                                        <option value='<c:choose><c:when test = "${item < 10}">0${item}</c:when><c:otherwise>${item}</c:otherwise></c:choose>'>
                                          <c:choose>
                                            <c:when test = "${item < 10}">
                                              0${item}
                                            </c:when>
                                            <c:otherwise>
                                              ${item}
                                            </c:otherwise>
                                          </c:choose>
                                        </option>
                                      </c:forEach>
                                    </select>
                                    <select id="expo_from_mm" name="expo_from_mm" class="form-control form-control-sm mb-2" style="width:5rem">
                                      <option value="00" <c:if test="${'00' eq expo_dtl.expo_from_mm}">selected</c:if>>00</option>
                                      <option value="30" <c:if test="${'30' eq expo_dtl.expo_from_mm}">selected</c:if>>30</option>
                                    </select>
                                </div>
                            </td>
                        </tr>                          
                        <tr>
                            <th>엑스포 종료일시</th>
                            <td>
                                <div class="form-inline">
                                    <input type="date" class="form-control form-control-sm mb-2" id="expo_to_dt" name="expo_to_dt" value="${expo_dtl.expo_to_dt}" style="width:10rem">
                                    <select id="expo_to_hh" name="expo_to_hh" class="form-control form-control-sm mb-2" style="width:5rem">
                                      <c:forEach var="item" begin="0" end="23" step="1" varStatus="status">
                                        <option value='<c:choose><c:when test = "${item < 10}">0${item}</c:when><c:otherwise>${item}</c:otherwise></c:choose>'>
                                          <c:choose>
                                            <c:when test = "${item < 10}">
                                              0${item}
                                            </c:when>
                                            <c:otherwise>
                                              ${item}
                                            </c:otherwise>
                                          </c:choose>
                                        </option>
                                      </c:forEach>
                                    </select>
                                    <select id="expo_to_mm" name="expo_to_mm" class="form-control form-control-sm mb-2" style="width:5rem">
                                      <option value="00" <c:if test="${'00' eq expo_dtl.expo_to_mm}">selected</c:if>>00</option>
                                      <option value="30" <c:if test="${'30' eq expo_dtl.expo_to_mm}">selected</c:if>>30</option>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>접수시작일</th>
                            <td>
                              <input type="date" class="form-control form-control-sm mb-2" id="apct_prod_from_dt" name="apct_prod_from_dt" value="${expo_dtl.apct_prod_from_dt}" style="width:10rem">
                            </td>
                        </tr>     
                        <tr>
                            <th>접수종료일</th>
                            <td>
                              <input type="date" class="form-control form-control-sm mb-2" id="apct_prod_to_dt" name="apct_prod_to_dt" value="${expo_dtl.apct_prod_to_dt}" style="width:10rem">
                            </td>
                        </tr>
                        <tr>
                            <th>사용여부</th>
                            <td>
                              <div class="tb-td">
                                <input type="hidden" id="use_yn"/>
                                <input type="radio" value="Y" name="use_yn" id="use_yn-1" <c:if test="${'N' ne expo_dtl.use_yn}">checked</c:if>><label for="use_yn-1"><span></span> 사용</label>
                                <input type="radio" value="N" name="use_yn" id="use_yn-2" <c:if test="${'N' eq expo_dtl.use_yn}">checked</c:if>><label for="use_yn-2"><span></span> 미사용</label>
                              </div>                            
                            </td>
                        </tr>                               
                      </table>

                      <div class="text-right pt-3">
                        <button type="button" class="basic-btn" id="btnList">목록</button>
                        <button type="button" class="basic-btn" id="btnUpdate">저장</button>
                      </div>
                        
                  </div>
                </div>
              </form>
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

  <jsp:include page="/WEB-INF/jsp/include/footer_mgnt.jsp"></jsp:include>
  <jsp:include page="mgnt1002_js.jsp"></jsp:include>   

  </body>
</html>