<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Calendar cal = Calendar.getInstance();
cal.add(Calendar.DATE, +1);
Date reserve_today = new Date(cal.getTimeInMillis());
DateFormat dfd = new SimpleDateFormat("yyyy-MM-dd");
String reserve_dates = dfd.format(reserve_today);
System.out.println(reserve_dates);
%>     
    
<%
	String ruser_id ="";
	String ruser_pw ="";
	String ruser_name ="";
	String ruser_tel ="";
	String ruser_res ="";
	if(session.getAttribute("userid")==null || session.getAttribute("userid")==""){
		out.println("<script>alert('로그인이 필요한 페이지 입니다. (로그인 페이지로 이동합니다.)');location.href='./login_member.jsp';</script>");
	}
	else{
		if(session.getAttribute("useres").equals("Y")){
			out.println("<script>alert('이미 예약이 존재합니다. (예약은 한번만 가능하니다.)');location.href='./index.do';</script>");
		}
		else{
			try{
				ruser_id = session.getAttribute("userid").toString();
				ruser_name = session.getAttribute("username").toString();
				ruser_tel = session.getAttribute("usertel").toString();
			}
			catch(Exception e){
				System.out.println(e);
			}
		}
	}
%>     
<div class="sub_title">
<section class="sub_image">
<span>
최적의 입주환경을 준비하는 입주 전 서비스<br>
두근두근 설레는 마음, 레미안 입주를 앞둔 고객님을 위한 사전방문 예약 입니다.</span>
</section>    
</div>    
    
<!-- 회원가입 화면 시작 -->
    <label class="mbship_title">
        <p>MAKE A RESERVATION</p>
        <ul>
          <li style="color: #000;">※ 예약하실 일자 및 예약자 정보를 입력하세요</li>
        </ul>
      </label>
    <form id="r" method="post" action="./reserveok.do" enctype="application/x-www-form-urlencoded">
      <fieldset class="mbship_box">
        <h3>예약일자 입력 <span style="display: inline-block; font-size: 12px; vertical-align: 5px; float: right;">■ 표시는 필수 입력 항목입니다.</span></h3>
        <span class="agree_span">
        <ol class="mbinfos">
        <input type="hidden" name="rmodi" value="N">
        <input type="hidden" name="mres" value="Y">
        <li><em class="ck_font">■</em> 아이디</li>
        <li><%=ruser_id%>
        <input name="rid" type="hidden" class="mbinput1" value="<%=ruser_id%>" readonly>
        </li>
        <li><em class="ck_font">■</em> 고객명</li>
        <li><%=ruser_name%>
        <input name="rname" type="hidden" class="mbinput2" value="<%=ruser_name%>" readonly>
        </li>
        <li><em class="ck_font">■</em> 예약일자</li>
        <li>
        <input name="rday" type="date" class="mbinput1" min="<%=reserve_dates%>">
        </li>
        <li><em class="ck_font">■</em> 예약시간</li>
        <li>
        <select class="mbinput1" name="rtime">
        <option value="">시간선택</option>    
        <option value="09:00">09:00</option>        
        <option value="10:00">10:00</option>
        <option value="11:00">11:00</option>
        <option value="14:00">14:00</option>
        <option value="15:00">15:00</option>
        <option value="16:00">16:00</option>
        <option value="17:00">17:00</option>
        </select>
        </li>
        <li><em class="ck_font">■</em> 휴대전화번호</li>
        <li><%=ruser_tel%>
        <input name="rtel" type="hidden" class="mbinput2" value="<%=ruser_tel%>" readonly>
        </li>
        <li><em class="ck_font">■</em> 인원수</li>
        <li>
        <label class="ck_label">
        <input type="radio" name="rnum" value="1" class="ck_label"> 1명
        </label>
        <label class="ck_label">
        <input type="radio" name="rnum" value="2" class="ck_label"> 2명
        </label>
        </li>
        </ol>
        </span>
        <span class="span_buttons">
        <button type="button" class="next_btn1_1" onclick="reserveok()">예약하기</button>
        </span>
      </fieldset>
    </form>