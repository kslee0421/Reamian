<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% Date today = new Date();
DateFormat df = new SimpleDateFormat("yyyyMMddhms");
String dates = df.format(today);%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/page_default.css?v=<%=today%>">
<link rel="stylesheet" href="./css/admin_css.css?v=<%=today%>">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<link rel="stylesheet" href="./css/notice.css?v=<%=today%>">
<title>관리자 페이지</title>
</head>
<body>
<nav>
<%@ include file="./jsp_top.jsp"%>
</nav>
<main class="page_main">
<%@ include file="./jsp_faq_main.jsp"%>
</main>
<footer>
<%@ include file="./jsp_copy.jsp"%>    
</footer>
<Script src="./js/faq_main.js?v=<%=today%>" defer></Script>
<script src="./js/menus.js?v=<%=dates%>"></script>
</body>

</html>