<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%
	String fuser_id ="";
	String fuser_pw ="";
	String fuser_name ="";
	String fuser_tel ="";
	if(session.getAttribute("auserid")==null || session.getAttribute("auserid")==""){
	
	}
	else{
		try{
			fuser_id = session.getAttribute("auserid").toString();
			fuser_name = session.getAttribute("ausername").toString();
			fuser_tel = session.getAttribute("ausertel").toString();
		}
		catch(Exception e){
			System.out.println(e);
		}
	}
%>  
<script src="./ckeditor/ckeditor.js"></script>
<form id="f" method="post" action="./faqok.do" enctype="application/x-www-form-urlencoded">
<section class="page_section">
<div class="listbody">
    <div class="protitle">FAQ 등록</div>
    <div class="procho">
       <section class="data_listsview">
       <ol>
       <li>질문 제목</li>
       <li><input type="text" class="notice_in in1" name="fquestion"></li>
       <li>글쓴이</li>
       <li><%=fuser_name%><input type="hidden" class="notice_in in2" name="fwriter" value="<%=fuser_name%>" readonly></li> <li style="height:520px;">답변 내용</li>
       <li style="height:520px; padding-top: 10px;">
       <textarea class="notice_in in3" id="text" name="fanswer"></textarea>
       </li>      
       </ol>
       <span class="notice_btns">
       <input type="button" value="FAQ 등록" class="meno_btn2" id="faq" onclick="faq_ok();"></span>
       </section>
    </div>
</div> 
</section>
</form>
<script>
CKEDITOR.replace("text");
CKEDITOR.config.resize_enabled = false;
</script>