package seo.web.commonCode.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommCodeService{

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<Map<String, Object>> selectCommonCodeList(Map<String,Object> map) {
		return sqlSessionTemplate.selectList("selectCommonCodeList", map);
	}

	public List<HashMap<String, Object>> selectCommonCodeListMain() {
		return sqlSessionTemplate.selectList("selectCommonCodeListMain");
	}

	public List<HashMap<String, Object>> selectDetailList(String code){
		return sqlSessionTemplate.selectList("selectDetailList", code);
	}
	
	public int insertDetailCode(List<HashMap<String, Object>> insertData) {
		return sqlSessionTemplate.insert("insertDetailCode", insertData);
	}

	public int decodeCheck(String decode) {
		int reuslt = sqlSessionTemplate.selectOne("decodeCheck", decode);
		return reuslt;
	}
	
	public void deleteDetailCode(List<HashMap<String, Object>> deleteData) {
		sqlSessionTemplate.delete("deleteDetailCode", deleteData);
	}

	public void updateDetailCode(List<HashMap<String, Object>> updateData) {
		sqlSessionTemplate.update("updateDetailCode", updateData);
	}
}
