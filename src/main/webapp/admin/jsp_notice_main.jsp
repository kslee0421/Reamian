<%@page import="java.util.List"%>
<%@page import="portfolio.noticevo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%    
  //List<String> rv = (List<String>)request.getAttribute("data");
	String search = (String)request.getAttribute("search");	
	// contoller에서 보내준 값 받아오기
	List<noticevo> rv = (List<noticevo>)request.getAttribute("data");
	int paging = 0;
	int ww= 1;
	int pg =1;	
	System.out.println("jsp rv :"+rv);
	System.out.println("cnt : "+request.getAttribute("cnt"));
	System.out.println("page : "+request.getAttribute("page"));
	System.out.println(search);
	int pagevalue = (int)request.getAttribute("page");
	Object abc = request.getAttribute("cnt");
	Object total = request.getAttribute("total");
	int totalvalue =Integer.parseInt((String)total);
	if (abc != null) {
		paging =Integer.parseInt((String)abc);  //여기서 불러줘야 아래서 쓸 수 있다
		pg =(int)Math.ceil(paging/ 10f);
	}
	String s = null;
	if(search == null || search == ""){
		search = "";
	}else{
		s="Y";
	}
   	int cal = pagevalue;
   	if (cal <= 0){
   		cal = paging;
   	}else{
   		cal = paging-pagevalue;
   	}
%>     
<section class="page_section">
<div class="listbody">
    <div class="protitle">공지사항 관리</div>
    <div class="procho">
       <section class="search_part">
        <ol>
        <li>공지사항 검색</li>
        <li>
	    <form id="noticemain" method="get" action="./notice_main.do">
    	    <input type="text" id="sdate2" class="search_input" name="search" value="<%=search%>">
        	<input type="button" value="검색" id="btn" class="datebtn">
	  	</form>
        </li>        
        <li></li>
        <li></li> 
        </ol>
       </section> 
       <section class="data_listsview">
       <ul>
        <li>번호</li>
        <li>제목</li>
        <li>첨부파일 유/무</li>
        <li>조회수</li>
        <li>글쓴이</li>
        <li>등록일</li>
        <li>삭제</li>
       </ul>
<% 
	if(rv == null || rv.size()==0){ //검색된 데이터가 없을 경우
%>
       <ul class="nodatas">
        <li>등록된 공지사항이 없습니다.</li>
       </ul>
<% 
	}
	else{
		int w= 0;
	do{	
		String fileox = rv.get(w).getNfile();
	   	String ox =null;
		if(fileox.equals("N")){
			ox ="X";
		}else{
			ox ="O";
		}

%>	
       <ul >
        <li onclick="notice_view(<%=rv.get(w).getNidx()%>)"><%=cal-w%></li>
        <li onclick="notice_view(<%=rv.get(w).getNidx()%>)" style="text-align: left; justify-content: flex-start;"><%=rv.get(w).getNsubject()%></li>
        <li onclick="notice_view(<%=rv.get(w).getNidx()%>)" ><%=ox%></li>
        <li onclick="notice_view(<%=rv.get(w).getNidx()%>)" ><%=rv.get(w).getNcount()%></li>
        <li onclick="notice_view(<%=rv.get(w).getNidx()%>)" ><%=rv.get(w).getNwriter()%></li>
        <li onclick="notice_view(<%=rv.get(w).getNidx()%>)" ><%=rv.get(w).getNdate().substring(0,10)%></li>
        <li>
            <input type="button" value="삭제" class="delbtn" onclick="delete_notice(<%=rv.get(w).getNidx()%>)">
        </li>
       </ul>
<%
	w++;
	}while(w < rv.size());
	}
%> 
       <span class="notice_btns">
       <input type="button" value="글쓰기" id="write" class="meno_btn2"></span>
       <aside>
        <div class="page_number">
           <ul>
<%while(ww <= pg){
		if(s==null) {%>
			<li onclick="page1(<%=ww%>)"><%=ww%></li>
<% }else{%>
			<li onclick="page2(<%=ww%>)"><%=ww%></li>
<%}ww++;}%>   
           </ul>
        </div>
       </aside>
       </section>
    </div>
</div> 
</section>