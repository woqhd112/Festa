package com.fin.festa.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.service.IndexService;

@Controller
@RequestMapping("/")
public class IndexController {

//////////////////////////////////////////////////////////////////////
////////////////////////////////홈 관련////////////////////////////////
//////////////////////////////////////////////////////////////////////

	@Autowired
	private IndexService indexService;
	
	//메인 출력
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String index(HttpServletRequest req) {
		
		indexService.index(req);
		return "index";
	}
	
	//404화면 출력
	@RequestMapping(value ="empty", method = RequestMethod.GET)
	public String notFound() {
		return "empty";
	}
}
