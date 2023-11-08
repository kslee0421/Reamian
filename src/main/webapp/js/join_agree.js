window.onload=agree;

var agree =function(f){	
var http =new XMLHttpRequest(); // 통신할거다
http.open("GET",f,false); //false : 동기
http.send();
return http.response;
}
document.getElementById("agree1").innerHTML = agree("./agree/agree1.txt");
document.getElementById("agree2").innerHTML = agree("./agree/agree2.txt");


function agreeck(){
	//console.log(z);
	var aa = document.getElementById("all_agree"); //전체선택 오브젝트
	var w =1;
	var check =true; //체크 핸들링을 위한 변수
	do{
		//해당 아이디별로 체크 중 해제 되었을 조건일 경우 
		if(document.getElementById("agreech"+w).checked==false){
			check =false;
		}
		w++;
	}while(w <3);
	
	if(check==false){ //하나라도 체크 아웃 되었을 경우 
		aa.checked = false; //전체 체크가 해제
	}
	else{
		aa.checked = true; //전체 체크가 선택
	}
	
}
function allagree(e){
	var w=1;		
	while(w <3){
	document.getElementById("agreech"+w).checked =e;
	w++;			
	}
}
function check(){
	if(document.getElementById("agreech1").checked==false){
		alert("회원가입 약관에 필수사항은 모두 체크 하셔야 회원가입이 진행됩니다.");
		return false;
	}
	else if(document.getElementById("agreech2").checked==false){
		alert("회원가입 약관에 필수사항은 모두 체크 하셔야 회원가입이 진행됩니다.");
		return false;
	}
	else{
		location.href="./join_member.jsp";
		return;
		
	}
}