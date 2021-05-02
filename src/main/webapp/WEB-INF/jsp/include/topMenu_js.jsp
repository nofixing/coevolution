<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="/assets/libs/jquery/dist/jquery.min.js"></script>

<!-- Common JS -->
<script src="/js/common.js"></script>

<script>

/**
 * Script 설정
 */
var lComm;

$(document).ready(function() {
	//초기 값 설정
	lComm = new gfnComm();

	$('#searchCategori').on('click', function () {
		searchCategori(1);
	});	

	$('#top_corp_search').on('click', function () {
		searchCategori(1);
	});	

	/* 카테고리 코드 조회 */
	searchCode();
});

/* 카테고리 코드 조회 */
function searchCode() {

	/* JSON 생성을 위해 입력*/
	gfnPutObj("UPPER_CD", "106000");

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/member/com_cd", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message.result_code == 0) {
			<c:if test="${sessionScope.LANG eq 'en'}">
				setSelectOption("top_category", message.C106000, "", "ALL");
			</c:if>
			<c:if test="${sessionScope.LANG ne 'en'}">
			setSelectOption("top_category", message.C106000, "", "전체");
			</c:if>
		} else {
			alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
		}

	});		
}

/* 참가기업검색 */
function searchCategori(pCurrentPage) {

	/* JSON 생성을 위해 입력*/
	gfnPutObj("category"		, getValue("top_category"));
	gfnPutObj("keyword"			, getValue("top_keyword"));
	gfnPutObj("page_current"	, pCurrentPage); /* 현재페이지 */

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/member/search_corp_search", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message.result_code == 0) {
			setCategoriHtml(message.corpList, message.zoomList);

			/* 총건수, 현재이지, view row, 호출할 function */
			var pageHtml = setPaging(message.row_count, message.page_current, message.page_row_cnt, "searchCategori");
			$('#top_corp_page').html(pageHtml);

		} else {
			alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
		}

	});		
}

/* 즐겨찾기를 등록한다. */
function top_favorit(pCustId) {
	
	/* JSON 생성을 위해 입력*/
	gfnPutObj("favorts_cust_id", pCustId);

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/vr/favorts/insert", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message.result_code == 0) {
			
			if(message.favorit_yn == "Y") {
				lComm.setCssAdd("top_favorit_"+pCustId,"text-warning");
			} else {
				lComm.setCssRemove("top_favorit_"+pCustId,"text-warning");
			}

		} else {
			if(message.result_code == (-999)) {
				alert("로그인 후 사용할 수 있습니다.");
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}
		}

	});	
}

/* 뱃지를 등록한다. */
function top_badge(pCustId) {

	/* JSON 생성을 위해 입력*/
	gfnPutObj("give_cust_id", pCustId);

	/* global 변수 json으로 변환 */
	var pParamJson = gfnGetJson();

	sendForm("POST", "/vr/badge/insert", "application/json; charset=utf-8", "json", pParamJson, function(message) {

		if(message.result_code == 0) {
			
			if(message.badge_yn == "Y") {
				lComm.setCssAdd("top_badge_"+pCustId,"text-warning");
			} else {
				lComm.setCssRemove("top_badge_"+pCustId,"text-warning");
			}

		} else {
			if(message.result_code == (-999)) {
				alert("로그인 후 사용할 수 있습니다.");
			} else {
				alert("서버 오류입니다.\r\n잠시 후 다시 진행하시기 바랍니다.");
			}
		}

	});	

}

function setCategoriHtml(corpList, zoomList) {

	/* 카테고리 */
	vCategoriHtml = '';

	for(var i = 0; i < corpList.length; i++) {
		vCategoriHtml += '<div class="row search-item align-items-center text-nounderline"> ';
		vCategoriHtml += '    <div class="col-12 col-sm-3"> ';
		vCategoriHtml += '        <!-- Image --> ';
		vCategoriHtml += '        <img src="/files'+lComm.nvl(corpList[i].ci_url,"#!")+'" class="mb-3" style="width: 110px;" onerror="this.style.display=\'none\'"> ';
		vCategoriHtml += '    </div> ';
		vCategoriHtml += '    <div class="col-12 col-sm-5 mb-0"> ';
		vCategoriHtml += '        <!-- Heading --> ';
		vCategoriHtml += '        <h5 class="mb-0"> ';
		vCategoriHtml += 	corpList[i].cust_nm ;
		vCategoriHtml += '        </h5> ';
		vCategoriHtml += '        <!-- Meta --> ';
		vCategoriHtml += '        <p class="mb-0 text-xs text-muted"> ';
		vCategoriHtml += '            <strong class="text-body"> ' + corpList[i].category1_nm + ' </strong> ';
		vCategoriHtml += '        </p> ';
		vCategoriHtml += '        <!-- Text --> ';
		vCategoriHtml += '        <p class="mb-0 text-sm text-muted"> ';

		if(corpList[i].category2 != "" && corpList[i].category2 != null) {
			vCategoriHtml += '        <h4><span class="badge bg-info "><small class="text-white"> ' + corpList[i].category2 + ' </small></span></h4> ';
		}

		for(var j = 0; j < zoomList.length; j++) {
			if(corpList[i].cust_id == zoomList[j].cust_id) {
				if(zoomList[j].use_yn == "Y") {
					vCategoriHtml += '		<div style="display:inline;" id="'+zoomList[i].zoom_id+'"><img src="/images/zoom.png" style="width:30px;cursor:pointer"  onClick="doZoom(\''+zoomList[j].zoom_url+'\')"></div>';
				} else {
					vCategoriHtml += '		<div style="display:inline;" id="'+zoomList[i].zoom_id+'"><img src="/images/zoomx.png" style="width:30px;"></div> ';
				}
			}
		}

		vCategoriHtml += '        </p> ';
		vCategoriHtml += '    </div> ';
		vCategoriHtml += '    <div class="col-12 col-sm-4 text-left pr-0"> ';
		vCategoriHtml += '        <!-- 즐겨찾기/관심뱃지 --> ';
		vCategoriHtml += '        <div class="row col-12 justify-content-between"> ';
		vCategoriHtml += '            <a href="'+ corpList[i].vr_shortcut_url+'" class="basic-btn"><spring:message code="top.goto" text="바로가기"/></a> '; 

		vCategoriHtml += '				<a href="javascript:top_favorit(\''+corpList[i].cust_id+'\')"> ';
		if(corpList[i].favorts_yn == "Y") {
			vCategoriHtml += '           <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-bookmark-star text-warning" viewBox="0 0 16 16" id="top_favorit_'+corpList[i].cust_id+'"> ';
		} else {
			vCategoriHtml += '           <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-bookmark-star" viewBox="0 0 16 16" id="top_favorit_'+corpList[i].cust_id+'"> ';
		}

		vCategoriHtml += '                <path d="M7.84 4.1a.178.178 0 0 1 .32 0l.634 1.285a.178.178 0 0 0 .134.098l1.42.206c.145.021.204.2.098.303L9.42 6.993a.178.178 0 0 0-.051.158l.242 1.414a.178.178 0 0 1-.258.187l-1.27-.668a.178.178 0 0 0-.165 0l-1.27.668a.178.178 0 0 1-.257-.187l.242-1.414a.178.178 0 0 0-.05-.158l-1.03-1.001a.178.178 0 0 1 .098-.303l1.42-.206a.178.178 0 0 0 .134-.098L7.84 4.1z"/> ';
		vCategoriHtml += '                <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z"/> ';
		vCategoriHtml += '            </svg> </a>';

		vCategoriHtml += '				<a href="javascript:top_badge(\''+corpList[i].cust_id+'\')"> ';
		if(corpList[i].badge_yn == "Y") {
			vCategoriHtml += '            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-award text-warning" viewBox="0 0 16 16" id="top_badge_'+corpList[i].cust_id+'"> ';
		} else {
			vCategoriHtml += '            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-award" viewBox="0 0 16 16" id="top_badge_'+corpList[i].cust_id+'"> ';
		}

		vCategoriHtml += '                <path d="M9.669.864L8 0 6.331.864l-1.858.282-.842 1.68-1.337 1.32L2.6 6l-.306 1.854 1.337 1.32.842 1.68 1.858.282L8 12l1.669-.864 1.858-.282.842-1.68 1.337-1.32L13.4 6l.306-1.854-1.337-1.32-.842-1.68L9.669.864zm1.196 1.193l.684 1.365 1.086 1.072L12.387 6l.248 1.506-1.086 1.072-.684 1.365-1.51.229L8 10.874l-1.355-.702-1.51-.229-.684-1.365-1.086-1.072L3.614 6l-.25-1.506 1.087-1.072.684-1.365 1.51-.229L8 1.126l1.356.702 1.509.229z"/> ';
		vCategoriHtml += '                <path d="M4 11.794V16l4-1 4 1v-4.206l-2.018.306L8 13.126 6.018 12.1 4 11.794z"/> ';
		vCategoriHtml += '            </svg> </a>';

		vCategoriHtml += '        </div> ';
		vCategoriHtml += '    </div> ';
		vCategoriHtml += '</div>  ';
		vCategoriHtml += '<hr class="my-1"><!-- / .row --> ';

	}

	if(corpList.length == 0) {
		vCategoriHtml += '<div class="row search-item align-items-center text-nounderline"> ';
		vCategoriHtml += '    <div class="col-sm-12 text-center"> ';
		vCategoriHtml += '        조회된 내역이 없습니다. ';
		vCategoriHtml += '    </div> ';
		vCategoriHtml += '</div>  ';
		vCategoriHtml += '<hr class="my-1"><!-- / .row --> ';
	}

	$('#div_categori').html(vCategoriHtml);
}



</script>