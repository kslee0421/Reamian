<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String nuser_id ="";
	String nuser_pw ="";
	String nuser_name ="";
	String nuser_tel ="";
	if(session.getAttribute("auserid")==null || session.getAttribute("auserid")==""){
	
	}
	else{
		try{
			nuser_id = session.getAttribute("auserid").toString();
			nuser_name = session.getAttribute("ausername").toString();
			nuser_tel = session.getAttribute("ausertel").toString();
		}
		catch(Exception e){
			System.out.println(e);
		}
	}
%>  
<script src="./ckeditor/ckeditor.js"></script>
<form id="n" method="post" action="./noticeok.do" enctype="multipart/form-data">
<section class="page_section">
<div class="listbody">
    <div class="protitle">공지사항 등록</div>
    <div class="procho">
       <section class="data_listsview">
       <ol>
       <li>공지제목</li>
       <li><input type="text" class="notice_in in1" name="nsubject"></li>
       <li>글쓴이</li>
       <li><%=nuser_name%><input type="hidden" class="notice_in in2" name="nwriter" value="<%=nuser_name%>" readonly></li> 
       <li style="height:520px;">내용</li>
       <li style="height:520px; padding-top: 10px;">
       <textarea class="notice_in in3" id="text" name="ncontents"></textarea>
       </li>       
       <li>첨부파일</li>
       <li><input type="file" name="nfilename"></li>  
       <input type="hidden" name="nfile" value="N"> 
       </ol>
       <span class="notice_btns">
       <input type="button" value="글등록" class="meno_btn2" id="notice" onclick="notice_ok()"></span>
       </section>
    </div>
</div> 
</section>
</form>
<script>
CKEDITOR.replace("text");
CKEDITOR.config.resize_enabled = false;
</script>