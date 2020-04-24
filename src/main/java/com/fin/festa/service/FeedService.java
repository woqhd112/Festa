package com.fin.festa.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.fin.festa.model.entity.FeedVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.ReportListVo;

public interface FeedService {

		void hotFeedSelectAll(HttpServletRequest req);
		
		List<List<?>> hotFeedScroll(HttpServletRequest req, PageSearchVo pageSearchVo);
		
		void hotFeedCmmtInsertOne(Model model, GroupCommentVo groupCommentVo, MyCommentVo myCommentVo);
		
		void hotFeedCmmtDeleteOne(Model model, GroupCommentVo groupCommentVo, MyCommentVo myCommentVo);
		
		void hotLikeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo);
		
		void hotLikeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo);
		
		void hotFeedReport(HttpServletRequest req, ReportListVo reportListVo, MultipartFile[] files);
		
		void hotFeedUpdateOne(HttpServletRequest req, GroupPostVo groupPostVo, MyPostVo myPostVo, MultipartFile[] files);
		
		void hotFeedUpdateOnePop(Model model, GroupPostVo groupPostVo, MyPostVo myPostVo);
		
		void hotFeedDeleteOne(Model model, GroupPostVo groupPostVo, MyPostVo myPostVo);
		
		List<GroupCommentVo> groupFeedCmmtMore(Model model, GroupPostVo groupPostVo);
		
		List<MyCommentVo> myFeedCmmtMore(Model model, MyPostVo myPostVo);
}
