var btn = document.querySelector("#btn");

btn.addEventListener("click",function(){
	membermain.submit();
});
btn.addEventListener("submit",function(){
	membermain.submit();
});

function delete_member(no){
	if(confirm("해당 내용 삭제시 데이터 복구 되지 않습니다.")){
		location.href='./delete_member.do?midx='+no;		
	}
}

function page1(w){
	location.href="./member_main.do?page="+w;
}
function page2(w){
	var sdate2val = document.getElementById("sdate2").value;
	location.href="./member_main.do?page="+w+"&search="+sdate2val;
}