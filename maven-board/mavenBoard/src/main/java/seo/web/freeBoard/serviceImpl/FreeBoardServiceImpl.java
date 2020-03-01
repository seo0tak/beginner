package seo.web.freeBoard.serviceImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import seo.web.commonCode.service.CommCodeService;
import seo.web.freeBoard.common.util.Paging;
import seo.web.freeBoard.dao.FreeBoardDao;
import seo.web.freeBoard.service.FreeBoardService;

@Service
public class FreeBoardServiceImpl implements FreeBoardService{
	
	@Autowired
	private FreeBoardDao freeBoardDao;
	
	@Autowired
	private CommCodeService commCodeService;

	@Override
	public Map<String,Object> search(Map<String, Object> map) throws Exception {
		String startDate = (String)map.get("startDate");
		String endDate = (String)map.get("endDate");
		startDate = startDate.replace("-", "");
		endDate = endDate.replace("-", "");
		map.put("startDate", startDate );
		map.put("endDate", endDate );
		
		int count = freeBoardDao.getTotalCount(map);
		
		int curPage = (int)map.get("curPage");
		Paging paging = new Paging(count,curPage);
		int start = paging.getPageBegin();
		int end = paging.getPageEnd();
		map.put("start", start );
		map.put("end", end );
		
		List<Map<String,Object>> list = freeBoardDao.freeBoardList(map);
		map.put("paging", paging );
		map.put("map", list);
		
		return map;
	}

	@Override
	public Map<String, Object> main(Map<String, Object> map) throws Exception {
		String startDate = (String)map.get("startDate");
		String endDate = (String)map.get("endDate");
		startDate = startDate.replace("-", "");
		endDate = endDate.replace("-", "");
		map.put("startDate", startDate );
		map.put("endDate", endDate );
		
		map.put("CODE", "COM001");
		map.put("USEYN", "Y");
		List<Map<String, Object>> CommonCodeList = commCodeService.selectCommonCodeList(map); // COM001 에 대한 리스트
		map.put("CommonCodeList", CommonCodeList );
		
		int count = freeBoardDao.getTotalCount(map);
		
		int curPage = (int)map.get("curPage");
		Paging paging = new Paging(count,curPage);
		int start = paging.getPageBegin();
		int end = paging.getPageEnd();
		map.put("start", start );
		map.put("end", end );
		
		List<Map<String,Object>> list = freeBoardDao.freeBoardList(map);
		map.put("paging", paging );
		map.put("map", list);
		
		return map;
	}

	@Override
	public Map<String,Object> freeBoardInsertPro(Map<String, Object> map) throws Exception {
		map.put("result", 0);
		map.put("bunho", 0);
		int cnt = freeBoardDao.freeBoardInsertPro(map);
		String message = null;
		if(cnt>0) {
			message = "success";
			map.put("message", message);
		}
		else {
			message = "fail";
			map.put("message", message);
		}
		return map;
	}

	@Override
	public Map<String, Object> freeBoardDetail(Map<String, Object> map) throws Exception {
		int num = (int)map.get("num");
		map = freeBoardDao.getDetailByNum(num);
		return map;
	}

	@Override
	public Map<String, Object> freeBoardModify(Map<String, Object> map) throws Exception {
		map.put("result", 0);
		int cnt = freeBoardDao.freeBoardModify(map);
		String message = null;
		if(cnt>0) {
			message = "success";
			map.put("message", message);
		}
		else {
			message = "fail";
			map.put("message", message);
		}
		return map;
	}

	@Override
	public void FreeBoardDelete(Map<String, Object> map) throws Exception {
		int num = (int)map.get("num");
		freeBoardDao.FreeBoardDelete(num);
	}


}