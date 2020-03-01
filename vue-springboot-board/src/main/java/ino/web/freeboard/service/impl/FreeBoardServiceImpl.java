package ino.web.freeboard.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ino.web.freeboard.common.util.Paging;
import ino.web.freeboard.repository.FreeBoardRepository;
import ino.web.freeboard.service.FreeBoardService;

@Service
public class FreeBoardServiceImpl implements FreeBoardService{

	@Autowired
	private FreeBoardRepository freeBoardRepository;

	@Override
	public Map<String, Object> main(Map<String, Object> paramMap) {
		Map<String, Object> resultMap = new HashMap<>();
		int count = freeBoardRepository.getTotalCount();
		int curPage = (int)paramMap.get("curPage");
		Paging paging = new Paging(count,curPage);
		int start = paging.getPageBegin();
		int end = paging.getPageEnd();
		paramMap.put("start", start );
		paramMap.put("end", end );
		
		List<Map<String, Object>> list = freeBoardRepository.freeBoardGetList(paramMap);
		resultMap.put("list", list);
		resultMap.put("paging", paging);
		return resultMap;
	}

	@Override
	public String create(Map<String, Object> map) {
		map.put("result", 0);
		map.put("bunho", 0);
		int cnt = freeBoardRepository.insertBoard(map);
		String message = null;
		if(cnt>0) {
			message = "success";
		}
		else {
			message = "fail";
		}
		map.put("message", message);
		return message;
	}

	@Override
	public Map<String, Object> detail(int num) {
		Map<String, Object> map = freeBoardRepository.getDataByNum(num);
		return map;
	}

	@Override
	public String update(Map<String, Object> map) {
		map.put("result", 0);
		int cnt = freeBoardRepository.updateByNum(map);
		String message = null;
		if(cnt>0) {
			message = "success";
		}
		else {
			message = "fail";
		}
		map.put("message", message);
		return message;
	}

	@Override
	public String delete(int num) {
		int cnt = freeBoardRepository.deleteByNum(num);
		String message = null;
		if(cnt>0) {
			message = "success";
		}
		else {
			message = "fail";
		}
		return message;
	}
	
	
}
