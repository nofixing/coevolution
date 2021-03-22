<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="https://cdn.jsdelivr.net/gh/jquery-form/form@4.3.0/dist/jquery.form.min.js" integrity="sha384-qlmct0AOBiA2VPZkMY3+2WqkHtIQ9lSdAsAn5RUJD/3vA5MKDgSGcdmIv4ycVxyn" crossorigin="anonymous"></script>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();

	$('#btnFileSave').on('click', function () {
		/* CI */
		setValue("file_clsf_dtl_cd","102006");
		fileUpload();
	});			

});

/* 파일업로드 */
function fileUpload() {

	/* 파일업로드 조회 */
	var form = $('#fileForm')[0];
	var formData = new FormData(form);
	
	var fileList = $('input[name=fileUpload]').length;

	for(var i = 0; i < fileList; i++){
		console.log('file_name :' + $("#fileUpload")[i].files[0]);
		formData.append("files", $("#fileUpload")[i].files[0]);
	}

	//formData.append("file_clsf_cd", getValue("file_clsf_cd"));
	//formData.append("file_clsf_dtl_cd", getValue("file_clsf_dtl_cd"));

	console.log(formData);

	$.ajax({

		type: "POST",
		url: "/mypage/corpattach",
		data: formData,
		processData: false,
		contentType: false,
		cache: false,
		timeout: 600000,
		success: function (result) {
			alert("SUCCESS");
			console.log("SUCCESS : ");
		},
		error: function (e) {
			alert("ERROR");
			console.log("ERROR : ", e);
		}

	});

}

</script>