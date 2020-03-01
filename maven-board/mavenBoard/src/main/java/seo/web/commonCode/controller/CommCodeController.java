package seo.web.commonCode.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import seo.web.commonCode.service.CommCodeService;


@Controller
public class CommCodeController {
	
	@Autowired 
	private CommCodeService commCodeService;
	
	@Autowired
	private DataSourceTransactionManager txManager;
	
	@RequestMapping("/commonCode.ino")
	public ModelAndView commonCode(HttpServletRequest req){
		ModelAndView mav = new ModelAndView();
		List<HashMap<String,Object>> list = commCodeService.selectCommonCodeListMain();
		mav.addObject("list" , list);
		mav.setViewName("commonCodeMain");
		return mav;
	}
	
	
	
	
	
	@RequestMapping("/commonCodeDetail.ino")
	public ModelAndView detail(@RequestParam(defaultValue = "", required = false ) String code) {
		ModelAndView mav = new ModelAndView();
		List<HashMap<String, Object>> list = commCodeService.selectDetailList(code);
		mav.addObject("list", list);
		mav.addObject("code", code);
		mav.setViewName("detail");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/commit.ino")
	public void commit(@RequestBody List<HashMap<String,Object>> list) throws Exception{
		/*  
		 * 트랜잭션 처리   
		*/
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        List<HashMap<String,Object>> insertData = new ArrayList<>();
        List<HashMap<String,Object>> updateData = new ArrayList<>();
        List<HashMap<String,Object>> deleteData = new ArrayList<>();
        try{
        	for (HashMap<String, Object> resultMap : list) {
				if(resultMap.get("FLAG").equals("I")) {
					insertData.add(resultMap);
				}
				if(resultMap.get("FLAG").equals("U")) {
					updateData.add(resultMap);
				}
				if(resultMap.get("FLAG").equals("D")) {
					deleteData.add(resultMap);
				}
			}
        	if(insertData.size() > 0) {
        		commCodeService.insertDetailCode(insertData);
        	}
        	if(updateData.size() > 0) {
        		commCodeService.updateDetailCode(updateData);
        	}
        	if(deleteData.size() > 0) {
        		commCodeService.deleteDetailCode(deleteData);
        	}
	        txManager.commit(status);
        }catch (Exception ex) {
			txManager.rollback(status);
			throw ex;
        }
	}
	
	@ResponseBody
	@RequestMapping("/decodeCheck.ino")
	public int decodeCheck(HttpServletRequest req) {
		int result = commCodeService.decodeCheck(req.getParameter("decode"));
		return result;
	}
	
	@RequestMapping("/test.ino")
	public ModelAndView test() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("test");
		return mav;
	}
	
}
