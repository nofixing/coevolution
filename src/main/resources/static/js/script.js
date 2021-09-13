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
     url = "http://direct-sks.com/expo?"+"stockcode="+target+"&cust_id="+custid+"&cust_seq="+custseq+"&hp_no="+hp+"&event_day="+eventday;
    }else{
     url = "http://m.direct-sks.com/expo?"+"stockcode="+target+"&cust_id="+custid+"&cust_seq="+custseq+"&hp_no="+hp+"&event_day="+eventday;
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

		alert('이벤트가 종료되었습니다.');
		$('.wrap .box').removeClass('on');
		$('#layer-popup-01').fadeOut(150);

		return false;

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



    });
});
