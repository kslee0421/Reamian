<%@page import="java.util.List"%>
<%@page import="portfolio.reservo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
         <%    
	String search = (String)request.getAttribute("search");	
	List<reservo> resmain = (List<reservo>)request.getAttribute("data");
	int paging = 0;
	int ww= 1;
	int pg =1;	
	System.out.println("jsp resmain:"+request.getAttribute("cnt"));
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
    <div class="protitle">사전예약 회원 관리</div>
    <div class="procho">
       <form id="reserve_main" method="get" action="./reserve_main.do">
       <section class="search_part">
        <ol >
        <li>회원 검색</li>
        <li>
        <select class="search_select" id="search" name="tag">
        <option value="rid">아이디</option>    
        <option value="rname">이름</option>    
        <option value="rtel">연락처</option>    
        </select>
        <input type="text" id="sdate2" name="search" class="search_input" value="<%=search%>">
        <input type="button" value="검색" id="btn" class="datebtn">
        </li>        
        <li></li>
        <li></li> 
        </ol>
       </form>
       </section> 
       <section class="reserve_listsview">
       <ul>
        <li>번호</li>
        <li>아이디</li>
        <li>고객명</li>
        <li>연락처</li>
        <li>예약일자</li>
        <li>예약시간</li>
        <li>인원수</li>
        <li>예약취소</li>
       </ul>
       <% 
	if(resmain == null || resmain.size()==0){ //검색된 데이터가 없을 경우
%>
       <ul class="nodatas">
        <li>사전예약 신청 회원이 없습니다.</li>
       </ul>  
       <% 
	}
	else{
		int w= 0;
	do{	
%>	     
       <ul>
        <li><%=cal-w%></li>
        <li><%=resmain.get(w).getRid()%></li>
        <li><%=resmain.get(w).getRname()%></li>
        <li><%=resmain.get(w).getRtel()%></li>
        <li><%=resmain.get(w).getRday().substring(0,10)%></li>
        <li><%=resmain.get(w).getRtime()%></li>
        <li><%=resmain.get(w).getRnum()%></li>    
        <li>
            <input type="button" value="취소" class="delbtn" onclick="delete_reserve(<%=resmain.get(w).getRidx()%>)">
        </li>
       </ul>
 <%
	w++;
	}while(w < resmain.size());
	}
%>       
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