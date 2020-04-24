package com.fin.festa.model.entity;

import java.sql.Date;
import java.sql.Timestamp;

import com.fin.festa.util.DateCalculate;

public class GroupNoticeCommentVo {	//그룹 공지사항 댓글 

	DateCalculate cal;
	private int gncnum;				//공지사항 댓글 번호 (pk)
	private String gncauthor;		//댓글 작성자 이름
	private String gnccontent;		//댓글 내용
	private String gncdate1;
	private Timestamp gncdate;			//댓글 작성일
	private int gnnum;				//공지사항 번호
	private int grnum;				//해당그룹 번호
	private int pronum;				//해당 작성자번호
	private CampVo camp;
	private CampReviewVo campReview;
	private GroupCommentVo groupComment;
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
		return "GroupNoticeCommentVo [gncnum=" + gncnum + ", gncauthor=" + gncauthor + ", gnccontent=" + gnccontent
				+ ", gncdate=" + gncdate + ", gnnum=" + gnnum + ", grnum=" + grnum + ", pronum=" + pronum + ", camp="
				+ camp + ", campReview=" + campReview + ", groupComment=" + groupComment + ", groupNotice="
				+ groupNotice + ", groupPost=" + groupPost + ", group=" + group + ", joinGroup=" + joinGroup
				+ ", myAdmin=" + myAdmin + ", myBookMark=" + myBookMark + ", myComment=" + myComment + ", myFollower="
				+ myFollower + ", myFollowing=" + myFollowing + ", myGood=" + myGood + ", myPost=" + myPost
				+ ", myVenture=" + myVenture + ", pageSearch=" + pageSearch + ", profile=" + profile + ", reportList="
				+ reportList + ", updateWait=" + updateWait + "]";
	}
	
	public GroupNoticeCommentVo() {
		// TODO Auto-generated constructor stub
	}

	public GroupNoticeCommentVo(int gncnum, String gncauthor, String gnccontent, Timestamp gncdate, int gnnum, int grnum,
			int pronum, CampVo camp, CampReviewVo campReview, GroupCommentVo groupComment, GroupNoticeVo groupNotice,
			GroupPostVo groupPost, GroupVo group, JoinGroupVo joinGroup, MyAdminVo myAdmin, MyBookMarkVo myBookMark,
			MyCommentVo myComment, MyFollowerVo myFollower, MyFollowingVo myFollowing, MyGoodVo myGood, MyPostVo myPost,
			MyVentureVo myVenture, PageSearchVo pageSearch, ProfileVo profile, ReportListVo reportList,
			UpdateWaitVo updateWait) {
		super();
		this.gncnum = gncnum;
		this.gncauthor = gncauthor;
		this.gnccontent = gnccontent;
		this.gncdate = gncdate;
		this.gnnum = gnnum;
		this.grnum = grnum;
		this.pronum = pronum;
		this.camp = camp;
		this.campReview = campReview;
		this.groupComment = groupComment;
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

	public int getGncnum() {
		return gncnum;
	}

	public void setGncnum(int gncnum) {
		this.gncnum = gncnum;
	}

	public String getGncauthor() {
		return gncauthor;
	}

	public void setGncauthor(String gncauthor) {
		this.gncauthor = gncauthor;
	}

	public String getGnccontent() {
		return gnccontent;
	}

	public void setGnccontent(String gnccontent) {
		this.gnccontent = gnccontent;
	}

	public Timestamp getGncdate() {
		return gncdate;
	}

	public void setGncdate(Timestamp gncdate) {
		this.gncdate = gncdate;
		cal=new DateCalculate();
		gncdate1=cal.dateFormat(gncdate);
	}

	public int getGnnum() {
		return gnnum;
	}

	public void setGnnum(int gnnum) {
		this.gnnum = gnnum;
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

	public String getGncdate1() {
		return gncdate1;
	}
	
	
	
}
