function faq_ok(){
	if(f.fquestion.value==""){
		alert("제목이 입력 되지 않았습니다.");
	}
	else if(f.fwriter.value==""){
		alert("글쓴이가 입력되지 않았습니다.");
	}
	else{
		f.submit();   
	}	
};