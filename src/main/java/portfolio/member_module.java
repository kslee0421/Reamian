package portfolio;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository("members")
public class member_module {

	@Resource(name="sqlsession")
	private SqlSessionTemplate tm;
	
	public datavo search_id(String userid) {
		datavo dto = tm.selectOne("reamianDB.search_id",userid);
		return dto;
	}
}
