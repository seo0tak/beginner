package seo.web.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import seo.web.repository.BoardRepository;
import seo.web.service.BoardService;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardRepository boardRepository;

	@Override
	public Map<String, Object> main(Map<String, Object> paramMap) {
		Map<String, Object> resultMap = new HashMap<>();
		List<Map<String, Object>> list = boardRepository.boardGetList(paramMap);
		resultMap.put("list", list);
		return resultMap;
	}
	
}
