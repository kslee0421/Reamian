window.onload =function(){
	this.mid = document.querySelector("#rid").value;
	fetch("./reserve_cc.do",{
		method:"POST",
		cache:"no-cache",
		headers:{
			"Content-Type":"application/x-www-form-urlencoded"
		},
		body:
			"userid="+this.mid // userid와 usertel로 컨트롤러에 넘기자
	}).then(function(aa){  //해당 파일을 통신을 통하여 배열로 변환작업
		return aa.text();
	}).then(function(bb){ //try 데이터 출력 
		console.log(bb);
	}).catch(function(error){ //error 예외처리로 데이터 에러 발생
		console.log("Data Error!!");
	});
	
};
document.querySelector("#delete_reserve").addEventListener("click",function(){
	this.mid = document.querySelector("#rid").value;
	location.href='./delete_reserve.do?rid='+this.mid;
});
