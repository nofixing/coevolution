/**
* 2020-10-18 공통 스크립트
*
* ajax 연결
* sendForm(pMethod, pUrl) 
*   pMethod     : GET, POST
*   pUrl        :  전송URL
*   pParamJson  : JSON형식의 Parameter
*
* 공통팝업
* gfnAlert (pType, pTitle, pContents)
*   pType : confirm/CONFIRM - YES OR NO
*           alert / ALERT   - 확인
*   pTitle : 팝업제목
*   pContents : 팝업내용
*
* gfnClearObj() : global 변수 초기화
*
* gfnPutObj(pKey, pValue)
* object 변수에 값을 입력한다.
* @param {*} pKey 
* @param {*} pValue 
*
* gfnGetJson(pArray)
* array를 json 형태로 변환한다.
* @param {*} pArray 
*
* gfnGetObj(pKey)
* object 값을 return한다.
* @param {} pKey 
*
* 쿠키를 저장한다
* @param {*} cname 
* @param {*} cvalue 
* @param {*} exdays 
* setCookie(cname, cvalue, exdays) 
*
* 쿠키를 읽어온다.
* @param {*} cname 
* getCookie(cname) 
*
* 날짜 Class
* gfnDate.prototype
* 당일일자 리턴 
* getToday : function(pParam)
*
* 테이블 생성
* @param {*} pParentId    table 들어갈 위치 (parent)
* @param {*} pTableId     table id
* @param {*} pTableInfo   table 속성
* @param {*} pTableData   table 데이터
* function setTable(pParentId, pTableId, pTableInfo, pTableData) 
*
    var pTableInfo = 
    {
      table_class : 'table table-striped',
      table_style : '',
      column:
        [
          {
            id 			: 'PART_CD_NM',
            col_name	: '구분',
            col_style	: 'width:25%;',
            body_style 	: ''
          }
        ]
    };

    var pTableData = [{"ACCOUNT_CD_ID":"100250","PART_CD_NM":"\\ud1b5\\uc7a5","ACCOUNT_NM":"\\uac10\\uc0ac\\ud5cc\\uae08","INC_AMT":"520000","SPT_AMT":"0"}];
 *

/**
 * 페이징 처리를 진행한다.
 * @param {*} pTotalCnt  총건수
 * @param {*} pCurrentPage  현재페이지
 * @param {*} pPagingViewCnt  화면에 보여질 row 건수
 * @param {*} pFunction  페이지 클릭 시 호출할 function 
 * var pageHtml = setPaging(message.row_count, message.page_current, message.page_row_cnt, "searchCategori");
function setPaging(pTotalCnt, pCurrentPage, pPagingViewCnt, pFunction) {

 * 값을 조회한다.
 * @param {*} pId 
function getValue(pId) 

 * 값을 입력한다.
 * @param {*} pId 
 * @param {*} pValue 
function setValue(pId, pValue) 

  * 필수항목체크
  * @param {*} pRequiredItems 
  fnRequiredItems : function (pRequiredItems) {
*/

/**
 * select box option 입력
 * setSelectOption("country_cd", message.countrylist);
 * @param {*} pId 
 * @param {*} pOptionList 
 * function setSelectOption(pId, pOptionList) {
 * 
 /**
 * checkbox, radio 값을 셋팅한다.
 * setCheckRadioList("checkbox", "S", message.list1, "list1", "<li>", "</li>");
 * @param {*} pClsf 
 * @param {*} vPrefix 
 * @param {*} valueList 
 * @param {*} pId 
 * function setCheckRadioList(pClsf, vPrefix, valueList, pId, startHtml, endHtml) { 

/**  ajax 연결
* sendForm(pMethod, pUrl) 
*   pMethod     : GET, POST
*   pDataType   : JSON, TEXT 등등..
*   pUrl        :  전송URL
*   pParamJson  : Parameter
**/
function sendForm(pMethod, pUrl, pcontentType, pDataType, pParamJson, callback) {

  if(pParamJson.substring(0,1) == "[") {
    pParamJson = pParamJson.substring(1, (pParamJson.length-1));
  }
  
  var request = $.ajax({   
    url: pUrl,   
    type: pMethod,  
    contentType: pcontentType, 
    data: pParamJson,   
    dataType: pDataType 
  });   
   
  request.done(function(msg) {   
    if(typeof callback === "function") {
      callback(msg);
    }
  });   
   
  request.fail(function(jqXHR, textStatus) {   
    if(typeof callback === "function") {
      callback(textStatus);
    }   
  }); 

}

/**
 * 파일전송
 * @param {*} pUrl 
 * @param {*} pFormData  
 * @param {*} callback 
 */
function sendFormFile(pUrl, pFormData, callback) {

	$.ajax({

		type: "POST",
		url: pUrl,
		data: pFormData,
		processData: false,
		contentType: false,
		cache: false,
		timeout: 600000,
		success: function (msg) {
      if(typeof callback === "function") {
        callback(msg);
      }
		},
		error: function (e) {
      if(typeof callback === "function") {
        callback(e);
      }   
		}
	});

}

/**
* 공통팝업
* gfnAlert (pType, pTitle, pContents)
*   pType : confirm/CONFIRM - YES OR NO
*           alert / ALERT   - 확인
*   pTitle : 팝업제목
*   pContents : 팝업내용
*   callback : callback 함수
*   사용방법
*		gfnAlert ("confirm", "ajax error", "통신오류가 발생하였습니다.["+this.status + "(" + this.readyState + ")]", function(rtnValue){
    });
**/
function gfnAlert (pType, pTitle, pContents, callback) {

      /* 기존 alert 창이 있으면 삭제 */
      if(document.getElementById("showModal")) {
        $("showModal").remove();
      }

      /* vr_ 시작하는 경우 iframe 으로 처리한다. */
      if(pContents.substring(0,2).toUpperCase() == "VR") {
        pContents = "<iframe height='540px' width='100%' src='/vr/"+pContents+"' frameborder='0'></iframe>";
      }

      rtnValue = false;

      var modlContents = "";
      modlContents += '<div class="modal fade" id="showModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">';
      //modlContents += '  <div class="modal-dialog modal-dialog-centered modal-dialog-video modal-lg" role="document">'; 흰바탕없음
	  modlContents += '  <div class="modal-dialog modal-dialog-centered" role="document">';
      modlContents += '    <div class="modal-content">';
      modlContents += '      <div class="modal-header">';
      modlContents += '         <h4 class="modal-title" id="myModalLabel">'+pTitle+'</h4>';
      modlContents += '         <button type="button" class="close" data-dismiss="modal" aria-label="Close">';
      modlContents += '           <span aria-hidden="true">&times;</span>';
      modlContents += '         </button>';
      modlContents += '      </div>';
      modlContents += '      <div class="modal-body border border-1 pt-3">';
      modlContents += pContents
      modlContents += '      </div>';
      modlContents += '      <div class="modal-footer" id="showFooter">';
  
      if(pType.toUpperCase() == "CONFIRM") {
        modlContents += '        <button type="button" class="basic-btn" id="showModalOK">확인</button>';
      }
      
      if(pType.toUpperCase() == "CONFIRM" || pType.toUpperCase() == "ALERT") {
        modlContents += '        <button type="button" class="basic-btn" data-bs-dismiss="modal" id="showModalClose">닫기</button>';
      }
      
      modlContents += '      </div>';
      modlContents += '    </div>';
      modlContents += '  </div>';
      modlContents += '</div>';


      document.getElementById("mainBody").insertAdjacentHTML("afterend", modlContents);

      $("#showModalOK").click(function() {
        $("#showModal").modal("hide");
        if(typeof callback === "function") {
          callback(true);
        }   
      });  
      
      $("#showModalClose").click(function() {
        $("#showModal").modal("hide");
        if(typeof callback === "function") {
          callback(false);
        }   
      }); 
  
      $("#showModal").modal();
  }

  /**
   * 팝업 alert
   * pDiv : 표시할 위치의 div id
   * pMessageGubn : warning, primary, success, info, danger
   * pContents : 팝업내용
   * callback : callback 함수
   * 사용방법
   * gfnAlertXx ("warning", "입력하세요", function(rtnValue){
     });
   */
  function gfnAlertX (pDivId, pMessageGubn, pContents, callback) {
    /* 기존 alert 창이 있으면 삭제 */
    if(document.getElementById("showModal")) {
      $("showModal").remove();
    }

    var modlContents = "";
    modlContents += '<div id="gfnMyAlert" class="alert alert-'+pMessageGubn+' alert-dismissible fade in" role="alert">';
    modlContents += '  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>';
    modlContents += pContents;
    modlContents += ' </div>';

    document.getElementById(pDivId).insertAdjacentHTML("afterend", modlContents);

    if(typeof callback === "function") {
      $('#gfnMyAlert').on('closed.bs.alert', function () {
        callback(false);
      });
    }
}

function gfnPopup (pUrl, pTitle, pWidth, pHeight, callback) {

/* 기존 alert 창이 있으면 삭제 */
	if(document.getElementById("showModal")) {
		$("showModal").remove();
	}

	pContents = "<iframe height='"+pHeight+"' width='"+pWidth+"' src='"+pUrl+"' frameborder='0'></iframe>";

	rtnValue = false;

	var modlContents = "";
	modlContents += '<div class="modal fade" id="showModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">';
	//modlContents += '  <div class="modal-dialog modal-dialog-centered modal-dialog-video modal-lg" role="document">'; 흰바탕없음
	modlContents += '  <div class="modal-dialog modal-dialog-centered" role="document">';
	modlContents += '    <div class="modal-content">';
	modlContents += '      <div class="modal-header">';
	modlContents += '         <h4 class="modal-title text-white" id="myModalLabel">'+pTitle+'</h4>';
	modlContents += '         <button type="button" id="popupBtnClose" class="close" data-dismiss="modal" aria-label="Close">';
	modlContents += '           <span aria-hidden="true">&times;</span>';
	modlContents += '         </button>';
	modlContents += '      </div>';
	modlContents += '      <div class="modal-body">';
	modlContents += pContents
	modlContents += '      </div>';
	modlContents += '    </div>';
	modlContents += '  </div>';
	modlContents += '</div>';

	document.getElementById("mainBody").insertAdjacentHTML("afterend", modlContents);

    if(typeof callback === "function") {
      $('#showModal').on('hide.bs.modal', function () {
        callback("close");
      });
    }

	$("#showModal").modal();
}

/* global object 변수 */
var gDataObjectPutGet;
var gDataArrayPutGet;

/**
 * gfnClearObj() 
 * global 변수 초기화
 **/
function gfnClearObj() {
  this.gDataObjectPutGet = null;
  this.gDataArrayPutGet = null;
}

/**
 * object 변수에 값을 입력한다.
 * @param {*} pKey 
 * @param {*} pValue 
 */
function gfnPutObj(pKey, pValue) {

  if(typeof gDataObjectPutGet == "undefined" || gDataObjectPutGet == null) {
    this.gDataObjectPutGet = new Object();
  }
  
  this.gDataObjectPutGet[pKey] = pValue;
}

function lfnPutObj(pDataObjectPutGet, pKey, pValue) {
  pDataObjectPutGet[pKey] = pValue;
}

function lfnGetObj(pDataObjectPutGet, pKey) {

  var returnValue = "";

  if(typeof eval("pDataObjectPutGet."+pKey) == "undefined" || eval("pDataObjectPutGet."+pKey) == null) {
    returnValue = "";
  } else {
	returnValue = eval("pDataObjectPutGet."+pKey);
  }

  return returnValue;

}

/**
 * array를 json 형태로 변환한다.
 * @param {*} pArray 
 */
function gfnGetJson(pArray) {

  if(typeof gDataArrayPutGet == "undefined" || gDataArrayPutGet == null) {
    this.gDataArrayPutGet = new Array();
  }

  this.gDataArrayPutGet.push(this.gDataObjectPutGet);

  // String 형태로 변환
  var jsonStr;
  if(pArray != null && pArray != "" && pArray.length > 0) {
    jsonStr = JSON.stringify(pArray);
  } else {
    jsonStr = JSON.stringify(this.gDataArrayPutGet);
  }

  gfnClearObj();

  return jsonStr;
}

/**
 * object 값을 return한다.
 * @param {} pKey 
 */
function gfnGetObj(pKey) {
  var returnValue = "";

  for(var i = 0; i < this.gDataArrayPutGet.length; i++) {
    var obj = this.gDataArrayPutGet[i];

    if(this.gDataObjectPutGet.KEY == pKey) {
      returnValue = this.gDataObjectPutGet.KEY_VALUE;
    }
  }

  return returnValue;
}

/**
 * from input 정보를 JOSN형태로 입력
 */
function gfnGetFormJSON() {
  $(':input').each(function(index) {
    if($(this).get(0).type == "radio") {
      if($(this).get(0).checked) {
        gfnPutObj($(this).get(0).name, $(this).get(0).value);	
      }
    } else if($(this).get(0).type == "checkbox") {
      if($(this).get(0).checked) {
        gfnPutObj($(this).get(0).name, $(this).get(0).value);	
      } else {
        gfnPutObj($(this).get(0).name, "");	
      }
    } else if($(this).get(0).type == "button" || $(this).get(0).type == "submit") {
    } else {
      gfnPutObj($(this).get(0).id, $(this).get(0).value);
    } 
  });
}

/**
 * 쿠키를 저장한다
 * @param {*} cname 
 * @param {*} cvalue 
 * @param {*} exdays 
 */
function setCookie(cname, cvalue, exdays) {
  var d = new Date();
  d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
  var expires = "expires="+d.toUTCString();
  document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

/**
 * 쿠키를 읽어온다.
 * @param {*} cname 
 */
function getCookie(cname) {
  var name = cname + "=";
  var ca = document.cookie.split(';');
  for(var i = 0; i < ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) == ' ') {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";
}

/**
 * 쿠키를 삭제한다.
 * @param {*} cname
 */
function deleteCookie(cname){
  var expireDate = new Date();

  expireDate.setDate(expireDate.getDate() - 1);

  document.cookie = cname + "= " + "; expires=" + expireDate.toGMTString();
}

/**
 * 현재날짜를 리턴한다 (2020-01-01)
 * @param {*} pParam 
 */
var gfnNowDate;
gfnComm = function(){   
  this.gfnNowDate =  new Date();
}; 

gfnComm.prototype = {
  /* 당일일자 리턴 */
  getToday : function(pParam) {
    return this.gfnNowDate.getFullYear() 
          + pParam + (Number(this.gfnNowDate.getMonth())+1 < 10 ? "0"+(Number(this.gfnNowDate.getMonth())+1) : (Number(this.gfnNowDate.getMonth())+1))
          + pParam + (Number(this.gfnNowDate.getDate()) < 10 ? "0"+(Number(this.gfnNowDate.getDate())) : (Number(this.gfnNowDate.getDate())));
  },

  addDays(date, days, pParam) {
    var result = new Date(date);
    result.setDate(result.getDate() + days);

    return result.getFullYear() 
          + pParam + (Number(result.getMonth())+1 < 10 ? "0"+(Number(result.getMonth())+1) : (Number(result.getMonth())+1))
          + pParam + (Number(result.getDate()) < 10 ? "0"+(Number(result.getDate())) : (Number(result.getDate())));    
  },

  /* 숫자 콤마 */
  setNumberComma : function(pParam) {
    return pParam.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  },

  /* 치환하기 */
  replaceAll : function (strTemp, strValue1, strValue2) { 

    while(1) {
        if( strTemp.indexOf(strValue1) != -1 )
            strTemp = strTemp.replace(strValue1, strValue2);
        else
            break;
    }

    return strTemp;
  },

  /* null값 치환 */
  nvl : function (pValue, pReplace) {

    var rtn = pValue;
    if(pValue == "" || pValue == undefined || pValue == null) {
      rtn = pReplace;
    }

    return rtn;
  },

  /* Null 체크 */
  isNull : function (pValue) {
    if(pValue == "" || pValue == undefined || pValue == null) {
      return true;
    } else {
      return false;
    }
  },

  /**
   * css를 변경한다.
   * @param {*} pId 
   * @param {*} pReMoveClass 
   * @param {*} pAddClass 
   */
  setCssChange : function (pId, pReMoveClass, pAddClass) {
    $("#"+pId).removeClass(pReMoveClass);
    $("#"+pId).addClass(pAddClass);
  },

  setCssRemove : function (pId, pReMoveClass) {
    $("#"+pId).removeClass(pReMoveClass);
  },

  setCssAdd : function (pId, pAddClass) {
    $("#"+pId).addClass(pAddClass);
  },

  /**
   * 전화번호 체크
   * @param {*} pTelNo 
   */
  chkTelNo : function (pTelNo) {
		var myRe = new RegExp('[0-9]{3}-[0-9]{4}-[0-9]{4}', 'g');
		var myArray = myRe.exec(pTelNo);
    
    if(pTelNo.length < 11 || pTelNo.length > 13) {
      return false;
    }

		if(lComm.isNull(myArray)) {
			//서울패턴
			myRe = new RegExp('[0-9]{2}-[0-9]{4}-[0-9]{4}', 'g');
			myArray = myRe.exec(pTelNo);

			if(lComm.isNull(myArray)) {
				//서울패턴
				myRe = new RegExp('[0-9]{2}-[0-9]{3}-[0-9]{4}', 'g');
				myArray = myRe.exec(pTelNo);
			}
    }
    
    if(this.isNull(myArray)) {
      return false;
    } else {
      return true;
    }
  },

  /**
   * 전화번호
   * @param {*} pValue 
   */
  setTelNoFormat : function (pValue) {
    
    pValue = pValue.replaceAll("-","");

    if(pValue.length >= 2) {
      if(pValue.substring(0,2) == "02") {
        if(pValue.length >= 2 && pValue.length <= 6) {
          pValue = pValue.substring(0,2) + "-" + pValue.substring(2,pValue.length)
        } else if(pValue.length >= 7 && pValue.length <= 9) {
          pValue = pValue.substring(0,2) + "-" + pValue.substring(2,5) + "-"+ pValue.substring(5,pValue.length);
        } else if(pValue.length == 10) {
          pValue = pValue.substring(0,2) + "-" + pValue.substring(2,6) + "-"+ pValue.substring(6,pValue.length);
        } 
      } else {
        if(pValue.length >= 3 && pValue.length <= 7) {
          pValue = pValue.substring(0,3) + "-" + pValue.substring(3,pValue.length)
        } else if(pValue.length >= 8 && pValue.length <= 11) {
          pValue = pValue.substring(0,3) + "-" + pValue.substring(3,7) + "-"+ pValue.substring(7,pValue.length);
        } 
      }
    }

    return pValue;

  },

  /**
   * 포커스 이동
   * @param {*} pId 
   */
  setFocus: function (pId) {
    $("#"+pId).focus();
  }
  , 

  /**
   * 필수항목체크
   * @param {*} pRequiredItems 
   */
  fnRequiredItems : function (pRequiredItems) {

    for(var irow in pRequiredItems) {
      if(this.isNull(getValue(pRequiredItems[irow].id))) {
        alert(pRequiredItems[irow].name + " 은(는) 필수 항목입니다.");
        this.setFocus(pRequiredItems[irow].id);
        return false;
      }
    }

    return true;
  }
  ,
  fnRequiredItemsChkRdo : function (pRequiredItems) {

    for(var irow in pRequiredItems) {

      if(!checked(pRequiredItems[irow].id)) {
        alert(pRequiredItems[irow].name + " 은(는) 필수 항목입니다.");
        this.setFocus(pRequiredItems[irow].id);
        return false;
      }
      
    }

    return true;
  }
}

/**
 * 테이블 생성
* @param {*} pParentId    table 들어갈 위치 (parent)
* @param {*} pTableId     table id
* @param {*} pTableInfo   table 속성
* @param {*} pTableData   table 데이터
 */
function setTable(pParentId, pTableId, pTableInfo, pTableData) {
  
  var comm = new gfnComm();

  var column_cnt = pTableInfo.column.length;
  console.log("column_cnt : " + column_cnt);

  /* 기존 테이블 삭제 */
  console.log("pTableId : " +  $("#"+pTableId).id);

  if(typeof $("#"+pTableId) == 'object') {
    $("#"+pTableId).remove();
  }  

  /* 테이블 생성 */
  var tableMain = $('<table/>', {id:pTableId, class:pTableInfo.table_class, style:pTableInfo.table_style});
  var sumCols = pTableInfo.sum_columns;

  /* 합계를 구할 경우 */
  var sum_columns, sum_index; /* 컴럼명,  pTableInfo의 컬럼 index */

  if(sumCols != "" && sumCols != undefined) {
    sum_columns = sumCols.split(";");
    sum_index = sum_columns;
  }

  if(sum_columns == undefined) {
    sum_columns = new Array();
    sum_index = new Array();
  }

  var theadMain = $('<thead/>');
  tableMain.append(theadMain);

  var theadTr = $('<tr/>');
  theadMain.append(theadTr);
  
  /* 테이블 명 설정 */
  for(var i = 0; i < column_cnt; i++) {

    if(pTableInfo.column[i].col_style != "") {
      theadTr.append($('<th '+pTableInfo.column[i].col_style+'>'+pTableInfo.column[i].col_name+'</th>'));
    } else {
      theadTr.append($('<th>'+pTableInfo.column[i].col_name+'</th>'));
    }

    /* 합계 표시 컬럼 설정 */
    if(sumCols != "") {
      for(var j = 0; j < sum_columns.length; j++ ) {   
        if (sum_columns[j] == pTableInfo.column[i].id) {
          sum_index[j] = {"id":pTableInfo.column[i].id, "sum":0, "colspan":i, "col_style":pTableInfo.column[i].col_style};
        }
      }
    }
  }


  /* 바디생성 */
  var trBody = $('<tbody/>');
  var row_cnt = pTableData.length;

  for(var i = 0; i < row_cnt; i++) {
    
    var trTr = $('<tr/>');
  
    for(var j = 0; j < column_cnt; j++) {

      var colValue = "";
      if(pTableInfo.column[j].body_fixVal != "" && pTableInfo.column[j].body_fixVal != undefined) {
        colValue = pTableInfo.column[j].body_fixVal;
      } else {
        //colValue = unescape(comm.replaceAll(eval("pTableData[i]."+pTableInfo.column[j].id), "\\", "%"));  
        colValue = eval("pTableData[i]."+pTableInfo.column[j].id);  
      }

      /* 콤마표시 */
      if(pTableInfo.column[j].number_comma == "Y") {
        colValue = comm.setNumberComma(colValue);
      }

      if(pTableInfo.column[j].body_style != "") {
        trTr.append($('<td '+pTableInfo.column[j].body_style+'>'+colValue+'</td>'));
      } else {
        trTr.append($('<td>'+colValue+'</td>'));
      }

    }

    trBody.append(trTr);

    /* 합계 계산 */
    for(var q = 0; q < sum_index.length; q++) {
      var totSum = Number(sum_index[q].sum) + Number(eval("pTableData[i]."+sum_index[q].id));
      sum_index[q] = {"id":sum_index[q].id, "sum":totSum, "colspan":sum_index[q].colspan, "col_style":sum_index[q].col_style};
    }
  }

  /* 데이터가 없을 경우 */
  if(pTableData.length == 0) {
    var trTr = $('<tr/>');
    trTr.append($('<td colspan='+column_cnt+' style="text-align:center">데이터가 없습니다.</td>'));
    trBody.append(trTr);
  }

  if(sum_index.length > 0) {
    var trTr = $('<tr/>');

    trTr.append($('<td class="bg-info" colspan="'+sum_index[0].colspan+'">합계</td>'));

    for(var q = 0; q < sum_index.length; q++) {
      var totSum = comm.setNumberComma(String(sum_index[q].sum));

      if(sum_index[q].col_style != "") {
        trTr.append($('<td class="bg-info" style="'+sum_index[q].col_style+'">'+totSum+'</td>'));
      } else {
        trTr.append($('<td class="bg-info">'+totSum+'</td>'));
      }      
      
    }    
  }

  trBody.append(trTr);

  tableMain.append(trBody);

  $('#'+pParentId).append(tableMain);
}

/**
 * 페이징 처리를 진행한다.
 * @param {*} pTotalCnt  총건수
 * @param {*} pCurrentPage  현재페이지
 * @param {*} pPagingViewCnt  화면에 보여질 row 건수
 * @param {*} pFunction  페이지 클릭 시 호출할 function 
 */
function setPaging(pTotalCnt, pCurrentPage, pPagingViewCnt, pFunction) {

  //페이징건수 (한번에 표시할 페이지)
  var vPagingViewCnt = pPagingViewCnt;

  if(pPagingViewCnt == "") {
	vPagingViewCnt = 10;
  }

  //총건수
  if(pTotalCnt == 0) pTotalCnt = 1;
  var vRowTotCnt = pTotalCnt;

  //현재페이지
  var currentPage = pCurrentPage;

  //다음페이지
  var nextPage = currentPage + 1;

  //이전페이지
  var privPage = currentPage - 1;

  //총페이지 수 계산
  var pageCnt = Math.floor(vRowTotCnt / vPagingViewCnt);

  var rminPageCnt = vRowTotCnt % vPagingViewCnt;
  
  //나머지값이 있으면 페이지 추가
  if(rminPageCnt > 0) {
    pageCnt += 1;
  }

  //다음페이지 총페이지수보다 클 경우 총페이지로 셋팅
  if(nextPage > pageCnt) nextPage = pageCnt;

  //이전페이지가 1페이지 보다 작을 경우 1페이지로 셋팅
  if(privPage < 1) privPage = 1;

  //시작페이지 계산
  var startPage = 1;
  // 1 ~ 10 page, 11 ~ 20 page
  var pagingGrp = Math.floor(currentPage / vPagingViewCnt);
  var pagingGrpRmin = currentPage % vPagingViewCnt;

  if(pagingGrpRmin > 0) {
    pagingGrp += 1;
  }

  var pagingList = "";
  var lastPage = (pagingGrp * vPagingViewCnt);

  if(lastPage > pageCnt) {
    lastPage = pageCnt;
  }

  //시작페이지
  startPage = (pagingGrp * vPagingViewCnt) - vPagingViewCnt + 1;

  for(var i = startPage; i <= lastPage; i++) {
    if(i == currentPage) {
      pagingList += "<li class='page-item page-link text-danger'>"+i+"</li>"
    } else {
      pagingList += "<li class='page-item'><a class='page-link' href='javascript:"+pFunction+"("+i+")'>"+i+"</a></li>"
    }
  }

  //처음/이전/이후/마지막
  //pagingList = "[처음 1]" + "[이전 "+privPage+"]" + pagingList + "[다음 " + nextPage + "]" + "[마지막 "+pageCnt+"]";
  pagingList = "<li class='page-item'><a class='page-link' href='javascript:"+pFunction+"("+privPage+")'>&lt;</a></li>"
             + pagingList 
             + "<li class='page-item'><a class='page-link' href='javascript:"+pFunction+"("+nextPage+")'>&gt;</a></li>";

  return pagingList;
}


/**
 * 값을 조회한다.
 * @param {*} pId 
 */
function getValue(pId) {
  var value = $('#'+pId).val();

  return value;
}

/**
 * 값을 입력한다.
 * @param {*} pId 
 * @param {*} pValue 
 */
function setValue(pId, pValue) {
  
  var tagNm = $('#'+pId).prop('tagName');

  if(tagNm.toUpperCase() == "SPAN" || tagNm.toUpperCase() == "DIV") {
    $('#'+pId).text(pValue);
  } else {
    $('#'+pId).val(pValue);
  }

}

function setText(pId, pValue) {
	$('#'+pId).text(pValue);
}

/**
 * 체크여부
 * @param {*} pId 
 */
function checked(pId) {
  return $("#"+pId).prop("checked");
}

/**
 * 체크처리
 * @param {*} pId 
 */
function gfnSetCheck(pId) {
  $("#"+pId).prop("checked", true);
}

function gfnSetUnCheck(pId) {
  $("#"+pId).prop("checked", false);
}

/**
 * select box option 입력
 * setSelectOption("country_cd", message.countrylist);
 * @param {*} pId 
 * @param {*} pOptionList 
 */
function setSelectOption(pId, pOptionList, pAddValue, pAddName, pForm) {

  if(pForm != "") {
	$("form[name='"+pForm +  "'] select[name='"+pId+"'] option").remove();
  }

  if(pAddValue != "" || pAddName != "") {
	$("#"+pId).append("<option value='"+pAddValue+"'>"+pAddName+"</option>");
  }

  for(var i = 0; i < pOptionList.length; i++) {
    $("#"+pId).append("<option value='"+pOptionList[i].cd_id+"'>"+pOptionList[i].cd_nm+"</option>");
  } 

}

/**
 * checkbox, radio 값을 셋팅한다.
 * setCheckRadioList("checkbox", "S", message.list1, "list1", "<li>", "</li>");
 * @param {*} pClsf 
 * @param {*} vPrefix 
 * @param {*} valueList 
 * @param {*} pId 
 */
function setCheckRadioList(pClsf, vPrefix, valueList, pId, startHtml, endHtml) {
  var vHtml = "";
  for(var i = 0; i < valueList.length; i++) {
    vHtml += startHtml+"<input type='"+pClsf+"' name='"+vPrefix + valueList[i].upper_cd_id+"' id='"+vPrefix + valueList[i].cd_id+"' value='"+valueList[i].cd_id+"'> <label for='"+vPrefix + valueList[i].cd_id+"'><span></span><p>"+valueList[i].cd_nm+"</p></label>"+endHtml;
  }

  $("#"+pId).html(vHtml);  
}


/* websoket */
var stompClient = null;

/**
 * 웹소켓접속
 */
function webSocketConnect(pSocketNm, callback) {

  var socket = new SockJS('/ws');

  stompClient = Stomp.over(socket);
  stompClient.connect({}, function (frame) {

    stompClient.subscribe('/topic/'+pSocketNm, function (chat) {
    	
      if(typeof callback === "function") {
          callback(JSON.parse(chat.body));
      }

    });

  });
  
}

/**
 *  공통코드를 조회한다
 * @param {*} pUpperCd 공통코드 Upper - 여러개를 조회할 경우 000,000 분리
 */
function gfnCommCode(pUpperCd) {

}

/**
 * Form ID를 기준으로 데이터를 셋팅한다.
 * @param {*} pJsonData field에 입력할 데이터 {"d":"d","n":"n"}
 */

function gfnSetField(pJsonData, pFieldArry) {

  for(var i = 0; i < pFieldArry.length; i++) {
    setValue(pFieldArry[i], eval("pJsonData."+pFieldArry[i]));
  }
}

/**
 * 이미지 뷰어
 * @param {*} pImageList 
 */
 
function imageViewer (pImageList) {

  
}

  /*
function doFunction(callback){
    // doFunction 에서 실행 될 내용들
    var a = 1;
    var b = 1;
    var c = a + b;
     
    alert('doFunction 에서 실행 될 내용이 실행된다.');
 
 
    // doFunction 에서 실행 될 내용들이 다 실행 된 후 인자값으로 받은 callback을 실행한다.
    // 넘겨받은 callback이 함수이기 때문에 실행 가능.
    // 이때 c 값을 인자값으로 넘겨준다.
    if(typeof callback === 'function') {
        callback(c);
    }
 
}


출처: https://yangyag.tistory.com/156 [Hello Brother!]

// 먼저 doFunction을 실행 시키고 callback 함수에 의해 function 안의 내용이 실행된다.
doFunction(function(msg){
 
    // doFunction 함수의 호출에 의해서 실행된다.
    // 인자값으로 받은 c값을 msg 로 받는다.
    alert('callback 함수의 실행 될 내용');
    alert('c 의 값은? ' + msg);
});


출처: https://yangyag.tistory.com/156 [Hello Brother!]

출처 : https://huskdoll.tistory.com/11
var channelInfoMap = new HashMap();

HashMap = function(){   
    this.map = new Array(); 
};   
HashMap.prototype = {   
    put : function(key, value){   
        this.map[key] = value; 
    },   
    get : function(key){   
        return this.map[key]; 
    },   
    getAll : function(){   
        return this.map; 
    },   
    clear : function(){   
        this.map = new Array(); 
    },   
    isEmpty : function(){     
         return (this.map.size() == 0); 
    }, 
    remove : function(key){     
         delete this.map[key]; 
    }, 
    toString : function(){ 
        var temp = ''; 
        for(i in this.map){   
            temp = temp + ',' + i + ':' +  this.map[i]; 
        } 
        temp = temp.replace(',',''); 
          return temp; 
    }, 
    keySet : function(){   
        var keys = new Array();   
        for(i in this.map){   
            keys.push(i); 
        }   
        return keys; 
    } 
};

  */
 