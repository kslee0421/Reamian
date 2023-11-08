var btn = document.querySelector("#btn");
btn.addEventListener("click",function(){
	reserve_main.submit();
});
btn.addEventListener("submit",function(){
	reserve_main.submit();
});

function delete_reserve(no){
	if(confirm("해당 내용 취소시 데이터 복구 되지 않습니다.")){
		location.href='./delete_reserve.do?ridx='+no;		
	}
}
function page1(w){
	location.href="./reserve_main.do?page="+w;
}
function page2(w){
	var sdate2val = document.getElementById("sdate2").value;
	location.href="./reserve_main.do?page="+w+"&search="+sdate2val;
}