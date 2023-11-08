<%@page import="portfolio.datavo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%    
	String search = (String)request.getAttribute("search");
	String data = (String)request.getAttribute("data");
	String areaval = (String)request.getAttribute("areavalue");
	String tagval = (String)request.getAttribute("tagval");
	if (areaval == null) {
		areaval = "";
	}
	if(tagval==null){
		tagval= "";
	}
	// contoller에서 보내준 값 받아오기
	List<datavo> dv = (List<datavo>)request.getAttribute("memberall");
	int paging = 0;
	int ww= 1;
	int pg =1;	
	System.out.println("jsp dv :"+dv);
	System.out.println("cnt : "+request.getAttribute("cnt"));
	System.out.println("page : "+request.getAttribute("page"));
	System.out.println("area : "+request.getAttribute("area"));
	System.out.println("data : "+request.getAttribute("data"));
	System.out.println(search);
	int pagevalue = (int)request.getAttribute("page");
	Object abc = request.getAttribute("cnt");
	Object total = request.getAttribute("total");
	int totalvalue =Integer.parseInt((String)total);
	if (abc != null) {
		paging =Integer.parseInt((String)abc);  //여기서 불러줘야 아래서 쓸 수 있다
		pg =(int)Math.ceil(paging/ 10f);
	}
	String s = null;
	if(search == null || search == ""){
		search = "";
	}else{
		s="Y";
	}
	if(areaval!=null&&!areaval.equals("")){
		s="A";
	}
	
   	int cal = pagevalue;
   	if (cal <= 0){
   		cal = paging;
   	}else{
   		cal = paging-pagevalue;
   		System.out.println("paging"+paging);
   		System.out.println(pagevalue);
   	} 
%>   
<section class="page_section">    
<div class="listbody">
 <div class="adlisttitle">관리자 현황</div>
 <form id="configmain" method="get" action="./config_main.do">
 <div class="procho">
    <ul>
        <li class="prochoL procfont">소속</li>
        <li class="prochoL ">
            <select class="adlistcsel1" id="area" name="area">
                <option value="" <% if(areaval.equals("")) { %> selected <% } %> >전체</option>
                <option value="서울" <% if(areaval.equals("서울")) { %> selected <% } %>>본사</option>
                <option value="경기도" <% if(areaval.equals("경기도")) { %> selected <% } %>>경기도</option>
                <option value="인천" <% if(areaval.equals("인천")) { %> selected <% } %>>인천</option>
                <option value="대전" <% if(areaval.equals("대전")) { %> selected <% } %>>대전</option>
                <option value="세종"<% if(areaval.equals("세종")) { %> selected <% } %>>세종</option>
                <option value="광주"<% if(areaval.equals("광주")) { %> selected <% } %>>광주</option>
                <option value="대구"<% if(areaval.equals("대구")) { %> selected <% } %>>대구</option>
                <option value="울산"<% if(areaval.equals("울산")) { %> selected <% } %>>울산</option>
                <option value="전라남도"<% if(areaval.equals("전라남도")) { %> selected <% } %>>전라남도</option>
                <option value="전라북도"<% if(areaval.equals("전라북도")) { %> selected <% } %>>전라북도</option>
                <option value="충청남도"<% if(areaval.equals("충청남도")) { %> selected <% } %>>충청남도</option>
                <option value="충청북도"<% if(areaval.equals("충청북도")) { %> selected <% } %>>충청북도</option>
                <option value="경상남도"<% if(areaval.equals("경상남도")) { %> selected <% } %>>경상남도</option>
                <option value="경상북도"<% if(areaval.equals("경상북도")) { %> selected <% } %>>경상북도</option>
                <option value="제주도"<% if(areaval.equals("제주도")) { %> selected <% } %>>제주도</option>  
            </select>
        </li>
    </ul>
 </div>
 <div class="procho">
    <ul>
        <li class="prochoL procfont">검색형식</li>
        <li class="prochoL ">
            <select class="adlistcsel1" name="tag" id="search">
                <option value="mname" <% if(tagval.equals("mname")) { %> selected <% } %>>이름</option>
                <option value="mid"  <% if(tagval.equals("mid")) { %> selected <% } %>>아이디</option>
                <option value="mtel" <% if(tagval.equals("mtel")) { %> selected <% } %>>연락처</option>
            </select>
        </li>
        <li class="prochoL"><input type="text" class="adlistcsel1" id="text" name="search" value="<%=search%>"></li>
        <li class="prochoL"><input type="button" class="proclick" id="btn" value="검색"></li>
        <li class="prochoL"><button type="button" class="proclick" id="all" >전체</button></li>
    </ul>
 </div>
</form>
 <div class="protaball" id="body">
    <table width="1100">	
        <thead>
            <tr style="color: white; background-color:rgb(67, 66, 66);">
                <td class="listcenter" width=50>NO</td>
                <td class="listcenter" width=150>구분</td>
                <td class="listcenter" width=150>아이디</td>
                <td class="listcenter" width=120>이름</td>
                <td class="listcenter" width=80>직책</td>
                <td class="listcenter" width=200>이메일</td>
                <td class="listcenter" width=120>연락처</td>
                <td class="listcenter" width=120>현황</td>
                <td class="listcenter" width=110>적용</td>
            </tr>
        </thead>
        <tbody>
<% 
	if(dv == null || dv.size()==0){ //검색된 데이터가 없을 경우
%>
            <tr height="30"><td class="listcenter" colspan="9">등록된 관리자가 없습니다.</td></tr>
            <% 
	}
	else{
	int w= 0;
	do{	
		
%>
            <tr class="master_list">
                <td class="listcenter" width=50><%=cal-w%></td>
                <td class="listcenter" width=150><%=dv.get(w).getMarea()%></td>
                <td class="listcenter" width=150><%=dv.get(w).getMid()%></td>
                <td class="listcenter" width=120><%=dv.get(w).getMname()%></td>
                <td class="listcenter" width=80><%=dv.get(w).getMgrade()%></td>
                <td class="listcenter" width=200><%=dv.get(w).getMemail()%></td>
                <td class="listcenter" width=120><%=dv.get(w).getMtel()%></td>
                <td class="listcenter" width=120>

   	<%String mstat = dv.get(w).getMstatus();
	%>
				<select class="adlistsel3"  name="mstatus" id="mstatus">		
					<option value="근무중" <% if(mstat.equals("근무중")) { %> selected <% } %>>근무중</option>	
					<option value="퇴직중" <% if(mstat.equals("퇴직중")) { %> selected <% } %>>퇴직중</option>
				</select>
                </td>
                <td class="listcenter" width=110>
                <button type="button" class="listclick ms" onclick="ajax_load(<%=dv.get(w).getMidx()%>)">적용</button></td>
                <%-- <button type="button" class="listclick ms" onclick="ajax_load(<%=rv.get(w).getMidx()%>)">적용</button></td> --%>
            </tr>
    <%
	w++;
	}while(w < dv.size());
	}	
%>
        </tbody>
    </table>
 </div>
 <div class="propagebt">
    <ul>
        <li> &lt; </li>
    <%
	System.out.print("jsp의 pg :"+pg);
	while(ww <= pg){
		if(s==null) {
			%>
			<li onclick="page1(<%=ww%>)"><%=ww%></li>
			
		<% }
		else if(s.equals("Y")){
		%>
			<li onclick="page2(<%=ww%>)"><%=ww%></li>
			
		<%}
		else{
		%>
			<li onclick="page3(<%=ww%>)"><%=ww%></li>	
		<%
		}ww++;
	}
	%> 
        <li style="margin-right: 0px;"> &gt; </li>
    </ul>
 </div>
</div>
<!-- 관리자 리스트 끝 -->    
</section>
