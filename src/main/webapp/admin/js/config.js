var btn = document.querySelector("#btn");
var all = document.querySelector("#all");
btn.addEventListener("click",function(){
	configmain.area.value = '';
	configmain.submit();
});
btn.addEventListener("submit",function(){
	configmain.submit();
	configmain.area.value = '';
});
all.addEventListener("click",function(){
	location.href='./config_main.do';
});
document.querySelector("#area").addEventListener("change",function(){
	configmain.text.value = '';
	configmain.search.value = '';
	configmain.submit();
});

function page1(w){
	location.href="./config_main.do?page="+w;
}
function page2(w){
	var text = document.getElementById("text").value;
	location.href="./config_main.do?page="+w+"&search="+text;
}
function page3(w){
	var area = document.getElementById("area").value;
	location.href="./config_main.do?page="+w+"&area="+area;
}


/*document.querySelector("#noticemain").addEventListener("submit",function(a){
	a.preventDefault();
	if(noticemain.search.value == ""){
		location.href='./notice_main.do';
	}
	else{
		noticemain.submit();
	}
});*/
/*
document.querySelector("#body").addEventListener("click",function(z){
	//console.log(node);
	var n = [].indexOf.call(node,z.target);
	//indexOf : 배열 번호값 지정
	//indexOf.call(부모안에자식,클릭한 자식노드) = call (return)
	console.log(n);
});	*/



/*document.querySelector("#body").addEventListener("click",function(z){
	var n = [].indexOf.call(node,z.target);
	var mvalue = document.getElementsByName("mstatus")[n].values;
	console.log(n);
	console.log(mvalue);
});*/

var node = document.querySelectorAll("#body button");

function ajax_load(z){
	//var status = document.querySelectorAll(".mstatus");
	var value = null;
	var status = document.getElementById("mstatus").value;
	console.log("value :"+value);
	console.log(z);
	console.log("ajax status :"+status);
	var data = {	
		"midx": z,
		"mstatus": status
	};
	if(z == "") {
		alert("midx가 없음");	
	}
	else if(status == ""){
		alert("status가 없음");
	}else{	
		var http = new XMLHttpRequest();
		http.onreadystatechange = function(){
			if(http.readyState == XMLHttpRequest.DONE && http.status==200){
				var result = this.response;
				console.log(result);
				//var testres = document.getElementById("midres");
				//console.log(testres);
				//yes: 중복, no: 가능, error: 오류
				if(result == ""){
					alert("잘못된 접근입니다.");
				}
				else{
					alert("수정이 완료 되었습니다.");
				}
			}
		}
		console.log('ajax_load in');
		http.open("post","./modify.do",true);  //나한테 보내기
		http.setRequestHeader("content-type","application/json; charset=utf-8");
	    http.send(JSON.stringify(data));
	}
}


