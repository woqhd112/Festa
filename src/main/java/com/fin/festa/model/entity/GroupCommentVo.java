package com.fin.festa.model.entity;

import java.sql.Date;
import java.sql.Timestamp;

import com.fin.festa.util.DateCalculate;

public class GroupCommentVo {	//그룹 댓글

	DateCalculate cal;
	private int gcnum;			//그룹 댓글 번호 (pk)
	private String gccontent;	//그룹 댓글 내용
	private String gcauthor;	//그룹 댓글 작성자
	private Timestamp gcdate;	//그룹 댓글 작성일
	private String gcdate1;
	private int gpnum;			//그룹 게시글 번호
	private int pronum;			//그룹 댓글 작성자 번호
	private int grnum;			//해당 그룹번호
	private CampVo camp;
	private CampReviewVo campReview;
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
		return "GroupCommentVo [gcnum=" + gcnum + ", gccontent=" + gccontent + ", gcauthor=" + gcauthor + ", gcdate=" + gcdate + ", gpnum=" + gpnum + ", pronum=" + pronum + ", grnum=" + grnum
				+ ", camp=" + camp + ", campReview=" + campReview + ", groupNoticeComment=" + groupNoticeComment
				+ ", groupNotice=" + groupNotice + ", groupPost=" + groupPost + ", group=" + group + ", joinGroup=" + joinGroup + ", myAdmin=" + myAdmin + ", myBookMark=" + myBookMark
				+ ", myComment=" + myComment + ", myFollower=" + myFollower + ", myFollowing=" + myFollowing
				+ ", myGood=" + myGood + ", myPost=" + myPost + ", myVenture=" + myVenture + ", pageSearch="
				+ pageSearch + ", profile=" + profile + ", reportList=" + reportList + ", updateWait=" + updateWait
				+ "]";
	}
	
	public GroupCommentVo() {
		// TODO Auto-generated constructor stub
	}

	public GroupCommentVo(int gcnum, String gccontent, String gcauthor, Timestamp gcdate, int gpnum,
			int pronum, int grnum, CampVo camp, CampReviewVo campReview, GroupNoticeCommentVo groupNoticeComment,
			GroupNoticeVo groupNotice, GroupPostVo groupPost, GroupVo group, JoinGroupVo joinGroup,
			MyAdminVo myAdmin, MyBookMarkVo myBookMark, MyCommentVo myComment, MyFollowerVo myFollower,
			MyFollowingVo myFollowing, MyGoodVo myGood, MyPostVo myPost, MyVentureVo myVenture, PageSearchVo pageSearch,
			ProfileVo profile, ReportListVo reportList, UpdateWaitVo updateWait) {
		super();
		this.gcnum = gcnum;
		this.gccontent = gccontent;
		this.gcauthor = gcauthor;
		this.gcdate = gcdate;
		this.gpnum = gpnum;
		this.pronum = pronum;
		this.grnum = grnum;
		this.camp = camp;
		this.campReview = campReview;
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

	public int getGcnum() {
		return gcnum;
	}

	public void setGcnum(int gcnum) {
		this.gcnum = gcnum;
	}

	public String getGccontent() {
		return gccontent;
	}

	public void setGccontent(String gccontent) {
		this.gccontent = gccontent;
	}

	public String getGcauthor() {
		return gcauthor;
	}

	public void setGcauthor(String gcauthor) {
		this.gcauthor = gcauthor;
	}

	public Timestamp getGcdate() {
		return gcdate;
	}

	public void setGcdate(Timestamp gcdate) {
		this.gcdate = gcdate;
		cal=new DateCalculate();
		gcdate1=cal.dateFormat(gcdate);
	}

	public int getGpnum() {
		return gpnum;
	}

	public void setGpnum(int gpnum) {
		this.gpnum = gpnum;
	}

	public int getPronum() {
		return pronum;
	}

	public void setPronum(int pronum) {
		this.pronum = pronum;
	}

	public int getGrnum() {
		return grnum;
	}

	public void setGrnum(int grnum) {
		this.grnum = grnum;
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

	public String getGcdate1() {
		return gcdate1;
	}
	
	
}
