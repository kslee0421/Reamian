var btn = document.querySelector("#btn");
btn.addEventListener("click",function(){
	noticemain.submit();
});
btn.addEventListener("submit",function(){
	noticemain.submit();
});

function delete_notice(no){
	if(confirm("해당 내용 삭제시 데이터 복구 되지 않습니다.")){
		location.href='./delete_notice.do?nidx='+no;		
	}
}
function notice_view(no){
	location.href='./notice_view.do?nidx='+no;		
}

document.querySelector("#write").addEventListener("click",function(){
	location.href='./notice_write.jsp';
});

function page1(w){
	location.href="./notice_main.do?page="+w;
}
function page2(w){
	var sdate2val = document.getElementById("sdate2").value;
	location.href="./notice_main.do?page="+w+"&search="+sdate2val;
}
