<%@page import="portfolio.faqvo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%    
  //List<String> rv = (List<String>)request.getAttribute("data");
	String search = (String)request.getAttribute("search");	
	// contoller에서 보내준 값 받아오기
	List<faqvo> rv = (List<faqvo>)request.getAttribute("data");
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
<label class="mbship_title">
        <p>FAQ</p>
        <ul>
          <li>RAEMIAN 자주묻는 질문</li>
        </ul>
      </label>
      <fieldset class="faq_box"  id = "faq_span">
    <%if(rv == null || rv.size()==0){%>
       	<ul class="nodatas">
        <li>등록된 FAQ 내용 없습니다.</li>
       </ul>
	<%}else{int w= 0;do{%>
        <ul class="node">
        <li>질문</li>       
        <li><%=rv.get(w).getFquestion()%></li>
        </ul>
        <ol style="display: none;">
        <li>
        <%=rv.get(w).getFanswer()%></li>
        </ul>
        </ol>
    <%w++;}while(w < rv.size());}%>  
      </fieldset>
      
      
      
      
      
      
      
      
    