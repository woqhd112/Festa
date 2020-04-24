package com.fin.festa.model.entity;

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
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.MyVentureVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.ProfileVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.model.entity.UpdateWaitVo;

public class MyBookMarkVo {	//내 캠핑장 북마크 

	private int pronum;		//내 번호
	private int canum;		//캠핑장 번호
	private CampVo camp;
	private CampReviewVo campReview;
	private GroupCommentVo groupComment;
	private GroupNoticeCommentVo groupNoticeComment;
	private GroupNoticeVo groupNotice;
	private GroupPostVo groupPost;
	private GroupVo group;
	private JoinGroupVo joinGroup;
	private MyAdminVo myAdmin;
	private MyCommentVo myComment;
	private MyFollowerVo myFollower;
	private MyFollowingVo myFollowing;
	private MyGoodVo myGood;
	private MyPostVo myPost;
	private MyVentureVo myVenture;
	private PageSearchVo pageSearch;
	private ProfileVo profile;
	private ReportListVo reportList;
	private UpdateWaitVo updateWait;
	
	@Override
	public String toString() {
		return "MyBookMarkVo [pronum=" + pronum + ", canum=" + canum + ", camp=" + camp + ", campReview=" + campReview
				+ ", groupComment=" + groupComment + ", groupNoticeComment=" + groupNoticeComment + ", groupNotice="
				+ groupNotice + ", groupPost=" + groupPost + ", group=" + group 
				+ ", joinGroup=" + joinGroup + ", myAdmin=" + myAdmin + ", myComment=" + myComment + ", myFollower="
				+ myFollower + ", myFollowing=" + myFollowing + ", myGood=" + myGood + ", myPost=" + myPost
				+ ", myVenture=" + myVenture + ", pageSearch=" + pageSearch + ", profile=" + profile + ", reportList="
				+ reportList + ", updateWait=" + updateWait + "]";
	}
	
	public MyBookMarkVo() {
		// TODO Auto-generated constructor stub
	}

	public MyBookMarkVo(int pronum, int canum, CampVo camp, CampReviewVo campReview, GroupCommentVo groupComment,
			GroupNoticeCommentVo groupNoticeComment, GroupNoticeVo groupNotice, GroupPostVo groupPost, GroupVo group,
			 JoinGroupVo joinGroup, MyAdminVo myAdmin, MyCommentVo myComment, MyFollowerVo myFollower,
			MyFollowingVo myFollowing, MyGoodVo myGood, MyPostVo myPost, MyVentureVo myVenture, PageSearchVo pageSearch,
			ProfileVo profile, ReportListVo reportList, UpdateWaitVo updateWait) {
		super();
		this.pronum = pronum;
		this.canum = canum;
		this.camp = camp;
		this.campReview = campReview;
		this.groupComment = groupComment;
		this.groupNoticeComment = groupNoticeComment;
		this.groupNotice = groupNotice;
		this.groupPost = groupPost;
		this.group = group;
		this.joinGroup = joinGroup;
		this.myAdmin = myAdmin;
		this.myComment = myComment;
		this.myFollower = myFollower;
		this.myFollowing = myFollowing;
		this.myGood = myGood;
		this.myPost = myPost;
		this.myVenture = myVenture;
		this.pageSearch = pageSearch;
		this.profile = profile;
		this.reportList = reportList;
		this.updateWait = updateWait;
	}

	public int getPronum() {
		return pronum;
	}

	public void setPronum(int pronum) {
		this.pronum = pronum;
	}

	public int getCanum() {
		return canum;
	}

	public void setCanum(int canum) {
		this.canum = canum;
	}

	public CampVo getCamp() {
		return camp;
	}

	public void setCamp(CampVo camp) {
		this.camp = camp;
	}

	public CampReviewVo getCampReview() {
		return campReview;
	}

	public void setCampReview(CampReviewVo campReview) {
		this.campReview = campReview;
	}

	public GroupCommentVo getGroupComment() {
		return groupComment;
	}

	public void setGroupComment(GroupCommentVo groupComment) {
		this.groupComment = groupComment;
	}

	public GroupNoticeCommentVo getGroupNoticeComment() {
		return groupNoticeComment;
	}

	public void setGroupNoticeComment(GroupNoticeCommentVo groupNoticeComment) {
		this.groupNoticeComment = groupNoticeComment;
	}

	public GroupNoticeVo getGroupNotice() {
		return groupNotice;
	}

	public void setGroupNotice(GroupNoticeVo groupNotice) {
		this.groupNotice = groupNotice;
	}

	public GroupPostVo getGroupPost() {
		return groupPost;
	}

	public void setGroupPost(GroupPostVo groupPost) {
		this.groupPost = groupPost;
	}

	public GroupVo getGroup() {
		return group;
	}

	public void setGroup(GroupVo group) {
		this.group = group;
	}

	public JoinGroupVo getJoinGroup() {
		return joinGroup;
	}

	public void setJoinGroup(JoinGroupVo joinGroup) {
		this.joinGroup = joinGroup;
	}

	public MyAdminVo getMyAdmin() {
		return myAdmin;
	}

	public void setMyAdmin(MyAdminVo myAdmin) {
		this.myAdmin = myAdmin;
	}

	public MyCommentVo getMyComment() {
		return myComment;
	}

	public void setMyComment(MyCommentVo myComment) {
		this.myComment = myComment;
	}

	public MyFollowerVo getMyFollower() {
		return myFollower;
	}

	public void setMyFollower(MyFollowerVo myFollower) {
		this.myFollower = myFollower;
	}

	public MyFollowingVo getMyFollowing() {
		return myFollowing;
	}

	public void setMyFollowing(MyFollowingVo myFollowing) {
		this.myFollowing = myFollowing;
	}

	public MyGoodVo getMyGood() {
		return myGood;
	}

	public void setMyGood(MyGoodVo myGood) {
		this.myGood = myGood;
	}

	public MyPostVo getMyPost() {
		return myPost;
	}

	public void setMyPost(MyPostVo myPost) {
		this.myPost = myPost;
	}

	public MyVentureVo getMyVenture() {
		return myVenture;
	}

	public void setMyVenture(MyVentureVo myVenture) {
		this.myVenture = myVenture;
	}

	public PageSearchVo getPageSearch() {
		return pageSearch;
	}

	public void setPageSearch(PageSearchVo pageSearch) {
		this.pageSearch = pageSearch;
	}

	public ProfileVo getProfile() {
		return profile;
	}

	public void setProfile(ProfileVo profile) {
		this.profile = profile;
	}

	public ReportListVo getReportList() {
		return reportList;
	}

	public void setReportList(ReportListVo reportList) {
		this.reportList = reportList;
	}

	public UpdateWaitVo getUpdateWait() {
		return updateWait;
	}

	public void setUpdateWait(UpdateWaitVo updateWait) {
		this.updateWait = updateWait;
	}
	
	
	
}
