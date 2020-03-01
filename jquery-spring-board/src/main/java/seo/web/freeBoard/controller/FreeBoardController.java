package seo.web.freeBoard.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import seo.web.freeBoard.common.util.StringNullCheck;
import seo.web.freeBoard.service.FreeBoardService;

@Controller
public class FreeBoardController {
	
	@Autowired
	private FreeBoardService freeBoardService;

	@ResponseBody
	@RequestMapping("/search.ino")
	public Map<String, Object> search(HttpServletRequest request) throws Exception
	{
		Map<String, Object> map = new HashMap<String, Object>();
		if (request.getParameter("curPage") == null){
			int curPage = 1;
			map.put("curPage", curPage );
		} else {
			map.put("curPage", Integer.parseInt(request.getParameter("curPage")) );
		}
		map.put("whatColumn", StringNullCheck.isEmpty( request.getParameter("whatColumn")) );
		map.put("keyword", StringNullCheck.isEmpty( request.getParameter("keyword")) );
		map.put("startDate", StringNullCheck.isEmpty( request.getParameter("startDate")) );
		map.put("endDate", StringNullCheck.isEmpty( request.getParameter("endDate")) );
		Map<String,Object> list = freeBoardService.search(map);
		return list;
	}
	
	@RequestMapping("/main.ino")
	public ModelAndView main(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		if (request.getParameter("curPage") == null){
			int curPage = 1;
			map.put("curPage", curPage );
		} else {
			map.put("curPage", Integer.parseInt( request.getParameter("curPage")) );
		}
		map.put("whatColumn", StringNullCheck.isEmpty( request.getParameter("whatColumn")) );
		map.put("keyword", StringNullCheck.isEmpty( request.getParameter("keyword")) );
		map.put("startDate", StringNullCheck.isEmpty( request.getParameter("startDate")) );
		map.put("endDate", StringNullCheck.isEmpty( request.getParameter("endDate")) );
		
		map = freeBoardService.main(map);
		
		mav.addObject("freeBoardList",map.get("map"));
		mav.addObject("paging",map.get("paging"));
		mav.addObject("whatColumn",map.get("whatColumn"));
		mav.addObject("keyword",map.get("keyword"));
		mav.addObject("startDate",map.get("startDate"));
		mav.addObject("endDate",map.get("endDate"));
		mav.addObject("selectOption",map.get("CommonCodeList"));
		mav.setViewName("boardMain");
		return mav;
	}
	
	@RequestMapping("/freeBoardInsert.ino")
	public ModelAndView freeBoardInsert(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		if (request.getParameter("curPage") == null){
			int curPage = 1;
			mav.addObject("curPage", curPage );
		} else {
			mav.addObject("curPage", Integer.parseInt( request.getParameter("curPage")) );
		}
		mav.addObject("whatColumn", StringNullCheck.isEmpty( request.getParameter("whatColumn")) );
		mav.addObject("keyword", StringNullCheck.isEmpty( request.getParameter("keyword")) );
		mav.addObject("startDate", StringNullCheck.isEmpty( request.getParameter("startDate")) );
		mav.addObject("endDate", StringNullCheck.isEmpty( request.getParameter("endDate")) );
		mav.setViewName("freeBoardInsert");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/freeBoardInsertPro.ino")
	public Map<String, Object> freeBoardInsertPro(HttpServletRequest request) throws Exception{
		Map<String, Object> map = new HashMap<>();
		map.put("name", request.getParameter("name"));
		map.put("title", request.getParameter("title"));
		map.put("content", request.getParameter("content"));
		map = freeBoardService.freeBoardInsertPro(map);
		return map;
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", Integer.parseInt(request.getParameter("num")));
		map = freeBoardService.freeBoardDetail(map);
		if (request.getParameter("curPage") == null){
			int curPage = 1;
			map.put("curPage", curPage );
		} else {
			map.put("curPage", Integer.parseInt( request.getParameter("curPage")) );
		}
		map.put("whatColumn", StringNullCheck.isEmpty( request.getParameter("whatColumn")) );
		map.put("keyword", StringNullCheck.isEmpty( request.getParameter("keyword")) );
		map.put("startDate", StringNullCheck.isEmpty( request.getParameter("startDate")) );
		map.put("endDate", StringNullCheck.isEmpty( request.getParameter("endDate")) );
		mav.addObject("list",map);
		mav.addObject("curPage",map.get("curPage"));
		mav.setViewName("freeBoardDetail");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardModify.ino")
	public Map<String, Object> freeBoardModify(HttpServletRequest request) throws Exception{
		Map<String, Object> map = new HashMap<>();
		map.put("bunho", request.getParameter("num"));
		map.put("name", request.getParameter("name"));
		map.put("title", request.getParameter("title"));
		map.put("content", request.getParameter("content"));
		map = freeBoardService.freeBoardModify(map);
		return map;
	}
	
	@RequestMapping("/freeBoardDelete.ino")
	public ModelAndView FreeBoardDelete(int num,
			@RequestParam(defaultValue = "", required = false ) String whatColumn,
			@RequestParam(defaultValue = "", required = false ) String keyword ,
			@RequestParam(defaultValue = "1", required = false ) int curPage,
			@RequestParam(defaultValue = "", required = false ) String startDate,
			@RequestParam(defaultValue = "", required = false ) String endDate
			) throws Exception{
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<>();
		map.put("num", num);
		freeBoardService.FreeBoardDelete(map);
		mav.setViewName("redirect:/main.ino?&curPage="+curPage+"&whatColumn="+whatColumn+"&keyword="+keyword+"&startDate="+startDate+"&endDate="+endDate);
		return mav;
	}
	
}