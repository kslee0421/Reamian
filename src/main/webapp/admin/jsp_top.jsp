<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String auser_id ="";
	String auser_name ="";
	
	if(session.getAttribute("auserid")==null || session.getAttribute("auserid")==""){
		out.println("<script>alert('로그인이 필요한 페이지 입니다.(로그인 페이지로 이동합니다.)');location.href='./';</script>");
	}
	else{
		try{
			auser_id = session.getAttribute("auserid").toString();
			auser_name = session.getAttribute("ausername").toString();
		}
		catch(Exception e){
			System.out.println(e);
		}
	}
%>    
<div class="menusize">
    <ul id="menus">
        <li class="topmenu1" id="main_btn">ADMINISTRATOR</li>
        <li class="topmenu2" id="info_btn">환경설정</li>
        <li class="topmenu2" id="member_btn">회원관리</li>
        <li class="topmenu2" id="notice_btn">공지사항 관리</li>
        <li class="topmenu2" id="faq_btn">FAQ</li>
        <li class="topmenu2" id="reserve_btn">예약현황</li>
        <li class="topmenu2" id="admin_member_btn">관리자현황</li>
<% if(auser_id==""||auser_id==null){ 
}else{
%>
        <li class="topmenu3" style="color:white;"><%=auser_name%>님 환영합니다  <a style="color:white;" href="./logout.jsp"  style="color:white;">[로그아웃]</a></li>
<%}%>    
    </ul>
 </div>
<div class="menuline"></div> 

