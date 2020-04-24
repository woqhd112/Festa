package com.fin.festa.model;

import java.util.List;

import com.fin.festa.model.entity.FeedVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.ReportListVo;

public interface FeedDao {
	
	List<FeedVo> hotGroupFeedSelectAll(PageSearchVo pageSearchVo);
	
	List<GroupCommentVo> hotGroupCommentSelectAll(FeedVo feed);
	
	List<FeedVo> hotMyFeedSelectAll(PageSearchVo pageSearchVo);
	
	List<MyCommentVo> hotMyCommentSelectAll(FeedVo feed);
	
	void myFeedCmmtInsertOne(MyCommentVo cmmt);
	
	void groupFeedCmmtInsertOne(GroupCommentVo groupcmmt);
	
	int myFeedCmmtDeleteOne(MyCommentVo cmmt);
	
	int groupFeedCmmtDeleteOne(GroupCommentVo groupcmmt);
	
	void myFeedLikeInsertOne(MyGoodVo good);
	
	void groupFeedLikeInsertOne(MyGoodVo good);
	
	int myFeedLikeDeleteOne(MyGoodVo good);
	
	int groupFeedLikeDeleteOne(MyGoodVo good);
	
	void myFeedReportInsertOne(ReportListVo report);
	
	void groupFeedReportInsertOne(ReportListVo report);
	
	int myFeedDeleteOne(MyPostVo post);
	
	int GroupFeedDeleteOne(GroupPostVo grouppost);
	
	int myFeedUpdateOne(MyPostVo post);
	
	int groupFeedUpdateOne(GroupPostVo grouppost);
	
	int myFeedLikeOnePlus(MyPostVo post);
	
	int groupFeedLikeOnePlus(GroupPostVo grouppost);
	
	int myFeedLikeOneMinus(MyPostVo post);
	
	int groupFeedLikeOneMinus(GroupPostVo grouppost);
	
	List<MyGoodVo> myGoodRenewal(MyGoodVo good);
	
	int feedReportCountUpdate(ReportListVo report);
	
	List<GroupCommentVo> groupFeedCmmtMore(GroupPostVo grouppost);
	
	List<MyCommentVo> myFeedCmmtMore(MyPostVo mypost);
	
	FeedVo groupFeedSelectOne(GroupPostVo grouppost);
	
	FeedVo myFeedSelectOne(MyPostVo mypost);
}