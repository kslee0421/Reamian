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
<link rel="stylesheet" href="./css/admin_css.css?v=<%=dates%>">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<link rel="stylesheet" href="./css/notice.css?v=<%=dates%>">
<link rel="stylesheet" href="./css/order.css?v=<%=dates%>">
<title>관리자 페이지</title>
<script>
</script>
</head>
<body>
<nav>
<%@ include file="./jsp_top.jsp"%> 
</nav>
<!-- 회원관리 시작 -->
<main class="page_main">
<%@ include file="./jsp_member_main.jsp"%>
</main>
<!-- 회원관리 끝 -->
<footer>
<%@ include file="./jsp_copy.jsp"%>
</footer>
<script src="./js/member_main.js?v=<%=dates%>"></script>
<script src="./js/menus.js?v=<%=dates%>"></script>
</body>
</html>