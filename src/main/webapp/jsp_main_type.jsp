<%@page import="portfolio.infovo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%    
  //List<String> rv = (List<String>)request.getAttribute("data");
	String search = (String)request.getAttribute("search");	
	// contoller에서 보내준 값 받아오기
	List<infovo> rv = (List<infovo>)request.getAttribute("data");
	int paging = 0;
	int ww= 1;
	int pg =1;	
	System.out.println("jsp rv :"+rv);
	System.out.println("cnt : "+request.getAttribute("cnt"));
	System.out.println("page : "+request.getAttribute("page"));
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
  	int cal = pagevalue;
  	if (cal <= 0){
  		cal = paging;
  	}else{
  		cal = paging-pagevalue;
  	}
%>     
    <!--타입정보 시작 컷-->
	<section id="px4" class="sect04 px-sect last-sect">
        <div class="w-base">
            <div class="tit-area  animated fadeInUp m_center">
                <h3>편안하고 실용적인 <br class="m_br">합리적 공간배치<br class="m_br"><a href="#">more</a></h3>
                <p class="animated fadeInUp m_center">더 나은 삶, 나은 내일<br>가족의 행복한 이야기로 가득 채워집니다</p>
            </div>

             <div class="contents-4-box row">
                <div>
                    <ul class="nav nav-tabs box-nav m_flex_center">	
                        <li>
                            <button type="button" class="tab_showroom active" data-num="1"><%=rv.get(0).getItype()%></button>
                        </li>
                        <li>
                            <button type="button" class="tab_showroom" data-num="2"><%=rv.get(1).getItype()%></button>
                        </li>
                        <li>
                            <button type="button" class="tab_showroom" data-num="3"><%=rv.get(2).getItype()%></button>
                        </li>
						 <li>
                            <button type="button" class="tab_showroom" data-num="4"><%=rv.get(3).getItype()%></button>
                        </li>
                    </ul>
                </div>
                <div class="col-sm-12 col-xs-12">
                    <div class="iso-box">
                    	<%int w= 0;
                    	do{%>	
                        <div class="showroom" id="showroom_<%=w+1%>">
                            <span><img src="<%=rv.get(w).getIurl()%>" class="img-responsive center-block" alt=""></span>

                            <div class="area-info col-sm-1">
                                <h4><%=rv.get(w).getItype()%></h4>
                                <ul>
                                    <li>
                                        <h5>주거전용</h5>
                                        <p><%=rv.get(w).getIparea()%>㎡</p>
                                    </li>
                                    <li>
                                        <h5>주거공용</h5>
                                        <p><%=rv.get(w).getIcarea()%>㎡</p>
                                    </li>
                                    <li>
                                        <h5>기타공용</h5>
                                        <p><%=rv.get(w).getIetarea()%>㎡</p>
                                    </li>
                                    <li>
                                        <h5>계약면적</h5>
                                        <p><%=rv.get(w).getIcnarea()%>㎡</p>
                                    </li>
                                </ul>
                           </div>
                        </div>
                        <%w++;
                        }while(w < rv.size());%>  
                    </div>
                </div>
            </div>
        </div>
	</section>
<!-- 타입정보 끝 -->