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
    
<link rel="stylesheet" type="text/css" href="./css/top.css?v=2">
    
<!-- 추가된 css -->
<link rel="stylesheet" type="text/css" href="./css/new_member.css?v=26">
<!-- 추가된 css -->
</head>

<body>
<!-- wrap -->
<div id="wrap">
	<!-- header 로고 & 대메뉴,소메뉴 -->
	<header id="hd">
    	<%@ include file="./jsp_main_top.jsp"%>  
	</header>
	<!-- header 로고 & 대메뉴,소메뉴 끝 -->


<div id="container">
<div id="index">
<section class="sub_image1" style="margin-top:180px;">
<span>
Experience of PRIDE<br>
남다른 삶의 자부심, 레미안의 핵심가치를 통해 경험해 보세요.
</span>
</section>    
    
<!-- 지구안내 화면 시작 -->    
<div class="sub_title" style="height:0;">
</div>    
    <label class="mbship_title" style="margin-top:0;">
        <p>지구안내</p>
        <ul>
          <li style="color: #000;">※ 상기 지구조감도는 입주자의 이해를 돕기 위한 개략도로 실제와 차이가 있을 수 있습니다.</li>
        </ul>
      </label>
      <fieldset class="mbship_box">
        <img src="./img/01_01.png">
      </fieldset>
<!-- 지구안내 화면 종료 -->
</div>
  <!-- 카피라이터 시작 -->
 	<footer id="ft">
	<%@ include file="./jsp_main_copy.jsp"%> 
  	</footer>	
 <!-- 카피라이터 종료 -->
</div>
</div>
<script src="./js/main_top.js?v=<%=dates%>"></script>        
</body>
</html>
