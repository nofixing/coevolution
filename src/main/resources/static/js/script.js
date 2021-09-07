function getStock(stockCode,stockCodeName,custid,custseq,hp,eventday,stockidx,personname){
    var target = stockCode;
    var isMobile = false;
    // PC 환경
    var filter = "win16|win32|win64|mac";
    if(navigator.platform){
       isMobile = filter.indexOf(navigator.platform.toLowerCase()) < 0;
    }
    var url="";
    if(isMobile == false){
     url = "http://direct-sks.com/expo?"+"stockCode="+target+"&cust_id="+custid+"&cust_seq="+custseq+"&hp_no="+hp+"&event_day="+eventday;
    }else{
     url = "http://m.direct-sks.com/expo?"+"stockCode="+target+"&cust_id="+custid+"&cust_seq="+custseq+"&hp_no="+hp+"&event_day="+eventday;
    }

    $('#stockCode').val(stockCode);
    $('#stockCodeName').val(stockCodeName);
    $('#cust_id').val(custid);
    $('#cust_seq').val(custseq);
    $('#hp_no').val(hp);
    $('#event_day').val(eventday);
    $('#stockidx').val(stockidx);
    $('#stockText').text(stockCodeName);
    $('#evPersonName').val(personname);
    $('#evUrl').val(url);
   // $('#stockBtn').attr('href', url);

}

$(document).on('click', 'a[href="#"]', function(e){
    e.preventDefault();
});


$(function() {
    $('.wrap .box .layer .btn').on('click', function() {

		// PC 환경
		var filter = "win16|win32|win64|mac";
		if(navigator.platform){
		   isMobile = filter.indexOf(navigator.platform.toLowerCase()) < 0;
		}

    /*
		if(isMobile){
			alert("지금은 PC에서만 참여 가능합니다.");
			return false;
		}
    */

        $('.wrap .box').addClass('on');

        var pParamJson = '{"cust_id":"${cust_id}"}';

        	sendForm("POST", "/event/stockissuance", "application/json; charset=utf-8", "json", pParamJson, function(message) {
                //alert(message.session_yn);
               // alert("badgeCnt==>" + message.badgeCnt);
                //alert(message.result_msg);

               if(message.session_yn == undefined || message.session_yn == 'N'){
                 alert('참관 등록 후 버추얼전시회에서 관심부스에 관심뱃지 3개 이상하셔야만 이벤트 참여 가능합니다');
                 location.href='/member/login_form';
                 return false;
               }else if(message.badgeCnt > 7) {
                 alert('버추얼전시회에서 관심부스에 관심뱃지 3개 이상하셔야만 이벤트 참여 가능합니다.');
                 location.href='/index/ieve2021';
                 return false;
               }else if(message.result_code == 100) {
                  alert('이미 참여하였습니다. 이벤트 기간 동안 한 번만 참여 가능합니다.');
                  location.href='/index/event';
                  return false;
               }else if(message.result_code == 0) {
               			//alert(message.stockCode);
               			setTimeout(function() {
                         $('#layer-popup-01').fadeIn(150);
                           getStock(message.stockCode,message.stockCodeName,message.cust_id,message.cust_seq,message.hp_no,message.event_day,message.stockidx,message.evPersonName);
                         }, 1500);
                         setTimeout(function() {
                         alert("아래 '당첨 정보 입력하기' 클릭 후 개인정보를 입력해주세요. 당첨 정보 미입력 시 경품 지급이 불가합니다.");
                          }, 2000);
               	}else if(message.result_code == -88) {
               	  alert("이벤트 기간이 아닙니다.");
               	  location.href='/ieve2021';
                  return false;
               	}else {
               		alert("시스템 관리자에게 문의하여 주시길 바랍니다.");
               		return false;
               	}
             });

        /*
        setTimeout(function() {
            getStock();
            $('#layer-popup-01').fadeIn(150);
        }, 1500);
        */
    });
    $('.popBtn').on('click', function() {
       var  stockCode, stockCodeName, custid, custseq, hp,eventday, stockidx,boardId,personname;
                stockCode = $('#stockCode').val();
                stockCodeName = $('#stockCodeName').val();
                custid = $('#cust_id').val();
                custseq = $('#cust_seq').val();
                hp = $('#hp_no').val();
                eventday = $('#event_day').val();
                stockidx  = $('#stockidx').val();
                boardId = $('#boardId').val();
                personname =$('#evPersonName').val();

             var dataList = new Array() ;
             var data = new Object() ;
             data.stockCode = stockCode;
             data.stockCodeName = stockCodeName;
             data.custid = custid;
             data.custseq = custseq;
             data.hp = hp;
             data.eventday = eventday;
             data.stockidx = stockidx;
             data.boardId = boardId;
             data.evPersonName = personname;
             dataList.push(data);

        var pParamJson = JSON.stringify(dataList) ;


       //var pParamJson =  '{"stockCode":stockCode,"stockCodeName":stockCodeName,"custid":custid,"custseq":custseq,"hp":hp,"eventday":eventday,"stockidx":stockidx}';
               	sendForm("POST", "/event/stockprocess", "application/json; charset=utf-8", "json", pParamJson, function(message) {
                      if(message.result_code == 100) {
                          alert('이벤트에 참여되었습니다. 당첨정보를 정확하게 입력해주세요.');
                         var options = 'width=500, height=600, top=30, left=30, resizable=no, scrollbars=no, location=no';
                         var url= $('#evUrl').val();
                         window.open(url, "eventpop", options);
                          $('.wrap .box').removeClass('on');
                          $('#layer-popup-01').fadeOut(150);

                            return false;
                      } else {
                      	alert("시스템 관리자에게 문의하여 주시길 바랍니다.");
                      	 return false;
                      }
                    });
    });
});
