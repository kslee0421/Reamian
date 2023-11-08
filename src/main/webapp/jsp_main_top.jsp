
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user_id ="";
	String user_pw ="";
	String user_name ="";
	if(session.getAttribute("userid")==null || session.getAttribute("userid")==""){
	}
	else{
		try{
			user_id = session.getAttribute("userid").toString();
			user_name = session.getAttribute("username").toString();
		}
		catch(Exception e){
			System.out.println(e);
		}
	}
%>  
<form id ="top">
      <div class="top_menu">
        <ul class="top_menu_list" id="top_menu_list">
<% if(user_id==""||user_id==null){%>
			<li><a href="./login_member.jsp">로그인</a></li>
	        <li><a href="./join_agree.jsp">회원가입</a></li>
<%}else{%>
	        <li style="color:white;"><%=user_name%> 님 환영합니다  <a style="color:white;" href="./logout.jsp">[로그아웃]</a></li>
<%}%>
	        <li id="faq_btn">FAQ</li>
	        <li id="notice_btn">공지사항</li>
        </ul>
    </div>
</form>
        <div class="top">
            <h1><a href="/portfolio/index.do" class="icon-hd-logo"></a></h1>
            <nav id="gnb">
                <li>
                    <a href=""><span>사업정보</span></a>
                    <ul>
                        <li><a href="./sub1.jsp">지구안내</a></li>
                        <li><a href="./sub2.jsp">입지안내</a></li>
                        <li><a href="./sub1.jsp">지역조감도</a></li>
                    </ul>
                </li>
                <li>
                    <a href=""><span>단지정보</span></a>
                    <ul>
                        <li><a href="./sub3.jsp">단지안내</a></li>
                        <li><a href="./sub2.jsp">시스템</a></li>
                        <li><a href="./sub2.jsp">단지배치도</a></li>
                        <li><a href="./sub1.jsp">동호배치도</a></li>
                    </ul>
                </li>
                <li>
                    <a href=""><span>세대정보</span></a>
                    <ul>
                        <li><a href="">타입별 평면도</a></li>
                        <li><a href="">인테리어</a></li>
						<li><a href="">사이버모델하우스</a></li>
						<li><a href="">인테리어마감재</a></li>
                    </ul>
                </li>
                <li>
                    <a href=""><span>공급정보</span></a>
                    <ul>
                       <li><a href="">입주자 모집공고</a></li>
                        <li><a href="">E-카달로그</a></li>
                         <li><a href="">공급일정 안내</a></li>
                        <li><a href="">오시는 길</a></li>
                      <li><a href=""></a></li>
                    </ul>
                </li>
                <li>
                    <a href=""><span>사전방문예약</span></a>
                    <ul id="slidebtn">
                        <li><a href="./reserve_in.jsp">사전방문예약</a></li>
                        <li><a href="./reserve_ck.do">사전방문예약수정</a></li>
                        <li><a href="./reserve_cc.do">사전방문예약확인/취소</a></li>
                    </ul>
                </li>
            </nav>
        </div>
