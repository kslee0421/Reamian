package portfolio;

import java.io.PrintWriter;
import java.net.InetAddress;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPClientConfig;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import okhttp3.*;

@Controller
public class webpage {
	PrintWriter pw = null;
	@Inject
	private SqlSessionFactory sqlsessionfactory;
	
	@Resource 
	private SqlSessionTemplate sqlsession;
	SqlSession se =null;
	
	private noticevo nvo;
	List<noticevo> noticeall ;
	
	/*ftp 관련 변수*/
	private String host; //호스트
	private String user; //ftp 사용자 아이디
	private String pass; //ftp 사용자 패스워드
	private int port; //ftp 포트
	
	/*SMS 변수*/
	private String service_id = "ncp:sms:kr:318002747651:raemian"; //open API Key 
	private String access_id ="ocUNXmdgtCs589Vk9WDq"; //access_id
	private String secret_key ="QtGAhRfAJLLSfHVXn4bgrEwDjppobjnMwTGuW9JF"; // 인증키 관리의 Secret key
	private String service = "SMS"; //SMS, LMS, MMS
	private String url ="https://sens.apigw.ntruss.com/sms/v2/services/"+service_id+"/messages" ;
	private String url2 ="/sms/v2/services/"+service_id+"/messages" ; //SHA 암호화에서 사용
	private String timestamp = Long.toString(System.currentTimeMillis());  //발송시간 1625245221 2023-10-18

	@RequestMapping("raemian_notice_view.do")
	public String raemian_notice_view(Model mm,HttpServletResponse res ,HttpServletRequest req,@RequestParam(required = false) String nidx) throws Exception {
		noticevo noticeall = null;
		SqlSession se = sqlsessionfactory.openSession();
		try {
			Map<String ,Object> m = new HashMap<String, Object>();
			m.put("nidx", nidx);
			se.update("reamianDB.notice_count_update",m);
			m.put("table", "notice");
			m.put("part","nidx_search");
			noticeall=se.selectOne("reamianDB.selectview",m);			
			//확인하고 조회할 값이 여러개면 vo를 사용해야한다
			req.setAttribute("data", noticeall);	
			
			ArrayList<String> onedata = new ArrayList<String>();	//각각 안받고 데이터를 배열로 받기위한 빈 배열
			onedata.add(Integer.toString(noticeall.getNidx()));
			onedata.add(noticeall.getNsubject());
			onedata.add(noticeall.getNcontents());
			onedata.add(noticeall.getNwriter());
			onedata.add(noticeall.getNfile());
			mm.addAttribute("one",onedata); //배열로 날리기
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("올바른 접근 방식이 아닙니다.");
		}
		se.close();
		return "raemian_notice_view";
	}
	
	@RequestMapping("delete_reserve.do")
	public String reserve_del(HttpServletResponse res ,HttpServletRequest req,@RequestParam(required = false) String rid) {
		res.setContentType("text/html; charset=utf-8");
		PrintWriter pw = null;
		SqlSession se = null;
		membervo mvo = null;
		String userid = null;
		userid= rid;
		HttpSession ss = req.getSession();
		Map<String ,Object> m = new HashMap<String, Object>();
		try {
			se = sqlsessionfactory.openSession();
			
			m.put("rid", rid);
			int result = se.delete("reamianDB.reserve_delete",rid);
			m.put("mid", userid);
			m.put("mres", "N");
			int ok = se.update("reamianDB.reserve_member_update",m);
			if(result > 0){
				pw = res.getWriter();
				pw.write("<script> "
						+ "alert('정상적으로 삭제 완료 되었습니다.'); "
						+ "location.href='./index.do';"
						+ "</script>");
				ss.setAttribute("useres", "N");
				System.out.println("정상적으로 삭제 완료 되었습니다.");
			}
			else {
				System.out.println("SQL 문법 오류 발생!");
			}
		}
		catch(Exception e) {
			System.out.println("올바른 접근 방식이 아닙니다.");
		}
		finally {
			se.close();
		}
		return null;
	}
	
	@RequestMapping("admin/reserve_main.do")
	@ResponseBody
	public String reserve_list(@ModelAttribute("reserve_main") reservo reservo, @RequestBody (required = false)HashMap<String, Object> target, @RequestParam( defaultValue = "0") int page, @RequestParam(required = false) String search,HttpServletRequest req, HttpServletResponse res) {
		String part = null;
		String data = null;
		String searchvalue = null;
		String table = "reserve";
		String areavalue =null;
		try {
			List<reservo> reserveall = null;
			Map<String ,Object> m = new HashMap<String, Object>();  
			SqlSession se = sqlsessionfactory.openSession(); // 데이터베이스 연결
			if(search !=null && !search.equals("") ) {	
				searchvalue = req.getParameter("search");
				part =req.getParameter("tag");;
				data = searchvalue;
			}
			m.put("table", table);
			String total = se.selectOne("reamianDB.count",m); //search2에 전달 
			m.put("data", data);
			m.put("part", part);
			System.out.println("part :"+part);
			System.out.println("data :"+data);
 			System.out.println("m :"+m);
			//int page =Integer.parseInt(pg);
			page = ((page-1)*10);
			if(page<0) {
				page=0;
				//pg="0";
			}
			m.put("page", page);			
			String cnt = se.selectOne("reamianDB.count",m); //search2에 전달 
			System.out.println("컨트롤러 mcnt:"+cnt);
			m.remove("table", table);
			reserveall = se.selectList("reamianDB.reserve_mainlist",m);
			int pagevalue = page;
			System.out.println("page2 :"+page);
			req.setAttribute("data", reserveall);
			req.setAttribute("cnt", cnt);
			req.setAttribute("search", searchvalue);
			req.setAttribute("page", pagevalue);
			req.setAttribute("total", total);
			RequestDispatcher ds = req.getRequestDispatcher("/admin/reserve_main.jsp");
			ds.forward(req,res);
			se.close();
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("Database 접속 오류발생!!");
		};

		return null;
	}
	
	@RequestMapping("index.do")
	@ResponseBody
	public String type_list(@ModelAttribute("type") infovo infovo, @RequestBody (required = false)HashMap<String, Object> target, @RequestParam( defaultValue = "0") int page, @RequestParam(required = false) String search,HttpServletRequest req, HttpServletResponse res) {
		String part = null;
		String data = null;
		String table = "info";
		try {
			List<noticevo> noticeall = null;
			Map<String ,Object> m = new HashMap<String, Object>();  
			SqlSession se = sqlsessionfactory.openSession(); // 데이터베이스 연결
			m.put("table", table);
			String total = se.selectOne("reamianDB.count",m); //search2에 전달 

			m.put("data", data);
			m.put("part", part);
			System.out.println("part :"+part);
			System.out.println("data :"+data);
 			System.out.println("m :"+m);
			//int page =Integer.parseInt(pg);
			String cnt = se.selectOne("reamianDB.count",m); //search2에 전달 
			System.out.println("컨트롤러 mcnt:"+cnt);
			page = ((page-1)*10);
			if(page<0) {
				page=0;
				//pg="0";
			}
			System.out.println(cnt.getClass());
			m.put("page", page);			
			noticeall = se.selectList("reamianDB.infolist",m);
			int pagevalue = page;
			System.out.println("page2 :"+page);
			req.setAttribute("data", noticeall);
			req.setAttribute("cnt", cnt);
			req.setAttribute("page", pagevalue);
			req.setAttribute("total", total);
			RequestDispatcher ds = req.getRequestDispatcher("index.jsp");
			ds.forward(req,res);
			se.close();
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("Database 접속 오류발생!!");
		};

		return null;
	}
	
	@RequestMapping("raemian_notice.do")
	@ResponseBody
	public String raemian_notice_list(@ModelAttribute("notice") noticevo noticevo, @RequestBody (required = false)HashMap<String, Object> target, @RequestParam( defaultValue = "0") int page, @RequestParam(required = false) String search,HttpServletRequest req, HttpServletResponse res) {
		String part = null;
		String data = null;
		String searchvalue = null;
		String table = "notice";
		try {
			List<noticevo> noticeall = null;
			Map<String ,Object> m = new HashMap<String, Object>();  
			SqlSession se = sqlsessionfactory.openSession(); // 데이터베이스 연결
			if(search!=null) {	
				searchvalue = req.getParameter("search");
				part ="nsubject";
				data = searchvalue;
			}
			m.put("table", table);
			String total = se.selectOne("reamianDB.count",m); //search2에 전달 

			m.put("data", data);
			m.put("part", part);
			System.out.println("part :"+part);
			System.out.println("data :"+data);
 			System.out.println("m :"+m);
			//int page =Integer.parseInt(pg);
			String cnt = se.selectOne("reamianDB.count",m); //search2에 전달 
			System.out.println("컨트롤러 mcnt:"+cnt);
			page = ((page-1)*10);
			if(page<0) {
				page=0;
				//pg="0";
			}
			System.out.println(cnt.getClass());
			m.put("page", page);			
			noticeall = se.selectList("reamianDB.noticelist",m);
			int pagevalue = page;
			System.out.println("page2 :"+page);
			req.setAttribute("data", noticeall);
			req.setAttribute("cnt", cnt);
			req.setAttribute("search", searchvalue);
			req.setAttribute("page", pagevalue);
			req.setAttribute("total", total);
			RequestDispatcher ds = req.getRequestDispatcher("/raemian_notice.jsp");
			ds.forward(req,res);
			se.close();
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("Database 접속 오류발생!!");
		};

		return null;
	}
	
	@RequestMapping("raemian_faq.do")
	@ResponseBody
	public String raemian_faq_list(@ModelAttribute("rfaq") faqvo faqvo, @RequestBody (required = false)HashMap<String, Object> target, @RequestParam( defaultValue = "0") int page, @RequestParam(required = false) String search,HttpServletRequest req, HttpServletResponse res) {
		String part = null;
		String data = null;
		String table = "faq";
		try {
			List<faqvo> faqall = null;
			Map<String ,Object> m = new HashMap<String, Object>();  
			SqlSession se = sqlsessionfactory.openSession(); // 데이터베이스 연결
			m.put("table", table);
			String total = se.selectOne("reamianDB.count",m); //search2에 전달 

			m.put("data", data);
			m.put("part", part);
			System.out.println("part :"+part);
			System.out.println("data :"+data);
 			System.out.println("m :"+m);
			//int page =Integer.parseInt(pg);
			String cnt = se.selectOne("reamianDB.count",m); //search2에 전달 
			System.out.println("컨트롤러 mcnt:"+cnt);
			page = ((page-1)*10);
			if(page<0) {
				page=0;
				//pg="0";
			}
			System.out.println(cnt.getClass());
			m.put("page", page);			
			faqall = se.selectList("reamianDB.faqlist",m);
			int pagevalue = page;
			System.out.println("page2 :"+page);
			req.setAttribute("data", faqall);
			req.setAttribute("cnt", cnt);
			req.setAttribute("page", pagevalue);
			req.setAttribute("total", total);
			RequestDispatcher ds = req.getRequestDispatcher("/raemian_faq.jsp");
			ds.forward(req,res);
			se.close();
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("Database 접속 오류발생!!");
		};

		return null;
	}
	
	@RequestMapping("reserve_cc.do")
	public String reserve_cc(@ModelAttribute("reserve") reservo reservo, @ModelAttribute("memberup") membervo membervo,@RequestParam(required =false) String userid, Model mm,HttpServletResponse res ,HttpServletRequest req,@RequestParam(required = false) String midx) throws Exception {
		String part = null;
		String data = null;
		List<reservo> rvo = null;
		List<membervo> mvo = null;
		String useres = null;
		String rtime = null;
		String rday = null;
		SqlSession se = sqlsessionfactory.openSession();
		HttpSession ss = req.getSession();
		try {
			Object mid = ss.getAttribute("userid");
			Map<String ,Object> m = new HashMap<String, Object>();
			m.put("rid", mid);
			rvo=se.selectList("reamianDB.reserve_view",m);
			m.put("mid", mid);
			mvo=se.selectList("reamianDB.member_select",m);
			req.setAttribute("rvo", rvo);	

		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("올바른 접근 방식이 아닙니다.");
		}
		se.close();
		
		return "reserve_cc";
	}
	
	@RequestMapping("resermofyok.do")
	public String resermofyok(HttpServletResponse res,HttpServletRequest req,@ModelAttribute("memberup") membervo membervo, @ModelAttribute("reservo") reservo reservo,@RequestParam(required =false) String rid, @RequestParam(required =false) String mres) {
		se = sqlsessionfactory.openSession();	
		membervo mvo = null;
		reservo rvo = null;
		PrintWriter pw = null;
		String useres = null;
		String usermodi = null;
		res.setContentType("text/html; charset=utf-8");
		HttpSession ss = req.getSession();
		Map<String ,Object> m = new HashMap<String, Object>();
		try{
			m.put("rid", rid);
			m.put("rday", reservo.getRday());
			m.put("rtime", reservo.getRtime());
			m.put("rnum", reservo.getRnum());
			m.put("rmodi", "Y");
			int result = se.update("reamianDB.reserve_modify_update",m);
			m.put("mid", rid);
			mvo = se.selectOne("reamianDB.member_select",m);
			rvo = se.selectOne("reamianDB.reserve_select",m);
			if(result>0) {
				System.out.println("정상적으로 업데이트가 완료되었습니다.");
				pw = res.getWriter();
				pw.write("<script> "
						+ "alert('정상적으로 예약수정이 완료되었습니다.'); "
						+ "location.href='./index.do';"
						+ "</script>");
				useres=mvo.getMres();
				usermodi=rvo.getRmodi();
				ss.setAttribute("useres", useres);
				ss.setAttribute("usermodi", usermodi);
			}
			else {
				System.out.println("SQL 문법오류 발생");
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	@RequestMapping("reserve_ck.do")
	public String reserve_ck(@ModelAttribute("reserve_list") reservo reservo, @ModelAttribute("member_up") membervo membervo,@RequestParam(required =false) String userid, Model mm,HttpServletResponse res ,HttpServletRequest req,@RequestParam(required = false) String midx) throws Exception {
		String part = null;
		String data = null;
		List<reservo> rvo = null;
		List<membervo> mvo = null;
		String useres = null;
		String rtime = null;
		String rday = null;
		SqlSession se = sqlsessionfactory.openSession();
		HttpSession ss = req.getSession();
		try {
			Object mid = ss.getAttribute("userid");
			Map<String ,Object> m = new HashMap<String, Object>();
			m.put("rid", mid);
			rvo=se.selectList("reamianDB.reserve_view",m);
			m.put("mid", mid);
			mvo=se.selectList("reamianDB.member_select",m);
			req.setAttribute("rvo", rvo);	

		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("올바른 접근 방식이 아닙니다.");
		}
		se.close();
		
		return "reserve_ck";
	}
	
	
	@RequestMapping("reserveok.do")
	public String reserveok(HttpServletResponse res,HttpServletRequest req,@ModelAttribute("memberup") membervo membervo, @ModelAttribute("reservo") reservo reservo,@RequestParam(required =false) String rid, @RequestParam(required =false) String mres) {
		se = sqlsessionfactory.openSession();	
		membervo mvo = null;
		PrintWriter pw = null;
		String useres = null;
		res.setContentType("text/html; charset=utf-8");
		HttpSession ss = req.getSession();
		Map<String ,Object> m = new HashMap<String, Object>();
		try{
			int result = se.insert("reamianDB.reserve_insert",reservo);
			m.put("mid", rid);
			m.put("mres","Y");
			int ok = se.update("reamianDB.reserve_member_update",m);
			mvo = se.selectOne("reamianDB.member_select",m);
			if(result>0) {
				pw = res.getWriter();
				pw.write("<script> "
						+ "alert('정상적으로 예약이 완료되었습니다.'); "
						+ "location.href='./index.do';"
						+ "</script>");
				useres=mvo.getMres();
				ss.setAttribute("useres", useres);
			}
			else {
				System.out.println("SQL 문법오류 발생");
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	@RequestMapping("/admin/admin_main.do")
	@ResponseBody
	public String admin_main(@ModelAttribute("member_main") membervo membervo,@ModelAttribute("faq_main") faqvo faqvo, @ModelAttribute("reserve_main") reservo reservo, @RequestBody (required = false)HashMap<String, Object> target, @RequestParam( defaultValue = "0") int page,HttpServletRequest req, HttpServletResponse res) {
		try {
			SqlSession se = sqlsessionfactory.openSession(); 
			//일반회원
			List<membervo> memberall = null;
			memberall = se.selectList("reamianDB.memberlist_main");
			req.setAttribute("memberall", memberall);
			//FAQ
			List<faqvo> faqall = null;
			faqall = se.selectList("reamianDB.faqlist_main");
			req.setAttribute("faqall", faqall);
			//예약현황
			List<reservo> reserveall = null;
			reserveall = se.selectList("reamianDB.reservelist_main");
			req.setAttribute("reserveall", reserveall);

			RequestDispatcher ds = req.getRequestDispatcher("/admin/admin_main.jsp");
			ds.forward(req,res);
			se.close();
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("Database 접속 오류발생!!");
		}

		return null;
	}
	
	@SuppressWarnings("unchecked")
	@PostMapping("smsok.do")
	public void smsok(@RequestParam (required = false ) String tel,
			@RequestParam (required = false) String context, HttpServletResponse response) throws Exception{
		/*요청사항에 대한 배열구조를 작성하는 파트*/
		JSONObject code1 = new JSONObject();
		JSONObject code2 = new JSONObject();
		JSONArray code3 = new JSONArray();
		code1.put("type", "SMS");
		code1.put("countryCode", "82");
		code1.put("from", "01047542394");
		code1.put("contentType", "COMM");
		code1.put("content", "이벤트 내용 발송");  //관리자가 확인하는 메세지 내용
		code2.put("content","[인증번호 : " + context+ "]"); //클라이언트 받을 메세지 내용
		code2.put("to", tel);
		code3.add(code2);
		code1.put("messages", code3);

		String data = code1.toString(); //해당 배열을 문자화로 변경
		System.out.println(data);
		//respnse.Builder.addHeader();
		//header 제작 코드 (curl) 클라이언트에서 서버와 통신 할 수 있는 서버 명령어 툴
		OkHttpClient client = new OkHttpClient(); // OKHttpClient POST GET 통신 공부 필수
		PrintWriter pw = response.getWriter();
		pw.write("ok");
//>> 연습할때는 여기서부터 주석 처리하고 만들자
//			Request req = new Request.Builder()
//				.addHeader("x-ncp-apigw-timestamp", timestamp)
//				.addHeader("x-ncp-iam-access-key", access_id)
//				.addHeader("x-ncp-apigw-signature-v2", makes())  //SHA로 변환된 값을 적용
//				.url(url)
//				.post(okhttp3.RequestBody.create(MediaType.parse("application/json"),data)) //POST로 전송
//				.build(); //curl 요청사항 제작
//		
//		Response res = client.newCall(req).execute(); //Naver API로 전송실행 및 응답 retutn 내용을 받음 
//		String result = res.body().string(); //문자열로 확인
//		System.out.println(result);
//		if(result.indexOf("202") > 0){ //202가있는지 없는지 검토
//		pw.print("ok");
//			System.out.println("전송 완료 되었습니다.");
//		}
//		else {
//			pw.print("cancel");
//			System.out.println("전송 오류 발생!!");
//		}
		
//>> 여기까지 주석처리		
		
	}
	//암호화 코드 변경 class ASE64  , SHA
	public String makes() throws Exception{
		String sp =" ";
		String line ="\n";
		String msg =new StringBuilder()
		.append("POST")
		.append(sp)
		.append(url2)
		.append(line)
		.append(timestamp)
		.append(line)
		.append(access_id)
		.toString();
		
		String base64 =""; 

		SecretKeySpec Key = new SecretKeySpec(secret_key.getBytes("UTF-8"), "HmacSHA256");
		Mac mac = Mac.getInstance("HmacSHA256");
		mac.init(Key);

		byte[] rawHmac = mac.doFinal(msg.getBytes("UTF-8"));
		base64 = Base64.getEncoder().encodeToString(rawHmac); //base64 -java utill

		return base64;
	}

	
	// member login
	@RequestMapping("login_memberok.do")
	@ResponseBody
	public String login_memberok(Model m,@RequestBody HashMap<String, Object> data, HttpServletRequest req,@ModelAttribute("reserve_login") reservo reservo) throws Exception{
	//public Model idcheck(Model m, @RequestParam(required = false) String userid) throws Exception{
		String userid = String.valueOf(data.get("userid"));
		String userpw = String.valueOf(data.get("userpw"));
		String username = "";
		String usertel = "";
		String useres = "";
		String usermodi = "";
		String ch =null;
		System.out.println(userid);
		HttpSession ss = req.getSession();
		membervo mvo =new membervo();
		reservo rvo =new reservo();
		Map<String ,Object> mm = new HashMap<String, Object>();
		try {
			mm.put("userid", userid);
			mm.put("userpw", userpw);
			se = sqlsessionfactory.openSession();
			String cnt = se.selectOne("reamianDB.login_member_cnt",mm);
			mvo = se.selectOne("reamianDB.login_member",mm);
			if(cnt.equals("0")) {
				ch ="N";
				//m.addAttribute("mid","N");				
				System.out.println("로그인이 불가능 합니다.");
			}
			else {
				//getter로드시 null일 경우 100% 오류가 발생함
				ch ="Y";
				
				rvo = se.selectOne("reamianDB.login_member_reserve",mm);
				//m.addAttribute("mid","Y");
				System.out.println("로그인이 되었습니다.");
				username=mvo.getMname();
				usertel=mvo.getMtel();
				useres=mvo.getMres();
				
				ss.setAttribute("userid", userid);
				ss.setAttribute("username", username);
				ss.setAttribute("usertel", usertel);
				ss.setAttribute("useres", useres);
				ss.setAttribute("usermodi", usermodi);
			}
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("Module 접속 오류!");
			//m.addAttribute("mid","error");
		}
		se.close();
		//return m;
		return ch;
	}
	
	@RequestMapping("idch.do")
	@ResponseBody
	public String idch(Model m,@RequestBody HashMap<String, Object> data) throws Exception{
	//public Model idcheck(Model m, @RequestParam(required = false) String userid) throws Exception{
		String userid = String.valueOf(data.get("userid"));
		String ch =null;
		System.out.println(userid);
		membervo mvo =new membervo();
		try {
			Map<String ,Object> mm = new HashMap<String, Object>();
			mm.put("userid", userid);
			se = sqlsessionfactory.openSession();
			String cnt = se.selectOne("reamianDB.countcheck",mm);
			
			if(cnt.equals("0")) {
				ch ="Y";
				//m.addAttribute("mid","Y");
				System.out.println("사용가능아이디 :"+ userid);
			}
			else {
				//getter로드시 null일 경우 100% 오류가 발생함
				ch ="N";
				//m.addAttribute("mid","N");				
				System.out.println("사용불가능 합니다");
			}
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("Module 접속 오류!");
			//m.addAttribute("mid","error");
		}
		se.close();
		//return m;
		return ch;
	}
	
	@RequestMapping("admin/delete_member.do")
	public String member_del(HttpServletResponse res ,@RequestParam(required = false) String midx) {
		res.setContentType("text/html; charset=utf-8");
		PrintWriter pw = null;
		SqlSession se = null;

		try {
			se = sqlsessionfactory.openSession();
			int result = se.delete("reamianDB.member_delete",midx);
			if(result > 0){
				pw = res.getWriter();
				pw.write("<script> "
						+ "alert('정상적으로 삭제 완료 되었습니다.'); "
						+ "location.href='./member_main.do';"
						+ "</script>");
				System.out.println("정상적으로 삭제 완료 되었습니다.");
			}
			else {
				System.out.println("SQL 문법 오류 발생!");
			}
		}
		catch(Exception e) {
			System.out.println("올바른 접근 방식이 아닙니다.");
		}
		finally {
			se.close();
		}
		return null;
	}
	
	@RequestMapping("/admin/member_main.do")
	@ResponseBody
	public String member_list(@ModelAttribute("member") membervo membervo, @RequestBody (required = false)HashMap<String, Object> target, @RequestParam( defaultValue = "0") int page, @RequestParam(required = false) String search,@RequestParam(required = false) String area,HttpServletRequest req, HttpServletResponse res) {
		String part = null;
		String data = null;
		String searchvalue = null;
		String table = "member";
		try {
			List<membervo> memberall = null;
			Map<String ,Object> m = new HashMap<String, Object>();  
			SqlSession se = sqlsessionfactory.openSession(); // 데이터베이스 연결
			if(search !=null && !search.equals("") ) {	
				searchvalue = req.getParameter("search");
				part =req.getParameter("tag");;
				data = searchvalue;
			}
			
			m.put("table", table);
			String total = se.selectOne("reamianDB.count",m); //search2에 전달 
			m.put("data", data);
			m.put("part", part);
			System.out.println("part :"+part);
			System.out.println("data :"+data);
 			System.out.println("m :"+m);
			//int page =Integer.parseInt(pg);
			page = ((page-1)*10);
			if(page<0) {
				page=0;
				//pg="0";
			}
			m.put("page", page);			
			String cnt = se.selectOne("reamianDB.count",m); //search2에 전달 
			System.out.println("컨트롤러 mcnt:"+cnt);
			m.remove("table", table);
			memberall = se.selectList("reamianDB.memberlist",m);
			int pagevalue = page;
			System.out.println("page2 :"+page);
			req.setAttribute("memberall", memberall);
			req.setAttribute("data", data);
			req.setAttribute("cnt", cnt);
			req.setAttribute("tagval", part);
			req.setAttribute("search", searchvalue);
			req.setAttribute("page", pagevalue);
			req.setAttribute("total", total);
			RequestDispatcher ds = req.getRequestDispatcher("/admin/member_main.jsp");
			ds.forward(req,res);
			se.close();
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("Database 접속 오류발생!!");
		};

		return null;
	}
	
	
	@RequestMapping("memberok.do")
	public String memberok(@ModelAttribute("admin_member") membervo membervo, HttpServletResponse res)throws Exception {
		PrintWriter pw = null;
		res.setContentType("text/html; charset=utf-8");
		se = sqlsessionfactory.openSession();	
		int a = se.insert("reamianDB.member_insert",membervo);
		if(a>0) {
			System.out.println("정상적으로 회원가입이 완료 되었습니다.");
			pw = res.getWriter();
			pw.write("<script> "
					+ "alert('정상적으로 회원가입이 완료 되었습니다.'); "
					+ "location.href='./login_member.jsp';"
					+ "</script>");
		}
		else {
			System.out.println("SQL 문법오류 발생");
		}
		return null;
	}
	
	@RequestMapping("admin/delete_info.do")
	public String info_del(HttpServletResponse res ,@RequestParam(required = false) String idx) {
		res.setContentType("text/html; charset=utf-8");
		PrintWriter pw = null;
		SqlSession se = null;
		try {
			se = sqlsessionfactory.openSession();
			int result = se.delete("reamianDB.info_delete",idx);
			if(result > 0){
				pw = res.getWriter();
				pw.write("<script> "
						+ "alert('정상적으로 삭제 완료 되었습니다.'); "
						+ "location.href='./info_main.do';"
						+ "</script>");
				System.out.println("정상적으로 삭제 완료 되었습니다.");
			}
			else {
				System.out.println("SQL 문법 오류 발생!");
			}
		}
		catch(Exception e) {
			System.out.println("올바른 접근 방식이 아닙니다.");
		}
		finally {
			se.close();
		}
		return null;
	}
	
	@RequestMapping("admin/info_main.do")
	@ResponseBody
	public String info_list(@ModelAttribute("info") infovo infovo, @RequestBody (required = false)HashMap<String, Object> target, @RequestParam( defaultValue = "0") int page, @RequestParam(required = false) String search,HttpServletRequest req, HttpServletResponse res) {
		String part = null;
		String data = null;
		String searchvalue = null;
		String table = "info";
		try {
			List<noticevo> noticeall = null;
			Map<String ,Object> m = new HashMap<String, Object>();  
			SqlSession se = sqlsessionfactory.openSession(); // 데이터베이스 연결
			if(search!=null) {	
				searchvalue = req.getParameter("search");
				part ="iparea";
				data = searchvalue;
			}
			m.put("table", table);
			String total = se.selectOne("reamianDB.count",m); //search2에 전달 
			m.put("data", data);
			m.put("part", part);
			System.out.println("part :"+part);
			System.out.println("data :"+data);
 			System.out.println("m :"+m);
			//int page =Integer.parseInt(pg);
			String cnt = se.selectOne("reamianDB.count",m); //search2에 전달 
			System.out.println("컨트롤러 mcnt:"+cnt);
			page = ((page-1)*10);
			if(page<0) {
				page=0;
				//pg="0";
			}
			System.out.println(cnt.getClass());
			m.put("page", page);			
			noticeall = se.selectList("reamianDB.infolist",m);
			int pagevalue = page;
			System.out.println("page2 :"+page);
			req.setAttribute("data", noticeall);
			req.setAttribute("cnt", cnt);
			req.setAttribute("search", searchvalue);
			req.setAttribute("page", pagevalue);
			req.setAttribute("total", total);
			RequestDispatcher ds = req.getRequestDispatcher("/admin/info_main.jsp");
			ds.forward(req,res);
			se.close();
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("Database 접속 오류발생!!");
		};

		return null;
	}

	
	@RequestMapping("admin/infok.do")
	public String infok(@ModelAttribute("info") infovo infovo, HttpServletResponse res) throws Exception{
		res.setContentType("text/html; charset=utf-8");
		se = sqlsessionfactory.openSession();	
		int a = se.insert("reamianDB.info_insert",infovo);
		if(a>0) {						
			PrintWriter pw = null;
			System.out.println("공지사항이 정상적으로 등록되었습니다.");
			pw = res.getWriter();
			pw.write("<script> "
				+ "alert('정상적으로 등록이 완료되었습니다.'); "
				+ "location.href='./info_main.do';"
				+ "</script>");
			System.out.println("FAQ 등록완료");
		}
		else {
			System.out.println("SQL 문법오류 발생");
		}
		return null;
	}
	
	
	@RequestMapping("admin/delete_faq.do")
	public String faq_del(HttpServletResponse res ,@RequestParam(required = false) String fidx) {
		res.setContentType("text/html; charset=utf-8");
		PrintWriter pw = null;
		SqlSession se = null;
		try {
			se = sqlsessionfactory.openSession();
			int result = se.delete("reamianDB.faq_delete",fidx);
			if(result > 0){
				pw = res.getWriter();
				pw.write("<script> "
						+ "alert('정상적으로 삭제 완료 되었습니다.'); "
						+ "location.href='./faq_main.do';"
						+ "</script>");
				System.out.println("정상적으로 삭제 완료 되었습니다.");
			}
			else {
				System.out.println("SQL 문법 오류 발생!");
			}
		}
		catch(Exception e) {
			System.out.println("올바른 접근 방식이 아닙니다.");
		}
		finally {
			se.close();
		}
		return null;
	}
	
	@RequestMapping("admin/faqok.do")
	public String faqok(@ModelAttribute("faq") faqvo faqvo, HttpServletResponse res) throws Exception{
		res.setContentType("text/html; charset=utf-8");	
		se = sqlsessionfactory.openSession();	
		int a = se.insert("reamianDB.faq_insert",faqvo);
		if(a>0) {						
			PrintWriter pw = null;
			System.out.println("공지사항이 정상적으로 등록되었습니다.");
			pw = res.getWriter();
			pw.write("<script> "
				+ "alert('정상적으로 등록이 완료되었습니다.'); "
				+ "location.href='./faq_main.do';"
				+ "</script>");
			System.out.println("FAQ 등록완료");
		}
		else {
			System.out.println("SQL 문법오류 발생");
		}
		return null;
	}
	
	@RequestMapping("admin/faq_main.do")
	@ResponseBody
	public String faq_list(@ModelAttribute("faq") faqvo faqvo, @RequestBody (required = false)HashMap<String, Object> target, @RequestParam( defaultValue = "0") int page, @RequestParam(required = false) String search,HttpServletRequest req, HttpServletResponse res) {
		String part = null;
		String data = null;
		String searchvalue = null;
		String table = "faq";
		try {
			List<faqvo> faqall = null;
			Map<String ,Object> m = new HashMap<String, Object>();  
			SqlSession se = sqlsessionfactory.openSession(); // 데이터베이스 연결
			if(search!=null) {	
				searchvalue = req.getParameter("search");
				part ="fanswer";
				data = searchvalue;
			}
			m.put("table", table);
			String total = se.selectOne("reamianDB.count",m); //search2에 전달 

			m.put("data", data);
			m.put("part", part);
			System.out.println("part :"+part);
			System.out.println("data :"+data);
 			System.out.println("m :"+m);
			//int page =Integer.parseInt(pg);
			String cnt = se.selectOne("reamianDB.count",m); //search2에 전달 
			System.out.println("컨트롤러 mcnt:"+cnt);
			page = ((page-1)*10);
			if(page<0) {
				page=0;
				//pg="0";
			}
			System.out.println(cnt.getClass());
			m.put("page", page);			
			faqall = se.selectList("reamianDB.faqlist",m);
			int pagevalue = page;
			System.out.println("page2 :"+page);
			req.setAttribute("data", faqall);
			req.setAttribute("cnt", cnt);
			req.setAttribute("search", searchvalue);
			req.setAttribute("page", pagevalue);
			req.setAttribute("total", total);
			RequestDispatcher ds = req.getRequestDispatcher("/admin/faq_main.jsp");
			ds.forward(req,res);
			se.close();
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("Database 접속 오류발생!!");
		};

		return null;
	}
	
	//공지사항 뷰 페이지
	@RequestMapping("admin/notice_view.do")
	public String notice_view(Model mm,HttpServletResponse res ,HttpServletRequest req,@RequestParam(required = false) String nidx) throws Exception {
		noticevo noticeall = null;
		SqlSession se = sqlsessionfactory.openSession();
		try {
			Map<String ,Object> m = new HashMap<String, Object>();
			m.put("nidx", nidx);
			se.update("reamianDB.notice_count_update",m);
			m.put("table", "notice");
			m.put("part","nidx_search");
			noticeall=se.selectOne("reamianDB.selectview",m);			
			//확인하고 조회할 값이 여러개면 vo를 사용해야한다
			req.setAttribute("data", noticeall);	
			
			ArrayList<String> onedata = new ArrayList<String>();	//각각 안받고 데이터를 배열로 받기위한 빈 배열
			onedata.add(Integer.toString(noticeall.getNidx()));
			onedata.add(noticeall.getNsubject());
			onedata.add(noticeall.getNcontents());
			onedata.add(noticeall.getNwriter());
			onedata.add(noticeall.getNfile());
			mm.addAttribute("one",onedata); //배열로 날리기
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("올바른 접근 방식이 아닙니다.");
		}
		se.close();
		return "admin/notice_view";
	}
	
	@RequestMapping("admin/delete_notice.do")
	public String review_del(HttpServletResponse res ,@RequestParam(required = false) String nidx) {
		res.setContentType("text/html; charset=utf-8");
		PrintWriter pw = null;
		SqlSession se = null;
		try {
			se = sqlsessionfactory.openSession();
			int result = se.delete("reamianDB.notice_delete",nidx);
			if(result > 0){
				pw = res.getWriter();
				pw.write("<script> "
						+ "alert('정상적으로 삭제 완료 되었습니다.'); "
						+ "location.href='./notice_main.do';"
						+ "</script>");
				System.out.println("정상적으로 삭제 완료 되었습니다.");
			}
			else {
				System.out.println("SQL 문법 오류 발생!");
			}
		}
		catch(Exception e) {
			System.out.println("올바른 접근 방식이 아닙니다.");
		}
		finally {
			se.close();
		}
		return null;
	}
	
	
	//공지사항 리스트출력
	@RequestMapping("admin/notice_main.do")
	@ResponseBody
	public String notice_list(@ModelAttribute("notice") noticevo noticevo, @RequestBody (required = false)HashMap<String, Object> target, @RequestParam( defaultValue = "0") int page, @RequestParam(required = false) String search,HttpServletRequest req, HttpServletResponse res) {
		String part = null;
		String data = null;
		String searchvalue = null;
		String table = "notice";
		try {
			List<noticevo> noticeall = null;
			Map<String ,Object> m = new HashMap<String, Object>();  
			SqlSession se = sqlsessionfactory.openSession(); // 데이터베이스 연결
			if(search!=null) {	
				searchvalue = req.getParameter("search");
				part ="nsubject";
				data = searchvalue;
			}
			m.put("table", table);
			String total = se.selectOne("reamianDB.count",m); //search2에 전달 

			m.put("data", data);
			m.put("part", part);
			System.out.println("part :"+part);
			System.out.println("data :"+data);
 			System.out.println("m :"+m);
			//int page =Integer.parseInt(pg);
			String cnt = se.selectOne("reamianDB.count",m); //search2에 전달 
			System.out.println("컨트롤러 mcnt:"+cnt);
			page = ((page-1)*10);
			if(page<0) {
				page=0;
				//pg="0";
			}
			System.out.println(cnt.getClass());
			m.put("page", page);			
			noticeall = se.selectList("reamianDB.noticelist",m);
			int pagevalue = page;
			System.out.println("page2 :"+page);
			req.setAttribute("data", noticeall);
			req.setAttribute("cnt", cnt);
			req.setAttribute("search", searchvalue);
			req.setAttribute("page", pagevalue);
			req.setAttribute("total", total);
			RequestDispatcher ds = req.getRequestDispatcher("/admin/notice_main.jsp");
			ds.forward(req,res);
			se.close();
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("Database 접속 오류발생!!");
		};

		return null;
	}

	
	//공지사항 글쓰기
	@RequestMapping("admin/noticeok.do")
	public String noticeok(@RequestParam(required = false) MultipartFile nfilename, @ModelAttribute("notice") noticevo noticevo, HttpServletResponse res, Model m) {
		se = sqlsessionfactory.openSession();
		res.setContentType("text/html; charset=utf-8");
        FTPClient ftp = new FTPClient();
		ftp.setControlEncoding("utf-8"); //서버가 utf-8이라서 여기도 utf-8 한글깨짐 방지
		FTPClientConfig cf = new FTPClientConfig();
		noticevo nto =new noticevo();
		try { 	
			String filenm = nfilename.getOriginalFilename();
			System.out.println(filenm);
			if (filenm=="") {
				nto.setNfile("N");
				nto.setNsubject(noticevo.nsubject);
				nto.setNcontents(noticevo.ncontents);	
				nto.setNwriter(noticevo.nwriter);
				int a = se.insert("reamianDB.notice_insert",nto);
				if(a>0) {
					PrintWriter pw = null;
					System.out.println("공지사항이 정상적으로 등록되었습니다.");
					pw = res.getWriter();
					pw.write("<script> "
							+ "alert('정상적으로 등록이 완료되었습니다.'); "
							+ "location.href='./notice_main.do';"
							+ "</script>");
				}
				else {
					System.out.println("SQL 문법오류 발생");
				}
			}
			else {
			
			InetAddress inet = InetAddress.getLocalHost();
			String ip = inet.getHostAddress();
			
			this.host="iup.cdn1.cafe24.com";
			this.user="primewom137";
			this.pass="acts32dim@@";
			this.port=21;
			
			ftp.configure(cf); //FTP client로 연결을 준비하는 단계
			ftp.connect(this.host,this.port); //client로 서버에 접근 (호스트정보, 포트정보)
			
			if(ftp.login(this.user,this.pass)) { //ftp로그인(아이디,패스워드)
				int rp =ftp.getReplyCode(); //status = 200번대 : 정상
				System.out.println(rp);				
				ftp.setFileType(FTP.BINARY_FILE_TYPE); //파일 전송 유형
				//BINARY_FILE_TYPE : 이미지, 동영상, PPT
				//ASCII_FILE_TYPE : txt 파일
				System.out.println(ftp);  //접속성공시 정상적으로 해당 정보를 출력:org.apache.commons.net.ftp.FTPClient@684f5090 이런거 뜨면 잘 연결이 된거
				//ftp.makeDirectory("www"); //디렉토리 생성
				//ftp.removeDirectory("img_ks"); //디렉토리 생성
				//InputStream is = mfile.getInputstream();
				Date today = new Date();
				DateFormat df = new SimpleDateFormat("yyyyMMddhms");
				String dates = df.format(today);
  				boolean result = ftp.storeFile("/www/img/"+dates+filenm,nfilename.getInputStream());
 				if(result == true) {
					//db 저장
					//cafe24 CDN : http://아이디.cdn1.cafe24.com/img/
 					
 					String url ="http://primewom137.cdn1.cafe24.com/img/"+dates+filenm;
 					m.addAttribute("imgsrc",url);
 					System.out.println(noticevo.ncontents);
					nto.setNsubject(noticevo.nsubject);
					nto.setNcontents(noticevo.ncontents);
					nto.setNwriter(noticevo.nwriter);
					nto.setNfile(url);
					System.out.println("정상적으로 업로드 되었습니다");
					
					//FTP 파일 삭제 
					//boolean delok = ftp.deleteFile("/www/img/logo.jpg");
					//System.out.println(delok);
					
					int a = se.insert("reamianDB.notice_insert",nto);
					if(a>0) {
						PrintWriter pw = null;
						System.out.println("공지사항이 정상적으로 등록되었습니다.");
						pw = res.getWriter();
						pw.write("<script> "
								+ "alert('정상적으로 등록이 완료되었습니다.'); "
								+ "location.href='./notice_main.do';"
								+ "</script>");
					}
					else {
						System.out.println("SQL 문법오류 발생");
					}
				}
				else {
					System.out.println("해당 디렉토리 및 파일에 문제가 발생하였습니다.");
				}	
			}
			else {
				System.out.println("FTP 정보가 올바르지 않습니다.");	
			}
			ftp.disconnect(); //ftp 접속종료
			}
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("FTP 접속 정보 오류 및 접속사용자 오버!!");
		}
		finally {
			try {
				ftp.disconnect();
			}
			catch (Exception e) {
				System.out.println("접속종료 오류발생");
			}
		}
		se.close();
		return null;
	}
	
	
	@RequestMapping("admin/modify.do")
	@ResponseBody
	public datavo modifyok(@RequestBody HashMap<String, Object> data) throws Exception{
		System.out.println("data :"+data);
		se = sqlsessionfactory.openSession();
		datavo dto =new datavo();
		String midx = String.valueOf(data.get("midx"));
		String mstatus = (String)data.get("mstatus");
		dto.setMidx(Integer.parseInt(midx));
		dto.setMstatus(mstatus);
		System.out.println("컨트롤러의 midx :"+midx);
		System.out.println("컨트롤러의 mstatus :"+mstatus);
		try {
			if(dto.getMidx() == 0) {
				System.out.println("통과안됨 :"+ dto.getMidx());
			}
			else {
				int a = se.update("reamianDB.config_update", dto);
				if(a>0) {
					System.out.println("정상적으로 업데이트가 완료 되었습니다.");
				}
				else {
					System.out.println("SQL 문법오류 발생");
				}
				//getter로드시 null일 경우 100% 오류가 발생함
				//m.addAttribute("midx","yes");				
			}
		}
		catch(Exception e) {
			System.out.println("Module 접속 오류!");
			System.out.println(e);
			//m.addAttribute("midx","error");
		}
		se.close();
		return dto;
		//return "admin/jsp/idsearch";
	}

	
	//관리자 현황페이지 리스트 출력
		@RequestMapping("admin/config_main.do")
		@ResponseBody
		public String config_list(@ModelAttribute("config") datavo datavo, @RequestBody (required = false)HashMap<String, Object> target, @RequestParam( defaultValue = "0") int page, @RequestParam(required = false) String search,@RequestParam(required = false) String area,HttpServletRequest req, HttpServletResponse res) {
			String part = null;
			String data = null;
			String searchvalue = null;
			String table = "admin_member";
			String areavalue =null;
			int pagevalue = 0;
			try {
				List<datavo> memberall = null;
				Map<String ,Object> m = new HashMap<String, Object>();  
				SqlSession se = sqlsessionfactory.openSession(); // 데이터베이스 연결
				if(search !=null && !search.equals("") ) {	
					searchvalue = req.getParameter("search");
					part =req.getParameter("tag");;
					data = searchvalue;
				}
				if(area != null && !area.equals("")) {
					part="marea";
					areavalue =req.getParameter("area");
					data = areavalue;
				};				
				m.put("table", table);
				String total = se.selectOne("reamianDB.count",m); //search2에 전달 
				m.put("data", data);
				m.put("part", part);
				System.out.println("part :"+part);
				System.out.println("data :"+data);
	 			System.out.println("m :"+m);
				//int page =Integer.parseInt(pg);
				page = ((page-1)*10);
				if(page<0) {
					page=0;
					//pg="0";
				}
				m.put("page", page);			
				String cnt = se.selectOne("reamianDB.count",m); //search2에 전달 
				System.out.println("컨트롤러 mcnt:"+cnt);
				m.remove("table", table);
				memberall = se.selectList("reamianDB.admin_memberlist",m);
				pagevalue =page;
			
				System.out.println("page2 :"+page);
				req.setAttribute("memberall", memberall);
				req.setAttribute("data", data);
				req.setAttribute("areavalue", areavalue);
				req.setAttribute("cnt", cnt);
				req.setAttribute("search", searchvalue);
				req.setAttribute("tagval", part);				
				req.setAttribute("page", pagevalue);
				req.setAttribute("total", total);
				RequestDispatcher ds = req.getRequestDispatcher("/admin/config_main.jsp");
				ds.forward(req,res);
				se.close();
			}
			catch(Exception e) {
				System.out.println(e);
				System.out.println("Database 접속 오류발생!!");
			};

			return null;
		}

	
	@RequestMapping("admin/admin_idch.do")
	@ResponseBody
	public String admin_idch(Model m,@RequestBody HashMap<String, Object> data) throws Exception{
	//public Model idcheck(Model m, @RequestParam(required = false) String userid) throws Exception{
		String userid = String.valueOf(data.get("userid"));
		String ch =null;
		System.out.println(userid);
		datavo dvo =new datavo();
		try {
			Map<String ,Object> mm = new HashMap<String, Object>();
			mm.put("userid", userid);
			se = sqlsessionfactory.openSession();
			String cnt = se.selectOne("reamianDB.admin_countcheck",mm);
			
			if(cnt.equals("0")) {
				ch ="Y";
				//m.addAttribute("mid","Y");
				System.out.println("사용가능아이디 :"+ userid);
			}
			else {
				//getter로드시 null일 경우 100% 오류가 발생함
				ch ="N";
				//m.addAttribute("mid","N");				
				System.out.println("사용불가능 합니다");
			}
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("Module 접속 오류!");
			//m.addAttribute("mid","error");
		}
		se.close();
		//return m;
		return ch;
	}
	
	// 회원가입
	@RequestMapping("admin/admin_memberok.do")
	public String admin_memberok(HttpServletResponse res, @ModelAttribute("member") datavo datavo) throws Exception{
		res.setContentType("text/html; charset=utf-8");
		se = sqlsessionfactory.openSession();	
		int a = se.insert("reamianDB.admin_member_insert",datavo);
		if(a>0) {
			PrintWriter pw = null;
			System.out.println("회원가입이 완료되었습니다.");
			pw = res.getWriter();
			pw.write("<script> "
					+ "alert('회원가입이 완료되었습니다.'); "
					+ "location.href='index.jsp';"
					+ "</script>");
		}
		else {
			System.out.println("SQL 문법오류 발생");
		}
		return null;
	}
	
	@RequestMapping("admin/login_admin.do")
	@ResponseBody
	public String login_admin(Model m,HttpServletRequest req,@RequestBody HashMap<String, Object> data) throws Exception{
	//public Model idcheck(Model m, @RequestParam(required = false) String userid) throws Exception{
		String userid = String.valueOf(data.get("userid"));
		String userpw = String.valueOf(data.get("userpw"));
		String auserid = "";
		String ausername = "";
		String ausertel = "";
		String ch =null;
		System.out.println(userid);
		HttpSession ss = req.getSession();
		datavo dvo =new datavo();
		datavo dvonc =new datavo();

		try {
			Map<String ,Object> mm = new HashMap<String, Object>();
			mm.put("userid", userid);
			mm.put("userpw", userpw);
			se = sqlsessionfactory.openSession();
			String cnt = se.selectOne("reamianDB.login_admin_cnt",mm);
			String idcnt = se.selectOne("reamianDB.login_admin_idcnt",mm);
			if (!idcnt.equals("0")) {
				dvo = se.selectOne("reamianDB.login_admin",mm);
				dvonc = se.selectOne("reamianDB.login_admin_ncount",mm);				
				int logcount =dvonc.getMlogcnt();
				if(cnt.equals("0")) {
					if(logcount >=5){
						ch ="C";
						System.out.println("로그인 횟수를 초과했습니다.");
					}else {
						ch ="N";
						int locnt=se.update("reamianDB.login_count_update",mm);
					}
				}
				else {
					ch ="Y";
					int locnt=se.update("reamianDB.login_count_update_set",mm);
					System.out.println("로그인이 되었습니다.");

					auserid=dvo.getMid();
					ausername=dvo.getMname();
					ausertel=dvo.getMtel();
					ss.setAttribute("auserid", auserid);
					ss.setAttribute("ausername", ausername);
					ss.setAttribute("ausertel", ausertel);
				}
			}
			else{
				ch ="N";	
				System.out.println("없는 아이디 입니다.");
			}
		}
		catch(Exception e) {
			System.out.println(e);
			System.out.println("Module 접속 오류!");
		}
		se.close();
		//return m;
		return ch;
	}
}

