<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%Date today = new Date();
DateFormat df = new SimpleDateFormat("yyyyMMddhms");
String dates = df.format(today);%> 
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/admin_css.css?v=2023090292">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<title>관리자 페이지</title>
</head>
<body>
  <div class="adbody" style="margin-top: 115px;">
      <div class="adtitle">ADMINISTRATOR</div>
      <div class="admoom">
        <form id="l" method="post" action="./loginok.do">
          <div class="intotal"> 
            <div class="adin1">
              <input type="text" name="mid" id="login_id" class="loginid" placeholder=" 아이디">
            </div>
            <div class="adin2">
              <input type="password" name="mpw" id="login_pass" class="loginpass" placeholder="패스워드">
            </div>
          </div>
          <div class="adbt">
            <button id="login" type="button" class="loginbt1">로그인</button>
            <button type="button" class="loginbt2" id="join">회원가입</button><br>
            <label><input type="checkbox" onchange="admin_login()" >admin계정으로 로그인</label>
          </div>
          <div class="adinfomain">
            <ul>
               <li class="adinfo">※
                사원번호가 없을시 관리자에게 연락 바랍니다.</li>
               <li class="adinfo">※ 모든 정보는 기록되어 집니다.</li>
               <li class="adinfo">※ 퇴사시 해당 정보는 접속이 불가능 하게 됩니다.</li>
            </ul>
          </div>
         </form>
        </div>
      </div>
<script src="./js/index.js?v=<%=dates%>"></script>
</body>
</html>