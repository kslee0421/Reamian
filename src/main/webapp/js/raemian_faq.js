document.querySelector("#faq_span").addEventListener("click",function(z){
	console.log(z.target);
	console.log(z);
	var n = document.querySelectorAll("#faq_span > .node");
	
	this.node = [].indexOf.call(n,z.srcElement.parentNode); //li 자식노드에서 부모노드를 찾아서 확인하는 작업
	
	this.ea= document.querySelectorAll("#faq_span > ol").length;
	
	var w = 0; 
	while(w < this.ea){
	document.querySelectorAll("#faq_span > ol")[w].style["display"] ="none";
	w++;
	}
	document.querySelectorAll("#faq_span > ol")[this.node].style["display"] ="flex";
	console.log(this.node);
	console.log(this.ea);
});