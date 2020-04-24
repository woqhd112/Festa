package com.fin.festa.model.entity;

import java.sql.Date;
import java.util.List;

public class JoinGroupVo {						//가입그룹목록 
	
	private List<JoinGroupVo> joinGroupList;	//그룹 배열파라미터에 쓰이는값
	private int jgnum;							//그룹묶음 번호 (pk)
	private String grname;						//가입그룹 이름
	private int grnum;							//가입그룹 번호
	private int pronum;							//내 번호
	private Date jgdate;						//그룹가입일
	private CampVo camp;
	private CampReviewVo campReview;
	private GroupCommentVo groupComment;
	private GroupNoticeCommentVo groupNoticeComment;
	private GroupNoticeVo groupNotice;
	private GroupPostVo groupPost;
	private GroupVo group;
	private MyAdminVo myAdmin;
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
	private int joinstatus;		//접속상태
	
	@Override
	public String toString() {
		return "JoinGroupVo [joinGroupList=" + joinGroupList + ", jgnum=" + jgnum + ", grname=" + grname + ", grnum="
				+ grnum + ", pronum=" + pronum + ", jgdate=" + jgdate + ", camp=" + camp + ", campReview=" + campReview
				+ ", groupComment=" + groupComment + ", groupNoticeComment=" + groupNoticeComment + ", groupNotice="
				+ groupNotice + ", groupPost=" + groupPost + ", group=" + group + ", myAdmin="
				+ myAdmin + ", myBookMark=" + myBookMark + ", myComment=" + myComment + ", myFollower=" + myFollower
				+ ", myFollowing=" + myFollowing + ", myGood=" + myGood + ", myPost=" + myPost + ", myVenture="
				+ myVenture + ", joinstatus=" + joinstatus + ", pageSearch=" + pageSearch + ", profile=" + profile + ", reportList=" + reportList
				+ ", updateWait=" + updateWait + "]";
	}
	
	public JoinGroupVo() {
		// TODO Auto-generated constructor stub
	}

	public JoinGroupVo(List<JoinGroupVo> joinGroupList, int jgnum, String grname, int grnum, int pronum, Date jgdate,
			CampVo camp, CampReviewVo campReview, GroupCommentVo groupComment, GroupNoticeCommentVo groupNoticeComment,
			GroupNoticeVo groupNotice, GroupPostVo groupPost, GroupVo group, MyAdminVo myAdmin,
			MyBookMarkVo myBookMark, MyCommentVo myComment, MyFollowerVo myFollower, MyFollowingVo myFollowing,
			MyGoodVo myGood, MyPostVo myPost, MyVentureVo myVenture, PageSearchVo pageSearch, ProfileVo profile,
			ReportListVo reportList, UpdateWaitVo updateWait, int joinstatus) {
		super();
		this.joinGroupList = joinGroupList;
		this.jgnum = jgnum;
		this.grname = grname;
		this.grnum = grnum;
		this.pronum = pronum;
		this.jgdate = jgdate;
		this.camp = camp;
		this.campReview = campReview;
		this.groupComment = groupComment;
		this.groupNoticeComment = groupNoticeComment;
		this.groupNotice = groupNotice;
		this.groupPost = groupPost;
		this.group = group;
		this.myAdmin = myAdmin;
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
		this.joinstatus = joinstatus;
	}

	public int getJoinstatus() {
		return joinstatus;
	}

	public void setJoinstatus(int joinstatus) {
		this.joinstatus = joinstatus;
	}
	
	public List<JoinGroupVo> getJoinGroupList() {
		return joinGroupList;
	}

	public void setJoinGroupList(List<JoinGroupVo> joinGroupList) {
		this.joinGroupList = joinGroupList;
	}

	public int getJgnum() {
		return jgnum;
	}

	public void setJgnum(int jgnum) {
		this.jgnum = jgnum;
	}

	public String getGrname() {
		return grname;
	}

	public void setGrname(String grname) {
		this.grname = grname;
	}

	public int getGrnum() {
		return grnum;
	}

	public void setGrnum(int grnum) {
		this.grnum = grnum;
	}

	public int getPronum() {
		return pronum;
	}

	public void setPronum(int pronum) {
		this.pronum = pronum;
	}

	public Date getJgdate() {
		return jgdate;
	}

	public void setJgdate(Date jgdate) {
		this.jgdate = jgdate;
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

	public MyAdminVo getMyAdmin() {
		return myAdmin;
	}

	public void setMyAdmin(MyAdminVo myAdmin) {
		this.myAdmin = myAdmin;
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

	public void setMyFollwer(MyFollowerVo myFollower) {
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
