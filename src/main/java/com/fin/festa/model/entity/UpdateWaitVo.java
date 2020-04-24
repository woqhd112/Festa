package com.fin.festa.model.entity;

import java.math.BigInteger;
import java.sql.Date;
import java.util.List;

public class UpdateWaitVo {						//가입 & 승인 대기 (사업자, 그룹)

	private List<UpdateWaitVo> updateList;		//업데이트대기 배열파라미터에 쓰이는값
	private String grname;						//그룹 이름
	private String grsayone;					//신청시 하고싶은말
	private String proname;						//내 이름
	private String mvaddr;						//사업자 주소
	private String mvphoto;						//사업자등록증 사진
	private String mvaddrsuv;					//사업자 주소 상세
	private BigInteger mvnumber;				//사업자번호
	private int grnum;							//그룹 번호
	private int pronum;							//내 번호
	private int uwrn;							//페이지 번호
	private String mvname;						//캠핑장명
	private Date uwdate;						//신청일
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
	private MyVentureVo myVenture;
	private PageSearchVo pageSearch;
	private ProfileVo profile;
	private ReportListVo reportList;
	
	@Override
	public String toString() {
		return "UpdateWaitVo [updateList=" + updateList + ", grname=" + grname + ", grsayone=" + grsayone + ", proname="
				+ proname + ", mvaddr=" + mvaddr + ", mvphoto=" + mvphoto + ", mvaddrsuv=" + mvaddrsuv + ", mvnumber="
				+ mvnumber + ", grnum=" + grnum + ", pronum=" + pronum + ", uwrn=" + uwrn + ", mvname=" + mvname
				+ ", uwdate=" + uwdate + ", camp=" + camp + ", campReview=" + campReview + ", groupComment="
				+ groupComment + ", groupNoticeComment=" + groupNoticeComment + ", groupNotice=" + groupNotice
				+ ", groupPost=" + groupPost + ", group=" + group + ", joinGroup=" + joinGroup
				+ ", myAdmin=" + myAdmin + ", myBookMark=" + myBookMark + ", myComment=" + myComment + ", myFollower="
				+ myFollower + ", myFollowing=" + myFollowing + ", myGood=" + myGood + ", myPost=" + myPost
				+ ", myVenture=" + myVenture + ", pageSearch=" + pageSearch + ", profile=" + profile + ", reportList="
				+ reportList + "]";
	}
	
	public UpdateWaitVo() {
		// TODO Auto-generated constructor stub
	}

	public UpdateWaitVo(List<UpdateWaitVo> updateList, String grname, String grsayone, String proname, String mvaddr,
			String mvphoto, String mvaddrsuv, BigInteger mvnumber, int grnum, int pronum, int uwrn, String mvname, Date uwdate,
			CampVo camp, CampReviewVo campReview, GroupCommentVo groupComment, GroupNoticeCommentVo groupNoticeComment,
			GroupNoticeVo groupNotice, GroupPostVo groupPost, GroupVo group, JoinGroupVo joinGroup,
			MyAdminVo myAdmin, MyBookMarkVo myBookMark, MyCommentVo myComment, MyFollowerVo myFollower,
			MyFollowingVo myFollowing, MyGoodVo myGood, MyPostVo myPost, MyVentureVo myVenture, PageSearchVo pageSearch,
			ProfileVo profile, ReportListVo reportList) {
		super();
		this.updateList = updateList;
		this.grname = grname;
		this.grsayone = grsayone;
		this.proname = proname;
		this.mvaddr = mvaddr;
		this.mvphoto = mvphoto;
		this.mvaddrsuv = mvaddrsuv;
		this.mvnumber = mvnumber;
		this.grnum = grnum;
		this.pronum = pronum;
		this.uwrn = uwrn;
		this.mvname = mvname;
		this.uwdate = uwdate;
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
		this.myVenture = myVenture;
		this.pageSearch = pageSearch;
		this.profile = profile;
		this.reportList = reportList;
	}

	public List<UpdateWaitVo> getUpdateList() {
		return updateList;
	}

	public void setUpdateList(List<UpdateWaitVo> updateList) {
		this.updateList = updateList;
	}

	public String getGrname() {
		return grname;
	}

	public void setGrname(String grname) {
		this.grname = grname;
	}

	public String getGrsayone() {
		return grsayone;
	}

	public void setGrsayone(String grsayone) {
		this.grsayone = grsayone;
	}

	public String getProname() {
		return proname;
	}

	public void setProname(String proname) {
		this.proname = proname;
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

	public BigInteger getMvnumber() {
		return mvnumber;
	}

	public void setMvnumber(BigInteger mvnumber) {
		this.mvnumber = mvnumber;
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

	public int getUwrn() {
		return uwrn;
	}

	public void setUwrn(int uwrn) {
		this.uwrn = uwrn;
	}

	public String getMvname() {
		return mvname;
	}

	public void setMvname(String mvname) {
		this.mvname = mvname;
	}

	public Date getUwdate() {
		return uwdate;
	}

	public void setUwdate(Date uwdate) {
		this.uwdate = uwdate;
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

	
	
	
}
