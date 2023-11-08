
var chch =0;
var codefrm =0;
function memberok(){
	var w=1;
	if(m.detailAddress.value==""){
		m.detailAddress.value= "";
	}
	do{
		if(document.getElementById("mch"+w).checked==true){
			document.getElementById("mch"+w).value="Y";
		} else{
			document.getElementById("mch"+w).value="N";
		}
	w++;
	}while(w <=4);
	
	console.log("ch1"+m.mch1.value);
	console.log("ch2"+m.mch2.value);
	console.log("ch3"+m.mch3.value);
	console.log("ch4"+m.mch4.value);
	
	if(m.mname.value==""){
		alert("이름이 입력되지 않았습니다.");
	}
	else if(m.mid.value==""){
		alert("아이디란이 입력되지 않았습니다.");
	}
	else if(m.mpw.value==""){
		alert("패스워드란이 입력되지 않았습니다.");
	}
	else if(m.mpwc.value==""){
		alert("패스워드란이 입력되지 않았습니다.");
	}
	else if(m.mtel.value==""){
		alert("전화번호란이 입력되지 않았습니다.");
	}
	else if(m.mpw.value==""){
		alert("패스워드란이 입력되지 않았습니다.");
	}
	else if(m.mpwc.value==""){
		alert("패스워드확인란이 입력되지 않았습니다.");
	}
	else if(m.postcode.value==""||m.roadAddress.value==""){
		alert("주소가 입력되지 않았습니다.");
	}
	else{
		this.text =/[\s/|ㄱ-ㅎ|ㅏ-ㅣ|가-사]/g;
		if(this.text.test(m.mid.value) ==true){
			alert('아이디 형식이 잘못되었습니다.')
		}
		else if((m.mid.value.length)>=12 || (m.mid.value.length)<=5){
			alert('아이디는 5자리 이상, 12자리 미만이어야 합니다.')
		}
		else if((m.mpw.value.length)<=5 || (m.mpw.value.length)>=14) {
			alert('비밀번호는 8자리이상 14자리미만의 영어/숫자여야 합니다.')
		}
		else if(isNaN(m.mtel.value)==true){ //숫자로 변환했을때 true로 뜨면 문자가 들어간거(파서인트 같은거)
			alert('정상적인 휴대폰 번호를 입력하세요')
		}
		else if((m.mpw.value)!=(m.mpwc.value)){
			alert('비밀번호 확인값이 잘못되었습니다')
		}
		else if((m.mtel.value.length)<9 && (m.mtel.value.length)>12){//자바에도 있다 문자열중에서 @라는 단어가 있는지 없는지 판별 ==-1은 : 그 문자가 존재하지 않습니다.
			alert('전화번호의 형식이 잘못되었습니다')
		}
		else if(m.memail.value==""){
			m.memail.value=" ";
		}
		else if(chch==0){
		alert("아이디 중복체크 해 주십시요.");
		}
		else if(chch==1){
		alert("사용이 불가능한 아이디 입니다.");
		}
		else if(codefrm==0){
		alert("휴대폰 인증완료를 해 주십시요");
		}
		else{
			m.madd.value="("+m.postcode.value+")"+" "+m.roadAddress.value+" "+m.detailAddress.value; 	
			m.submit(); 
		}
	}	
};

function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
    
var sc2 = "";
window.onload = function(){
	var f;
	var sc = "";
	for(f=1; f<=6; f++){
		sc= Math.floor(Math.random() * 10);
		sc2+=sc;	
	}
	m.codech.value=sc2;
}

document.querySelector("#idch").addEventListener("click",function(){
	var id = document.getElementById("mid");
	this.text =/[\s/|ㄱ-ㅎ|ㅏ-ㅣ]/g;
	if(id.value==""){
		alert("아이디를 입력해주시기 바랍니다.");
	}
	else if(this.text.test(m.mid.value) ==true){
			alert('아이디 형식이 잘못되었습니다.')
	}
	else if(id.value.length>=12 || id.value.length<=6 ){
		alert('올바른 아이디를 입력하세요.');	
	}else{
	var data = {	
		"userid": id.value
	};
	var http = new XMLHttpRequest();
	http.onreadystatechange = function(){
		if(http.readyState == XMLHttpRequest.DONE && http.status==200){
			var result = this.response;
			if(result == "N"){
				alert("사용불가능한 아이디 입니다.");
				chch= "1";
			}
			else if(result =="Y"){
				alert("사용가능한 아이디 입니다.");
				chch="2";
				m.mid.readOnly =true;
			}
		}
	}
	console.log('ajax_load in');
	http.open("post","./idch.do",true);  //나한테 보내기
	http.setRequestHeader("content-type","application/json; charset=utf-8");
    http.send(JSON.stringify(data));
    }     
});

function send(){
	if(m.mtel.value==""){
		alert("전화번호란이 입력되지 않았습니다.");
	}
	else{
		var tel = document.getElementById("mtel").value;
		var context = sc2;
		var http = new XMLHttpRequest(); //패치로 써도된다.
		http.onreadystatechange= function(){
			if(http.readyState == XMLHttpRequest.DONE && http.status==200){
				console.log(http.response);
				var result = http.response;
				if(result == "ok"){
					alert("인증번호가 발송되었습니다. 발송된 인증번호를 입력하세요!");
				}
			}
		}
		http.open("POST","./smsok.do",true);
		http.setRequestHeader("content-type","application/x-www-form-urlencoded");
		http.send("tel="+tel + "&context="+context);
	}
};


function frm(){
	var code = document.getElementById("code").value;
	if(code==sc2){
		alert("인증이 정상적으로 완료되었습니다.");
		codefrm=1;
		m.code.readOnly =true;
		document.querySelector("#frmbtn").style.display="none";
		document.querySelector("#code").style.color="#eee";
		m.mtel.readOnly =true;
		document.querySelector("#sndbtn").style.display="none";
		document.querySelector("#mtel").style.color="#eee";
	}
	else{
		alert("인증번호를 다시 입력하세요");
		codefrm=0;
	}
};

var mch1 =document.querySelector("#mch1");
mch1.addEventListener("change",function(){
	if(m.memail.value==""){
		alert("이메일을 입력해주세요");
		this.checked = false;
	}
	else{
		m.memail.readOnly =true;
	};
	
	if(this.checked == false){
		m.memail.readOnly =false;
	}
});

var mch2 =document.querySelector("#mch2");
mch2.addEventListener("change",function(){
	if(m.mtel.value==""){
		alert("전화번호를 입력해주세요");
		this.checked = false;
	}
	else{
		m.mtel.readOnly =true;
	};
	
	if(this.checked == false){
		m.mtel.readOnly =false;
	}
});

let membercc = document.querySelector("#membercc");

membercc.addEventListener("click",function(){
	location.href='./login_member.jsp';
});

