<%@page import="java.util.List"%>
<%@page import="portfolio.infovo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%    
  //List<String> rv = (List<String>)request.getAttribute("data");
	String search = (String)request.getAttribute("search");	
	// contoller에서 보내준 값 받아오기
	List<infovo> rv = (List<infovo>)request.getAttribute("data");
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
    <div class="protitle">환경설정 관리</div>
    <div class="procho">
       <section class="search_part">
        <ol>
        <li>세대정보 검색</li>
        <li>
        <form id="infomain" method="get" action="./info_main.do">
        <input type="text" id="sdate2" class="search_input"  name="search" value="<%=search%>" placeholder="주거전용면적을 검색합니다">
        <input type="button" value="검색" class="datebtn" id="btn">
        </form>
        </li>        
        <li></li>
        <li></li> 
        </ol>
       </section> 
       <section class="data_listsview">
       <ul>
        <li>번호</li>
        <li>세대타입 및 면적</li>
        <li>사용 유/무</li>
        <li>출력순서</li>
        <li>글쓴이</li>
        <li>등록일</li>
        <li>삭제</li>
       </ul>
     <%if(rv == null || rv.size()==0){%>
       <ul class="nodatas">
        <li>등록된 세대타입 내용이 없습니다.</li>
       </ul>
       	<%}else{int w= 0;do{%>	
       <ul style="height:140px;">
        <li><%=cal-w%></li>
        <li style="text-align: left; justify-content: flex-start;">
        <div class="info_img">
        <img src="<%=rv.get(w).getIurl()%>">   
        </div>
        <div class="info_text">
        <span>주거타입 : <%=rv.get(w).getItype()%></span>
        <span>주거전용 : <%=rv.get(w).getIparea()%> ㎡</span>
        <span>주거공용 : <%=rv.get(w).getIcarea()%> ㎡</span>
        <span>기타공용 : <%=rv.get(w).getIetarea()%> ㎡</span>
        <span>계약면적 : <%=rv.get(w).getIcnarea()%> ㎡</span>
        </div>
        </li>
        <li><%=rv.get(w).getIuse()%></li>
        <li><%=rv.get(w).getIorder()%></li>
        <li><%=rv.get(w).getIwriter()%></li>
        <li><%=rv.get(w).getIdate().substring(0,10)%></li>
        <li>
            <input type="button" value="삭제" class="delbtn" onclick="delete_info(<%=rv.get(w).getIdx()%>)">
        </li>
       </ul>
<%w++;}while(w < rv.size());}%>  
       <span class="notice_btns">
       <input type="button" value="세대타입 생성" class="meno_btn2" id="write"></span>
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