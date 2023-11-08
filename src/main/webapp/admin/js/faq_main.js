var btn = document.querySelector("#btn");
btn.addEventListener("click",function(){
	faqmain.submit();
});
btn.addEventListener("submit",function(){
	faqmain.submit();
});

function delete_faq(no){
	if(confirm("해당 내용 삭제시 데이터 복구 되지 않습니다.")){
		location.href='./delete_faq.do?fidx='+no;		
	}
}
function faqher(){
	location.href='./faq_write.jsp';		
}


document.querySelector("#faq_span").addEventListener("click",function(z){
	//this.value, this.id, this.style
	console.log(z.target);
	console.log(z);
	var n = document.querySelectorAll("#faq_span > .node");
	
	this.node = [].indexOf.call(n,z.srcElement.parentNode); //li 자식노드에서 부모노드를 찾아서 확인하는 작업
	
	//Answer에 대한 갯수
	this.ea= document.querySelectorAll("#faq_span > ol").length;
	
	//해당 모든 Answer을 Display 숨김
	var w = 0; 
	while(w < this.ea){
	document.querySelectorAll("#faq_span > ol")[w].style["display"] ="none";
	w++;
	}
	document.querySelectorAll("#faq_span > ol")[this.node].style["display"] ="flex";
	//해당 Q에 대한 Answer값만 출력
	
	console.log(this.node);
	console.log(this.ea);
});

function page1(w){
	location.href="./faq_main.do?page="+w;
}
function page2(w){
	var sdate2val = document.getElementById("sdate2").value;
	location.href="./faq_main.do?page="+w+"&search="+sdate2val;
}