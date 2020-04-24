package com.fin.festa.model.entity;

import java.sql.Date;
import java.util.List;

public class ProfileVo {					//내 정보 (프로필) 

	private List<ProfileVo> profileList;	//정지값 처리할때 쓰임
	private int pronum;						//내 번호 (pk)
	private String proname;					//내 이름
	private String proid;					//내 아이디
	private String propw;					//내 비밀번호
	private String proaddr;					//내 관심지역
	private String projob;					//내 직업
	private String projender;				//내 성별
	private String proidnum;				//내 생년월일
	private String prophoto;				//내 사진
	private String prointro;				//내 소개
	private Date prodate;
	private String chatgrnum;
	private int prorn;			//페이지 번호
	private int logincheck;		//로그인상태체크
	private int proprovide;		//소셜로그인체크
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
	private ReportListVo reportList;
	private UpdateWaitVo updateWait;
	
	@Override
	public String toString() {
		return "ProfileVo [profileList=" + profileList + ", pronum=" + pronum + ", proname=" + proname + ", proid="
				+ proid + ", propw=" + propw + ", proaddr=" + proaddr + ", projob=" + projob + ", projender="
				+ projender + ", proidnum=" + proidnum + ", prophoto=" + prophoto + ", prointro=" + prointro
				+ ", prodate=" + prodate + ", prorn=" + prorn + ", logincheck=" + logincheck + ", proprovide="
				+ proprovide + ", camp=" + camp + ", campReview=" + campReview + ", groupComment=" + groupComment
				+ ", groupNoticeComment=" + groupNoticeComment + ", groupNotice=" + groupNotice + ", groupPost="
				+ groupPost + ", group=" + group + ", joinGroup=" + joinGroup + ", myAdmin=" + myAdmin + ", myBookMark="
				+ myBookMark + ", myComment=" + myComment + ", myFollower=" + myFollower + ", myFollowing="
				+ myFollowing + ", myGood=" + myGood + ", myPost=" + myPost + ", myVenture=" + myVenture
				+ ", pageSearch=" + pageSearch + ", reportList=" + reportList + ", updateWait=" + updateWait + ", chatgrnum=" + chatgrnum + "]";
	}
	
	public ProfileVo() {
		// TODO Auto-generated constructor stub
	}
	
	

	public ProfileVo(List<ProfileVo> profileList, int pronum, String proname, String proid, String propw, String chatgrnum,
			String proaddr, String projob, String projender, String proidnum, String prophoto, String prointro,
			Date prodate, int prorn, int logincheck, int proprovide, CampVo camp, CampReviewVo campReview,
			GroupCommentVo groupComment, GroupNoticeCommentVo groupNoticeComment, GroupNoticeVo groupNotice,
			GroupPostVo groupPost, GroupVo group, JoinGroupVo joinGroup, MyAdminVo myAdmin, MyBookMarkVo myBookMark,
			MyCommentVo myComment, MyFollowerVo myFollower, MyFollowingVo myFollowing, MyGoodVo myGood, MyPostVo myPost,
			MyVentureVo myVenture, PageSearchVo pageSearch, ReportListVo reportList, UpdateWaitVo updateWait) {
		super();
		this.profileList = profileList;
		this.pronum = pronum;
		this.proname = proname;
		this.proid = proid;
		this.propw = propw;
		this.proaddr = proaddr;
		this.projob = projob;
		this.projender = projender;
		this.proidnum = proidnum;
		this.prophoto = prophoto;
		this.prointro = prointro;
		this.prodate = prodate;
		this.prorn = prorn;
		this.logincheck = logincheck;
		this.proprovide = proprovide;
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
		this.reportList = reportList;
		this.updateWait = updateWait;
		this.chatgrnum = chatgrnum;
	}

	public List<ProfileVo> getProfileList() {
		return profileList;
	}

	public void setProfileList(List<ProfileVo> profileList) {
		this.profileList = profileList;
	}

	public int getPronum() {
		return pronum;
	}

	public void setPronum(int pronum) {
		this.pronum = pronum;
	}

	public String getProname() {
		return proname;
	}

	public void setProname(String proname) {
		this.proname = proname;
	}

	public String getProid() {
		return proid;
	}

	public void setProid(String proid) {
		this.proid = proid;
	}

	public String getPropw() {
		return propw;
	}

	public void setPropw(String propw) {
		this.propw = propw;
	}

	public String getProaddr() {
		return proaddr;
	}

	public void setProaddr(String proaddr) {
		this.proaddr = proaddr;
	}

	public String getProjob() {
		return projob;
	}

	public void setProjob(String projob) {
		this.projob = projob;
	}

	public String getProjender() {
		return projender;
	}

	public void setProjender(String projender) {
		this.projender = projender;
	}

	public String getProidnum() {
		return proidnum;
	}

	public void setProidnum(String proidnum) {
		this.proidnum = proidnum;
	}

	public String getProphoto() {
		return prophoto;
	}

	public void setProphoto(String prophoto) {
		this.prophoto = prophoto;
	}

	public String getProintro() {
		return prointro;
	}

	public void setProintro(String prointro) {
		this.prointro = prointro;
	}

	public Date getProdate() {
		return prodate;
	}

	public void setProdate(Date prodate) {
		this.prodate = prodate;
	}

	public int getProrn() {
		return prorn;
	}

	public void setProrn(int prorn) {
		this.prorn = prorn;
	}

	public int getLogincheck() {
		return logincheck;
	}

	public void setLogincheck(int logincheck) {
		this.logincheck = logincheck;
	}

	public int getProprovide() {
		return proprovide;
	}

	public void setProprovide(int proprovide) {
		this.proprovide = proprovide;
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

	public String getChatgrnum() {
		return chatgrnum;
	}

	public void setChatgrnum(String chatgrnum) {
		this.chatgrnum = chatgrnum;
	}
	
	
	
}


