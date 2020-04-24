package com.fin.festa.model.entity;

import java.math.BigInteger;
import java.sql.Date;
import java.util.List;

public class MyVentureVo {					//사업자 관리 

	private List<MyVentureVo> ventureList;	//내사업자정보 배열파라미터 넘길때 쓰는데이터
	private int mvnum;						//내 사업자 관리 번호 (pk)
	private String mvname;					//사업장 이름
	private String mvaddr;					//사업장 주소
	private String mvphoto;					//사업자등록증 사진
	private String mvaddrsuv;				//사업장 주소상세
	private String proname;					//대표자명
	private BigInteger mvnumber;					//사업자번호
	private int pronum;						//내 번호
	private int mvrn;						//페이지 번호
	private Date mvdate;					//사업자 등록일
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
	private MyCommentVo myComment;
	private MyFollowerVo myFollower;
	private MyFollowingVo myFollowing;
	private MyGoodVo myGood;
	private MyPostVo myPost;
	private PageSearchVo pageSearch;
	private ProfileVo profile;
	private ReportListVo reportList;
	private UpdateWaitVo updateWait;
	
	@Override
	public String toString() {
		return "MyVentureVo [ventureList=" + ventureList + ", mvnum=" + mvnum + ", mvname=" + mvname + ", mvaddr="
				+ mvaddr + ", mvphoto=" + mvphoto + ", mvaddrsuv=" + mvaddrsuv + ", proname=" + proname + ", mvnumber="
				+ mvnumber + ", pronum=" + pronum + ", mvrn=" + mvrn + ", mvdate=" + mvdate + ", camp=" + camp
				+ ", campReview=" + campReview + ", groupComment=" + groupComment + ", groupNoticeComment="
				+ groupNoticeComment + ", groupNotice=" + groupNotice + ", groupPost=" + groupPost + ", group=" + group
				 + ", joinGroup=" + joinGroup + ", myAdmin=" + myAdmin + ", myBookMark="
				+ myBookMark + ", myComment=" + myComment + ", myFollower=" + myFollower + ", myFollowing="
				+ myFollowing + ", myGood=" + myGood + ", myPost=" + myPost + ", pageSearch=" + pageSearch
				+ ", profile=" + profile + ", reportList=" + reportList + ", updateWait=" + updateWait + "]";
	}
	
	public MyVentureVo() {
		// TODO Auto-generated constructor stub
	}

	public MyVentureVo(List<MyVentureVo> ventureList, int mvnum, String mvname, String mvaddr, String mvphoto,
			String mvaddrsuv, String proname, BigInteger mvnumber, int pronum, int mvrn, Date mvdate, CampVo camp,
			CampReviewVo campReview, GroupCommentVo groupComment, GroupNoticeCommentVo groupNoticeComment,
			GroupNoticeVo groupNotice, GroupPostVo groupPost, GroupVo group, JoinGroupVo joinGroup,
			MyAdminVo myAdmin, MyBookMarkVo myBookMark, MyCommentVo myComment, MyFollowerVo myFollower,
			MyFollowingVo myFollowing, MyGoodVo myGood, MyPostVo myPost, PageSearchVo pageSearch, ProfileVo profile,
			ReportListVo reportList, UpdateWaitVo updateWait) {
		super();
		this.ventureList = ventureList;
		this.mvnum = mvnum;
		this.mvname = mvname;
		this.mvaddr = mvaddr;
		this.mvphoto = mvphoto;
		this.mvaddrsuv = mvaddrsuv;
		this.proname = proname;
		this.mvnumber = mvnumber;
		this.pronum = pronum;
		this.mvrn = mvrn;
		this.mvdate = mvdate;
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
		this.myComment = myComment;
		this.myFollower = myFollower;
		this.myFollowing = myFollowing;
		this.myGood = myGood;
		this.myPost = myPost;
		this.pageSearch = pageSearch;
		this.profile = profile;
		this.reportList = reportList;
		this.updateWait = updateWait;
	}

	public List<MyVentureVo> getVentureList() {
		return ventureList;
	}

	public void setVentureList(List<MyVentureVo> ventureList) {
		this.ventureList = ventureList;
	}

	public int getMvnum() {
		return mvnum;
	}

	public void setMvnum(int mvnum) {
		this.mvnum = mvnum;
	}

	public String getMvname() {
		return mvname;
	}

	public void setMvname(String mvname) {
		this.mvname = mvname;
	}

	public String getMvaddr() {
		return mvaddr;
	}

	public void setMvaddr(String mvaddr) {
		this.mvaddr = mvaddr;
	}

	public String getMvphoto() {
		return mvphoto;
	}

	public void setMvphoto(String mvphoto) {
		this.mvphoto = mvphoto;
	}

	public String getMvaddrsuv() {
		return mvaddrsuv;
	}

	public void setMvaddrsuv(String mvaddrsuv) {
		this.mvaddrsuv = mvaddrsuv;
	}

	public String getProname() {
		return proname;
	}

	public void setProname(String proname) {
		this.proname = proname;
	}

	public BigInteger getMvnumber() {
		return mvnumber;
	}

	public void setMvnumber(BigInteger mvnumber) {
		this.mvnumber = mvnumber;
	}

	public int getPronum() {
		return pronum;
	}

	public void setPronum(int pronum) {
		this.pronum = pronum;
	}

	public int getMvrn() {
		return mvrn;
	}

	public void setMvrn(int mvrn) {
		this.mvrn = mvrn;
	}

	public Date getMvdate() {
		return mvdate;
	}

	public void setMvdate(Date mvdate) {
		this.mvdate = mvdate;
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
