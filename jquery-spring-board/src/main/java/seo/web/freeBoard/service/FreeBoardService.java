package seo.web.freeBoard.service;

import java.util.Map;

public interface FreeBoardService {
	//검색
	public Map<String,Object> search(Map<String, Object> map) throws Exception;
	//메인
	public Map<String,Object> main(Map<String, Object> map) throws Exception;
	public Map<String,Object> freeBoardInsertPro(Map<String, Object> map) throws Exception;
	public Map<String,Object> freeBoardDetail(Map<String, Object> map) throws Exception;
	public Map<String,Object> freeBoardModify(Map<String, Object> map) throws Exception;
	public void FreeBoardDelete(Map<String, Object> map) throws Exception;
}
