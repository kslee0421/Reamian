
document.querySelector("#login").addEventListener("click",function(){
	var id = document.getElementById("login_id");
	var pw = document.getElementById("login_pass");
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
			}
			else if(result == "C"){
				alert("로그인 시도 횟수를 5번 초과하여 로그인 할 수 없습니다. (관리자에게 문의 하세요)")
			}
			else if(result =="Y"){
				location.href='./admin_main.do';
			}
		}
	}
	console.log('ajax_load in');
	http.open("post","./login_admin.do",true);  //나한테 보내기
	http.setRequestHeader("content-type","application/json; charset=utf-8");
    http.send(JSON.stringify(data));
    }     
});


var join = document.querySelector("#join");
join.addEventListener("click",function(){
	location.href='./join_admin_member.jsp';
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




