package com.fin.festa.model.entity;

import java.sql.Date;

public class CampReviewVo {		//캠핑장 한줄평
	
	private int crnum;			//한줄평 글번호 (pk)
	private String crauthor;	//작성자 이름
	private String crcontent;	//한줄평 내용
	private Date crdate;		//작성일
	private double crgood;		//별점
	private int canum;			//캠핑장 번호 
	private int pronum;			//작성자 번호
	private int crrn;			//페이지 번호
	private CampVo camp;
	private GroupCommentVo groupComment;
	private GroupNoticeCommentVo groupNoticeComment;
	private GroupNoticeVo groupNotice;
	private GroupPostVo groupPost;
	private GroupVo group;
	private JoinGroupVo joinGroup;
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
	
	@Override
	public String toString() {
		return "CampReviewVo [crnum=" + crnum  + ", crauthor=" + crauthor + ", crcontent="
				+ crcontent + ", crdate=" + crdate + ", crgood=" + crgood + ", canum=" + canum + ", pronum=" + pronum
				+ ", crrn=" + crrn + ", camp=" + camp + ", groupComment=" + groupComment + ", groupNoticeComment="
				+ groupNoticeComment + ", groupNotice=" + groupNotice + ", groupPost=" + groupPost + ", group=" + group
				+ ", joinGroup=" + joinGroup + ", myAdmin=" + myAdmin + ", myBookMark="
				+ myBookMark + ", myComment=" + myComment + ", myFollower=" + myFollower + ", myFollowing="
				+ myFollowing + ", myGood=" + myGood + ", myPost=" + myPost + ", myVenture=" + myVenture
				+ ", pageSearch=" + pageSearch + ", profile=" + profile + ", reportList=" + reportList + ", updateWait="
				+ updateWait + "]";
	}
	
	public CampReviewVo() {
		// TODO Auto-generated constructor stub
	}

	public CampReviewVo(int crnum, String crauthor, String crcontent, Date crdate, double crgood,
			int canum, int pronum, int crrn, CampVo camp, GroupCommentVo groupComment,
			GroupNoticeCommentVo groupNoticeComment, GroupNoticeVo groupNotice, GroupPostVo groupPost, GroupVo group,
			 JoinGroupVo joinGroup, MyAdminVo myAdmin, MyBookMarkVo myBookMark, MyCommentVo myComment,
			MyFollowerVo myFollower, MyFollowingVo myFollowing, MyGoodVo myGood, MyPostVo myPost, MyVentureVo myVenture,
			PageSearchVo pageSearch, ProfileVo profile, ReportListVo reportList, UpdateWaitVo updateWait) {
		super();
		this.crnum = crnum;
		this.crauthor = crauthor;
		this.crcontent = crcontent;
		this.crdate = crdate;
		this.crgood = crgood;
		this.canum = canum;
		this.pronum = pronum;
		this.crrn = crrn;
		this.camp = camp;
		this.groupComment = groupComment;
		this.groupNoticeComment = groupNoticeComment;
		this.groupNotice = groupNotice;
		this.groupPost = groupPost;
		this.group = group;
		this.joinGroup = joinGroup;
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
	}

	public int getCrnum() {
		return crnum;
	}

	public void setCrnum(int crnum) {
		this.crnum = crnum;
	}

	public String getCrauthor() {
		return crauthor;
	}

	public void setCrauthor(String crauthor) {
		this.crauthor = crauthor;
	}

	public String getCrcontent() {
		return crcontent;
	}

	public void setCrcontent(String crcontent) {
		this.crcontent = crcontent;
	}

	public Date getCrdate() {
		return crdate;
	}

	public void setCrdate(Date crdate) {
		this.crdate = crdate;
	}

	public double getCrgood() {
		return crgood;
	}

	public void setCrgood(double crgood) {
		this.crgood = crgood;
	}

	public int getCanum() {
		return canum;
	}

	public void setCanum(int canum) {
		this.canum = canum;
	}

	public int getPronum() {
		return pronum;
	}

	public void setPronum(int pronum) {
		this.pronum = pronum;
	}

	public int getCrrn() {
		return crrn;
	}

	public void setCrrn(int crrn) {
		this.crrn = crrn;
	}

	public CampVo getCamp() {
		return camp;
	}

	public void setCamp(CampVo camp) {
		this.camp = camp;
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
