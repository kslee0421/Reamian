function infok(){
	if(i.itype.value==""){
		alert("제목이 입력 되지 않았습니다.");
	}
	else if(i.iparea.value==""){
		alert("글쓴이가 입력되지 않았습니다.");
	}
	else if(i.icarea.value==""){
		alert("주거전용면적이 입력되지 않았습니다.");
	}
	else if(i.iparea.value==""){
		alert("주거공용면적이 입력되지 않았습니다.");
	}
	else if(i.ietarea.value==""){
		alert("기타공용면적이 입력되지 않았습니다.");
	}
	else if(i.icnarea.value==""){
		alert("계약면적면적이 입력되지 않았습니다.");
	}
	else if(i.iurl.value==""){
		alert("이미지 url이 입력되지 않았습니다.");
	}
	else if(i.iorder.value==""){
		alert("출력순서가 입력되지 않았습니다.");
	}
	else{
		i.submit();   
	}	
};