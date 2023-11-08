function reserveok(){
//var rnum = document.querySelector('input[name="rnum"]:checked');
	if(r.rday.value==""){
		alert("예약일자가 선택되지 않았습니다.");
	}
	else if(r.rtime.value==""){
		alert("예약시간이 선택되지 않았습니다.");
	}
	else if(r.rnum.value==""){
		alert("인원수가 선택되지 않았습니다.");
	}
	else{
		r.submit();
	}
};
