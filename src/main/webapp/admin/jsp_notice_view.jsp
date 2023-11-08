<%@page import="java.util.ArrayList"%>
<%@page import="portfolio.noticevo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%ArrayList<String> rv = (ArrayList<String>)request.getAttribute("one");%>    
<section class="page_section">
<div class="listbody">
    <div class="protitle">공지사항 확인</div>
    <div class="procho">
       <section class="data_listsview">
       <ol>
       <li>공지제목</li>
       <li class="text_in">${one.get(1)}</li>
       <li>글쓴이</li>
       <li class="text_in">${one.get(3)}</li> 
       <li style="height:520px;">내용</li>
       <li style="height:520px; padding-top: 10px;">
       <div class="text_in2">${one.get(2)}</div>
       </li>       
       <li>첨부파일</li>
       <li class="text_in"><a href="${one.get(4)}" style="color:blue;text-decoration: underline;" target="_blank" >${one.get(4).substring(39)}</a></li>   
       </ol>
       <span class="notice_btns">
       <input type="button" value="목록" id="list" class="meno_btn2"></span>
       </section>
    </div>
</div> 
</section>

<script>
document.querySelector("#list").addEventListener("click",function(){
	location.href='./notice_main.do';
});
</script>