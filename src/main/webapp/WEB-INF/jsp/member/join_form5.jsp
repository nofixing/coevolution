<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
  <form>
    <input type="hidden" id="agree_1" name="agree_1" value="${agree_1}"/>
    <input type="hidden" id="agree_2" name="agree_2" value="${agree_2}"/>
    <input type="hidden" id="agree_3" name="agree_3" value="${agree_3}"/>
    <input type="hidden" id="cust_clsf_cd" name="cust_clsf_cd" value="202002"/>

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
            기업 참가(부스) 등록
          </h5>

        </div>
        <div class="col-auto">

          <!-- Breadcrumb -->
          <span class="breadcrumb-item">
            <a href="/index">Home</a>
          </span>
          <span class="breadcrumb-item active">
            기업 참가(부스) 등록
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
          <p>기업 참가(부스) 등록</p>
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
                  <div class="form-box">
                      <div class="top-txt"><span>*</span> 필수 작성 항목 입니다</div>
                      <div class="join-form-tb">
                          <div class="tb-tr">
                              <div class="tb-th"><span>*</span> 아이디<br>(ID)</div>
                              <div class="tb-td" id="idview">
                                  <input type="text" style="ime-mode:disabled;" minlength="6" maxlength="10" id="cust_id" name="cust_id" class="input-box" placeholder="아이디를 입력하세요">
                                  <div class="chk-btn idchk-btn"><a href="#!" id="btnDupCheck">중복확인</a></div>
                                  <p class="notice">※ 아이디는 6자 이상, 10자 이하 영문 소문자와 숫자만 사용 가능합니다.</p>
                              </div>
                          </div>
                          <div class="tb-tr">
                              <div class="tb-th"><span>*</span> 비밀번호<br>(Password)</div>
                              <div class="tb-td">
                                  <input type="password" id="cust_pw" name="cust_pw" minlength="6" maxlength="15" class="input-box" placeholder="비밀번호를 입력하세요">
                                  <p class="notice">※ 비밀번호는 영문, 숫자 혼용하여 6~15자 이내로 입력해주세요.</p>
                              </div>
                          </div>
                          <div class="tb-tr">
                              <div class="tb-th"><span>*</span> 비밀번호 확인<br>(Password Check)</div>
                              <div class="tb-td">
                                  <input type="password" id="cust_pw2" name="cust_pw2" minlength="6" maxlength="15" class="input-box">
                              </div>
                          </div>
                          <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 기업명<br>(Company)</div>
                                  <div class="tb-td">
                                      <input type="text" name="cust_nm" id="cust_nm" maxlength="50" class="input-box" placeholder="기업명을 입력하세요">
                                  </div>
                          </div>
                                    
                          <div class="tb-tr tr-half">
                              <div class="half-box">
                                  <div class="tb-th"><span>*</span>부서<br>(Department)</div>
                                  <div class="tb-td">
                                      <input type="text" name="dept_nm" id="dept_nm" maxlength="50" class="input-box" placeholder="부서을 입력하세요">
                                  </div>
                              </div>
                              <div class="half-box">
                                  <div class="tb-th"><span>*</span>담당자명<br>(Person in charge)</div>
                                  <div class="tb-td">
                                      <input type="text" name="rep_nm" id="rep_nm" maxlength="50" class="input-box" placeholder="담당자명을 입력하세요">
                                  </div>
                              </div>
                          </div>
                          <div class="tb-tr">
                              <div class="tb-th"><span>*</span> 휴대폰번호<br>(Phone number)</div>
                              <div class="tb-td">
                                  <input type="text" name="hp_no" id="hp_no" maxlength="13" class="input-box" placeholder="-없이 숫자만 입력하세요">
                              </div>
                          </div>
                          <div class="tb-tr">
                              <div class="tb-th"><span>*</span> 이메일 주소<br>(e-mail)</div>
                              <div class="tb-td">
                                  <div class="input-email">
                                      <div class="in-box"><input type="text" name="email_id1" id="email_id1" maxlength="50" class="input-box"></div>
                                      <div class="in-box"><input type="text" name="email_id2" id="email_id2" maxlength="50" class="input-box"></div>
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
                          <div class="tb-tr">
                                  <div class="tb-th"><span>*</span> 국가<br>(Country)</div>
                                  <div class="tb-td">
                                      <div class="select-box">
                                          <select class="custom-select-sm" name="country_cd" id="country_cd">
                                              
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
                        </div>
                    </div>
                    <div class="top-txt mt-3 text-left">※ 부스 정보 입력은 회원가입 후 마이페이지 ＇내 부스 정보 등록‘ 을 통해 가능합니다.</div>
                    <div class="register_page">
                        <button type="button" class="register_page_submit" id="btnSignUp">확인</button>
                        <button type="button" class="register_page_btn" id="btnCncl">취소</button>
                    </div>
              </div>
          </div>
        </div>
      </div>
    </div> <!-- / .container -->
  </section>

  </form>
  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
  <jsp:include page="join_form5_js.jsp"></jsp:include>   

  </body>
</html>