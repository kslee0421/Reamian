<%@page import="portfolio.membervo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%    
	String search = (String)request.getAttribute("search");
	String data = (String)request.getAttribute("data");
	String tagval = (String)request.getAttribute("tagval");
	List<membervo> mv = (List<membervo>)request.getAttribute("memberall");
	if(tagval==null){
		tagval= "";
	}
	int paging = 0;
	int ww= 1;
	int pg =1;	
	System.out.println("jsp mv :"+mv);
	System.out.println("cnt : "+request.getAttribute("cnt"));
	System.out.println("page : "+request.getAttribute("page"));
	System.out.println("data : "+request.getAttribute("data"));
	System.out.println(search);
	int pagevalue = (int)request.getAttribute("page");
	Object abc = request.getAttribute("cnt");
	Object total = request.getAttribute("total");
	int totalvalue =Integer.parseInt((String)total);
	if (abc != null) {
		paging =Integer.parseInt((String)abc);  //여기서 불러줘야 아래서 쓸 수 있다
		pg =(int)Math.ceil(paging/ 15f);
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
    <div class="protitle">회원 관리</div>
    <div class="procho">
    	<form id="membermain" method="get" action="./member_main.do">
       <section class="search_part">
        <ol >
        <li>회원 검색</li>
        <li>
        <select class="search_select" name="tag" id="search">
        <option value="mid" <% if(tagval.equals("mid")) { %> selected <% } %>>아이디</option>    
        <option value="mname" <% if(tagval.equals("mname")) { %> selected <% } %>>이름</option>    
        <option value="mtel" <% if(tagval.equals("mtel")) { %> selected <% } %>>연락처</option>    
        </select>
        <input type="text" id="sdate2" class="search_input" name="search" value="<%=search%>">
        <input type="button" value="검색" class="datebtn" id="btn">
        </li>        
        <li></li>
        <li></li> 
        </ol>
       </section> 
   		</form>
       <section class="member_listsview">
       <ul>
        <li>번호</li>
        <li>아이디</li>
        <li>고객명</li>
        <li>연락처</li>
        <li>이메일</li>
        <li>주소</li>
        <li>이메일</li>
        <li>전화</li>
        <li>우편물</li>
        <li>SMS</li>
        <li>삭제</li>
       </ul>
<% 
	if(mv == null || mv.size()==0){ //검색된 데이터가 없을 경우
%>
       <ul class="nodatas">	
        <li>등록된 회원이 없습니다.</li>
       </ul>
<% 
	}
	else{
	int w= 0;
	do{	
		
%>       
       <ul>
        <li><%=cal-w%></li>
        <li><%=mv.get(w).getMid()%></li>
        <li><%=mv.get(w).getMname()%></li>
        <li><%=mv.get(w).getMtel()%></li>
        <li><%=mv.get(w).getMemail()%></li>
        <li style="justify-content: flex-start;"><%=mv.get(w).getMadd()%></li>
        <li><%=mv.get(w).getMch1()%></li>   
        <li><%=mv.get(w).getMch2()%></li>  
        <li><%=mv.get(w).getMch3()%></li>   
        <li><%=mv.get(w).getMch4()%></li>   
        <li>
            <input type="button" value="삭제" class="delbtn" onclick="delete_member(<%=mv.get(w).getMidx()%>)">
        </li>
       </ul>
           <%
	w++;
	}while(w < mv.size());
	}	
%>
       <aside>
        <div class="page_number">
       	<ul>
    <%
	System.out.print("jsp의 pg :"+pg);
	while(ww <= pg){
		if(s==null) {
			%>
			<li onclick="page1(<%=ww%>)"><%=ww%></li>
			
		<% }
		else if(s.equals("Y")){
		%>
			<li onclick="page2(<%=ww%>)"><%=ww%></li>
		<%}	
		ww++;
	};
	%> 
		</ul>
        </div>
       </aside>
       </section>
    </div>
</div> 
</section>