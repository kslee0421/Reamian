<%@page import="portfolio.noticevo"%>
<%@page import="java.util.List"%>
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
%>  
    <label class="mbship_title">
        <p>NOTICE</p>
        <ul>
          <li>RAEMIAN 새로운 소식을 확인하세요</li>
        </ul>
      </label>
      <fieldset class="mbship_box">
        <ul>
        <li>번호</li>  
        <li>제목</li>  
        <li>조회수</li>     
        <li>글쓴이</li>  
        <li>등록일</li>      
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
		if(fileox==null || fileox.equals("N")){
			ox ="X";
		}else{
			ox ="O";
		}

   	int cal = pagevalue;
   	if (cal <= 0){
   		cal = paging;
   	}else{
   		cal = paging-pagevalue;
   	}
%>	        
        <ul  onclick="notice_view(<%=rv.get(w).getNidx()%>)">
        <li><%=cal-w%></li>  
        <li style="text-align: left;"><%=rv.get(w).getNsubject()%></li>  
        <li><%=rv.get(w).getNcount()%></li>     
        <li><%=rv.get(w).getNwriter()%></li>  
        <li><%=rv.get(w).getNdate().substring(0,10)%></li>      
        </ul>  
 <%
	w++;
	}while(w < rv.size());
	}
%>        
        <span class="pages">
          <ul>
    <%
	System.out.print("jsp의 pg :"+pg);
	while(ww <= pg){
		if(s==null) {
			%>
			<li style="float:left;"><a href="./raemian_notice.do?page=<%=ww%>"><%=ww%></a></li>
		<% }
		else{
		%>
			<li style="float:left;"><a href="./reamian_notice.do?page=<%=ww%>&search=<%=search%>"><%=ww%></a></li>
		<%
		}
		ww++;
	}
	%>   
          </ul>
        </span>
          
        <span class="search_css">
   	    <form id="raemian_notice" method="get" action="./raemian_notice.do">
        <input name="search" value="<%=search%>" type="text" class="search_in" placeholder="검색할 제목을 입력하세요">
        <input type="submit" value="검색" id="btn" class="search_btn">
        </form>
        </span>
      </fieldset>