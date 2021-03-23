<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>
  </head>
  <body>
  <form>
    <input type="hidden" id="agree_1" name="agree_1" value="${agree_1}"/>
    <input type="hidden" id="agree_2" name="agree_2" value="${agree_2}"/>
    <input type="hidden" id="agree_3" name="agree_3" value="${agree_3}"/>
    <input type="hidden" id="cust_clsf_cd" name="cust_clsf_cd" value="202001"/>

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
              참관등록
            </h5>

          </div>
          <div class="col-auto">

            <!-- Breadcrumb -->
            <span class="breadcrumb-item">
              <a href="/index">Home</a>
            </span>
            <span class="breadcrumb-item active">
              참관등록
            </span>

          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </nav>



    <!-- 진행순서
      ================================================== -->
    <section class="section">
      <div class="container">
        <div class="form join_form">
          <div class="form_head">
            <p>참관등록</p>
          </div>
          <div class="join_inner">
            <div class="register_head clearfix">
              <ul class="register_seq">
                <li><span>Step 01</span> 약관동의</li>
                <li class="on"><span>Step 02</span> 정보입력</li>
                <li><span>Step 03</span> 가입완료</li>
              </ul>
            </div>
            <div class="form_inner member page-area">
                <div class="join-form-area">
                  <form action="">
                      <div class="form-box">
                          <div class="top-txt"><span>*</span> 필수 작성 항목 입니다</div>
                          <div class="join-form-tb">
                              <div class="tb-tr tr-half">
                                  <div class="half-box">
                                      <div class="tb-th"><span>*</span> 이름</div>
                                      <div class="tb-td">
                                          <input type="text" maxlength="20" class="input-box" placeholder="이름을 입력하세요" id="cust_nm" name="cust_nm">
                                      </div>
                                  </div>
                                  <div class="half-box">
                                      <div class="tb-th"><span>*</span> 성별</div>
                                      <div class="tb-td">
                                          <input type="radio" name="gender_cd" id="gender_cd_203001" value="203001" checked><label for="gender_cd_203001"><span></span> <p>남자</p></label>
                                          <input type="radio" name="gender_cd" id="gender_cd_203002" value="203002"><label for="gender_cd_203002"><span></span> <p>여자</p></label>
                                      </div>
                                  </div>
                              </div>
                              
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 연령대</div>
                                  <div class="tb-td">
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204001" value="204001" checked>
                                      <label for="age_cd_204001"><span></span> <p>20대 미만</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204002" value="204002">
                                      <label for="age_cd_204002"><span></span> <p>20대</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204003" value="204003">
                                      <label for="age_cd_204003"><span></span> <p>30대</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204004" value="204004">
                                      <label for="age_cd_204004"><span></span> <p>40대</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204005" value="204005">
                                      <label for="age_cd_204005"><span></span> <p>50대</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204006" value="204006">
                                      <label for="age_cd_204006"><span></span> <p>60대</p></label>
                                      
                                      <input type="radio" name="age_cd" id="age_cd_204007" value="204007">
                                      <label for="age_cd_204007"><span></span> <p>60대 초과</p></label>
                                      
                                  </div>
                              </div>
      
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span>소속</div>
                                  <div class="tb-td">
                                          <input type="text" name="company_nm" id="company_nm" maxlength="50" class="input-box" placeholder="소속을 입력하세요">
                                  </div>
                              </div>						
                              <div class="tb-tr tr-half">
                                  <div class="half-box">
                                      <div class="tb-th"><span>*</span>부서</div>
                                      <div class="tb-td">
                                          <input type="text" name="dept_nm" id="dept_nm" maxlength="50" class="input-box" placeholder="부서을 입력하세요">
                                      </div>
                                  </div>
                                  <div class="half-box">
                                      <div class="tb-th">직급</div>
                                      <div class="tb-td">
                                          <input type="text" name="posn_nm" id="posn_nm" maxlength="50" class="input-box" placeholder="직급을 입력하세요">
                                      </div>
                                  </div>
                              </div>
                              <div class="tb-tr tr-half">
                                <div class="half-box">
                                  <div class="tb-th"><span>*</span> 휴대폰번호</div>
                                  <div class="tb-td">
                                      <input type="text" name="hp_no" id="hp_no" maxlength="13" class="input-box" placeholder="-없이 숫자만 입력하세요">
                                  </div>
                                </div>
                                <div class="half-box">
                                  <div class="tb-th"> 연락처</div>
                                  <div class="tb-td">
                                      <input type="text" name="tel_no" id="tel_no" maxlength="13" class="input-box" placeholder="연락처를 입력하세요">
                                  </div>
                                </div>
                              </div>
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 이메일 주소</div>
                                  <div class="tb-td">
                                      <div class="input-email">
                                          <div class="in-box"><input type="text" name="email_id1" id="email_id1" value="${email_id1}" maxlength="50" class="input-box"></div>
                                          <div class="in-box"><input type="text" name="email_id2" id="email_id2" value="${email_id2}" maxlength="50" class="input-box"></div>
                                          <div class="select-box">
                                              <select class="custom-select-sm" id="email_clsf">
                                                  <option value="" selected>직접입력</option>
                                                  <option value="naver.com"> naver.com</option>
                                                  <option value="hanmail.net"> hanmail.net</option>
                                                  <option value="daum.net"> daum.net</option>
                                                  <option value="nate.com"> nate.com</option>
                                                  <option value="gmail.com"> gmail.com</option>
                                              </select>
                                          </div>									
                                      </div>
                                  </div>
                              </div>
                              <div class="tb-tr tr-half">
                                  <div class="half-box">
                                      <div class="tb-th"><span>*</span> 국가</div>
                                      <div class="tb-td">
                                          <div class="select-box">
                                              <select name="country_cd" class="custom-select-sm" id="country_cd">
                                                  <option value="">선택</option>
                                                  <option value="88">가나
                                                  </option><option value="84">가봉
                                                  </option><option value="99">가이아나
                                                  </option><option value="85">감비아
                                                  </option><option value="96">건지섬
                                                  </option><option value="93">과델로프
                                                  </option><option value="95">과테말라
                                                  </option><option value="94">괌
                                                  </option><option value="102">교황청
                                                  </option><option value="92">그레나다
                                                  </option><option value="86">그루지아
                                                  </option><option value="90">그리스
                                                  </option><option value="91">그린랜드
                                                  </option><option value="98">기네비소
                                                  </option><option value="97">기니
                                                  </option><option value="160">나미비아
                                                  </option><option value="161">나우르
                                                  </option><option value="169">나이지리아
                                                  </option><option value="210">남아프리카
                                                  </option><option value="211">남조지아 &amp; 남샌드위치 군도
                                                  </option><option value="163">네덜란드
                                                  </option><option value="164">네덜란드 열도
                                                  </option><option value="162">네팔
                                                  </option><option value="173">노르웨이
                                                  </option><option value="171">노폴크 아일랜드
                                                  </option><option value="165">뉴 칼레도니아
                                                  </option><option value="166">뉴질랜드
                                                  </option><option value="170">니우에
                                                  </option><option value="168">니제르
                                                  </option><option value="167">니카라과
                                                  </option><option value="221">대만
                                                  </option><option value="123" selected="">대한민국
                                                  </option><option value="65">덴마크
                                                  </option><option value="67">도미니카
                                                  </option><option value="68">도미니카 공화국
                                                  </option><option value="87">독일
                                                  </option><option value="126">라오스
                                                  </option><option value="130">라이베리아
                                                  </option><option value="127">라트비아
                                                  </option><option value="190">러시아 연방
                                                  </option><option value="128">레바논
                                                  </option><option value="129">레소토
                                                  </option><option value="189">루마니아
                                                  </option><option value="191">루안다
                                                  </option><option value="134">룩셈부르그
                                                  </option><option value="131">리비아
                                                  </option><option value="133">리투아니아
                                                  </option><option value="132">리히텐슈타인
                                                  </option><option value="137">마다카스카르
                                                  </option><option value="145">마샬군도
                                                  </option><option value="136">마세도니아
                                                  </option><option value="240">마이너 아우틀링 합중국 군도
                                                  </option><option value="151">마이크로네시아
                                                  </option><option value="135">마카오
                                                  </option><option value="146">마티니크
                                                  </option><option value="138">말라위
                                                  </option><option value="139">말레이시아
                                                  </option><option value="141">말레이시아 라부안(사전승인 받은 경우)
                                                  </option><option value="140">말레이시아 라부안(사전승인 받지 않은 경우)
                                                  </option><option value="143">말리
                                                  </option><option value="112">맨섬
                                                  </option><option value="149">메요트
                                                  </option><option value="150">멕시코
                                                  </option><option value="153">모나코
                                                  </option><option value="157">모로코
                                                  </option><option value="148">모리셔스
                                                  </option><option value="147">모리타니
                                                  </option><option value="158">모잠비크
                                                  </option><option value="155">몬테네그로
                                                  </option><option value="156">몬트세라트
                                                  </option><option value="152">몰도바
                                                  </option><option value="142">몰디브
                                                  </option><option value="144">몰타
                                                  </option><option value="154">몽골
                                                  </option><option value="239">미국
                                                  </option><option value="247">미령 버진군도
                                                  </option><option value="159">미얀마
                                                  </option><option value="243">바누아투
                                                  </option><option value="24">바레인
                                                  </option><option value="26">바베이도스
                                                  </option><option value="23">바하마
                                                  </option><option value="25">방글라데시
                                                  </option><option value="31">버뮤다
                                                  </option><option value="244">베네주엘라
                                                  </option><option value="30">베닝
                                                  </option><option value="245">베트남
                                                  </option><option value="28">벨기에
                                                  </option><option value="27">벨로루시
                                                  </option><option value="29">벨리제
                                                  </option><option value="36">보빗군도
                                                  </option><option value="34">보스니아-헤르체고비나
                                                  </option><option value="35">보츠와나
                                                  </option><option value="33">볼리비아
                                                  </option><option value="42">부룬디
                                                  </option><option value="41">부르키나 파소
                                                  </option><option value="32">부탄
                                                  </option><option value="172">북마리아나 군도
                                                  </option><option value="122">북한
                                                  </option><option value="40">불가리아
                                                  </option><option value="81">불령 가이아나
                                                  </option><option value="83">불령 남부지역
                                                  </option><option value="188">불령 리유니온,코모도 제도
                                                  </option><option value="82">불령 폴리네시아
                                                  </option><option value="37">브라질
                                                  </option><option value="39">브루나이
                                                  </option><option value="197">사모아
                                                  </option><option value="200">사우디아라비아
                                                  </option><option value="63">사이프러스
                                                  </option><option value="198">산마리노
                                                  </option><option value="199">상토메 프린스페
                                                  </option><option value="249">서사하라
                                                  </option><option value="201">세네갈
                                                  </option><option value="202">세르비아
                                                  </option><option value="203">세이쉘
                                                  </option><option value="194">세인트 루시아
                                                  </option><option value="196">세인트 빈센트 그레나딘
                                                  </option><option value="193">세인트 키츠 네비스
                                                  </option><option value="195">세인트 피레 미켈론
                                                  </option><option value="192">세인트 헬레나
                                                  </option><option value="209">소말리아
                                                  </option><option value="208">솔로몬 군도
                                                  </option><option value="214">수단
                                                  </option><option value="215">수리남
                                                  </option><option value="213">스리랑카
                                                  </option><option value="216">스발비드 군도
                                                  </option><option value="217">스와질랜드
                                                  </option><option value="218">스웨덴
                                                  </option><option value="219">스위스
                                                  </option><option value="212">스페인
                                                  </option><option value="206">슬로바키아
                                                  </option><option value="207">슬로베니아
                                                  </option><option value="220">시리아
                                                  </option><option value="204">시에라 리온
                                                  </option><option value="205">싱가포르
                                                  </option><option value="237">아랍에미리트 연합
                                                  </option><option value="19">아루바
                                                  </option><option value="18">아르메니아
                                                  </option><option value="17">아르헨티나
                                                  </option><option value="11">아메리칸 사모아
                                                  </option><option value="106">아이슬란드
                                                  </option><option value="100">아이티
                                                  </option><option value="111">아일랜드
                                                  </option><option value="22">아제르바이잔
                                                  </option><option value="7">아프카니스탄
                                                  </option><option value="12">안도라
                                                  </option><option value="15">안타티카
                                                  </option><option value="16">안티가 바부다
                                                  </option><option value="9">알바니아
                                                  </option><option value="10">알제리
                                                  </option><option value="13">앙골라
                                                  </option><option value="14">앙귈라
                                                  </option><option value="73">에리트리아
                                                  </option><option value="74">에스토니아
                                                  </option><option value="69">에쿠아도르
                                                  </option><option value="71">엘살바도르
                                                  </option><option value="238">영국
                                                  </option><option value="246">영령 버진군도
                                                  </option><option value="38">영령 인도양
                                                  </option><option value="47">영령 케이먼 군도
                                                  </option><option value="250">예맨
                                                  </option><option value="174">오만
                                                  </option><option value="21">오스트리아
                                                  </option><option value="103">온두라스
                                                  </option><option value="8">올란드제도
                                                  </option><option value="248">왈라스 &amp; 퓨투나 군도
                                                  </option><option value="118">요르단
                                                  </option><option value="235">우간다
                                                  </option><option value="241">우루과이
                                                  </option><option value="242">우즈베크
                                                  </option><option value="236">우크라이나
                                                  </option><option value="75">이디오피아
                                                  </option><option value="110">이라크
                                                  </option><option value="109">이란
                                                  </option><option value="113">이스라엘
                                                  </option><option value="70">이집트
                                                  </option><option value="114">이탈리아
                                                  </option><option value="107">인도
                                                  </option><option value="108">인도네시아
                                                  </option><option value="116">일본
                                                  </option><option value="115">자마이카
                                                  </option><option value="251">잠비아
                                                  </option><option value="117">저지섬
                                                  </option><option value="72">적도 기니
                                                  </option><option value="51">중국
                                                  </option><option value="48">중앙아프리카
                                                  </option><option value="66">지부티
                                                  </option><option value="89">지브랄타
                                                  </option><option value="252">짐바브웨
                                                  </option><option value="49">챠드
                                                  </option><option value="64">체코공화국
                                                  </option><option value="50">칠레
                                                  </option><option value="45">카나다
                                                  </option><option value="44">카메룬
                                                  </option><option value="46">카보 베르데
                                                  </option><option value="119">카자흐
                                                  </option><option value="187">카타르
                                                  </option><option value="43">캄보디아
                                                  </option><option value="120">케냐
                                                  </option><option value="55">코모로스
                                                  </option><option value="53">코스 군도
                                                  </option><option value="59">코스타리카
                                                  </option><option value="60">코트디봐르
                                                  </option><option value="54">콜롬비아
                                                  </option><option value="56">콩고공화국
                                                  </option><option value="57">콩고민주공화국
                                                  </option><option value="62">쿠바
                                                  </option><option value="124">쿠웨이트
                                                  </option><option value="58">쿡 아일랜드
                                                  </option><option value="61">크로아티아
                                                  </option><option value="52">크리스마스 아일랜드
                                                  </option><option value="125">키르기스
                                                  </option><option value="121">키리바티
                                                  </option><option value="222">타지크
                                                  </option><option value="223">탄자니아
                                                  </option><option value="224">태국
                                                  </option><option value="231">터키
                                                  </option><option value="226">토고
                                                  </option><option value="227">토켈라우
                                                  </option><option value="228">통가
                                                  </option><option value="233">투르크 &amp; 카이코스 군도
                                                  </option><option value="232">투르크멘
                                                  </option><option value="234">투발루
                                                  </option><option value="230">튀니지
                                                  </option><option value="229">트리니다드 토바고
                                                  </option><option value="225">티모르
                                                  </option><option value="178">파나마
                                                  </option><option value="180">파라과이
                                                  </option><option value="77">파로에 군도
                                                  </option><option value="175">파키스탄
                                                  </option><option value="179">파푸아 뉴기니
                                                  </option><option value="176">팔라우
                                                  </option><option value="177">팔레스타인   
                                                  </option><option value="181">페루
                                                  </option><option value="185">포루투갈
                                                  </option><option value="76">포클랜드 군도
                                                  </option><option value="184">폴란드
                                                  </option><option value="186">푸에르토리코
                                                  </option><option value="80">프랑스
                                                  </option><option value="78">피지
                                                  </option><option value="183">피트카이른
                                                  </option><option value="79">핀란드
                                                  </option><option value="182">필리핀
                                                  </option><option value="101">허드 앤 맥도날드 군도
                                                  </option><option value="105">헝가리
                                                  </option><option value="20">호주
                                                  </option><option value="104">홍콩
                                              </option></select>
                                          </div>	
                                      </div>
                                  </div>
                                  <div class="half-box">
                                      <div class="tb-th"><span>*</span> 지역(시/도)</div>
                                      <div class="tb-td">
                                          <input type="text" name="city_nm" id="city_nm" maxlength="50" class="input-box" placeholder="지역(시/도)을 입력하세요">
                                      </div>
                                  </div>
                              </div>
                              <div class="tb-tr">
                                  <div class="tb-th">주소</div>
                                  <div class="tb-td">
                                      <input type="text" name="addr_1" id="addr_1" maxlength="100" class="input-box input-w" placeholder="주소">
                                      <input type="hidden" name="addr_2" id="addr_2" class="input-box input-w" placeholder="주소">
                                  </div>
                              </div>
                              
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 방문타입</div>
                                  <div class="tb-td">
                                      <input type="radio" name="visit_pups_cd" id="visit_pups_cd_205001" value="205001" checked><label for="visit_pups_cd_205001"><span></span> <p>일반관람</p></label>
                                      <input type="radio" name="visit_pups_cd" id="visit_pups_cd_205002" value="205002"><label for="visit_pups_cd_205002"><span></span> <p>비즈니스</p></label>
                                      <input type="radio" name="visit_pups_cd" id="visit_pups_cd_205003" value="205003"><label for="visit_pups_cd_205003"><span></span> <p>기자(취재)</p></label>
                                      <input type="radio" name="visit_pups_cd" id="visit_pups_cd_205004" value="205004"><label for="visit_pups_cd_205004"><span></span> <p>혁신제품상담</p></label>
                                  </div>
                              </div>
                              <div class="tb-tr">
                                <div class="tb-th">추천인(ID) 등록</div>
                                <div class="tb-td">
                                    <input type="text"  name="rcmder_cust_id" id="rcmder_cust_id" maxlength="20" class="input-box" placeholder="">
                                    <div class="chk-btn idchk-btn" name="search_rcmder_cust_id" id="search_rcmder_cust_id"><a href="#!">추천인 검색</a></div>
                                    <p class="notice">※ 추천인(ID) 등록 시 이벤트 참여 가능한 뱃지를 제공해드립니다.</p>
                                </div>
                            </div>
                          </div>
                      </div>
                      <div class="form-box">
                          <div class="top-txt"><span>*</span> 아래 질문을 모두 체크해 주십시오</div>
                          <div class="join-form-tb">
                              <!-- 201117추가-->
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 관심분야</div>
                                  <div class="tb-td">
                                      <div class="general_chk_box">
                                          <ul class="input-chk">
                                              
                                              <li><input type="checkbox" name="S206000" id="S206001" value="206001"> <label for="S206001"><span></span><p>전기자동차 국가별관</p></label></li>
                                              <li><input type="checkbox" name="S206000" id="S206002" value="206002"> <label for="S206002"><span></span><p>전기자동차 주제별관</p></label></li>
                                              <li><input type="checkbox" name="S206000" id="S206003" value="206003"> <label for="S206003"><span></span><p>전기자동차</p></label></li>
                                              <li><input type="checkbox" name="S206000" id="S206004" value="206004"> <label for="S206004"><span></span><p>관람가이드</p></label></li>
                                              <li><input type="checkbox" name="S206000" id="S206005" value="206005"> <label for="S206005"><span></span><p>부스</p></label></li>
                                              <li><input type="checkbox" name="S206000" id="S206006" value="206006"> <label for="S206006"><span></span><p>기타</p></label></li>
                                              
                                          </ul>
                                      </div>
                                  </div>
                              </div>
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 종사분야</div>
                                  <div class="tb-td">
                                      <div class="general_chk_box">
                                          <ul class="input-chk">
                                              
                                              <li><input type="checkbox" name="S207000" id="S207001" value="207001"> <label for="S207001"><span></span><p>제조업</p></label></li>
                                              <li><input type="checkbox" name="S207000" id="S207002" value="207002"> <label for="S207002"><span></span><p>무역업</p></label></li>
                                              <li><input type="checkbox" name="S207000" id="S207003" value="207003"> <label for="S207003"><span></span><p>유통업</p></label></li>
                                              <li><input type="checkbox" name="S207000" id="S207004" value="207004"> <label for="S207004"><span></span><p>정부/공공기관</p></label></li>
                                              <li><input type="checkbox" name="S207000" id="S207005" value="207005"> <label for="S207005"><span></span><p>금융/투자</p></label></li>
                                              <li><input type="checkbox" name="S207000" id="S207006" value="207006"> <label for="S207006"><span></span><p>대학/연구/교육기관</p></label></li>
                                              <li><input type="checkbox" name="S207000" id="S207007" value="207007"> <label for="S207007"><span></span><p>언론/출판업</p></label></li>
                                              <li><input type="checkbox" name="S207000" id="S207008" value="207008"> <label for="S207008"><span></span><p>서비스업</p></label></li>
                                              <li><input type="checkbox" name="S207000" id="S207009" value="207009"> <label for="S207009"><span></span><p>학생</p></label></li>
                                              <li><input type="checkbox" name="S207000" id="S207010" value="207010"> <label for="S207010"><span></span><p>기타</p></label></li>
                                              
                                          </ul>
                                      </div>
                                  </div>
                              </div>
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 업무(구매)권한</div>
                                  <div class="tb-td">
                                      <div class="general_chk_box">
                                          <ul class="input-chk">
                                              
                                              <li><input type="checkbox" name="S208000" id="S208001" value="208001"> <label for="S208001"><span></span><p>기업가/대표자/프리랜서</p></label></li>
                                              <li><input type="checkbox" name="S208000" id="S208002" value="208002"> <label for="S208002"><span></span><p>부사장/공공기관장</p></label></li>
                                              <li><input type="checkbox" name="S208000" id="S208003" value="208003"> <label for="S208003"><span></span><p>임원/지점장/공공기관임원</p></label></li>
                                              <li><input type="checkbox" name="S208000" id="S208004" value="208004"> <label for="S208004"><span></span><p>부서장/그룹장/팀장</p></label></li>
                                              <li><input type="checkbox" name="S208000" id="S208005" value="208005"> <label for="S208005"><span></span><p>직원/공무원/기능공</p></label></li>
                                              <li><input type="checkbox" name="S208000" id="S208006" value="208006"> <label for="S208006"><span></span><p>교수/교사/강사/연구원</p></label></li>
                                              <li><input type="checkbox" name="S208000" id="S208007" value="208007"> <label for="S208007"><span></span><p>학생/수강생</p></label></li>
                                              <li><input type="checkbox" name="S208000" id="S208008" value="208008"> <label for="S208008"><span></span><p>업무권한없음</p></label></li>
                                              
                                          </ul>
                                      </div>
                                  </div>
                              </div>
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 방문목적</div>
                                  <div class="tb-td">
                                      <div class="general_chk_box">
                                          <ul class="input-chk">
                                              
                                              <li><input type="checkbox" name="S209000" id="S209001" value="209001"> <label for="S209001"><span></span><p>구매/비지니스상담</p></label></li>
                                              <li><input type="checkbox" name="S209000" id="S209002" value="209002"> <label for="S209002"><span></span><p>일반관람</p></label></li>
                                              <li><input type="checkbox" name="S209000" id="S209003" value="209003"> <label for="S209003"><span></span><p>시장조사</p></label></li>
                                              <li><input type="checkbox" name="S209000" id="S209004" value="209004"> <label for="S209004"><span></span><p>수출입알선</p></label></li>
                                              <li><input type="checkbox" name="S209000" id="S209005" value="209005"> <label for="S209005"><span></span><p>기술/정보수집</p></label></li>
                                              <li><input type="checkbox" name="S209000" id="S209006" value="209006"> <label for="S209006"><span></span><p>기타</p></label></li>
                                              
                                          </ul>
                                      </div>
                                  </div>
                              </div>
                              <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 인지경로</div>
                                  <div class="tb-td">
                                      <div class="general_chk_box">
                                          <ul class="input-chk">
                                              
                                              <li><input type="checkbox" name="S209000" id="S210001" value="210001"> <label for="S210001"><span></span><p>온라인 초청장, 브로슈어</p></label></li>
                                              <li><input type="checkbox" name="S209000" id="S210002" value="210002"> <label for="S210002"><span></span><p>홈페이지/검색</p></label></li>
                                              <li><input type="checkbox" name="S209000" id="S210003" value="210003"> <label for="S210003"><span></span><p>광고</p></label></li>
                                              <li><input type="checkbox" name="S209000" id="S210004" value="210004"> <label for="S210004"><span></span><p>뉴스레터</p></label></li>
                                              <li><input type="checkbox" name="S209000" id="S210005" value="210005"> <label for="S210005"><span></span><p>소셜미디어</p></label></li>
                                              <li><input type="checkbox" name="S209000" id="S210006" value="210006"> <label for="S210006"><span></span><p>참가업체추천</p></label></li>
                                              <li><input type="checkbox" name="S209000" id="S210007" value="210007"> <label for="S210007"><span></span><p>주관기관 추천</p></label></li>
                                              <li><input type="checkbox" name="S209000" id="S210008" value="210008"> <label for="S210008"><span></span><p>기타</p></label></li>
                                              
                                          </ul>
                                      </div>
                                  </div>
                              </div>
                              <!-- 201117추가-->
                          </div>
                      </div>
                      <div class="register_page">
                        <button type="button" class="register_page_submit" id="btnSignUp">확인</button>
                        <button type="button" class="register_page_btn" id="btnCncl">취소</button>
                      </div>
                  </form>
                </div>
            </div>
          </div>
        </div>
      </div> <!-- / .container -->
    </section>

  </form>

  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="join_form31_js.jsp"></jsp:include>

  </body>
</html>