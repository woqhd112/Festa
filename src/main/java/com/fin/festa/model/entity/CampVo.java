package com.fin.festa.model.entity;

import java.sql.Date;
import java.util.List;

public class CampVo {					//캠핑장

	private List<CampVo> campList;		//캠핑장 배열파라미터 넘길때 쓰는값
	private int canum;					//캠핑장 번호 (pk)
	private String caname;				//캠핑장 이름
	private String caphoto;				//캠핑장 사진
	private String caaddr;				//캠핑장 주소
	private String caaddrsuv;			//캠핑장 주소 상세
	private String caaddrsel;			//캠핑장 선호지역
	private String caintro;				//캠핑장 소개
	private String caintroone;			//캠핑장 한줄소개
	private String caguide1;			//캠핑장 이용안내
	private String caguide2;			//		″
	private String caguide3;			//		″
	private String caguide4;			//		″
	private String caguide5;			//		″
	private String caguide6;			//		″
	private String caguide7;			//		″
	private String httitle1;			//캠핑장해시태그1
	private String httitle2;			//캠핑장해시태그2
	private String httitle3;			//캠핑장해시태그3
	private Date cadate;				//캠핑장 문서 작성일
	private Date cadateup;				//캠핑장 문서 수정일
	private double caavg;				//캠핑장 별점 평균
	private int cagood;					//캠핑장 좋아요 수
	private int mvnum;					//캠핑장 사업자번호
	private int carn;					//페이지 번호
	private int catotal;
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
	private UpdateWaitVo updateWait;
	
	@Override
	public String toString() {
		return "CampVo [campList=" + campList + ", canum=" + canum + ", caname=" + caname + ", caphoto=" + caphoto
				+ ", caaddr=" + caaddr + ", caaddrsuv=" + caaddrsuv + ", caaddrsel=" + caaddrsel + ", caintro="
				+ caintro + ", caintroone=" + caintroone + ", caguide1=" + caguide1 + ", caguide2=" + caguide2
				+ ", caguide3=" + caguide3 + ", caguide4=" + caguide4 + ", caguide5=" + caguide5 + ", caguide6="
				+ caguide6 + ", caguide7=" + caguide7 + ", httitle1=" + httitle1 + ", httitle2=" + httitle2
				+ ", httitle3=" + httitle3 + ", cadate=" + cadate + ", cadateup=" + cadateup + ", caavg=" + caavg
				+ ", cagood=" + cagood + ", mvnum=" + mvnum + ", carn=" + carn + ", catotal=" + catotal + ", campReview=" + campReview
				+ ", groupComment=" + groupComment + ", groupNoticeComment=" + groupNoticeComment + ", groupNotice="
				+ groupNotice + ", groupPost=" + groupPost + ", group=" + group + ", joinGroup=" + joinGroup
				+ ", myAdmin=" + myAdmin + ", myBookMark=" + myBookMark + ", myComment=" + myComment + ", myFollower="
				+ myFollower + ", myFollowing=" + myFollowing + ", myGood=" + myGood + ", myPost=" + myPost
				+ ", myVenture=" + myVenture + ", pageSearch=" + pageSearch + ", profile=" + profile + ", reportList="
				+ reportList + ", updateWait=" + updateWait + "]";
	}
	
	public CampVo() {
		// TODO Auto-generated constructor stub
	}

	public CampVo(List<CampVo> campList, int canum, String caname, String caphoto, String caaddr, String caaddrsuv,
			String caaddrsel, String caintro, String caintroone, String caguide1, String caguide2, String caguide3,
			String caguide4, String caguide5, String caguide6, String caguide7, String httitle1, String httitle2,
			String httitle3, Date cadate, Date cadateup, double caavg, int cagood, int mvnum, int carn, int catotal,
			CampReviewVo campReview, GroupCommentVo groupComment, GroupNoticeCommentVo groupNoticeComment,
			GroupNoticeVo groupNotice, GroupPostVo groupPost, GroupVo group, JoinGroupVo joinGroup, MyAdminVo myAdmin,
			MyBookMarkVo myBookMark, MyCommentVo myComment, MyFollowerVo myFollower, MyFollowingVo myFollowing,
			MyGoodVo myGood, MyPostVo myPost, MyVentureVo myVenture, PageSearchVo pageSearch, ProfileVo profile,
			ReportListVo reportList, UpdateWaitVo updateWait) {
		super();
		this.campList = campList;
		this.canum = canum;
		this.caname = caname;
		this.caphoto = caphoto;
		this.caaddr = caaddr;
		this.caaddrsuv = caaddrsuv;
		this.caaddrsel = caaddrsel;
		this.caintro = caintro;
		this.caintroone = caintroone;
		this.caguide1 = caguide1;
		this.caguide2 = caguide2;
		this.caguide3 = caguide3;
		this.caguide4 = caguide4;
		this.caguide5 = caguide5;
		this.caguide6 = caguide6;
		this.caguide7 = caguide7;
		this.httitle1 = httitle1;
		this.httitle2 = httitle2;
		this.httitle3 = httitle3;
		this.cadate = cadate;
		this.cadateup = cadateup;
		this.caavg = caavg;
		this.cagood = cagood;
		this.mvnum = mvnum;
		this.carn = carn;
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
		this.updateWait = updateWait;
		this.catotal = catotal;
	}

	public List<CampVo> getCampList() {
		return campList;
	}

	public void setCampList(List<CampVo> campList) {
		this.campList = campList;
	}

	public int getCanum() {
		return canum;
	}

	public void setCanum(int canum) {
		this.canum = canum;
	}

	public String getCaname() {
		return caname;
	}

	public void setCaname(String caname) {
		this.caname = caname;
	}

	public String getCaphoto() {
		return caphoto;
	}

	public void setCaphoto(String caphoto) {
		this.caphoto = caphoto;
	}

	public String getCaaddr() {
		return caaddr;
	}

	public void setCaaddr(String caaddr) {
		this.caaddr = caaddr;
	}

	public String getCaaddrsuv() {
		return caaddrsuv;
	}

	public void setCaaddrsuv(String caaddrsuv) {
		this.caaddrsuv = caaddrsuv;
	}

	public String getCaaddrsel() {
		return caaddrsel;
	}

	public void setCaaddrsel(String caaddrsel) {
		this.caaddrsel = caaddrsel;
	}

	public String getCaintro() {
		return caintro;
	}

	public void setCaintro(String caintro) {
		this.caintro = caintro;
	}

	public String getCaintroone() {
		return caintroone;
	}

	public void setCaintroone(String caintroone) {
		this.caintroone = caintroone;
	}

	public String getCaguide1() {
		return caguide1;
	}

	public void setCaguide1(String caguide1) {
		this.caguide1 = caguide1;
	}

	public String getCaguide2() {
		return caguide2;
	}

	public void setCaguide2(String caguide2) {
		this.caguide2 = caguide2;
	}

	public String getCaguide3() {
		return caguide3;
	}

	public void setCaguide3(String caguide3) {
		this.caguide3 = caguide3;
	}

	public String getCaguide4() {
		return caguide4;
	}

	public void setCaguide4(String caguide4) {
		this.caguide4 = caguide4;
	}

	public String getCaguide5() {
		return caguide5;
	}

	public void setCaguide5(String caguide5) {
		this.caguide5 = caguide5;
	}

	public String getCaguide6() {
		return caguide6;
	}

	public void setCaguide6(String caguide6) {
		this.caguide6 = caguide6;
	}

	public String getCaguide7() {
		return caguide7;
	}

	public void setCaguide7(String caguide7) {
		this.caguide7 = caguide7;
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

	public Date getCadate() {
		return cadate;
	}

	public void setCadate(Date cadate) {
		this.cadate = cadate;
	}

	public Date getCadateup() {
		return cadateup;
	}

	public void setCadateup(Date cadateup) {
		this.cadateup = cadateup;
	}

	public double getCaavg() {
		return caavg;
	}

	public void setCaavg(double caavg) {
		this.caavg = caavg;
	}

	public int getCagood() {
		return cagood;
	}

	public void setCagood(int cagood) {
		this.cagood = cagood;
	}

	public int getMvnum() {
		return mvnum;
	}

	public void setMvnum(int mvnum) {
		this.mvnum = mvnum;
	}

	public int getCarn() {
		return carn;
	}

	public void setCarn(int carn) {
		this.carn = carn;
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

	public UpdateWaitVo getUpdateWait() {
		return updateWait;
	}

	public void setUpdateWait(UpdateWaitVo updateWait) {
		this.updateWait = updateWait;
	}

	public int getCatotal() {
		return catotal;
	}

	public void setCatotal(int catotal) {
		this.catotal = catotal;
	}
	
	
}
