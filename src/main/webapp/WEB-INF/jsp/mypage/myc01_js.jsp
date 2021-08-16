<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

/**
 * Script 설정
 */
var lComm;
var lfileList;

/* 파일선택 */
var totalFileSize = 0;				// 등록할 전체 파일 사이즈
var fileSizeList = new Array();		// 파일 사이즈 리스트
var fileList = new Array();			// 파일 리스트
var fileIndex = 0;					// 파일 리스트 번호
var uploadSize = 10;				//업로드사이즈
var maxUploadSize = 50;				//총업로드사이즈
var fileNowCnt = 0;					//입력된 파일 건수
var fileNowMaxCnt = 0;				//입력가능한 파일 갯수

$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();

	$('#btn_corp_ci').on('click', function () {
		/* CI */
		/* 기업 CI 첨부파일 1개만 가능 */
		fileNowCnt = imgCnt("102006");
		fileNowMaxCnt = 1;

		if(fileNowCnt > 0) {
			alert("CI 이미지가 등록되어 있습니다.\r\n삭제 후 다시 등록하시기 바랍니다.");
		} else {
			showFileModal("102006");
			setValue("file_clsf_dtl_cd", "102006");
		}
	});	

	$('#btn_corp_product').on('click', function () {
		/* 제품소개 */
		fileNowCnt = imgCnt("102009");
		fileNowMaxCnt = 5;

		if(fileNowCnt >= 5) {
			alert("제품 소개는 5개까지 등록 가능합니다.");
		} else {
			showFileModal("102009");
			setValue("file_clsf_dtl_cd","102009");
		}
	});	

	$('#btnGallery').on('click', function () {
		/* 갤러리 */
		fileNowCnt = imgCnt("102010");
		fileNowMaxCnt = 5;

		if(fileNowCnt >= 5) {
			alert("갤러리는 5개까지 등록 가능합니다.");
		} else {
			showFileModal("102010");
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
			
					var closeIcon = '<div style="position:absolute;top:0px;right:10px;z-index:2">';
					closeIcon += '<a href=\"javascript:fileDel(\'' + lfileList[i].attach_id + '\')\">';
					closeIcon += '<svg xmlns="http://www.w3.org/2000/svg" width="10" height="10" fill="currentColor" class="bi bi-x-lg text-dark" viewBox="0 0 16 16">';
					closeIcon += '<path d="M1.293 1.293a1 1 0 0 1 1.414 0L8 6.586l5.293-5.293a1 1 0 1 1 1.414 1.414L9.414 8l5.293 5.293a1 1 0 0 1-1.414 1.414L8 9.414l-5.293 5.293a1 1 0 0 1-1.414-1.414L6.586 8 1.293 2.707a1 1 0 0 1 0-1.414z"/>';
					closeIcon += '</svg></a></div>';

                    if (lfileList[i].file_clsf_dtl_cd == "102006") { //기업CI
                        imgCorpCi += "<div class='pr-1 text-center' style=\"position: relative;\">"+closeIcon+"<a href=\"javascript:doView('102006')\"><img src='" + "/files" + lfileList[i].file_path + "' width='75px' height='80px'/></a></div>";
                    } else if (lfileList[i].file_clsf_dtl_cd == "102009") { //제품소개
						corpProduct += "<div class='pr-1 text-center' style=\"position: relative;\">"+closeIcon+"<a href=\"javascript:doViewPdf('"+lfileList[i].file_path+"')\"><img src='/images/pdf.png' width='75px' height='80px' title='"+lfileList[i].org_file_name+"'/></a></div>";
                    } else if (lfileList[i].file_clsf_dtl_cd == "102010") { //갤러리
                        corpGallery += "<div class='pr-1 text-center' style=\"position: relative;\">"+closeIcon+"<a href=\"javascript:doView('102010')\"><img src='" + "/files" + lfileList[i].file_path + "' width='75px' height='80px'/></a></div>";
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

/* pdf 상세 */
function doViewPdf(pUrl) {

	var pdfHtml =  pdfPopup(pUrl);
	gfnAlert ("", "", pdfHtml, function(){});

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
function onClick_fileUpload(pCls) {

	/* 파일업로드 조회 */
	var form = $('#fileForm')[0];
	var formData = new FormData(form);
	
	//var fileList = $('input[name=fileUpload]').length;
	var uploadFileList = Object.keys(fileList);

	if (uploadFileList.length == 0) {
		alert("선택된 파일이 없습니다.");
		return;
	}

	if (totalFileSize > maxUploadSize) {
		// 파일 사이즈 초과 경고창
		alert("파일업로드 용량을 초과하였습니다. (" + maxUploadSize + " MB)");
		return;
	}

	for(var i = 0; i < uploadFileList.length; i++){
		//formData.append("files", $("#fileUpload")[i].files[0]);
		formData.append('files', fileList[uploadFileList[i]]);

		if(pCls == "102009") { /* 제품소개 */
			if((fileList[uploadFileList[i]].name).toUpperCase().lastIndexOf(".PDF") < 0) {
				alert("PDF 파일만 업로드 가능합니다.");	
				return false;
			}
		} else {
			var ext = ".jpg, .jpeg, .png";

			if((fileList[uploadFileList[i]].name).toUpperCase().lastIndexOf(".JPG")  < 0 && 
			   (fileList[uploadFileList[i]].name).toUpperCase().lastIndexOf(".JPEG") < 0 &&
			   (fileList[uploadFileList[i]].name).toUpperCase().lastIndexOf(".PNG") < 0
			   ) {
				alert("jpg, .jpeg, .png 파일만 업로드 가능합니다.");	
				return false;
			}
		}
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

	if(!confirm("선택하신 파일을 삭제하시겠습니까?")) return false;
	
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
function showFileModal(pCls) {
	if(document.getElementById("fileModal")) {
		$("#fileModal").remove();
	}

	var modlContents = fileModalHtml(pCls);

	document.getElementById("divFileModal").insertAdjacentHTML("afterend", modlContents);

	$(".custom-file-input").on("change", function() {
		var fileName = $(this).val().split("\\").pop();
		$(this).siblings(".custom-file-label").addClass("selected").html(fileName);
	});

	$("#fileModal").modal();

	$("#fileUpload").bind('change', function() {
		selectFile(this.files);
	});

	/* 파일선택 */
	fileInit();

	gfnFileDropDown();
}

/* 모달HTML */
function fileModalHtml(pCls) {

	var ext = ".jpg, .jpeg, .png";
	if(pCls == "102009") { /* 제품소개 */
		ext = ".pdf";
	}

	var vHtml = "";
    vHtml += '    <div class="modal fade" id="fileModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">';
    vHtml += '      <div class="modal-dialog" id="fileModalDialog">';
    vHtml += '        <div class="modal-content">';
    vHtml += '          <div class="modal-header">';
    vHtml += '            <button type="button" class="close" data-dismiss="modal" aria-label="Close">';
    vHtml += '              <span aria-hidden="true">&times;</span>';
    vHtml += '            </button>';
    vHtml += '          </div>';
    vHtml += '          <div class="modal-body" style="height:140px">';
	vHtml += '				<div class="custom-file">';
    vHtml += '              	<input type="file" class="custom-file-input" multiple="multiple" id="fileUpload" name="fileUpload" accept="'+ext+'"/>';
	vHtml += '					<label class="custom-file-label" for="fileUpload">파일선택</label>';
	vHtml += '					<div id="dropZone" class="text-center d-flex align-items-center border" style="width: 100%; height: 80px; background-color:#e9ecef">';
	vHtml += '						<div id="fileDragDesc" class="col-sm-12"> 파일을 드래그 해주세요. </div>';		
	vHtml += '					</div>';
	vHtml += '				</div>';
    vHtml += '          </div>';
	vHtml += '			<div class="modal-body pb-3">'
	vHtml += '				<table id="fileListTable" class="border" style="width:100%;">';
	vHtml += '					<thead>';
    vHtml += '  					<th scope="col" class="text-center border" style="width:60%;height:35px;background-color:#e9ecef">파일명</th>';
    vHtml += '  					<th scope="col" class="text-center border" style="width:20%;height:35px;background-color:#e9ecef">파일크기</th>';
    vHtml += '  					<th scope="col" class="text-center border" style="width:20%;height:35px;background-color:#e9ecef">삭제</th>';
	vHtml += '					</thead>';	
	vHtml += '					<tbody id="fileTableTbody">';
	vHtml += '						<tr id="nofiles" style="height:35px"><td class="text-center" colspan="3">입력된 파일이 없습니다.</td></tr>';
	vHtml += '					</tbody>';
	vHtml += '				</table>';
	vHtml += '			</div>'
    vHtml += '          <div class="input-group">';
    vHtml += '            <div class="col-sm-12 d-flex justify-content-center">';
    vHtml += '              <button type="button" class="btn-outline-primary form-control form-control-sm mb-2" style="width: 8rem;" id="btnFileSave" onClick="onClick_fileUpload(\''+pCls+'\')">저장</button>';
    vHtml += '            </div>   ';
    vHtml += '          </div>';
    vHtml += '        </div>';
    vHtml += '      </div>';
    vHtml += '    </div>';

	return vHtml;
}

function gfnFileDropDown() {
	var dropZone = $("#dropZone");
	//Drag기능 
	dropZone.on('dragenter', function(e) {
		e.stopPropagation();
		e.preventDefault();
		// 드롭다운 영역 css
		dropZone.css('background-color', '#E3F2FC');
	});
	dropZone.on('dragleave', function(e) {
		e.stopPropagation();
		e.preventDefault();
		// 드롭다운 영역 css
		dropZone.css('background-color', '#e9ecef');
	});
	dropZone.on('dragover', function(e) {
		e.stopPropagation();
		e.preventDefault();
		// 드롭다운 영역 css
		dropZone.css('background-color', '#E3F2FC');
	});
	dropZone.on('drop', function(e) {
		e.preventDefault();
		// 드롭다운 영역 css
		dropZone.css('background-color', '#e9ecef');

		var files = e.originalEvent.dataTransfer.files;
		if (files != null) {
			if (files.length < 1) {
				console.log("폴더 업로드 불가");
				return;
			} else {
				selectFile(files)
			}
		} else {
			alert("ERROR");
		}
	});
}

function selectFile(fileObject) {
	
	var files = null;

	if (fileObject != null) {
		// 파일 Drag 이용하여 등록시
		files = fileObject;
	} else {
		return false;
	}

	// 다중파일 등록
	if (files != null) {
				
		for (var i = 0; i < files.length; i++) {
			// 파일 이름
			var fileName = files[i].name;
			var fileNameArr = fileName.split("\.");
			// 확장자
			var ext = fileNameArr[fileNameArr.length - 1];
			
			var fileSize = files[i].size; // 파일 사이즈(단위 :byte)
			console.log("fileSize="+fileSize);
			if (fileSize <= 0) {
				console.log("0kb file return");
				return;
			}
			
			var fileSizeKb = fileSize / 1024; // 파일 사이즈(단위 :kb)
			var fileSizeMb = fileSizeKb / 1024;	// 파일 사이즈(단위 :Mb)
			
			var fileSizeStr = "";
			if ((1024*1024) <= fileSize) {	// 파일 용량이 1메가 이상인 경우 
				console.log("fileSizeMb="+fileSizeMb.toFixed(2));
				fileSizeStr = fileSizeMb.toFixed(2) + " Mb";
			} else if ((1024) <= fileSize) {
				console.log("fileSizeKb="+parseInt(fileSizeKb));
				fileSizeStr = parseInt(fileSizeKb) + " kb";
			} else {
				console.log("fileSize="+parseInt(fileSize));
				fileSizeStr = parseInt(fileSize) + " byte";
			}

			if ($.inArray(ext.toUpperCase(), [ 'PDF', 'JPG', 'JPEG', 'PNG']) < 0) {
				alert("업로드 할 수 없는 파일이 있습니다. ("+fileName+")\r\n다시 올려주시기 바랍니다.");
			} else if (fileSizeMb > uploadSize) {
				// 파일 사이즈 체크
				alert("용량 초과\n업로드 가능 용량 : " + uploadSize + " MB");
				break;
			} else {
				// 전체 파일 사이즈
				totalFileSize += fileSizeMb;

				// 파일 배열에 넣기
				fileList[fileIndex] = files[i];

				// 파일 사이즈 배열에 넣기
				fileSizeList[fileIndex] = fileSizeMb;

				// 업로드 파일 목록 생성
				addFileList(fileIndex, fileName, fileSizeStr);

				// 파일 번호 증가
				fileIndex++;
			}
		}
	} else {
		return false;
	}
}

// 업로드 파일 목록 생성
function addFileList(fIndex, fileName, fileSizeStr) {

	var chkFile = false;
	var inFileCnt = 0;
	for(let fileSL in fileSizeList) {
		if(fileSL != "" && fileSL != null) {
			chkFile = true;
			inFileCnt++;
		}
	}

	if(fileNowMaxCnt < (inFileCnt + fileNowCnt)) { 
		alert("파일 최대 입력 건수를 초과하였습니다.("+fileNowMaxCnt+"개)");
		fileInit();

		var vHtml = '<tr id="nofiles"><td class="text-center" colspan="3" style="height:35px;">입력된 파일이 없습니다.</td></td>';
		$('#fileTableTbody').append(vHtml);

		return false;
	}

	if(chkFile || fIndex == 0) {
		$("#nofiles").remove();
	}
	
	var html = "";
	html += "<tr id='fileTr_" + fIndex + "' style='height:35px;'>";
	html += "    <td class='text-left border'>"+fileName+"</td>";
	html += "    <td class='text-center border'>"+fileSizeStr+"</td>";
	html += "    <td class='text-center border'><input value='삭제' type='button' href='#' onclick='deleteFile(" + fIndex + "); return false;'></td>";
	html += "</tr>"

	$('#fileTableTbody').append(html);
}
	
// 업로드 파일 삭제
function deleteFile(fIndex) {
	console.log("deleteFile.fIndex=" + fIndex);
	// 전체 파일 사이즈 수정
	totalFileSize -= fileSizeList[fIndex];

	// 파일 배열에서 삭제
	delete fileList[fIndex];

	// 파일 사이즈 배열 삭제
	delete fileSizeList[fIndex];

	// 업로드 파일 테이블 목록에서 삭제
	$("#fileTr_" + fIndex).remove();
	
	var chkFile = false;
	for(let fileSL in fileSizeList) {
		if(fileSL != "" && fileSL != null) chkFile = true;
	}

	if(!chkFile) {
		var vHtml = '<tr id="nofiles"><td class="text-center" colspan="3" style="height:35px;">입력된 파일이 없습니다.</td></td>';
		$('#fileTableTbody').append(vHtml);
	}

	console.log("totalFileSize="+totalFileSize);
}

function fileInit() {

	for(var i = 0; i <= fileIndex; i++) {
		$("#fileTr_" + i).remove();
	}

	totalFileSize = 0;				// 등록할 전체 파일 사이즈
	fileSizeList = new Array();		// 파일 사이즈 리스트
	fileList = new Array();			// 파일 리스트
	fileIndex = 0;					// 파일 리스트 번호
	uploadSize = 10;				//업로드사이즈
	maxUploadSize = 50;				//총업로드사이즈
}
</script>