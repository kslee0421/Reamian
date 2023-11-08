var btn = document.querySelector("#btn");
btn.addEventListener("click",function(){
	infomain.submit();
});
btn.addEventListener("submit",function(){
	infomain.submit();
});

function delete_info(no){
	if(confirm("해당 내용 삭제시 데이터 복구 되지 않습니다.")){
		location.href='./delete_info.do?idx='+no;		
	}
}

document.querySelector("#write").addEventListener("click",function(){
	location.href='./info_write.jsp';
});

function page1(w){
	location.href="./info_main.do?page="+w;
}
function page2(ws){
	var sdate2val = document.getElementById("sdate2").value;
	location.href="./info_main.do?page="+w+"&search="+sdate2val;
}
