package com.fin.festa.model.entity;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import com.fin.festa.util.DateCalculate;

public class GroupPostVo {		//그룹 게시글

	DateCalculate cal;
	private int gpnum;			//게시글 번호
	private String gpauthor;	//게시글 작성자 이름
	private String gpphoto;		//게시글 내용 사진
	private String gpcontent;	//게시글 내용
	private String httitle1;	//게시글 해시태그1
	private String httitle2;	//게시글 해시태그2
	private String httitle3;	//게시글 해시태그3
	private Timestamp gpdate;		//게시글 작성일
	private String gpdate1;
	private int gpgood;			//게시글 좋아요 수
	private int grnum;			//게시글 그룹 번호
	private int pronum;			//게시글 작성자 번호
	private int gptotal;		//게시글의 댓글수
	private CampVo camp;
	private CampReviewVo campReview;
	private GroupCommentVo groupComment;
	private GroupNoticeCommentVo groupNoticeComment;
	private GroupNoticeVo groupNotice;
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
		return "GroupPostVo [gpnum=" + gpnum + ", gpauthor=" + gpauthor + ", gpphoto=" + gpphoto + ", gpcontent="
				+ gpcontent + ", httitle1=" + httitle1 + ", httitle2=" + httitle2 + ", httitle3=" + httitle3
				+ ", gpdate=" + gpdate + ", gpgood=" + gpgood + ", grnum=" + grnum + ", pronum=" + pronum + ", gptotal="
				+ gptotal + ", camp=" + camp + ", campReview=" + campReview + ", groupComment=" + groupComment
				+ ", groupNoticeComment=" + groupNoticeComment + ", groupNotice=" + groupNotice + ", group=" + group
				+ ", joinGroup=" + joinGroup + ", myAdmin=" + myAdmin + ", myBookMark=" + myBookMark + ", myComment="
				+ myComment + ", myFollower=" + myFollower + ", myFollowing=" + myFollowing + ", myGood=" + myGood
				+ ", myPost=" + myPost + ", myVenture=" + myVenture + ", pageSearch=" + pageSearch + ", profile="
				+ profile + ", reportList=" + reportList + ", updateWait=" + updateWait + "]";
	}
	
	public GroupPostVo() {
		// TODO Auto-generated constructor stub
	}

	public GroupPostVo(int gpnum, String gpauthor, String gpphoto, String gpcontent, String httitle1, String httitle2,
			String httitle3, Timestamp gpdate, int gpgood, int grnum, int pronum, int gptotal, CampVo camp,
			CampReviewVo campReview, GroupCommentVo groupComment, GroupNoticeCommentVo groupNoticeComment,
			GroupNoticeVo groupNotice, GroupVo group, JoinGroupVo joinGroup, MyAdminVo myAdmin, MyBookMarkVo myBookMark,
			MyCommentVo myComment, MyFollowerVo myFollower, MyFollowingVo myFollowing, MyGoodVo myGood, MyPostVo myPost,
			MyVentureVo myVenture, PageSearchVo pageSearch, ProfileVo profile, ReportListVo reportList,
			UpdateWaitVo updateWait) {
		super();
		this.gpnum = gpnum;
		this.gpauthor = gpauthor;
		this.gpphoto = gpphoto;
		this.gpcontent = gpcontent;
		this.httitle1 = httitle1;
		this.httitle2 = httitle2;
		this.httitle3 = httitle3;
		this.gpdate = gpdate;
		this.gpgood = gpgood;
		this.grnum = grnum;
		this.pronum = pronum;
		this.gptotal = gptotal;
		this.camp = camp;
		this.campReview = campReview;
		this.groupComment = groupComment;
		this.groupNoticeComment = groupNoticeComment;
		this.groupNotice = groupNotice;
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

	public int getGpnum() {
		return gpnum;
	}

	public void setGpnum(int gpnum) {
		this.gpnum = gpnum;
	}

	public String getGpauthor() {
		return gpauthor;
	}

	public void setGpauthor(String gpauthor) {
		this.gpauthor = gpauthor;
	}

	public String getGpphoto() {
		return gpphoto;
	}

	public void setGpphoto(String gpphoto) {
		this.gpphoto = gpphoto;
	}

	public String getGpcontent() {
		return gpcontent;
	}

	public void setGpcontent(String gpcontent) {
		this.gpcontent = gpcontent;
	}

	public String getHttitle1() {
		return httitle1;
	}

	public void setHttitle1(String httitle1) {
		this.httitle1 = httitle1;
	}

	public String getHttitle2() {
		return httitle2;
	}

	public void setHttitle2(String httitle2) {
		this.httitle2 = httitle2;
	}

	public String getHttitle3() {
		return httitle3;
	}

	public void setHttitle3(String httitle3) {
		this.httitle3 = httitle3;
	}

	public Timestamp getGpdate() {
		return gpdate;
	}

	public void setGpdate(Timestamp gpdate) {
		this.gpdate = gpdate;
		cal=new DateCalculate();
		gpdate1=cal.dateFormat(this.gpdate);
	}

	public int getGpgood() {
		return gpgood;
	}

	public void setGpgood(int gpgood) {
		this.gpgood = gpgood;
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

	public int getGptotal() {
		return gptotal;
	}

	public void setGptotal(int gptotal) {
		this.gptotal = gptotal;
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

	public String getGpdate1() {
		return gpdate1;
	}
	
}
