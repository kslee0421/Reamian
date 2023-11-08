<%@page import="portfolio.reservo"%>
<%@page import="portfolio.faqvo"%>
<%@page import="portfolio.membervo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%    
	List<membervo> mv = (List<membervo>)request.getAttribute("memberall");
	List<reservo> rv = (List<reservo>)request.getAttribute("reserveall");
%>  
<section>
   <div class="ad_top" ></div>
 <div class="ad_mainall">
   <div class="ad_main">
<!-- 일반회원 리스트 시작(추가) -->
       <div class="ad_main1">
         <ul>
            <li class="ad_maintitle">일반회원</li>
            <li class="ad_mainbox">
            <ol>
                <li>아이디</li>
                <li>고객명</li>
                <li>연락처</li>
                <li>이메일</li>
                <li>주소</li>
            </ol>
            <% 
	if(mv == null || mv.size()==0){ //검색된 데이터가 없을 경우
%>
       <ol class="nodatas">	
        <li>등록된 회원이 없습니다.</li>
       </ol>
<% 
	}
	else{
	int w= 0;
	do{	
%>  
            <ol class="bgcancel">
                <li><%=mv.get(w).getMid()%></li>
                <li><%=mv.get(w).getMname()%></li>
                <li><%=mv.get(w).getMtel()%></li>
                <li><%=mv.get(w).getMemail()%></li>
                <li style="text-align: center;"><%=mv.get(w).getMadd()%></li>
            </ol> 
                       <%
	w++;
	}while(w < mv.size());
	}	
%> 
            </li>
         </ul>
      </div>
<!-- 일반회원 리스트 끝(추가) -->
   </div>
 
   <div class="ad_main">
      <div class="ad_main1">
         <ul>
            <li class="ad_maintitle">예약현황</li>
            <li class="ad_mainbox2">
            <ol>
                <li>아이디</li>
                <li>고객명</li>
                <li>연락처</li>
                <li>예약일자</li>
                <li>예약시간</li>
                <li>예약인원</li>
            </ol>
	                        <% 
		if(rv == null || rv.size()==0){ //검색된 데이터가 없을 경우
	%>
	       <ol class="nodatas">	
	        <li>등록된 예약이 없습니다.</li>
	       </ol>
	<% 
		}
		else{
		int w= 0;
		do{	
	%>  
            <ol class="bgcancel">
                <li><%=rv.get(w).getRid()%></li>
                <li><%=rv.get(w).getRname()%></li>
                <li><%=rv.get(w).getRtel()%></li>
                <li><%=rv.get(w).getRday()%></li>
                <li><%=rv.get(w).getRtime()%></li>
                <li><%=rv.get(w).getRnum()%></li>
            </ol>  
<%
	w++;
	}while(w < rv.size());
	}	
%> 
            </li> 
         </ul>
      </div>
   </div>
 </div>
<!-- 관리자 메인 파트 끝 -->
   <div class="ad_botom"></div>
</section>