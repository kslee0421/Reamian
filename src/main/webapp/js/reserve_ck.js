window.onload =function(){
	this.mid = document.querySelector("#mid").value;
	console.log(this.mid);
	fetch("./reserve_ck.do",{
		method:"POST",
		cache:"no-cache",
		headers:{
			"Content-Type":"application/x-www-form-urlencoded"
		},
		body:
			"userid="+this.mid// userid와 usertel로 컨트롤러에 넘기자
	}).then(function(aa){  //해당 파일을 통신을 통하여 배열로 변환작업
		return aa.text();
	}).then(function(bb){ //try 데이터 출력 
		console.log(bb);
	}).catch(function(error){ //error 예외처리로 데이터 에러 발생
		console.log("Data Error!!");
	});
	
};

function resmodify(){
		alert("예약수정은 한번만 가능합니다. 수정하시겠습니까?");
	if(resck.rday.value==""){
		alert("예약일자가 선택되지 않았습니다.");
	}
	else if(resck.rtime.value==""){
		alert("예약시간이 선택되지 않았습니다.");
	}
	else if(resck.rnum.value==""){
		alert("인원수가 선택되지 않았습니다.");
	}
	else{
		resck.submit();
	}
};
