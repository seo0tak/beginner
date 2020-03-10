package seo.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import seo.web.service.BoardService;


@RestController
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value="/api", produces = "application/json", method = RequestMethod.GET)
	public Map<String, Object> main(HttpServletRequest req) {
		Map<String, Object> map = new HashMap<>();
		map = boardService.main(map);
		return map;
	}
}
