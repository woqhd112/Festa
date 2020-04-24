package com.fin.festa.controller;

import java.util.ArrayList;
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
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.service.NewsService;

@Controller
@RequestMapping("/news/")
public class NewsController {

//////////////////////////////////////////////////////////////////////
//////////////////////////////  뉴스피드  /////////////////////////////
//////////////////////////////////////////////////////////////////////
	
	@Autowired
	private NewsService newsService;
	
	//뉴스피드 조회
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String newsFeedSelectAll(HttpServletRequest req, MyFollowingVo myFollowingVo){
		newsService.newsFeedSelectAll(req, myFollowingVo);
		return "news/index";
	}
	
	//뉴스피드 조회 (피드 더보기)
	@RequestMapping(value = "more", method = RequestMethod.POST)
	public String newsFeedMore(HttpServletRequest req, MyFollowingVo myFollowingVo){
		newsService.newsFeedMore(req, myFollowingVo);
		return "news/more";
	}
	
	//뉴스피드 조회 (댓글 더보기)
	@RequestMapping(value = "comment", method = RequestMethod.GET)
	public @ResponseBody List<?> newsCommentMore(Model model, MyPostVo myPost, GroupPostVo groupPost){
		List<?> list = null;
		if (groupPost.getGpnum() == 0) {
			list = newsService.newsFeedCommentMore(model, myPost);
		} else {
			list = newsService.newsGroupCommentMore(model, groupPost);
		}
		return list;
	}
	
	//내 피드 수정 (팝업)
	@RequestMapping(value = "edit", method = RequestMethod.GET)
	public String feedUpdateOne(Model model, GroupPostVo groupPostVo, MyPostVo myPostVo) {
		newsService.newsFeedSelectOne(model, groupPostVo, myPostVo);
		return "news/maker";
	}
	
	//내 피드 수정 (팝업>팝업 내 기능)
	@RequestMapping(value = "edit", method = RequestMethod.POST)
	public String feedUpdateOne(HttpServletRequest req, MyPostVo myPostVo, GroupPostVo groupPostVo, MultipartFile[] files) {
		newsService.newsFeedUpdateOne(req, groupPostVo, myPostVo, files);
		return "news/index";
	}

	//내 피드 삭제 (팝업>내부팝업 기능)
	@RequestMapping(value = "del", method = RequestMethod.POST)
	public String feedDeleteOne(Model model, GroupPostVo groupPostVo, MyPostVo myPostVo) {
		newsService.newsFeedDeleteOne(model, groupPostVo, myPostVo);
		return "news/index";
	}
	
	//뉴스피드 댓글 등록
	@RequestMapping(value = "cmmtadd", method = RequestMethod.POST)
	public String newsFeedCmmtInsertOne(Model model, MyCommentVo myCommentVo, GroupCommentVo groupCommentVo) {
		newsService.newsFeedCmmtInsertOne(model, groupCommentVo, myCommentVo);
		return "news/index";
	}
	
	//뉴스피드 댓글 삭제 (내부팝업 기능)
	@RequestMapping(value = "cmmtdel", method = RequestMethod.POST)
	public String newsFeedCmmtDeleteOne(Model model, GroupCommentVo groupCommentVo, MyCommentVo myCommentVo){
		newsService.newsFeedCmmtDeleteOne(model, groupCommentVo, myCommentVo);
		return "news/index";
	}
	
	//뉴스피드 좋아요
	@RequestMapping(value = "likeadd", method = RequestMethod.POST)
	public String newsLikeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo){
		newsService.newsLikeInsertOne(req, myGoodVo);
		return "news/index";
	}
	
	//뉴스피드 좋아요 해제
	@RequestMapping(value = "likedel", method = RequestMethod.POST)
	public String newsLikeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo){
		newsService.newsLikeDeleteOne(req, myGoodVo);
		return "news/index";
	}

	//뉴스피드 신고 (팝업)
	@RequestMapping(value = "report", method = RequestMethod.GET)
	public String newsFeedReport(Model model, MyPostVo myPostVo, GroupPostVo groupPostVo){
		newsService.newsFeedSelectOne(model, groupPostVo, myPostVo);
		return "news/report";
	}
	
	//뉴스피드 신고 (팝업>팝업 내 기능)
	@RequestMapping(value = "report", method = RequestMethod.POST)
	public String newsFeedReport(HttpServletRequest req, MultipartFile[] files, ReportListVo reportListVo){
		newsService.newsFeedReport(req, files, reportListVo);
		return "news/index";
	}
}
