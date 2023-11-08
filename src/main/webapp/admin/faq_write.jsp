<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%Date today = new Date();
DateFormat df = new SimpleDateFormat("yyyyMMddhms");
String dates = df.format(today);%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/page_default.css?v=<%=dates%>">
<link rel="stylesheet" href="./css/admin_css.css??v=<%=dates%>">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<!-- 신규추가된 css 파일 -->
<link rel="stylesheet" href="./css/notice.css??v=<%=dates%>">
<!-- 신규추가된 css 파일 끝-->
<title>관리자 페이지</title>
<script>
</script>
</head>
<body>
<nav>
<%@ include file="./jsp_top.jsp"%>
</nav>
<main class="page_main">
<%@ include file="./jsp_faq_write.jsp"%>
</main>
<footer>
<%@ include file="./jsp_copy.jsp"%>      
</footer>
<script src="./js/faq_write.js?v=<%=dates%>"></script>
<script src="./js/menus.js?v=<%=dates%>"></script>
</body>
</html>