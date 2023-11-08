
function notice_ok(){
	console.log(n.nfilename.files.length);
	if(n.nsubject.value==""){
		alert("제목이 입력 되지 않았습니다.");
	}
	else if(n.nwriter.value==""){
		alert("글쓴이가 입력되지 않았습니다.");
	}
	else{
		n.submit();   
	}	
};
	