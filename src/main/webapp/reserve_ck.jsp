<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%Date today = new Date();
DateFormat df = new SimpleDateFormat("yyyyMMddhms");
String dates = df.format(today);%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1">
<meta property="og:type" content="website">
<meta property="og:title" content="인천검단 레미안">
<title>인천검단 레미안</title>
<!-- css -->
<link rel="stylesheet" type="text/css" href="css/normalize.css">
<link rel="stylesheet" type="text/css" href="css/slick.css">
<link rel="stylesheet" type="text/css" href="css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/cal-style.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" href="./dadmin/css/sweetalert.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
    
<link rel="stylesheet" type="text/css" href="./css/top.css?v=<%=dates%>">

<link rel="stylesheet" type="text/css" href="./css/new_member.css?v=<%=dates%>">
</head>

<body>
<!-- wrap -->
<div id="wrap">
	<header id="hd">
<%@ include file="./jsp_main_top.jsp"%>
	</header>
<div id="container">
<div id="index">
<%@ include file="./jsp_reserve_ck.jsp"%>
</div>
  <!-- 카피라이터 시작 -->
	  	<footer id="ft">
  <%@ include file="./jsp_main_copy.jsp"%>
  	</footer>	
 <!-- 카피라이터 종료 -->
</div>
    </div>
<script src="./js/reserve_ck.js?v=<%=dates%>"></script>
<script src="./js/main_top.js?v=<%=dates%>"></script>        
</body>
</html>
