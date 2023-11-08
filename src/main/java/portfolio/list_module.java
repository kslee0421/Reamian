package portfolio;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

@Repository("lists")
public class list_module {

	@Resource(name="sqlsession")
	private SqlSessionTemplate session;
	
	public List<datavo> selectall(@RequestParam(defaultValue = "0") int page) {
		List<datavo> selectall = session.selectList("reamianDB.selectall",page);
		System.out.println("모듈 selectall: "+selectall);
		return selectall;
	}
	
	public List<datavo> searchall(@RequestParam(defaultValue = "0") int page) {
		List<datavo> searchall = session.selectList("reamianDB.selectsearch",page);
		System.out.println("모듈 searchall: "+searchall);
		return searchall;
	}

	public List<noticevo> noticeall(@RequestParam( defaultValue = "0") int page) {
		List<noticevo> noticeall = session.selectList("reamianDB.notice_all",page);
		System.out.println("모듈 noticeall: "+noticeall);
		return noticeall;
	}
}
