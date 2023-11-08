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
<link rel="stylesheet" href="./css/page_default.css">
<link rel="stylesheet" href="./css/admin_css.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<title>관리자 페이지</title>
</head>
<body>
<nav>
<%@ include file="./jsp_top.jsp"%>   
</nav>
<!-- 관리자 리스트 시작 -->
<main class="page_main">
<%@ include file="./jsp_config.jsp"%>   
</main>
<footer>
<%@ include file="./jsp_copy.jsp"%>
</footer>
<script src="./js/config.js?v=<%=dates%>"></script>
<script src="./js/menus.js?v=<%=dates%>"></script>
</body>
</html>