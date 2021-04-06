<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script language="javascript">

/**
 * Script 설정
 */
var lComm, lfnPutObj, lfileList;;
var lDataObjectPutGet = new Object(); /* Local Set Get */
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();
	var yyyyMMdd = lComm.getToday("-");

	//확인 (회원가입)
	$('#btnUpdate').on('click', function () {
		fnUpdate();
	});

	$('#btnUpdateBooth').on('click', function () {
		fnUpdateBooth();
	});

	//전화번호
	$('#hp_no').on('focusout', function () {
		var telNo = lComm.setTelNoFormat(getValue("hp_no"));
		setValue("hp_no", telNo);
	});	

	$('#btn_corp_ci').on('click', function () {
		/* CI */
		/* 기업 CI 첨부파일 1개만 가능 */
		if(imgCnt("102006") > 0) {
			alert("CI 이미지가 등록되어 있습니다.\r\n삭제 후 다시 등록하시기 바랍니다.");
		} else {
			showFileModal();
			setValue("file_clsf_dtl_cd", "102006");
		}
	});	

	$('#btn_corp_product').on('click', function () {
		/* 제품소개 */
		if(imgCnt("102009") >= 5) {
			alert("제품 소개는 5개까지 등록 가능합니다.");
		} else {
			showFileModal();
			setValue("file_clsf_dtl_cd","102009");
		}
	});	

	$('#btnGallery').on('click', function () {
		/* 갤러리 */
		if(imgCnt("102010") >= 5) {
			alert("갤러리는 5개까지 등록 가능합니다.");
		} else {
			showFileModal();
			setValue("file_clsf_dtl_cd","102010");
		}		
	});		

	fnSearch();

});

/* 회원정보조회 */
var lFormValue;
function fnSearch() {

	var pParamJson = '{"cust_id":"${cust_id}"}';

	sendForm("POST", "/mgnt/m_corp_custinfo", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message.result_code == 0) {
			console.log(message);

			lFormValue = message;

			/* 국가코드 */  
			setSelectOption("country_cd", message.countrylist);

			/* 카테고리1 */  
			setSelectOption("category1", message.category1, "", "선택");			

			/* 필드값입력 */
			var pFieldArry = ["cust_id","cust_nm","email_id","hp_no","dept_nm","rep_nm","country_cd","category1","ins_dt","cust_sts_nm"];
			gfnSetField(message.custInfo[0], pFieldArry);

			setValue("vr_corpinfo_url", message.vr_corpinfo_url);
			setValue("vr_corpcoslt_url", message.vr_corpcoslt_url);

			/* 개인정보수집이용동의 */
			if(message.custInfo[0].agree_1 == "Y") {
				setValue("agree_1", "동의");
			} else {
				setValue("agree_1", "미동의");
			}

			/* 마케팅활용동의 */
			if(message.custInfo[0].agree_3 == "Y") {
				setValue("agree_3", "동의");
			} else {
				setValue("agree_3", "미동의");
			}

			/* 부스정보조회 */
			fnSearchBooth();

		} else {
			if(message.session_yn == "N" || message == undefined) {
				alert("로그아웃되었습니다.");	
				document.location.href="/m.do";
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}
		}

	});	
}

/* 부스정보조회 */
function fnSearchBooth() {

	var pParamJson = '{"m_yn":"Y","cust_id":"${cust_id}"}';

	sendForm("POST", "/mypage/corpinfo", "application/json; charset=utf-8", "json", pParamJson, function(message) {
		
		if(message.result_code == 0) {
			var pFieldArry = ["homepage_url", "about_company_kor", "about_company_eng", "video_url", "promtn_url", "scan_3d_url", "comrce_url"];

			if(message.list.length > 0) {
				gfnSetField(message.list[0], pFieldArry);
			}

			/* 이미지 셋팅 */
			lfileList = message.attachList;
			var imgCorpCi = "", corpProduct = "", corpGallery = ""; 

			if(lfileList != null) {
				for(var i = 0; i < lfileList.length; i++) {
					
					if(lfileList[i].file_clsf_dtl_cd == "102006") { //기업CI
						imgCorpCi += "<div class='pr-1 text-center'><a href=\"javascript:doView('102006')\"><img src='" + "/files" + lfileList[i].file_path + "' width='75px' height='50px'/></a><br><a href=\"javascript:fileDel('"+lfileList[i].attach_id+"')\">[삭제]</a></div>";
					} else if(lfileList[i].file_clsf_dtl_cd == "102009") { //제품소개
						corpProduct += "<div class='pr-1 text-center'><a href=\"javascript:doViewPdf('"+lfileList[i].file_path+"')\"><img src='/images/pdf.png' width='75px' title='"+lfileList[i].org_file_name+"'/></a><br><a href=\"javascript:fileDel('"+lfileList[i].attach_id+"')\">[삭제]</a></div>";
					} else if(lfileList[i].file_clsf_dtl_cd == "102010") { //갤러리
						corpGallery += "<div class='pr-1 text-center'><a href=\"javascript:doView('102010')\"><img src='" + "/files" + lfileList[i].file_path + "' width='75px' height='50px'/></a><br><a href=\"javascript:fileDel('"+lfileList[i].attach_id+"')\">[삭제]</a></div>";
					}
				}
			}

			$("#imgCorpCi").html(imgCorpCi);
			$("#corpProduct").html(corpProduct);
			$("#corpGallery").html(corpGallery);

		} else {
			if(message == undefined) {
				alert("로그아웃되었습니다.");
				document.location.href="/m.do";
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}
		}

	});	

}

/* 회원정보수정 */
function fnUpdate() {

	/* 필수체크 */
	var chk = '['
		+ '  {"id":"email_id","name":"이메일 주소"}'
		+ ', {"id":"hp_no","name":"휴대폰"}'
		+ ', {"id":"dept_nm","name":"부서"}'
		+ ', {"id":"rep_nm","name":"담당자명"}'
		+ ', {"id":"country_cd","name":"국가"}'
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
	}

	/* form값 global 변수에 입력 */
	gfnGetFormJSON();

	/* 값입력 */
 	gfnPutObj("cust_id", "${cust_id}");

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/mgnt/m_corp_custupdate", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		console.log("message : " + message);

		if(message.result_code == 0) {
			alert("회원정보가 수정되었습니다.");
			fnSearch();
		} else {
			if(message.session_yn == "N" || message == undefined) {
				alert("로그아웃되었습니다.");	
				document.location.href="/m.do";
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}
		}

	});	
}

//부스정보수정
function fnUpdateBooth() {

	/* form값 global 변수에 입력 */
	gfnGetFormJSON();

	/* 값입력 */
 	gfnPutObj("cust_id", "${cust_id}");
	gfnPutObj("m_yn", "Y");

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();		

	sendForm("POST", "/mypage/corpsave", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message.result_code == 0) {
			alert("부스 정보를 수정하였습니다.");
			fnSearch();
		} else {
			if(message == undefined) {
				alert("로그아웃되었습니다.");
				document.location.href="/m.do";
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}
		}

	});	

}

/* pdf 상세 */
function doViewPdf(pUrl) {

	var pdfHtml =  pdfPopup(pUrl);
	gfnAlert ("", "", pdfHtml, function(){});

}


/* 이미지 상세 */
function doView(pUrl) {

	var pUrl = Array();
	for(var i = 0; i < lfileList.length; i++) {
		if(lfileList[i].file_clsf_dtl_cd == pFileClsfDtlCd) { 
			pUrl.push("/files" + lfileList[i].file_path);
		}
	}
	var imgPopup = imagePopup(pUrl);

	gfnAlert ("", "", imgPopup, function(){});

}

/* 등록된 이미지 개수 체크 */
function imgCnt(pFileClsfDtlCd) {
	var cnt = 0;

	if(lfileList != null) {
		for(var i = 0; i < lfileList.length; i++) {
			if(lfileList[i].file_clsf_dtl_cd == pFileClsfDtlCd) { 
				cnt++;
			}
		}	
	}

	return cnt;
}

function imagePopup(pUrl) {
	var vhtml = 
	"<div id='gImageControls' class='carousel slide' data-ride='carousel'>";
	vhtml +=	"<div class='carousel-inner'>";

	for(var i = 0; i < pUrl.length; i++) {

		if(i == 0) {
			vhtml +=		"<div class='carousel-item active'>";
		} else {
			vhtml +=		"<div class='carousel-item'>";
		}
		
		vhtml +=			"<img class='d-block w-100' src='"+pUrl[i]+"'>";
		vhtml +=		"</div>";
	}

	vhtml +=		"<a class='carousel-control-prev' href='#gImageControls' role='button' data-slide='prev'>";
	vhtml +=			"<span class='carousel-control-prev-icon' aria-hidden='true'></span>";
	vhtml +=		"</a>";
	vhtml +=		"<a class='carousel-control-next' href='#gImageControls' role='button' data-slide='next'>";
	vhtml +=			"<span class='carousel-control-next-icon' aria-hidden='true'></span>";
	vhtml +=		"</a>";
	vhtml +=	"</div>";
	vhtml +="</div>";

	return vhtml;
}

function pdfPopup(pUrl) {
	var vhtml = "<div id='gImageControls' class='carousel slide' data-ride='carousel'>";
	vhtml +=	"<div class='carousel-inner'>";
	vhtml += 		"<iframe src='/js/pdfjs/web/viewer.html?file=/files"+pUrl+"' style='position: relative;   top: 0;  bottom: 0; left: 0;   width: 100%;   height: 500px;  border: 0'></iframe>";
	vhtml +=	"</div>";
	vhtml +="</div>";

	return vhtml;
}


/* 파일업로드 */
function onClick_fileUpload() {

	/* 파일업로드 조회 */
	var form = $('#fileForm')[0];
	setValue("file_cust_id", "${cust_id}");

	var formData = new FormData(form);
	
	var fileList = $('input[name=fileUpload]').length;

	for(var i = 0; i < fileList; i++){
		formData.append("files", $("#fileUpload")[i].files[0]);
	}

	console.log(formData);

	sendFormFile("/mgnt/m_corp_attach", formData, function(message){
		/* 저장 완료 시 다시 조회한다 */
		if(message.result_code == 0) {
			fnSearch();
			alert("파일업로드를 완료하였습니다.");
			$("#fileModal").modal("hide");
		} else {
			alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
		}		
  	});
}

/* 파일삭제 */
function fileDel(pAttachId) {

	setValue("attach_id", pAttachId);

	/* form값 global 변수에 입력 */
	gfnGetFormJSON();

	/* 값입력 */
 	gfnPutObj("cust_id", "${cust_id}");
	gfnPutObj("m_yn", "Y");
	
	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();		

	sendForm("POST", "/mypage/corpattachdel", "application/json; charset=utf-8", "json", pParamJson, function(message) {
		
		if(message.result_code == 0) {
			alert("선택하신 파일을 삭제하였습니다.");
			fnSearch();
		} else {
			alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
		}

	});	
}

/* 모달창을 띄운다. */
function showFileModal() {
	if(document.getElementById("fileModal")) {
		$("#fileModal").remove();
	}

	var modlContents = fileModalHtml();

	document.getElementById("divFileModal").insertAdjacentHTML("afterend", modlContents);

	$("#fileModal").modal();
}

/* 모달HTML */
function fileModalHtml() {

	var vHtml = "";
    vHtml += '    <div class="modal fade" id="fileModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">';
    vHtml += '      <div class="modal-dialog" id="fileModalDialog">';
    vHtml += '        <div class="modal-content">';
    vHtml += '          <div class="modal-header">';
    vHtml += '            <button type="button" class="close" data-dismiss="modal" aria-label="Close">';
    vHtml += '              <span aria-hidden="true">&times;</span>';
    vHtml += '            </button>';
    vHtml += '          </div>';
    vHtml += '          <div class="modal-body">';
    vHtml += '              <input type="file" id="fileUpload" name="fileUpload" accept=".jpg, .jpeg, .png, .pdf"/>';
    vHtml += '          </div>';
    vHtml += '          <div class="input-group">';
    vHtml += '            <div class="col-sm-12 d-flex justify-content-center">';
    vHtml += '              <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 8rem;" id="btnFileSave" onClick="onClick_fileUpload()">저장</button>';
    vHtml += '            </div>   ';
    vHtml += '          </div>';
    vHtml += '        </div>';
    vHtml += '      </div>';
    vHtml += '    </div>';

	return vHtml;
}

/* 비밀번호를 초기화한다. */
function pwReset() {

	if(!confirm("비밀번호를 초기화하시겠습니까?")) return false;

	/* form값 global 변수에 입력 */
	gfnGetFormJSON();

	/* 값입력 */
 	gfnPutObj("cust_id", "${cust_id}");
	
	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();		

	sendForm("POST", "/mgnt/m_corp_pwreset", "application/json; charset=utf-8", "json", pParamJson, function(message) {
		
		if(message.result_code == 0) {
			alert("비밀번호를 초기화하였습니다.");
		} else {
			alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
		}

	});	
}

</script>