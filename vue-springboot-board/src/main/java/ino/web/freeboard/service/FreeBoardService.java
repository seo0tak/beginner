package ino.web.freeboard.service;

import java.util.Map;

public interface FreeBoardService {
	//조회
	public Map<String, Object> main(Map<String, Object> map);
	//추가
	public String create(Map<String, Object> map);
	//상제보기
	public Map<String, Object> detail(int num);
	//수정
	public String update(Map<String, Object> map);
	//삭제
	public String delete(int num);
}
