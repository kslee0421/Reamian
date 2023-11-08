<%@page import="portfolio.faqvo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%    
	String search = (String)request.getAttribute("search");	
	List<faqvo> rv = (List<faqvo>)request.getAttribute("data");
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
    <div class="protitle">FAQ 관리</div>
    <div class="procho">
       <section class="search_part">
        <ol>
        <li>FAQ내용 검색</li>
        <li>
   	    <form id="faqmain" method="get" action="./faq_main.do">
        <input type="text" class="search_input" name="search" value="<%=search%>" placeholder="내용입력">
        <input type="button" value="검색" id="btn" class="datebtn">	  	
        </form>
        </li>        
        <li></li>
        <li></li> 
        </ol>
       </section> 
       <section class="data_listsview2">
       <ul>
        <li>QA</li>
        <li>질문/답변</li>
        <li>글쓴이</li>
        <li>등록일</li>
        <li>삭제</li>
       </ul>
         
<!-- FAQ 샘플 HTML 코드 시작 -->           
     <span id = "faq_span">
     <%if(rv == null || rv.size()==0){%>
       <ul class="nodatas">
        <li>등록된 FAQ 내용 없습니다.</li>
       </ul>
	<%}else{int w= 0;do{%>	
       <ul class="node">
        <li>Q</li>
        <li style="text-align: left; justify-content: flex-start;"><%=rv.get(w).getFquestion()%></li>
        <li><%=rv.get(w).getFwriter()%></li>
        <li><%=rv.get(w).getFdate().substring(0,10)%></li>
        <li>
        <input type="button" value="삭제" class="delbtn" onclick="delete_faq(<%=rv.get(w).getFidx()%>)">
        </li>
       </ul>
       <ol style="display: none; background-color:#efefef">
        <li>A</li>
        <li style="text-align: left; justify-content: flex-start;"><%=rv.get(w).getFanswer()%></li>
       </ol>     
 	<%w++;}while(w < rv.size());}%>        
     </span>
       <span class="notice_btns">
       <input type="button" value="FAQ 등록" class="meno_btn2" onclick="faqher()"></span>
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