<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	session.invalidate();
%>
<script>
window.onload =function(){
	alert("로그아웃 되었습니다.");
	location.href="./index.do";
}
</script>