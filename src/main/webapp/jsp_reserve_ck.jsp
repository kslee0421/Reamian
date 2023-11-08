<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.List"%>
<%@page import="portfolio.reservo"%>
<%@page import="java.util.ArrayList"%>
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
	String rday ="" ;
	String rtime ="" ;
	String rnum = "" ;
	int ridx = 0 ;
	List<reservo> rvo = null;
		if(session.getAttribute("userid")==null || session.getAttribute("userid")==""){
			out.println("<script>alert('로그인이 필요한 페이지 입니다. (로그인 페이지로 이동합니다.)');location.href='./login_member.jsp';</script>");
		}else if(session.getAttribute("useres").equals("N")){
			out.println("<script>alert('에약된 내용이 없습니다. (예약페이지로 이동합니다.)');location.href='./reserve_in.jsp';</script>");
		}else{
			try{	
				rvo = (List<reservo>)request.getAttribute("rvo");
			
				if(rvo.get(0).getRmodi().equals("Y")){
				out.println("<script>alert('예약의 수정은 한번만 가능합니다. (예약 확인 페이지로 이동합니다.)');location.href='./reserve_cc.jsp';</script>");			
				}	
				else{	
					ruser_id = session.getAttribute("userid").toString();
					ruser_name = session.getAttribute("username").toString();
					ruser_tel = session.getAttribute("usertel").toString();
					System.out.println(ruser_name);
					System.out.println(ruser_res);
					rday = rvo.get(0).getRday().substring(0,10);
					rtime =rvo.get(0).getRtime();
					rnum =rvo.get(0).getRnum();
					System.out.println(rvo);
					}
			}	
			catch(Exception e){
				System.out.println(e);
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
    
<!-- 예약확인 화면 시작 -->
    <label class="mbship_title">
        <p>RESERVATION CONFIRM</p>
        <ul>
          <li style="color: red;">※ 예약수정은 1회 변경 가능 합니다.</li>
        </ul>
      </label>
    <form id="resck" method="post" action="resermofyok.do" enctype="application/x-www-form-urlencoded">
    <input type="hidden" value="<%=ruser_id%>" id="mid" name="mid">
    <input type="hidden" value="Y" name="rmodi">
      <fieldset class="mbship_box">
        <h3>예약확인 <span style="display: inline-block; font-size: 12px; vertical-align: 5px; float: right;">■ 표시는 필수 입력 항목입니다.</span></h3>
        <span class="agree_span">
        <ol class="mbinfos">
        <li><em class="ck_font">■</em> 아이디</li>
        <li><%=ruser_id%>
        <input type="hidden" class="mbinput1" name="rid" value="<%=ruser_id%>">
        </li>
        <li><em class="ck_font">■</em> 고객명</li>
        <li><%=ruser_name%>
        <input type="hidden" class="mbinput2" name="rname" value="<%=ruser_name%>">
        </li>
        <li><em class="ck_font">■</em> 예약일자</li>
        <li>
        <input name="rday" type="date" class="mbinput1" value="<%=rday%>" min="<%=reserve_dates%>">
        </li>
        <li><em class="ck_font">■</em> 예약시간</li>
        <li>
        <select class="mbinput1" name="rtime" value="">
        <option value=""<% if(rtime.equals("")) { %> selected <% } %> >시간선택</option>    
        <option value="09:00" <% if(rtime.equals("09:00")) { %> selected <% } %>>09:00</option>        
        <option value="10:00" <% if(rtime.equals("10:00")) { %> selected <% } %>>10:00</option>
        <option value="11:00" <% if(rtime.equals("11:00")) { %> selected <% } %>>11:00</option>
        <option value="14:00" <% if(rtime.equals("14:00")) { %> selected <% } %>>14:00</option>
        <option value="15:00" <% if(rtime.equals("15:00")) { %> selected <% } %>>15:00</option>
        <option value="16:00" <% if(rtime.equals("16:00")) { %> selected <% } %>>16:00</option>
        <option value="17:00" <% if(rtime.equals("17:00")) { %> selected <% } %>>17:00</option>
        </select>
        </li>
        <li><em class="ck_font">■</em> 휴대전화번호</li>
        <li><%=ruser_tel%>
        <input type="hidden" name="rtel" class="mbinput2" value="<%=ruser_tel%>">
        </li>
        <li><em class="ck_font">■</em> 인원수</li>
        <li>
        <label class="ck_label">
        <input type="radio" name="rnum" value="1" class="ck_label" <%if(rnum.equals("1")) { %> checked <% } %>> 1명
        </label>
        <label class="ck_label">
        <input type="radio" name="rnum" value="2" class="ck_label" <%if(rnum.equals("2")) { %> checked <% } %>> 2명
        </label>
        </li>
        </ol>
        </span>
        <span class="span_buttons">
        <button type="button" class="next_btn1_1" onclick="resmodify()">예약수정</button>
        </span>
      </fieldset>
    </form>
<!-- 예약확인 화면 종료-->