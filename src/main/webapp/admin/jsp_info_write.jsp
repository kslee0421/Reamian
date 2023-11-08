<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String iuser_id ="";
	String iuser_name ="";
	String iuser_tel ="";
	if(session.getAttribute("auserid")==null || session.getAttribute("auserid")==""){
	
	}
	else{
		try{
			iuser_id = session.getAttribute("auserid").toString();
			iuser_name = session.getAttribute("ausername").toString();
			iuser_tel = session.getAttribute("ausertel").toString();
		}
		catch(Exception e){
			System.out.println(e);
		}
	}
%>  
<form id="i" method="post" action="./infok.do" enctype="application/x-www-form-urlencoded">
<section class="page_section">
<div class="listbody">
    <div class="protitle">환경설정 등록</div>
    <div class="procho">
       <section class="data_listsview">
       <ol>
       <li>주거타입</li>
       <li><input name="itype" type="text" class="notice_in in2"> ※ 예) 74A 타입</li>
       <li>글쓴이</li>
       <li><%=iuser_name%><input name="iwriter" type="hidden" class="notice_in in2" value="<%=iuser_name%>" readonly></li>
       <li>주거전용</li>
       <li><input name="iparea" type="text" class="notice_in in2">㎡&nbsp;&nbsp;&nbsp;※ 숫자만 입력하세요</li>
       <li>주거공용</li>
       <li><input name="icarea" type="text" class="notice_in in2">㎡&nbsp;&nbsp;&nbsp;※ 숫자만 입력하세요</li>
       <li>기타공용</li>
       <li><input name="ietarea" type="text" class="notice_in in2">㎡&nbsp;&nbsp;&nbsp;※ 숫자만 입력하세요</li>
       <li>계약면적</li>
       <li><input name="icnarea" type="text" class="notice_in in2">㎡&nbsp;&nbsp;&nbsp;※ 숫자만 입력하세요</li>
       <li>이미지 URL</li>
       <li><input name="iurl" type="text" class="notice_in in1">&nbsp;&nbsp;&nbsp;예시) http://abc.co.kr/123.jpg</li> 
       <li>사용 유/무</li>
       <li><input name="iuse" type="radio" class="radio_txt" value="Y" checked>사용함 <input type="radio" value="N" class="radio_txt">사용안함</li>
       <li>출력순서</li>
       <li><input name="iorder" type="text" class="notice_in in2">&nbsp;&nbsp;&nbsp;※ 숫자만 입력하세요 단, 동일한 이름일 경우 데이터 등록된 순으로 출력 됩니다.</li>
       </ol>
       <span class="notice_btns">
       <input type="button" value="주거타입 등록" class="meno_btn2" id="info" onclick="infok();"></span>
       </section>
    </div>
</div> 
</section>
</form>