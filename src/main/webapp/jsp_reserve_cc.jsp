<%@page import="portfolio.reservo"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ruser_id ="";
	String ruser_pw ="";
	String ruser_name ="";
	String ruser_tel ="";
	String ruser_res ="";
	String rday ="" ;
	String rid ="" ;
	String rtime ="" ;
	String rnum = "" ;
	List<reservo> rvo = null;
		if(session.getAttribute("userid")==null || session.getAttribute("userid")==""){
			out.println("<script>alert('로그인이 필요한 페이지 입니다. (로그인 페이지로 이동합니다.)');location.href='./login_member.jsp';</script>");
		}else if(session.getAttribute("useres").equals("N")){
			out.println("<script>alert('에약된 내용이 없습니다. (예약페이지로 이동합니다.)');location.href='./reserve_in.do';</script>");
		}else{
			try{	
				rvo = (List<reservo>)request.getAttribute("rvo");
				ruser_id = session.getAttribute("userid").toString();
				ruser_name = session.getAttribute("username").toString();
				ruser_tel = session.getAttribute("usertel").toString();
				System.out.println(ruser_name);
				System.out.println(ruser_res);
				rday = rvo.get(0).getRday().substring(0,10);
				rtime =rvo.get(0).getRtime();
				rnum =rvo.get(0).getRnum();
				rid =rvo.get(0).getRid();
				System.out.println(rvo);
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
    
<!-- 예약취소 화면 시작 -->
    <label class="mbship_title">
        <p>RESERVATION CANCEL</p>
        <ul>
          <li style="color: red;">※ 예약취소시 해당 데이터는 복구 되지 않습니다.</li>
        </ul>
      </label>
   <form id="rsvcc" method="post" enctype="application/x-www-form-urlencoded">
        <input type="hidden" value="<%=rid%>" id="rid" name="rid">
      <fieldset class="mbship_box">
        <h3>예약확인</h3>
        <span class="agree_span">
        <ol class="mbinfos">
        <li><em class="ck_font">■</em> 아이디</li>
        <li><%=ruser_id%></li>
        <li><em class="ck_font">■</em> 고객명</li>
        <li><%=ruser_name%></li>
        <li><em class="ck_font">■</em> 예약일자</li>
        <li><%=rday%></li>
        <li><em class="ck_font">■</em> 예약시간</li>
        <li><%=rtime%></li>
        <li><em class="ck_font">■</em> 휴대전화번호</li>
        <li><%=ruser_tel%>
        </li>
        <li><em class="ck_font">■</em> 인원수</li>
        <li>
        <label class="ck_label"><%=rnum%></label>
        </li>
        </ol>
        </span>
        <span class="span_buttons">
        <button type="button" class="next_btn1_1" id="delete_reserve">예약취소</button>
        </span>
      </fieldset>
    </form>
<!-- 예약취소 화면 종료-->