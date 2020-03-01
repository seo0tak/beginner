package seo.web.freeBoard.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FreeBoardDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<Map<String,Object>> freeBoardList(Map<String, Object> map){
		return sqlSessionTemplate.selectList("freeBoardGetList", map);
	}
	
	public int freeBoardInsertPro(Map<String, Object> map){
		sqlSessionTemplate.insert("freeBoardInsertPro",map);
		int cnt = (int)map.get("result");
		return cnt;
	}
	
	public Map<String, Object> getDetailByNum(int num){
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}
	
	public int getNewNum(){
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}
	
	public int freeBoardModify(Map<String, Object> map){
		sqlSessionTemplate.update("freeBoardModify", map);
		int cnt = (int)map.get("result");
		return cnt;
	}

	public void FreeBoardDelete (int num) {
		sqlSessionTemplate.delete("freeBoardDelete", num);
	}
	
	public int getTotalCount(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("totalCount" ,map);
	}

	public int getBunho() {
		return sqlSessionTemplate.selectOne("bunho");
	}
}
