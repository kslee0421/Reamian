var chch =0;
document.querySelector("#adm_ok").addEventListener("click",function(z){
	f.mtel.value=f.mtel1.value+f.mtel2.value+f.mtel3.value; 
	z.preventDefault();
	if(f.marea.value==""){
		alert("소속지역이 선택되지 않았습니다.");
	}
	else if(f.mdept.value==""){
		alert("부서가 선택되지 않았습니다.");
	}
	else if(f.mname.value==""){
		alert("이름이 입력되지 않았습니다.");
	}
	else if(f.mgrade.value==""){
		alert("직책이 선택 않았습니다.");
	}
	else if(f.mid.value==""){
		alert("아이디란이 입력되지 않았습니다.");
	}
	else if(f.mpw.value==""){
		alert("패스워드란이 입력되지 않았습니다.");
	}
	else if(f.mpwc.value==""){
		alert("패스워드확인란이 입력되지 않았습니다.");
	}
	else if(f.memail.value==""){
		alert("이메일이 입력되지 않았습니다.");
	}
	else if(f.mtel1.value==""||f.mtel2.value==""||f.mtel3.value=="" ){
		alert("연락처가 입력되지 않았습니다.");
	}
	else{
		this.text =/[\s/|ㄱ-ㅎ|ㅏ-ㅣ]/g;
		if(this.text.test(f.mid.value) ==true){
			alert('아이디 형식이 잘못되었습니다.')
		}
		else if((f.mid.value.length)>=17 || (f.mid.value.length)<=6){
			alert('올바른 아이디를 입력하세요.')
		}
		else if((f.mpw.value.length)<=5) {
			alert('비밀번호는 6자리이상이어야합니다.')
		}
		else if(isNaN(f.mtel1.value)==true || isNaN(f.mtel2.value)==true||isNaN(f.mtel3.value)==true){ //숫자로 변환했을때 true로 뜨면 문자가 들어간거(파서인트 같은거)
			alert('정상적인 휴대폰 번호를 입력하세요')
		}
		else if((f.mpw.value)!=(f.mpwc.value)){
			alert('비밀번호 확인값이 잘못되었습니다')
		}
		else if(f.memail.value.indexOf("@")==-1){//자바에도 있다 문자열중에서 @라는 단어가 있는지 없는지 판별 ==-1은 : 그 문자가 존재하지 않습니다.
			alert('이메일 형식이 잘못되었습니다')
		}
		else if((f.mtel2.value.length)<=3 ||(f.mtel3.value.length)<=3){//자바에도 있다 문자열중에서 @라는 단어가 있는지 없는지 판별 ==-1은 : 그 문자가 존재하지 않습니다.
			alert('전화번호의 형식이 잘못되었습니다')
		}
		else if(chch==0){
		alert("아이디 중복체크 해 주십시요.");
		}
		else if(chch==1){
		alert("사용할 수 없는 아이디 입니다.");
		}
		else{
			f.submit();   // form태그안에 있는 사용자값을 전송 명령어
		}
	}	
});

document.querySelector("#idch").addEventListener("click",function(){
	var id = document.getElementById("mid");
	this.text =/[\s/|ㄱ-ㅎ|ㅏ-ㅣ|가-사]/g;
	if(id.value==""){
		alert("아이디를 입력해주시기 바랍니다.");
	}
	else if((f.mid.value.length)>=17 || (f.mid.value.length)<=5){
		alert('아이디는 5자리이상 17자리 미만이어야 합니다.')
	}
	else if(this.text.test(id.value)==true){
		alert('아이디의 형식이 잘못되었습니다.')
	}else{
		
	var data = {	
		"userid": id.value
	};
	var http = new XMLHttpRequest();
	http.onreadystatechange = function(){
		if(http.readyState == XMLHttpRequest.DONE && http.status==200){
			var result = this.response;
			if(result == "N"){
				alert("사용할 수 없는 아이디 입니다.");
				chch= "1";
			}
			else if(result =="Y"){
				alert("사용할 수 있는 아이디 입니다.");
				chch="2";
				f.mid.readOnly =true;
			}
		}
	}
	console.log('ajax_load in');
	http.open("post","./admin_idch.do",true);  //나한테 보내기
	http.setRequestHeader("content-type","application/json; charset=utf-8");
    http.send(JSON.stringify(data));
    }     
});

document.querySelector("#adm_cancel").addEventListener("click",function(z){
	location.href="./";
});
