<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>

/**
 * Script 설정
 */
var lComm;
$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();

	var pParamJson = '{"page_current":"1"}';

	/* 부스즐겨찾기 조회 */
	sendForm("POST", "/mypage/favorts", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message.result_code == 0) {

			var pTableInfo = 
			{
				table_class : 'table table-striped table-hover table-sm border-bottom',
				table_style : '',
				column:
				[
					{
						id 			: 'rn',
						col_name	: '번호',
						col_style	: 'scope="col" width="10%" class="text-center"',
						body_style 	: 'cope="row" class="text-center"'
					},
					{
						id 			: 'favorts_cust_nm',
						col_name	: '부스명',
						col_style	: 'scope="col" width="40%" class="text-left"',
						body_style 	: 'class="text-left"'
					},
					{
						id 			: '',
						col_name	: '즐겨찾기내역',
						col_style	: 'scope="col" width="25%" class="text-center"',
						body_style 	: 'class="text-center"',
						body_fixVal : '<img src="/image/star.png" width="20rem"/>'
					},	
					{
						id 			: '',
						col_name	: '부스바로가기',
						col_style	: 'scope="col" width="25%" class="text-center"',
						body_style 	: 'class="text-center"',
						body_fixVal : '<img src="/image/medal.png" width="20rem"/>'
					}				
				]
			};

			var pTableData = message.data;

			/*
			* @param {*} pParentId    table 들어갈 위치 (parent)
			* @param {*} pTableId     table id
			* @param {*} pTableInfo   table 속성
			* @param {*} pTableData   table 데이터
			*/
			setTable("divFavorit", "tbFavorit", pTableInfo, pTableData);

			/* 전체건수 */
			$('#spCnt').text(message.page_row_cnt);

			/* 페이징 처리 */

		} else {
			alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
		}

	});

});

</script>