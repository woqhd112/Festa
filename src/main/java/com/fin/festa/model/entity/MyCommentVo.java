package com.fin.festa.model.entity;

import java.sql.Date;
import java.sql.Timestamp;

import com.fin.festa.util.DateCalculate;

public class MyCommentVo {		//내 피드 댓글

	DateCalculate cal;
	private int mcnum;			//내 피드 번호 (pk)
	private String mcauthor;	//댓글 작성자
	private String mccontent;	//댓글 내용
	private Timestamp mcdate;		//댓글 작성일
	private String mcdate1;
	private int mpnum;			//해당 게시글 번호
	private int pronum;			//댓글 작성자 번호
	private int pronum_sync;	//해당피드주인번호
	private CampVo camp;
	private CampReviewVo campReview;
	private GroupCommentVo groupComment;
	private GroupNoticeCommentVo groupNoticeComment;
	private GroupNoticeVo groupNotice;
	private GroupPostVo groupPost;
	private GroupVo group;
	private JoinGroupVo joinGroup;
	private MyAdminVo myAdmin;
	private MyBookMarkVo myBookMark;
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
		return "MyCommentVo [mcnum=" + mcnum + ", mcauthor=" + mcauthor + ", mccontent="
				+ mccontent + ", mcdate=" + mcdate + ", mpnum=" + mpnum + ", pronum=" + pronum + ", pronum_sync="
				+ pronum_sync + ", camp=" + camp + ", campReview=" + campReview + ", groupComment=" + groupComment
				+ ", groupNoticeComment=" + groupNoticeComment + ", groupNotice=" + groupNotice + ", groupPost="
				+ groupPost + ", group=" + group  + ", joinGroup=" + joinGroup + ", myAdmin="
				+ myAdmin + ", myBookMark=" + myBookMark + ", myFollower=" + myFollower + ", myFollowing=" + myFollowing
				+ ", myGood=" + myGood + ", myPost=" + myPost + ", myVenture=" + myVenture + ", pageSearch="
				+ pageSearch + ", profile=" + profile + ", reportList=" + reportList + ", updateWait=" + updateWait
				+ "]";
	}
	
	public MyCommentVo() {
		// TODO Auto-generated constructor stub
	}

	public MyCommentVo(int mcnum, String mcauthor, String mccontent, Timestamp mcdate, int mpnum,
			int pronum, int pronum_sync, CampVo camp, CampReviewVo campReview, GroupCommentVo groupComment,
			GroupNoticeCommentVo groupNoticeComment, GroupNoticeVo groupNotice, GroupPostVo groupPost, GroupVo group,
			 JoinGroupVo joinGroup, MyAdminVo myAdmin, MyBookMarkVo myBookMark,
			MyFollowerVo myFollower, MyFollowingVo myFollowing, MyGoodVo myGood, MyPostVo myPost, MyVentureVo myVenture,
			PageSearchVo pageSearch, ProfileVo profile, ReportListVo reportList, UpdateWaitVo updateWait) {
		super();
		this.mcnum = mcnum;
		this.mcauthor = mcauthor;
		this.mccontent = mccontent;
		this.mcdate = mcdate;
		this.mpnum = mpnum;
		this.pronum = pronum;
		this.pronum_sync = pronum_sync;
		this.camp = camp;
		this.campReview = campReview;
		this.groupComment = groupComment;
		this.groupNoticeComment = groupNoticeComment;
		this.groupNotice = groupNotice;
		this.groupPost = groupPost;
		this.group = group;
		this.joinGroup = joinGroup;
		this.myAdmin = myAdmin;
		this.myBookMark = myBookMark;
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

	public int getMcnum() {
		return mcnum;
	}

	public void setMcnum(int mcnum) {
		this.mcnum = mcnum;
	}

	public String getMcauthor() {
		return mcauthor;
	}

	public void setMcauthor(String mcauthor) {
		this.mcauthor = mcauthor;
	}

	public String getMccontent() {
		return mccontent;
	}

	public void setMccontent(String mccontent) {
		this.mccontent = mccontent;
	}

	public Timestamp getMcdate() {
		return mcdate;
	}

	public void setMcdate(Timestamp mcdate) {
		this.mcdate = mcdate;
		cal=new DateCalculate();
		mcdate1=cal.dateFormat(mcdate);
	}

	public int getMpnum() {
		return mpnum;
	}

	public void setMpnum(int mpnum) {
		this.mpnum = mpnum;
	}

	public int getPronum() {
		return pronum;
	}

	public void setPronum(int pronum) {
		this.pronum = pronum;
	}

	public int getPronum_sync() {
		return pronum_sync;
	}

	public void setPronum_sync(int pronum_sync) {
		this.pronum_sync = pronum_sync;
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

	public MyBookMarkVo getMyBookMark() {
		return myBookMark;
	}

	public void setMyBookMark(MyBookMarkVo myBookMark) {
		this.myBookMark = myBookMark;
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

	public String getMcdate1() {
		return mcdate1;
	}
	
	
	
}
