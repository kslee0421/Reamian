<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    Date today = new Date();
    DateFormat df = new SimpleDateFormat("yyyyMMddhms");
    String dates = df.format(today);
    %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/page_default.css?v=">
<link rel="stylesheet" href="./css/admin_css.css?v=">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<!-- 신규추가된 css 파일 -->
<link rel="stylesheet" href="./css/notice.css?v=">
<title>관리자 페이지</title>
</head>
<body>
<nav>
<%@ include file="./jsp_top.jsp"%>   
</nav>
<!-- 관리자 리스트 시작 -->
<%@ include file="./jsp_notice_view.jsp"%>   
<main class="page_main">
</main>
<footer>
<%@ include file="./jsp_copy.jsp"%>
</footer>
</body>
<script src="./js/menus.js?v=<%=dates%>"></script>
</html>