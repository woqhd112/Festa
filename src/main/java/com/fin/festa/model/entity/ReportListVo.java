package com.fin.festa.model.entity;

import java.sql.Date;
import java.util.List;

public class ReportListVo {					//신고리스트 (전체) 

	private List<ReportListVo> reportList;	//신고 배열파라미터 넘길때 쓰는값
	private int rlnum;						//신고 번호(pk)
	private String rlcategory;				//신고 카테고리
	private String rlreport;				//신고 사유
	private String rlreporter;				//신고자
	private String reporterid;				//신고자 아이디
	private String rltarget;				//신고당한 사람
	private String targetid;				//신고당한 사람 아이디
	private String rlphoto;					//신고사진
	private Date rldate;					//신고 날짜
	private int rlstatus;					//신고상태
	private int pronum;						//신고자 번호
	private int pronum_sync;				//신고당한 사람 번호
	private int grnum;						//신고 그룹 번호
	private int gpnum;						//신고 그룹 게시글 번호
	private int gnnum;						//신고 그룹 공지 번호
	private int canum;						//신고 캠핑장 번호
	private int mpnum;						//신고 피드 번호(개인)
	private int rlrn;						//페이지 번호
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
	private UpdateWaitVo updateWait;
	
	@Override
	public String toString() {
		return "ReportListVo [reportList=" + reportList + ", rlnum=" + rlnum + ", rlcategory=" + rlcategory
				+ ", rlreport=" + rlreport + ", rlreporter=" + rlreporter + ", reporterid=" + reporterid + ", rltarget="
				+ rltarget + ", targetid=" + targetid + ", rlphoto=" + rlphoto + ", rldate=" + rldate + ", rlstatus="
				+ rlstatus + ", pronum=" + pronum + ", pronum_sync=" + pronum_sync + ", grnum=" + grnum + ", gpnum="
				+ gpnum + ", gnnum=" + gnnum + ", canum=" + canum + ", mpnum=" + mpnum + ", rlrn=" + rlrn + ", camp="
				+ camp + ", campReview=" + campReview + ", groupComment=" + groupComment + ", groupNoticeComment="
				+ groupNoticeComment + ", groupNotice=" + groupNotice + ", groupPost=" + groupPost + ", group=" + group
				+ ", joinGroup=" + joinGroup + ", myAdmin=" + myAdmin + ", myBookMark="
				+ myBookMark + ", myComment=" + myComment + ", myFollower=" + myFollower + ", myFollowing="
				+ myFollowing + ", myGood=" + myGood + ", myPost=" + myPost + ", myVenture=" + myVenture
				+ ", pageSearch=" + pageSearch + ", profile=" + profile + ", updateWait=" + updateWait + "]";
	}
	
	public ReportListVo() {
		// TODO Auto-generated constructor stub
	}

	public ReportListVo(List<ReportListVo> reportList, int rlnum, String rlcategory, String rlreport, String rlreporter,
			String reporterid, String rltarget, String targetid, String rlphoto, Date rldate, int rlstatus, int pronum,
			int pronum_sync, int grnum, int gpnum, int gnnum, int canum, int mpnum, int rlrn, CampVo camp,
			CampReviewVo campReview, GroupCommentVo groupComment, GroupNoticeCommentVo groupNoticeComment,
			GroupNoticeVo groupNotice, GroupPostVo groupPost, GroupVo group, JoinGroupVo joinGroup,
			MyAdminVo myAdmin, MyBookMarkVo myBookMark, MyCommentVo myComment, MyFollowerVo myFollower,
			MyFollowingVo myFollowing, MyGoodVo myGood, MyPostVo myPost, MyVentureVo myVenture, PageSearchVo pageSearch,
			ProfileVo profile, UpdateWaitVo updateWait) {
		super();
		this.reportList = reportList;
		this.rlnum = rlnum;
		this.rlcategory = rlcategory;
		this.rlreport = rlreport;
		this.rlreporter = rlreporter;
		this.reporterid = reporterid;
		this.rltarget = rltarget;
		this.targetid = targetid;
		this.rlphoto = rlphoto;
		this.rldate = rldate;
		this.rlstatus = rlstatus;
		this.pronum = pronum;
		this.pronum_sync = pronum_sync;
		this.grnum = grnum;
		this.gpnum = gpnum;
		this.gnnum = gnnum;
		this.canum = canum;
		this.mpnum = mpnum;
		this.rlrn = rlrn;
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
		this.updateWait = updateWait;
	}

	public List<ReportListVo> getReportList() {
		return reportList;
	}

	public void setReportList(List<ReportListVo> reportList) {
		this.reportList = reportList;
	}

	public int getRlnum() {
		return rlnum;
	}

	public void setRlnum(int rlnum) {
		this.rlnum = rlnum;
	}

	public String getRlcategory() {
		return rlcategory;
	}

	public void setRlcategory(String rlcategory) {
		this.rlcategory = rlcategory;
	}

	public String getRlreport() {
		return rlreport;
	}

	public void setRlreport(String rlreport) {
		this.rlreport = rlreport;
	}

	public String getRlreporter() {
		return rlreporter;
	}

	public void setRlreporter(String rlreporter) {
		this.rlreporter = rlreporter;
	}

	public String getReporterid() {
		return reporterid;
	}

	public void setReporterid(String reporterid) {
		this.reporterid = reporterid;
	}

	public String getRltarget() {
		return rltarget;
	}

	public void setRltarget(String rltarget) {
		this.rltarget = rltarget;
	}

	public String getTargetid() {
		return targetid;
	}

	public void setTargetid(String targetid) {
		this.targetid = targetid;
	}

	public String getRlphoto() {
		return rlphoto;
	}

	public void setRlphoto(String rlphoto) {
		this.rlphoto = rlphoto;
	}

	public Date getRldate() {
		return rldate;
	}

	public void setRldate(Date rldate) {
		this.rldate = rldate;
	}

	public int getRlstatus() {
		return rlstatus;
	}

	public void setRlstatus(int rlstatus) {
		this.rlstatus = rlstatus;
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

	public int getGrnum() {
		return grnum;
	}

	public void setGrnum(int grnum) {
		this.grnum = grnum;
	}

	public int getGpnum() {
		return gpnum;
	}

	public void setGpnum(int gpnum) {
		this.gpnum = gpnum;
	}

	public int getGnnum() {
		return gnnum;
	}

	public void setGnnum(int gnnum) {
		this.gnnum = gnnum;
	}

	public int getCanum() {
		return canum;
	}

	public void setCanum(int canum) {
		this.canum = canum;
	}

	public int getMpnum() {
		return mpnum;
	}

	public void setMpnum(int mpnum) {
		this.mpnum = mpnum;
	}

	public int getRlrn() {
		return rlrn;
	}

	public void setRlrn(int rlrn) {
		this.rlrn = rlrn;
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

	public UpdateWaitVo getUpdateWait() {
		return updateWait;
	}

	public void setUpdateWait(UpdateWaitVo updateWait) {
		this.updateWait = updateWait;
	}
	
}
