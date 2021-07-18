<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>

    <style>
      .form_height1 {
        height:calc(1.9rem + 2px);
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
              코드관리
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
              코드관리
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
                  코드관리
                </strong>
              </h3>

              <form name="form1" class="form-styled">

                <div class="form-row align-items-center">

                  <div class="col-sm-3">
                    <select class="form-control form-control-sm" id="code_clsf1" name="code_clsf1">
                      <option value="">선택</option>
                      <c:forEach var="list" items="${code_clsf1_list}">
                        <option value="${list.cd_id}" <c:if test="${code_clsf1 eq list.cd_id}">selected</c:if> >${list.cd_nm}</option>
                      </c:forEach>
                    </select>
                  </div>

                  <div class="col-sm-3">
                    <select class="form-control form-control-sm" id="code_clsf2" name="code_clsf2"> 
                      <option value="">선택</option>
                      <c:forEach var="list" items="${code_clsf2_list}">
                        <option value="${list.cd_id}" <c:if test="${code_clsf2 eq list.cd_id}">selected</c:if> >${list.cd_nm}</option>
                      </c:forEach>
                    </select>
                  </div>

                  <div class="col-sm-3">
                    <select class="form-control form-control-sm" id="code_clsf3" name="code_clsf3"> 
                      <option value="">선택</option>
                      <c:forEach var="list" items="${code_clsf3_list}">
                        <option value="${list.cd_id}" <c:if test="${code_clsf3 eq list.cd_id}">selected</c:if> >${list.cd_nm}</option>
                      </c:forEach>
                    </select>
                  </div>

                  <div class="col-sm-3 d-flex justify-content-end">
                    <button type="button" class="btn-outline-primary form-control form-control-sm" id="btnCodeSearch" style="width: 100px;">조회</button>
                  </div>

                </div> 
                
                <div class="form-row mt-3 d-flex justify-content-end">
                  <button type="button" class="btn-outline-primary form-control form-control-sm m-1" id="btnCodeNew" style="width: 100px;">신규</button>
                  <button type="button" class="btn-outline-primary form-control form-control-sm m-1" id="btnCodeSave" style="width: 100px;">저장</button>
                  <!--button type="button" class="btn-outline-primary form-control form-control-sm m-1" style="width: 100px;">삭제</button-->
                </div>
                

                <div class="table-responsive pt-3" style="overflow-x: auto; white-space:nowrap">
                  <table class="table table-striped table-hover table-sm border-bottom" id="tableList">
                    <thead class="table-light">
                      <tr>
                        <th scope="col" class="text-center">코드</th>
                        <th scope="col" class="text-left">코드명</th>
                        <th scope="col" class="text-center">상위코드</th>
                        <th scope="col" class="text-center">값1</th>
                        <th scope="col" class="text-center">값2</th>
                        <th scope="col" class="text-center">값3</th>
                        <th scope="col" class="text-center">순번</th>
                        <th scope="col" class="text-center">사용<br>여부</th>
                      </tr>
                    </thead>
                    <tbody id="codeList">
                      <input type="hidden" name="tot_cnt" id="tot_cnt" value="${fn:length(codelist)}"/>
                      <c:forEach var="list" items="${codelist}" varStatus="status">
                      <tr>
                        <td class="text-center">
                          <input type="hidden" id="cd_id_${status.index}" value="${list.cd_id}"/>
                          ${list.cd_id}
                        </td>
                        <td class="text-left"><input type="text"  class="form-control-sm" value="${list.cd_nm}" id="cd_nm_${list.cd_id}" name="cd_nm_${list.cd_id}" style="width:150px"/></td>
                        <td class="text-center"><input type="text"  maxlength="6" class="form-control-sm" value="${list.upper_cd_id}" id="upper_cd_id_${list.cd_id}" name="upper_cd_id_${list.cd_id}" style="width:75px"/></td>
                        <td class="text-center"><input type="text"  class="form-control-sm" value="${list.cd_val1}" id="cd_val1_${list.cd_id}" name="cd_val1_${list.cd_id}" style="width:80px"/></td>
                        <td class="text-center"><input type="text"  class="form-control-sm" value="${list.cd_val2}" id="cd_val2_${list.cd_id}" name="cd_val2_${list.cd_id}" style="width:80px"/></td>
                        <td class="text-center"><input type="text"  class="form-control-sm" value="${list.cd_val3}" id="cd_val3_${list.cd_id}" name="cd_val3_${list.cd_id}" style="width:80px"/></td>
                        <td class="text-center"><input type="number"  class="form-control-sm" value="${list.priority}" id="priority_${list.cd_id}" name="priority_${list.cd_id}" style="width:50px"/></td>
                        <td class="text-center">
                          <select class="form-control-sm" id="use_yn_${list.cd_id}">
                            <option value="Y" <c:if test="${list.use_yn eq 'Y'}">selected</c:if>>Y</option>
                            <option value="N" <c:if test="${list.use_yn eq 'N'}">selected</c:if>>N</option>
                          </select>
                        </td>
                      </tr>   
                      </c:forEach>
                      <c:if test="${fn:length(codelist) == 0}">
                      <tr>
                        <td scope="row" class="text-center" colspan="8">조회된 내용이 없습니다.</td>
                      </tr>
                      </c:if> 
                    </tbody>
                  </table>
                </div>

            </form>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="mgnt0601_js.jsp"></jsp:include>   

  </body>
</html>