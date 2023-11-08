function memberjoin(){
	location.href="./join_agree.jsp"
}
var chch = 0;
document.querySelector("#login").addEventListener("click",function(){
	var id = document.getElementById("mid");
	var pw = document.getElementById("mpw");
	if(id.value==""){
		alert("아이디를 입력해주시기 바랍니다.");
	}
	else if(pw.value==""){
		alert("패스워드를 입력해주시기 바랍니다.");	
	}else{
	var data = {	
		"userid": id.value,
		"userpw": pw.value
	};
	var http = new XMLHttpRequest();
	http.onreadystatechange = function(){
		if(http.readyState == XMLHttpRequest.DONE && http.status==200){
			var result = this.response;
			if(result == "N"){
				alert("아이디 또는 비밀번호를 잘못 입력하셨습니다.");
				chch++;
			}
			else if(result =="Y"){
				location.href='./index.do';
				chch=0;
			}
		}
	}
	console.log('ajax_load in');
	http.open("post","./login_memberok.do",true);  //나한테 보내기
	http.setRequestHeader("content-type","application/json; charset=utf-8");
    http.send(JSON.stringify(data));
    }     
});

function admin_login() {
	if(this.checked == false){
		l.mid.value="";
		l.mpw.value=""
	}
	else{
		l.mid.value="admin";
		l.mpw.value="a123456789"	
	}
}

