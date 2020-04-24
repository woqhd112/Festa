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
import com.fin.festa.service.FeedService;

@Controller
@RequestMapping("/hot/")
public class FeedController {

//////////////////////////////////////////////////////////////////////
//////////////////////////////  인기피드  /////////////////////////////
//////////////////////////////////////////////////////////////////////

	@Autowired
	private FeedService feedService;

	//인기피드 조회
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String hotFeedSelectAll(HttpServletRequest req) {
		
		feedService.hotFeedSelectAll(req);
		return "hot/index";
	}
	
	//인기피드 조회
	@RequestMapping(value = "scroll", method = RequestMethod.GET)
	public @ResponseBody List<List<?>> hotFeedScroll(HttpServletRequest req, PageSearchVo pagesearchVo) {
		
		return feedService.hotFeedScroll(req, pagesearchVo);
	}

	//내 인기피드 수정 (팝업)
	@RequestMapping(value = "maker", method = RequestMethod.GET)
	public String feedUpdateOnePop(Model model, MyPostVo myPostVo, GroupPostVo groupPostVo) {
		
		feedService.hotFeedUpdateOnePop(model, groupPostVo, myPostVo);
		return "hot/maker";
	}
	
	//내 인기피드 수정 (팝업>팝업 내 기능)
	@RequestMapping(value = "maker", method = RequestMethod.POST)
	public String feedUpdateOne(HttpServletRequest req, MyPostVo myPostVo, GroupPostVo groupPostVo, MultipartFile[] files) {
		
		feedService.hotFeedUpdateOne(req, groupPostVo, myPostVo, files);
		
		return "hot/index";
	}

	//내 인기피드 삭제 (내부팝업 기능)
	@RequestMapping(value = "del", method = RequestMethod.POST)
	public String feedDeleteOne(Model model, MyPostVo myPostVo, GroupPostVo groupPostVo) {
		
		feedService.hotFeedDeleteOne(model, groupPostVo, myPostVo);
		return "hot/index";
	}
	
	//인기개인피드 댓글 더보기
	@RequestMapping(value = "myfeed/cmmt", method = RequestMethod.GET)
	public @ResponseBody List<MyCommentVo> myFeedCmmtMore(Model model, MyPostVo myPostVo){
		
		return feedService.myFeedCmmtMore(model, myPostVo);
	}
	
	//인기그룹피드 댓글 더보기
	@RequestMapping(value = "groupfeed/cmmt", method = RequestMethod.GET)
	public @ResponseBody List<GroupCommentVo> groupFeedCmmtMore(Model model, GroupPostVo groupPostVo){
		
		return feedService.groupFeedCmmtMore(model, groupPostVo);
	}
	
	//인기피드 댓글 등록
	@RequestMapping(value = "cmmtadd", method = RequestMethod.POST)
	public String hotFeedCmmtInsertOne(Model model, MyCommentVo myCommentVo, GroupCommentVo groupCommentVo){
		
		feedService.hotFeedCmmtInsertOne(model, groupCommentVo, myCommentVo);
		return "hot/index";
	}
	
	//인기피드 댓글 삭제 (내부팝업 기능)
	@RequestMapping(value = "cmmtdel", method = RequestMethod.POST)
	public String hotFeedCmmtDeleteOne(Model model, MyCommentVo myCommentVo, GroupCommentVo groupCommentVo){
		
		feedService.hotFeedCmmtDeleteOne(model, groupCommentVo, myCommentVo);
		return "hot/index";
	}
	
	//인기피드 좋아요
	@RequestMapping(value = "likeadd", method = RequestMethod.POST)
	public String hotLikeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo){
		
		feedService.hotLikeInsertOne(req, myGoodVo);
		return "hot/index";
	}
	
	//인기피드 좋아요 해제
	@RequestMapping(value = "likedel", method = RequestMethod.POST)
	public String hotLikeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo){
		
		feedService.hotLikeDeleteOne(req, myGoodVo);
		return "hot/index";
	}

	//인기피드 신고 (팝업)
	@RequestMapping(value = "report", method = RequestMethod.GET)
	public String hotFeedReport(Model model, FeedVo feedVo){
		
		model.addAttribute("feedReport", feedVo);
		return "hot/report";
	}
	
	//인기피드 신고 (팝업>팝업 내 기능)
	@RequestMapping(value = "report", method = RequestMethod.POST)
	public String hotFeedReport(HttpServletRequest req, ReportListVo reportListVo, MultipartFile[] files){
		
		feedService.hotFeedReport(req, reportListVo, files);
		return "hot/index";
	}
	
	
}
