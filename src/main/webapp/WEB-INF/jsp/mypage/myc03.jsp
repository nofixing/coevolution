<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
              <a href="#">Home</a>
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
    <section class="section pt-4">
      <div class="container">
        <div class="row">
          <div class="col-md-2">
            
             <!--left Menu -->
            <jsp:include page="/WEB-INF/jsp/include/cLeftMenu.jsp"></jsp:include>

          </div>
          <div class="col-md-10">

            <!-- 즐겨찾기 -->
            <div class="pb-5 mb-5" id="animation">
              
              <!-- Heading -->
              <h3 class="mb-4">
                상담문의 내역
              </h3>

              <div class="form-styled">

                  
                <!--검색조건-->
                <form class="pt-4 pb-3">
                  <div class="form-row align-items-center">
                    <div class="col-sm-2">
                      <select class="form-control form-control-sm mb-2" id="inlineFormCustomSelect">
                        <option selected>진행상태</option>
                        <option value="1">답변대기</option>
                        <option value="2">답변완료</option>
                      </select>
                    </div>

                    <div class="col-sm-2">
                      <select class="form-control form-control-sm mb-2" id="inlineFormCustomSelect">
                        <option selected>전체</option>
                        <option value="1">제목</option>
                        <option value="2">내용</option>
                      </select>
                    </div>

                    <div class="col-sm-6">
                      <input type="text" class="form-control form-control-sm mb-2" id="inlineFormInput" >
                    </div>

                    <div class="col-sm-2">
                      <button type="button" class="btn-outline-primary form-control form-control-sm mb-2">조회</button>
                    </div>
                  </div>
                </form>            

                <!-- 총건수 -->
                <span class="text-muted small">
                  (총 1,000 건)
                </span>
                <table class="table table-striped table-hover table-sm border-bottom" onClick="document.location.hrft='/mypage/myc031'">
                  <thead class="table-light">
                    <tr>
                      <th scope="col" width="10%" class="text-center">번호</th>
                      <th scope="col" width="40%" class="text-left">제목</th>
                      <th scope="col" width="20%" class="text-center">회원</th>
                      <th scope="col" width="15%" class="text-center">등록일</th>
                      <th scope="col" width="15%" class="text-center">진행상태</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">
                        <div style="overflow: hidden;text-overflow: ellipsis; white-space: nowrap; width:250px;">
                          상담문의 내용입니다.상담문의 내용입니다.상담문의 내용입니다.상담문의 내용입니다.상담문의 내용입니다.
                        </div>
                      </td>
                      <td class="text-center">주제 색션 A</td>
                      <td class="text-center">2021-04-01</td>
                      <td class="text-center">답변대기</td>
                    </tr>        
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">상담문의 내용입니다.</td>
                      <td class="text-center">주제 색션 A</td>
                      <td class="text-center">2021-04-01</td>
                      <td class="text-center">답변대기</td>
                    </tr>  
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">상담문의 내용입니다.</td>
                      <td class="text-center">주제 색션 A</td>
                      <td class="text-center">2021-04-01</td>
                      <td class="text-center">답변대기</td>
                    </tr>        
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">상담문의 내용입니다.</td>
                      <td class="text-center">주제 색션 A</td>
                      <td class="text-center">2021-04-01</td>
                      <td class="text-center">답변대기</td>
                    </tr>  
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">상담문의 내용입니다.</td>
                      <td class="text-center">주제 색션 A</td>
                      <td class="text-center">2021-04-01</td>
                      <td class="text-center">답변대기</td>
                    </tr>        
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">상담문의 내용입니다.</td>
                      <td class="text-center">주제 색션 A</td>
                      <td class="text-center">2021-04-01</td>
                      <td class="text-center">답변대기</td>
                    </tr>  
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">상담문의 내용입니다.</td>
                      <td class="text-center">주제 색션 A</td>
                      <td class="text-center">2021-04-01</td>
                      <td class="text-center">답변대기</td>
                    </tr>        
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">상담문의 내용입니다.</td>
                      <td class="text-center">주제 색션 A</td>
                      <td class="text-center">2021-04-01</td>
                      <td class="text-center">답변대기</td>
                    </tr>  
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">상담문의 내용입니다.</td>
                      <td class="text-center">주제 색션 A</td>
                      <td class="text-center">2021-04-01</td>
                      <td class="text-center">답변대기</td>
                    </tr>        
                    <tr>
                      <th scope="row" class="text-center">1</th>
                      <td class="text-left">상담문의 내용입니다.</td>
                      <td class="text-center">주제 색션 A</td>
                      <td class="text-center">2021-04-01</td>
                      <td class="text-center">답변대기</td>
                    </tr>                                                                                                                                                                                                                                                                                
                  </tbody>
                </table>


                <!-- paging -->
                <div class="table-responsive d-flex justify-content-center">
                  <nav aria-label="Page navigation">
                    <ul class="pagination pt-3">
                      <li class="page-item">
                        <a class="page-link" href="#">Previous</a>
                      </li>
                      <li class="page-item">
                        <a class="page-link" href="#">1</a>
                      </li>
                      <li class="page-item">
                        <a class="page-link" href="#">2</a>
                      </li>
                      <li class="page-item">
                        <a class="page-link" href="#">3</a>
                      </li>
                      <li class="page-item">
                        <a class="page-link" href="#">Next</a>
                      </li>
                    </ul>
                  </nav>
                </div>
              
              
              </div>
              
            </div>
            
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </section>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>

  </body>
</html>