package com.fin.festa.model;

import java.util.List;

import com.fin.festa.model.entity.GroupChatVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupNoticeCommentVo;
import com.fin.festa.model.entity.GroupNoticeVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.JoinGroupVo;
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.ProfileVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.model.entity.UpdateWaitVo;

public interface GroupDao {
	
	int groupVentureCheck(GroupVo group);
	
	GroupVo groupSelectOne(GroupVo group);
	
	List<GroupNoticeVo> groupNoticeSelectAll(GroupVo group);
	
	GroupNoticeVo groupNoticeSelectOne(GroupNoticeVo notice);
	
	List<GroupNoticeCommentVo> groupNoticeCmmtSelectAll(GroupNoticeVo notice);
	
	List<GroupPostVo> groupFeedSelectAll(GroupVo group);
	
	List<GroupCommentVo> groupFeedCmmtSelectAll(GroupVo group);
	
	GroupPostVo groupFeedDetailOne(GroupPostVo groupPostVo);

	int groupFeedUpdate(GroupPostVo post);
	
	int joinGroupCheck(UpdateWaitVo wait);
	
	void joinGroupRequest(UpdateWaitVo wait);
	
	void groupNoticeInsert(GroupNoticeVo notice);
	
	void groupFeedInsert(GroupPostVo post);
	
	int groupFeedDelete(GroupPostVo post);
	
	void groupFeedCmmtInsert(GroupCommentVo cmmt);
	
	int groupFeedCmmtDelete(GroupCommentVo cmmt);
	
	int groupNoticeUpdate(GroupNoticeVo notice);
	
	int groupNoticeDelete(GroupNoticeVo notice);
	
	void groupNoticeCmmtInsert(GroupNoticeCommentVo groupnoticecmmt);
	
	void groupNoticeCmmtDelete(GroupNoticeCommentVo groupnoticecmmt);
	
	void groupReportInsert(ReportListVo report);
	
	void groupFeedReportInsert(ReportListVo report);
	
	void groupNoticeReportInsert(ReportListVo report);

	int groupInfoUpdate(GroupVo group);
	
	List<ProfileVo> groupUserSelectAll(GroupVo group);
	
	List<ProfileVo> groupUserSearch(GroupVo group);
	
	int groupUserKick(JoinGroupVo join);
	
	int groupUserAllKick(GroupVo group);
	
	List<UpdateWaitVo> groupRequestSelectAll(GroupVo group);
	
	void groupRequestHello(UpdateWaitVo wait);
	
	int groupTotalPlus(GroupVo group);
	
	int groupRequestSorry(UpdateWaitVo wait);
	
	int groupTotalMinus(GroupVo group);
	
	int groupDelete(GroupVo group);

	void groupFeedLikeInsertOne(MyGoodVo good);
	
	int groupFeedLikeDeleteOne(MyGoodVo good);
	
	int groupFeedLikeOnePlus(GroupPostVo post);
	
	int groupFeedLikeOneMinus(GroupPostVo post);
	
	int groupUserTotalCount(GroupVo group);
	
	int groupRequestTotalCount(GroupVo group);
	
	List<MyGoodVo> myGoodRenewal(MyGoodVo good);
	
	List<JoinGroupVo> groupUserInfo(GroupVo group);
	
	int groupOut(JoinGroupVo joinGroup);
	
	void myFollowingInsertOne(MyFollowingVo following);
	
	void yourFollowerInsertOne(MyFollowingVo following);
	
	int myFollowingDeleteOne(MyFollowingVo following);
	
	int yourFollowerDeleteOne(MyFollowingVo following);
	
	List<MyFollowingVo> myFollowingRenewal(MyFollowingVo following);
	
	int groupReportCountUpdate(ReportListVo report);
	
	int groupChatUserUpdate(GroupVo group);
	
	List<GroupChatVo> groupChatUser(GroupVo group);
}