package com.fin.festa.model.entity;

import java.util.List;

public class MyAdminVo {					//내 정보 (정지, 강퇴당했을 때) 
	
	private int pronum;						//내 번호 (pk)
	private String stopresult;				//정지&강퇴 사유
	private int propublic;					//계정 비활성화 & 활성화
	private int prostop;					//관리자 정지유무
	private int prokick;					//관리자 강퇴유무
	private int stoptotal;					//정지당한 횟수
	private int reporttotal;				//신고당한 횟수
	private int stoplv;						//정지 기간
	private CampVo camp;
	private CampReviewVo campReview;
	private GroupCommentVo groupComment;
	private GroupNoticeCommentVo groupNoticeComment;
	private GroupNoticeVo groupNotice;
	private GroupPostVo groupPost;
	private GroupVo group;
	private JoinGroupVo joinGroup;
	private MyBookMarkVo myBookMark;
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
		return "MyAdminVo [pronum=" + pronum + ", stopresult=" + stopresult + ", propublic=" + propublic + ", prostop="
				+ prostop + ", prokick=" + prokick + ", stoptotal=" + stoptotal + ", reporttotal=" + reporttotal
				+ ", stoplv=" + stoplv + ", camp=" + camp + ", campReview=" + campReview + ", groupComment="
				+ groupComment + ", groupNoticeComment=" + groupNoticeComment + ", groupNotice=" + groupNotice
				+ ", groupPost=" + groupPost + ", group=" + group + ", joinGroup=" + joinGroup
				+ ", myBookMark=" + myBookMark + ", myComment=" + myComment + ", myFollower=" + myFollower
				+ ", myFollowing=" + myFollowing + ", myGood=" + myGood + ", myPost=" + myPost + ", myVenture="
				+ myVenture + ", pageSearch=" + pageSearch + ", profile=" + profile + ", reportList=" + reportList
				+ ", updateWait=" + updateWait + "]";
	}
	
	public MyAdminVo() {
		// TODO Auto-generated constructor stub
	}

	public MyAdminVo(int pronum, String stopresult, int propublic, int prostop, int prokick, int stoptotal,
			int reporttotal, int stoplv, CampVo camp, CampReviewVo campReview, GroupCommentVo groupComment,
			GroupNoticeCommentVo groupNoticeComment, GroupNoticeVo groupNotice, GroupPostVo groupPost, GroupVo group,
			 JoinGroupVo joinGroup, MyBookMarkVo myBookMark, MyCommentVo myComment,
			MyFollowerVo myFollower, MyFollowingVo myFollowing, MyGoodVo myGood, MyPostVo myPost, MyVentureVo myVenture,
			PageSearchVo pageSearch, ProfileVo profile, ReportListVo reportList, UpdateWaitVo updateWait) {
		super();
		this.pronum = pronum;
		this.stopresult = stopresult;
		this.propublic = propublic;
		this.prostop = prostop;
		this.prokick = prokick;
		this.stoptotal = stoptotal;
		this.reporttotal = reporttotal;
		this.stoplv = stoplv;
		this.camp = camp;
		this.campReview = campReview;
		this.groupComment = groupComment;
		this.groupNoticeComment = groupNoticeComment;
		this.groupNotice = groupNotice;
		this.groupPost = groupPost;
		this.group = group;
		this.joinGroup = joinGroup;
		this.myBookMark = myBookMark;
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

	public String getStopresult() {
		return stopresult;
	}

	public void setStopresult(String stopresult) {
		this.stopresult = stopresult;
	}

	public int getPropublic() {
		return propublic;
	}

	public void setPropublic(int propublic) {
		this.propublic = propublic;
	}

	public int getProstop() {
		return prostop;
	}

	public void setProstop(int prostop) {
		this.prostop = prostop;
	}

	public int getProkick() {
		return prokick;
	}

	public void setProkick(int prokick) {
		this.prokick = prokick;
	}

	public int getStoptotal() {
		return stoptotal;
	}

	public void setStoptotal(int stoptotal) {
		this.stoptotal = stoptotal;
	}

	public int getReporttotal() {
		return reporttotal;
	}

	public void setReporttotal(int reporttotal) {
		this.reporttotal = reporttotal;
	}

	public int getStoplv() {
		return stoplv;
	}

	public void setStoplv(int stoplv) {
		this.stoplv = stoplv;
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

	public MyBookMarkVo getMyBookMark() {
		return myBookMark;
	}

	public void setMyBookMark(MyBookMarkVo myBookMark) {
		this.myBookMark = myBookMark;
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
