package com.fin.festa.model.entity;

import java.sql.Date;
import java.sql.Timestamp;

import com.fin.festa.util.DateCalculate;

public class GroupNoticeVo {	//그룹 공지사항

	DateCalculate cal;
	private int gnnum;			//공지사항 번호 (pk)
	private String gnauthor;	//공지사항 작성자 이름
	private String gnphoto;		//공지사항 등록 사진
	private String gncontent;	//공지사항 내용
	private String gndate1;
	private Timestamp gndate;		//공지사항 작성일
	private int grnum;			//공지사항 그룹 번호
	private int gntotal;		//공지사항댓글 갯수
	private CampVo camp;
	private CampReviewVo campReview;
	private GroupCommentVo groupComment;
	private GroupNoticeCommentVo groupNoticeComment;
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
		return "GroupNoticeVo [gnnum=" + gnnum + ", gnauthor=" + gnauthor + ", gnphoto=" + gnphoto + ", gncontent="
				+ gncontent + ", gndate=" + gndate + ", grnum=" + grnum + ", gntotal=" + gntotal + ", camp=" + camp
				+ ", campReview=" + campReview + ", groupComment=" + groupComment + ", groupNoticeComment="
				+ groupNoticeComment + ", groupPost=" + groupPost + ", group=" + group + ", joinGroup=" + joinGroup
				+ ", myAdmin=" + myAdmin + ", myBookMark=" + myBookMark + ", myComment=" + myComment + ", myFollower="
				+ myFollower + ", myFollowing=" + myFollowing + ", myGood=" + myGood + ", myPost=" + myPost
				+ ", myVenture=" + myVenture + ", pageSearch=" + pageSearch + ", profile=" + profile + ", reportList="
				+ reportList + ", updateWait=" + updateWait + "]";
	}
	
	public GroupNoticeVo() {
		// TODO Auto-generated constructor stub
	}

	public GroupNoticeVo(int gnnum, String gnauthor, String gnphoto, String gncontent, Timestamp gndate, int grnum,
			int gntotal, CampVo camp, CampReviewVo campReview, GroupCommentVo groupComment,
			GroupNoticeCommentVo groupNoticeComment, GroupPostVo groupPost, GroupVo group, JoinGroupVo joinGroup,
			MyAdminVo myAdmin, MyBookMarkVo myBookMark, MyCommentVo myComment, MyFollowerVo myFollower,
			MyFollowingVo myFollowing, MyGoodVo myGood, MyPostVo myPost, MyVentureVo myVenture, PageSearchVo pageSearch,
			ProfileVo profile, ReportListVo reportList, UpdateWaitVo updateWait) {
		super();
		this.gnnum = gnnum;
		this.gnauthor = gnauthor;
		this.gnphoto = gnphoto;
		this.gncontent = gncontent;
		this.gndate = gndate;
		this.grnum = grnum;
		this.gntotal = gntotal;
		this.camp = camp;
		this.campReview = campReview;
		this.groupComment = groupComment;
		this.groupNoticeComment = groupNoticeComment;
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

	public int getGnnum() {
		return gnnum;
	}

	public void setGnnum(int gnnum) {
		this.gnnum = gnnum;
	}

	public String getGnauthor() {
		return gnauthor;
	}

	public void setGnauthor(String gnauthor) {
		this.gnauthor = gnauthor;
	}

	public String getGnphoto() {
		return gnphoto;
	}

	public void setGnphoto(String gnphoto) {
		this.gnphoto = gnphoto;
	}

	public String getGncontent() {
		return gncontent;
	}

	public void setGncontent(String gncontent) {
		this.gncontent = gncontent;
	}

	public Timestamp getGndate() {
		return gndate;
	}

	public void setGndate(Timestamp gndate) {
		this.gndate = gndate;
		cal=new DateCalculate();
		gndate1=cal.dateFormat(gndate);
	}

	public int getGrnum() {
		return grnum;
	}

	public void setGrnum(int grnum) {
		this.grnum = grnum;
	}

	public int getGntotal() {
		return gntotal;
	}

	public void setGntotal(int gntotal) {
		this.gntotal = gntotal;
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

	public String getGndate1() {
		return gndate1;
	}
	
	
}
