var btn = document.querySelector("#btn");
btn.addEventListener("click",function(){
	raemian_notice.submit();
});
btn.addEventListener("submit",function(){
	raemian_notice.submit();
});

function notice_view(no){
	location.href='./raemian_notice_view.do?nidx='+no;		
}