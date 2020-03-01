package ino.web.freeboard.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FreeBoardRepository {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<Map<String,Object>> freeBoardGetList(Map<String, Object> map){
		return sqlSessionTemplate.selectList("freeBoardGetList", map);
	}

	public int getTotalCount() {
		return sqlSessionTemplate.selectOne("totalCount");
	}
	
	public int insertBoard(Map<String, Object> map) {
		sqlSessionTemplate.insert("insertBoard",map);
		int cnt = (int)map.get("result");
		return cnt;
	}

	public Map<String, Object> getDataByNum(int num) {
		return sqlSessionTemplate.selectOne("getDataByNum", num);
	}

	public int updateByNum(Map<String, Object> map) {
		sqlSessionTemplate.update("updateByNum", map);
		int cnt = (int)map.get("result");
		return cnt;
	}

	public int deleteByNum(int num) {
		return sqlSessionTemplate.delete("deleteByNum", num);
	}

}
