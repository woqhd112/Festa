package com.fin.festa.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.fin.festa.model.entity.FeedVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.ReportListVo;

public interface NewsService {

	void newsFeedSelectAll(HttpServletRequest req, MyFollowingVo myFollowingVo);
		
	void newsFeedCmmtInsertOne(Model model, GroupCommentVo groupCommentVo, MyCommentVo myCommentVo);
		
	void newsFeedCmmtDeleteOne(Model model, GroupCommentVo groupCommentVo, MyCommentVo myCommentVo);
		
	void newsLikeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo);
		
	void newsLikeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo);
		
	void newsFeedReport(HttpServletRequest req, MultipartFile[] files, ReportListVo reportListVo);
		
	void newsFeedUpdateOne(HttpServletRequest req, GroupPostVo groupPostVo, MyPostVo myPostVo,  MultipartFile[] files);
		
	void newsFeedDeleteOne(Model model, GroupPostVo groupPostVo, MyPostVo myPostVo);

	void newsFeedSelectOne(Model model, GroupPostVo groupPostVo, MyPostVo myPostVo);
	
	void newsFeedMore(HttpServletRequest req, MyFollowingVo myFollowingVo);

	List<MyCommentVo> newsFeedCommentMore(Model model, MyPostVo myPost);

	List<GroupCommentVo> newsGroupCommentMore(Model model, GroupPostVo groupPost);
}
