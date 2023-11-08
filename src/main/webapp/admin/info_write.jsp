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
<link rel="stylesheet" href="./css/page_default.css?v=">
<link rel="stylesheet" href="./css/admin_css.css?v=333">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<!-- 신규추가된 css 파일 -->
<link rel="stylesheet" href="./css/notice.css?v=<%=dates%>">
<!-- 신규추가된 css 파일 끝-->
<title>관리자 페이지</title>
<script>
</script>
</head>
<body>
<nav>
<%@ include file="./jsp_top.jsp"%> 
</nav>
<!-- 환경설정 관리 시작 -->
<main class="page_main">
<%@ include file="./jsp_info_write.jsp"%> 
</main>
<!-- 공지사항 관리 끝 -->
<footer>
<%@ include file="./jsp_copy.jsp"%>    
</footer>
<script src="./js/info_write.js?v=<%=dates%>"></script>
<script src="./js/menus.js?v=<%=dates%>"></script>
</body>
</html>