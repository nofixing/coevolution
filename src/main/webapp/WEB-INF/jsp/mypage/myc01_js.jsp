<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

/**
 * Script 설정
 */
var lComm;
var lfileList;

$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();

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

	$('#btnSave').on('click', function () {
		//저장
		fnSave();
	});	

	$('#btnZoom').on('click', function () {
		/* zoom 미팅 가능 */
		sendChat();
	});

	/* 소켓설정 */
	webSocketConnect("zoom_use_yn", function(message) {

		setValue("use_yn", message.zoom_use_yn);

		if(message.zoom_use_yn == "Y") {
			setText("btnZoom", "ZOOM 사용중");
			alert("ZOOM 미팅을 진행하실 수 있습니다.");
		} else {
			setText("btnZoom", "ZOOM 미사용");
			alert("더이상 ZOOM 미팅을 진행할 수 없습니다.");
		}
	});	

	/* 정보조회 */
	fnSearch();
});

/* 메시지 전송 */
function sendChat() {

	var msg = "";
	var useYn = "";
	if(getValue("use_yn") == "Y") {
		msg = "ZOOM 미사용 처리하시겠습니까?";
		useYn = "N";
	} else {
		if(getValue("zoom_url") == "") {
			alert("ZOOM URL를 입력하세요.");
			return false;
		}
		msg = "ZOOM 사용 처리하시겠습니까?";
		useYn = "Y";
	}

	if(confirm(msg)) {

		gfnPutObj("zoom_use_yn", useYn);
		gfnPutObj("zoom_mgnt_id", getValue("zoom_mgnt_id"));
		gfnPutObj("cust_id", "${sessionScope.login_session.cust_id}");
		gfnPutObj("user_id", "${sessionScope.login_session.cust_id}");
		gfnPutObj("zoom_url", getValue("zoom_url"));

		var pParamJson = gfnGetJson();

		if(pParamJson.substring(0,1) == "[") {
			pParamJson = pParamJson.substring(1, (pParamJson.length-1));
		}		

		stompClient.send("/app/zoom_use_yn", {}, pParamJson);
	}
}

/* 이미지 상세 */
function doView(pFileClsfDtlCd) {

	var pUrl = Array();
    if(lfileList != null) {
        for (var i = 0; i < lfileList.length; i++) {
            if (lfileList[i].file_clsf_dtl_cd == pFileClsfDtlCd) {
                pUrl.push("/files" + lfileList[i].file_path);
            }
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

/**
 * 내부스정보등록저장 
 */
function fnSave() {

		/* form값 global 변수에 입력 */
		gfnGetFormJSON();
	
		/* global 변수 json으로 변환 */
		var pParamJson = gfnGetJson();		

		sendForm("POST", "/mypage/corpsave", "application/json; charset=utf-8", "json", pParamJson, function(message) {
			
			if(message == "parsererror") {
				alert("로그아웃되었습니다.");
				document.location.href="/member/login_form";
			} else if(message.result_code == 0) {
				alert("부스 정보를 수정하였습니다.");
				fnSearch();
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}

		});	
}

/**
 * 데이터조회
 */
function fnSearch() {

	var pParamJson = "{}";

	sendForm("POST", "/mypage/corpinfo", "application/json; charset=utf-8", "json", pParamJson, function(message) {
		
		if(message.result_code == 0) {
			var pFieldArry = ["homepage_url", "about_company_kor", "about_company_eng", "video_url", "promtn_url", "scan_3d_url", "comrce_url"];

			if(message.list.length > 0) {
				gfnSetField(message.list[0], pFieldArry);
			}

			/* zoom url 설정 */
			var zoomList = message.zoomList;
			if(zoomList.length > 0) {
				pFieldArry = ["zoom_mgnt_id", "zoom_url", "use_yn"];
				gfnSetField(zoomList[0], pFieldArry);

				var useYn = getValue("use_yn");
				if(useYn == "Y") {
					setText("btnZoom", "ZOOM 사용중");
				} else {
					setText("btnZoom", "ZOOM 미사용");
				}
			}			

			/* 이미지 셋팅 */
			lfileList = message.attachList;
			var imgCorpCi = "", corpProduct = "", corpGallery = "";
			if(lfileList != null) {
                for (var i = 0; i < lfileList.length; i++) {

                    if (lfileList[i].file_clsf_dtl_cd == "102006") { //기업CI
                        imgCorpCi += "<div class='pr-1 text-center'><a href=\"javascript:doView('102006')\"><img src='" + "/files" + lfileList[i].file_path + "' width='75px' height='50px'/></a><br><a href=\"javascript:fileDel('" + lfileList[i].attach_id + "')\">[삭제]</a></div>";
                    } else if (lfileList[i].file_clsf_dtl_cd == "102009") { //제품소개
                        corpProduct += "<div class='pr-1 text-center'><a href=\"javascript:doView('102009')\"><img src='" + "/files" + lfileList[i].file_path + "' width='75px' height='50px'/></a><br><a href=\"javascript:fileDel('" + lfileList[i].attach_id + "')\">[삭제]</a></div>";
                    } else if (lfileList[i].file_clsf_dtl_cd == "102010") { //갤러리
                        corpGallery += "<div class='pr-1 text-center'><a href=\"javascript:doView('102010')\"><img src='" + "/files" + lfileList[i].file_path + "' width='75px' height='50px'/></a><br><a href=\"javascript:fileDel('" + lfileList[i].attach_id + "')\">[삭제]</a></div>";
                    }
                }
            }

            $("#imgCorpCi").html(imgCorpCi);
            $("#corpProduct").html(corpProduct);
            $("#corpGallery").html(corpGallery);

			

		} else {
			alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
		}

	});	

}

/* 파일업로드 */
function onClick_fileUpload() {

	/* 파일업로드 조회 */
	var form = $('#fileForm')[0];
	var formData = new FormData(form);
	
	var fileList = $('input[name=fileUpload]').length;

	for(var i = 0; i < fileList; i++){
		formData.append("files", $("#fileUpload")[i].files[0]);
	}

	console.log(formData);

	sendFormFile("/mypage/corpattach", formData, function(message){
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

</script>