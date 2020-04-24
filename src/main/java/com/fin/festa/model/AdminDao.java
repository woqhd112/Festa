package com.fin.festa.model;

import java.util.List;

import com.fin.festa.model.entity.AllCountVo;
import com.fin.festa.model.entity.CampReviewVo;
import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupNoticeCommentVo;
import com.fin.festa.model.entity.GroupNoticeVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.JoinGroupVo;
import com.fin.festa.model.entity.MyAdminVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyFollowerVo;
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.MyVentureVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.PreferableLocationVo;
import com.fin.festa.model.entity.ProfileVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.model.entity.UpdateWaitVo;
import com.fin.festa.model.entity.WeekCountVo;
import com.fin.festa.model.entity.WeekVo;
import com.fin.festa.util.DateCalculate;

public interface AdminDao {
	
	AllCountVo allCount();
	
	AllCountVo allCount_yesterday(String time);
	
	WeekVo lastWeekNewUser(DateCalculate cal);
	
	WeekCountVo weekNewUserCount(DateCalculate cal);
	
	List<ProfileVo> allUserCount();
	
	List<PreferableLocationVo> preferLocation();
	
	List<GroupVo> adminGroupSelectAll(PageSearchVo search);
	
	int adminGroupCount(PageSearchVo search);
	
	int groupDelete(GroupVo group);
	
	List<ProfileVo> adminUserSelectAll(PageSearchVo search);
	
	List<ProfileVo> adminUserStopSelectAll(PageSearchVo search);
	
	int userStop(MyAdminVo admin);
	
	int userKick(MyAdminVo admin);
	
	ProfileVo userInfo(ProfileVo profile);
	
	List<MyPostVo> userFeed(ProfileVo profile);
	
	List<MyCommentVo> userCmmt(ProfileVo profile);
	
	int userFeedCount(ProfileVo profile);
	
	int userFollowingCount(ProfileVo profile);
	
	int userFollowerCount(ProfileVo profile);
	
	List<CampVo> adminCampSelectAll(PageSearchVo search);
	
	int campDelete(CampVo camp);
	
	List<MyAdminVo> adminVentureSelectAll_mvnumber(PageSearchVo search);
	
	List<MyAdminVo> adminVentureSelectAll_caname(PageSearchVo search);
	
	List<UpdateWaitVo> adminVentureRequestSelectAll_mvnumber(PageSearchVo search);
	
	List<UpdateWaitVo> adminVentureRequestSelectAll_caname(PageSearchVo search);
	
	void ventureInsert(UpdateWaitVo wait);
	
	int updateDelete(UpdateWaitVo wait);
	
	List<GroupVo> groupCheck(UpdateWaitVo wait);
	
	int groupVentureUpdate(GroupVo group);
	
	int ventureDelete(MyVentureVo venture);
	
	List<ReportListVo> adminReportSelectAll(PageSearchVo search);
	
	int adminReportCount(PageSearchVo search);
	
	int adminReportUpdate(ReportListVo report);
	
	GroupVo groupInfo(GroupVo group);
	
	List<GroupNoticeVo> groupNoticeInfo(GroupVo group);
	
	GroupNoticeVo groupNoticeDetail(GroupNoticeVo groupnotice);
	
	int groupNoticeDelete(GroupNoticeVo groupnotice);
	
	List<GroupNoticeCommentVo> groupNoticeCmmtInfo(GroupNoticeVo groupnotice);
	
	int groupNoticeCmmtDelete(GroupNoticeCommentVo groupnoticecmmt);
	
	List<GroupPostVo> groupFeedInfoSelectAll(GroupVo group);
	
	int groupFeedDelete(GroupPostVo grouppost);
	
	List<GroupCommentVo> groupFeedCmmtInfoSelectAll(GroupVo group);
	
	int groupFeedCmmtDelete(GroupCommentVo groupcmmt);
	
	int myFeedDelete(MyPostVo post);
	
	int myFeedCmmtDelete(MyCommentVo cmmt);
	
	CampVo campInfo(CampVo report);
	
	int campDeleteOne(CampVo camp);
	
	int groupVentureCheck(CampVo camp);
	
	List<CampReviewVo> campReviewInfo(CampVo camp);
	
	int campReviewDeleteOne(CampReviewVo campreview);
	
	List<GroupVo> ventureGroupCheck(MyVentureVo venture);
	
	int campReviewCount(CampVo camp);
	
	int ventureGroupDelete(GroupVo group);
	
	List<JoinGroupVo> adminGroupMemberList(GroupVo group);
	
	List<MyFollowerVo> adminUserfollowerList(ProfileVo profile);
	
	List<MyFollowingVo> adminUserfollowList(ProfileVo profile);
	
	MyVentureVo AdminVentureImg(MyVentureVo myVentureVo);
	
	ReportListVo adminReportSelectOne(ReportListVo reportListVo);
	
	int adminUserCount(PageSearchVo pageSearchVo);
	
	List<MyCommentVo> adminUserDetailCmmt(MyPostVo post);
	
	List<GroupCommentVo> adminGroupDetailCmmt(GroupPostVo grouppost);
	
	List<GroupNoticeCommentVo> adminGroupNoticeCmmt(GroupNoticeVo groupnotice);
	
	int adminCampCount(PageSearchVo pageSearchVo);
	
	GroupVo ventureGroup(CampVo camp);
	
	int adminVentureCount_campName(PageSearchVo pageSearchVo);
	
	int adminVentureCount_ventureNumber(PageSearchVo pageSearchVo);
	
	int adminVentureRequestCount_campName(PageSearchVo pageSearchVo);
	
	int adminVentureRequestCount_ventureNumber(PageSearchVo pageSearchVo);
	
	List<ProfileVo> stopUserList();
	
	int updateStop_zero(ProfileVo profile);
	
	int updateStop_over(ProfileVo profile);
} 