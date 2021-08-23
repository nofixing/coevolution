<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script language="javascript">

/**
 * Script 설정
 */
var lComm, lfnPutObj;
var lDataObjectPutGet = new Object(); /* Local Set Get */
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();
	var yyyyMMdd = lComm.getToday("-");

	/* 목록이동 */
	$('#btnList').on('click', function () {
		document.location.href="/mgnt/expo";
	});

	//저장 
	$('#btnUpdate').on('click', function () {
		fnUpdate();
	});

});


/* 엑스포정보수정 */
function fnUpdate() {

	/* 필수체크 */
	var chk = '['
		+ '  {"id":"ev_expo_nm","name":"엑스포 명칭"}'
		+ ', {"id":"expo_from_dt","name":"엑스포 시작일시"}'
		+ ', {"id":"expo_to_dt","name":"엑스포 종료일시"}'
	chk += ']';

	var jsonCheck = JSON.parse(chk);

	if(!lComm.fnRequiredItems(jsonCheck)) {
		return false;
	}

	var frm = document.forms[0];
	setValue("use_yn", frm.use_yn.value);

	/* form값 global 변수에 입력 */
	gfnGetFormJSON();

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	/* expo id 조회 */
	sendForm("POST", "/mgnt/expo_id", "application/json; charset=utf-8", "json", pParamJson, function(message1) {

		if(message1.result_code == 0) {

			if(message1.expoId != getValue("ev_expo_id") && message1.expoId != "0") {
				if(!confirm("사용여부를 사용으로 입력 시 기존 엑스포는 미사용 처리됩니다.\r\n계속 진행하시겠습니까?")) return false;
			}

			sendForm("POST", "/mgnt/expo_insert", "application/json; charset=utf-8", "json", pParamJson, function(message) {

				if(message == "parsererror") {
					alert("로그아웃되었습니다.");
					document.location.href="/m.do";
				} else if(message.result_code == 0) {
					var msg = "엑스포 정보를 등록되었습니다.";
					alert(msg);
					document.location.href="/mgnt/expo";
				} else {
					if(message.result_code == undefined || message.session_yn == "N") {
						alert("로그아웃되었습니다.");	
						document.location.href="/index";
					} else {
						alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
					}
				}

			});	
		}
	});
	
}

</script>