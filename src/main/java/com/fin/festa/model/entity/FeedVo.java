package com.fin.festa.model.entity;

import java.sql.Timestamp;
import java.util.List;

import com.fin.festa.util.DateCalculate;

public class FeedVo {
	
	DateCalculate cal;
	private List<FeedVo> feedList;
	private int gpnum;			//게시글 번호
	private String gpauthor;	//게시글 작성자 이름
	private String gpphoto;		//게시글 내용 사진
	private String gpcontent;	//게시글 내용
	private String httitle1;	//게시글 해시태그1
	private String httitle2;	//게시글 해시태그2
	private String httitle3;	//게시글 해시태그3
	private int grnum;			//게시글 그룹 번호
	private int pronum;			//게시글 작성자 번호
	private int gptotal;		//게시글의 댓글수
	
	private int mpnum;			//내 게시글 번호 (pk)
	private String mpauthor;	//내 이름
	private String mpphoto;		//게시글 사진
	private String mpcontent;	//게시글 내용
	private Timestamp date;	
	private String date1;
	private int good;			//내 게시글 좋아요
	private int mptotal;		//내게시글의 댓글수
	
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
	private MyVentureVo myVenture;
	private PageSearchVo pageSearch;
	private ProfileVo profile;
	private ReportListVo reportList;
	private UpdateWaitVo updateWait;
	
	@Override
	public String toString() {
		return "FeedVo [feedList="+ feedList +", cal=" + cal + ", gpnum=" + gpnum + ", gpauthor=" + gpauthor + ", gpphoto=" + gpphoto
				+ ", gpcontent=" + gpcontent + ", httitle1=" + httitle1 + ", httitle2=" + httitle2 + ", httitle3="
				+ httitle3 + ", grnum=" + grnum + ", pronum=" + pronum + ", gptotal=" + gptotal
				+ ", mpnum=" + mpnum + ", mpauthor=" + mpauthor + ", mpphoto=" + mpphoto + ", mpcontent=" + mpcontent
				+ ", date=" + date + ", date1=" + date1 + ", good=" + good + ", mptotal=" + mptotal + ", camp="
				+ camp + ", campReview=" + campReview + ", groupComment=" + groupComment + ", groupNoticeComment="
				+ groupNoticeComment + ", groupNotice=" + groupNotice + ", group=" + group + ", joinGroup=" + joinGroup
				+ ", myAdmin=" + myAdmin + ", myBookMark=" + myBookMark + ", myComment=" + myComment + ", myFollower="
				+ myFollower + ", myFollowing=" + myFollowing + ", myGood=" + myGood + ", myVenture=" + myVenture
				+ ", pageSearch=" + pageSearch + ", profile=" + profile + ", reportList=" + reportList + ", updateWait="
				+ updateWait + "]";
	}
	
	public FeedVo() {
		// TODO Auto-generated constructor stub
	}

	public FeedVo(List<FeedVo> feedList, DateCalculate cal, int gpnum, String gpauthor, String gpphoto, String gpcontent, String httitle1,
			String httitle2, String httitle3, int grnum, int pronum, int gptotal, int mpnum,
			String mpauthor, String mpphoto, String mpcontent, Timestamp date, String date1, int good, int mptotal,
			CampVo camp, CampReviewVo campReview, GroupCommentVo groupComment, GroupNoticeCommentVo groupNoticeComment,
			GroupNoticeVo groupNotice, GroupVo group, JoinGroupVo joinGroup, MyAdminVo myAdmin, MyBookMarkVo myBookMark,
			MyCommentVo myComment, MyFollowerVo myFollower, MyFollowingVo myFollowing, MyGoodVo myGood,
			MyVentureVo myVenture, PageSearchVo pageSearch, ProfileVo profile, ReportListVo reportList,
			UpdateWaitVo updateWait) {
		super();
		this.feedList = feedList;
		this.cal = cal;
		this.gpnum = gpnum;
		this.gpauthor = gpauthor;
		this.gpphoto = gpphoto;
		this.gpcontent = gpcontent;
		this.httitle1 = httitle1;
		this.httitle2 = httitle2;
		this.httitle3 = httitle3;
		this.grnum = grnum;
		this.pronum = pronum;
		this.gptotal = gptotal;
		this.mpnum = mpnum;
		this.mpauthor = mpauthor;
		this.mpphoto = mpphoto;
		this.mpcontent = mpcontent;
		this.date = date;
		this.date1 = date1;
		this.good = good;
		this.mptotal = mptotal;
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
		this.myVenture = myVenture;
		this.pageSearch = pageSearch;
		this.profile = profile;
		this.reportList = reportList;
		this.updateWait = updateWait;
	}

	public DateCalculate getCal() {
		return cal;
	}

	public void setCal(DateCalculate cal) {
		this.cal = cal;
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

	public int getMpnum() {
		return mpnum;
	}

	public void setMpnum(int mpnum) {
		this.mpnum = mpnum;
	}

	public String getMpauthor() {
		return mpauthor;
	}

	public void setMpauthor(String mpauthor) {
		this.mpauthor = mpauthor;
	}

	public String getMpphoto() {
		return mpphoto;
	}

	public void setMpphoto(String mpphoto) {
		this.mpphoto = mpphoto;
	}

	public String getMpcontent() {
		return mpcontent;
	}

	public void setMpcontent(String mpcontent) {
		this.mpcontent = mpcontent;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
		cal=new DateCalculate();
		date1=cal.dateFormat(this.date);
	}

	public String getDate1() {
		return date1;
	}

	public void setDate1(String date1) {
		this.date1 = date1;
	}

	public int getGood() {
		return good;
	}

	public void setGood(int good) {
		this.good = good;
	}

	public int getMptotal() {
		return mptotal;
	}

	public void setMptotal(int mptotal) {
		this.mptotal = mptotal;
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

	
	public List<FeedVo> getFeedList() {
		return feedList;
	}

	public void setFeedList(List<FeedVo> feedList) {
		this.feedList = feedList;
	}

	
}
