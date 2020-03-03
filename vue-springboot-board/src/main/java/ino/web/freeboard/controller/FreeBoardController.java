package ino.web.freeboard.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ino.web.freeboard.common.util.StringNullCheck;
import ino.web.freeboard.service.FreeBoardService;

@CrossOrigin(origins = "http://localhost:8081")
@RestController
@RequestMapping("/api")
public class FreeBoardController {
	
	@Autowired
	FreeBoardService freeBoardService;
	
	@GetMapping("/vueBoard")
	public Map<String, Object> main(HttpServletRequest req) {
		Map<String, Object> map = new HashMap<>();
		//String null 체크
		if(StringNullCheck.isEmpty(req.getParameter("curPage"))){
			int curPage = 1;
			map.put("curPage", curPage);
		}else {
			map.put("curPage", Integer.parseInt(req.getParameter("curPage")));
		}
	
		map = freeBoardService.main(map);
		return map;
	}
	
	@PostMapping("/vueBoard")
	public String create(@RequestBody Map<String,Object> map) {
		String message = freeBoardService.create(map);
		return message;
	}
	
	@GetMapping("/vueBoard/{num}")
	public Map<String, Object> detail(@PathVariable("num") int num) {
		Map<String, Object> resultMap = new HashMap<>();
		resultMap = freeBoardService.detail(num);
		return resultMap;
	}
	
	@PutMapping("/vueBoard/{num}")
	public String update(@PathVariable("num") int num, @RequestBody Map<String,Object> map){
		map.put("bunho", num);
		String message = freeBoardService.update(map);
		return message;
	}
	
	@DeleteMapping("/vueBoard/{num}")
	public String delete(@PathVariable("num") int num) {
		String message = freeBoardService.delete(num);
		return message;
	}
}
