package com.fin.festa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fin.festa.model.entity.FeedVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.service.SearchService;

@Controller
@RequestMapping("/search/")
public class SearchController {
	
//////////////////////////////////////////////////////////////////////
///////////////////////////////검색 관련///////////////////////////////
//////////////////////////////////////////////////////////////////////
	
	@Autowired
	private SearchService searchService;

	//검색 결과
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String search(HttpServletRequest req, PageSearchVo pageSearchVo) {
		
		searchService.search(req, pageSearchVo);
		return "search";
	}
	
	//검색 결과 피드 상세(팝업)
	@RequestMapping(value="feed", method = RequestMethod.GET)
	public String searchFeedDetail(Model model, MyPostVo myPostVo, GroupPostVo groupPostVo) {
		
		searchService.searchFeedDetail(model, myPostVo, groupPostVo);
		return "common/feed";
	}
	
	@RequestMapping(value = "scroll", method = RequestMethod.GET)
	public @ResponseBody List<FeedVo> searchScroll(HttpServletRequest req, PageSearchVo pageSearchVo) {
		
		return searchService.searchScroll(req, pageSearchVo);
	}
	
	//검색 그룹피드댓글 더보기 비동기
	@RequestMapping(value = "feed/group_cmmt", method = RequestMethod.GET)
	public @ResponseBody List<GroupCommentVo> searchGroupCmmt(Model model, GroupCommentVo groupCommentVo){
		
		return searchService.searchGroupCmmt(model, groupCommentVo);
	}
	
	//검색 개인피드댓글 더보기 비동기
	@RequestMapping(value = "feed/my_cmmt", method = RequestMethod.GET)
	public @ResponseBody List<MyCommentVo> searchMyCmmt(Model model, MyCommentVo myCommentVo){
		
		return searchService.searchMyCmmt(model, myCommentVo);
	}
	
	//검색 결과 피드 수정(팝업>팝업)
	@RequestMapping(value="feed/maker", method = RequestMethod.GET)
	public String searchFeedUpdateOne() {
		return "search/maker";
	}
	
	//검색 결과 피드 수정(팝업>팝업>팝업 내 기능)
	@RequestMapping(value="feed/maker", method = RequestMethod.POST)
	public String searchFeedUpdateOne(Model model, MyPostVo myPostVo, GroupPostVo groupPostVo) {
		return "search/feed";
	}
	
	//검색 결과 피드 삭제(팝업>내부팝업 기능)
	@RequestMapping(value="feed/del", method = RequestMethod.POST)
	public String searchFeedDeleteOne(Model model, MyPostVo myPostVo, GroupPostVo groupPostVo) {
		return "search/index";
	}
	
	//검색 결과 피드 댓글 등록(팝업>팝업 내 기능)
	@RequestMapping(value = "feed/cmmtadd", method = RequestMethod.POST)
	public String searchFeedCmmtInsertOne(Model model, MyCommentVo myCommentVo, GroupCommentVo groupCommentVo){
		
		searchService.searchFeedCmmtInsertOne(model, myCommentVo, groupCommentVo);
		return "common/feed";
	}
	
	//검색 결과 피드 댓글 삭제(팝업>내부팝업 기능)
	@RequestMapping(value = "feed/cmmtdel", method = RequestMethod.POST)
	public String searchFeedCmmtDeletetOne(Model model, MyCommentVo myCommentVo, GroupCommentVo groupCommentVo){
		return "search/feed";
	}

	//검색 결과 피드 좋아요(팝업>팝업 내 기능)
	@RequestMapping(value = "feed/likeadd", method = RequestMethod.POST)
	public String searchFeedLikeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo){
		
		searchService.searchFeedLikeInsertOne(req, myGoodVo);
		return "common/feed";
	}
	
	//검색 결과 피드 좋아요 취소(팝업>팝업 내 기능)
	@RequestMapping(value = "feed/likedel", method = RequestMethod.POST)
	public String searchFeedLikeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo){
		
		searchService.searchFeedLikeDeleteOne(req, myGoodVo);
		return "common/feed";
	}

	//검색 결과 피드 신고(팝업)
	@RequestMapping(value="feed/report", method = RequestMethod.GET)
	public String searchFeedReport(Model model, FeedVo feed) {
		
		model.addAttribute("feedReport", feed);
		return "common/report";
	}

	//검색 결과 피드 신고(팝업>팝업 내 기능)
	@RequestMapping(value="feed/report", method = RequestMethod.POST)
	public String searchFeedReport(HttpServletRequest req, ReportListVo reportListVo, MultipartFile[] files) {
		
		searchService.searchFeedReport(req, reportListVo, files);
		return "common/report";
	}
}
