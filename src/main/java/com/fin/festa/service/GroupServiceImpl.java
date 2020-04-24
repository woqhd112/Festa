package com.fin.festa.service;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.fin.festa.model.GroupDaoImpl;
import com.fin.festa.model.IndexDaoImpl;
import com.fin.festa.model.MemberDaoImpl;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupNoticeCommentVo;
import com.fin.festa.model.entity.GroupNoticeVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.JoinGroupVo;
import com.fin.festa.model.entity.MyBookMarkVo;
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.ProfileVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.model.entity.UpdateWaitVo;
import com.fin.festa.util.DateCalculate;
import com.fin.festa.util.UploadPhoto;

@Service
public class GroupServiceImpl implements GroupService{

	//등록,수정,삭제가 최소2개이상 들어가는 메소드는 꼭 트랜잭션 적용할것!!

	@Autowired
	GroupDaoImpl groupDao;
	
	@Autowired
	MemberDaoImpl memberDao;

	@Autowired
	IndexDaoImpl indexDao;
	
	int check;
	
	//가입된 그룹인지 체크
	@Override
	public int joinGroup(HttpServletRequest req, UpdateWaitVo updateWaitVo) {
		int result=groupDao.joinGroupCheck(updateWaitVo);
		int result2=groupDao.updateGroupCheck(updateWaitVo);
		if(result == 0 && result2 ==0) {				//가입된 그룹이 아님
			check=0;
			return check;
		} else if (result == 0 && result2 == 1){		//승인 대기중
			check=1;
			return check;
		} else {										//그룹원
			check=2;
			ProfileVo profileVo=new ProfileVo();
			profileVo.setPronum(updateWaitVo.getPronum());
			HttpSession session = req.getSession();
			List<JoinGroupVo> joinGroup = memberDao.myJoinGroupSelectAll(profileVo.getPronum());
			session.setAttribute("joinGroup", joinGroup);
			
			return check;
		}
		
	}

	//그룹 가입
	@Override
	public void groupAdmission(Model model, UpdateWaitVo updateWaitVo) {
		groupDao.joinGroupRequest(updateWaitVo);
	}
	
	//공식그룹인지 체크
	//그룹정보출력
	//그룹피드출력
	//그룹공지사항출력
	//그룹피드댓글출력
	@Override
	public void groupSelectOne(HttpServletRequest req, GroupVo groupVo) {
		req.setAttribute("check", groupDao.groupVentureCheck(groupVo));
		req.setAttribute("detail", groupDao.groupSelectOne(groupVo));
		req.setAttribute("feed", groupDao.groupFeedSelectAll(groupVo));
		req.setAttribute("ntc", groupDao.groupNoticeSelectAll(groupVo));
		req.setAttribute("feedcmmt", groupDao.groupFeedCmmtSelectAll(groupVo));
		
		if(req.getSession().getAttribute("login")!=null) {
			req.setAttribute("grouplist", indexDao.addrGroupSelectAll((ProfileVo) req.getSession().getAttribute("login")));
		} else {
			req.setAttribute("grouplist", indexDao.totalGroupSelectAll());
		}
		req.setAttribute("camplist", indexDao.veryHotCampSelectAll());
	}
	
	//공지사항댓글 더보기 비동기
	@Override
	public List<GroupNoticeCommentVo> groupNoticeDetailCmmt(Model model, GroupNoticeVo groupnotice) {
		return groupDao.groupNoticeDetailCmmt(groupnotice);
	}

	//그룹피드댓글 더보기 비동기
	@Override
	public List<GroupCommentVo> groupDetailCmmt(Model model, GroupPostVo grouppost) {
		return groupDao.groupDetailCmmt(grouppost);
	}
	
	//그룹인원정보 출력
	@Override
	public void groupMemberList(HttpServletRequest req, GroupVo groupVo) {
		req.setAttribute("member", groupDao.groupUserInfo(groupVo));
	}
	
	//그룹 신고등록
	//신고당한유저 신고당한횟수 +1
	@Transactional
	@Override
	public void groupReport(HttpServletRequest req, ReportListVo reportListVo, MultipartFile[] files) {

		UploadPhoto up = new UploadPhoto();
		String rlphoto = up.upload(files, req, reportListVo);
		reportListVo.setRlphoto(rlphoto);
		
		//기타버튼눌렀다가 다른거체크하고 넘어온경우 다른거체크값으로 대체
		String rlreport = reportListVo.getRlreport();
		String[] report = rlreport.split("\\,");
		if(report.length>1) {
			if(report[0].equals("기타")) {
				rlreport = report[1];
			}else {
				rlreport = report[0];
			}
		}else {
			rlreport=rlreport.substring(0, rlreport.length()-1);
		}
		reportListVo.setRlreport(rlreport);
		
		groupDao.groupReportInsert(reportListVo);
		groupDao.groupReportCountUpdate(reportListVo);
	}

	//공지사항 등록
	@Override
	public void noticeInsertOne(HttpServletRequest req, MultipartFile[] files, GroupNoticeVo groupNoticeVo) {
		UploadPhoto up = new UploadPhoto();
		String gnPhoto=up.upload(files, req, groupNoticeVo);
		groupNoticeVo.setGnphoto(gnPhoto);
		groupDao.groupNoticeInsert(groupNoticeVo);
	}

	//공지사항 상세정보출력
	//공지사항 댓글출력
	@Override
	public void noticeSelectOne(HttpServletRequest req, GroupNoticeVo groupNoticeVo) {
		GroupVo group=new GroupVo();
		group.setGrnum(groupNoticeVo.getGrnum());
		req.setAttribute("detail", groupDao.groupSelectOne(group));
		req.setAttribute("ntc", groupDao.groupNoticeSelectAll(group));
		req.setAttribute("ntcDetail", groupDao.groupNoticeSelectOne(groupNoticeVo));
		req.setAttribute("ntcCmmt", groupDao.groupNoticeCmmtSelectAll(groupNoticeVo));
	}
	

	//공지사항 수정
	@Override
	public void noticeUpdateOne(HttpServletRequest req, MultipartFile[] filess, GroupNoticeVo groupNoticeVo) {
		UploadPhoto up = new UploadPhoto();
		String gnphoto=up.upload(filess, req, groupNoticeVo);
		if (groupNoticeVo.getGnphoto()!=null) {
			if (!gnphoto.isEmpty()) {
				groupNoticeVo.setGnphoto(groupNoticeVo.getGnphoto() + "," + gnphoto);
			}
		}
		else {
			groupNoticeVo.setGnphoto(gnphoto);
		}
		groupDao.groupNoticeUpdate(groupNoticeVo);
	}

	//공지사항 삭제
	@Override
	public void noticeDeleteOne(Model model, GroupNoticeVo groupNoticeVo) {
		groupDao.groupNoticeDelete(groupNoticeVo);
	}

	//공지사항 댓글등록
	@Override
	public void noticeCmmtInsertOne(HttpServletRequest req, GroupNoticeCommentVo groupNoticeCommentVo) {
		groupDao.groupNoticeCmmtInsert(groupNoticeCommentVo);
	}

	//공지사항 댓글삭제
	@Override
	public void noticeCmmtDeleteOne(HttpServletRequest req, GroupNoticeCommentVo groupNoticeCommentVo) {
		groupDao.groupNoticeCmmtDelete(groupNoticeCommentVo);
	}


	//공지사항 신고등록
	//해당유저 신고횟수 +1
	@Override
	public void noticeReport(HttpServletRequest req, ReportListVo reportListVo, MultipartFile[] files) {
		
		UploadPhoto up = new UploadPhoto();
		String rlphoto = up.upload(files, req, reportListVo);
		reportListVo.setRlphoto(rlphoto);
		
		//기타버튼눌렀다가 다른거체크하고 넘어온경우 다른거체크값으로 대체
		String rlreport = reportListVo.getRlreport();
		String[] report = rlreport.split("\\,");
		if(report.length>1) {
			if(report[0].equals("기타")) {
				rlreport = report[1];
			}else {
				rlreport = report[0];
			}
		}else {
			rlreport=rlreport.substring(0, rlreport.length()-1);
		}
		reportListVo.setRlreport(rlreport);
		
		groupDao.groupNoticeReportInsert(reportListVo);
		groupDao.groupReportCountUpdate(reportListVo);
	}

	//그룹피드 등록
	@Override
	public void groupFeedInsertOne(HttpServletRequest req, MultipartFile[] files, GroupPostVo groupPostVo) {
		UploadPhoto up = new UploadPhoto();
		String mpPhoto=up.upload(files, req, groupPostVo);
		groupPostVo.setGpphoto(mpPhoto);
		groupDao.groupFeedInsert(groupPostVo);
	}

	//그룹피드 수정 전 출력
	@Override
	public void groupFeedDetail(Model model, GroupPostVo groupPostVo) {
		model.addAttribute("feedDetail", groupDao.groupFeedDetailOne(groupPostVo));
	}
	
	//그룹피드 수정
	@Override
	public void groupFeedUpdateOne(HttpServletRequest req, MultipartFile[] filess ,GroupPostVo groupPostVo) {
		UploadPhoto up = new UploadPhoto();
		String gpphoto=up.upload(filess, req, groupPostVo);
		if (groupPostVo.getGpphoto()!=null) {
			if (!gpphoto.isEmpty()) {
				groupPostVo.setGpphoto(groupPostVo.getGpphoto() + "," + gpphoto);
			}
		}
		else {
			groupPostVo.setGpphoto(gpphoto);
		}
		groupDao.groupFeedUpdate(groupPostVo);
	}

	//그룹피드 삭제
	@Override
	public void groupFeedDeleteOne(Model model, GroupPostVo groupPostVo) {
		groupDao.groupFeedDelete(groupPostVo);
	}

	//그룹피드 댓글등록
	@Override
	public void groupFeedCmmtInsertOne(HttpServletRequest req, GroupCommentVo groupCommentVo) {
		groupDao.groupFeedCmmtInsert(groupCommentVo);
	}

	//그룹피드 댓글삭제
	@Override
	public void groupFeedCmmtDeleteOne(Model model, GroupCommentVo groupCommentVo) {
		groupDao.groupFeedCmmtDelete(groupCommentVo);
	}

	//그룹피드 좋아요등록
	//피드 좋아요 갯수 +1
	//좋아요목록 갱신
	@Transactional
	@Override
	public void FeedLikeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		
		groupDao.groupFeedLikeInsertOne(myGoodVo);
		
		GroupPostVo post=new GroupPostVo();
		post.setGpnum(myGoodVo.getGpnum());
		
		groupDao.groupFeedLikeOnePlus(post);
		
		req.getSession().setAttribute("goodlist", groupDao.myGoodRenewal(myGoodVo));
	}

	//그룹피드 좋아요해제
	//피드 좋아요 갯수 -1
	//좋아요목록 갱신
	@Transactional
	@Override
	public void FeedLikeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		
		groupDao.groupFeedLikeDeleteOne(myGoodVo);
		
		GroupPostVo post=new GroupPostVo();
		post.setGpnum(myGoodVo.getGpnum());
		
		groupDao.groupFeedLikeOneMinus(post);
		
		req.getSession().setAttribute("goodlist", groupDao.myGoodRenewal(myGoodVo));
	}

	//그룹피드 신고등록
	//신고당한유저 신고당한횟수 +1
	@Override
	public void groupFeedReport(HttpServletRequest req, ReportListVo reportListVo, MultipartFile[] files) {

		UploadPhoto up = new UploadPhoto();
		String rlphoto = up.upload(files, req, reportListVo);
		reportListVo.setRlphoto(rlphoto);
		
		//기타버튼눌렀다가 다른거체크하고 넘어온경우 다른거체크값으로 대체
		String rlreport = reportListVo.getRlreport();
		String[] report = rlreport.split("\\,");
		if(report.length>1) {
			if(report[0].equals("기타")) {
				rlreport = report[1];
			}else {
				rlreport = report[0];
			}
		}else {
			rlreport=rlreport.substring(0, rlreport.length()-1);
		}
		reportListVo.setRlreport(rlreport);
		
		groupDao.groupFeedReportInsert(reportListVo);
		groupDao.groupReportCountUpdate(reportListVo);
	}

	//채팅 아직 미구현..
	@Override
	public void groupChat(Model model) {
		// TODO Auto-generated method stub
		
	}

	//그룹관리정보출력

	
	//그룹총원출력
	@Override
	public void groupAdminSelectOne(Model model, GroupVo groupVo) {
		// TODO Auto-generated method stub
		
	}

	//그룹관리 수정
	@Override
	public void groupAdminUpdateOne(HttpServletRequest req, GroupVo groupVo, MultipartFile[] files) {	
		UploadPhoto up = new UploadPhoto();
		String grPhoto=up.upload(files, req, groupVo);
		if(grPhoto.equals("")) {
			groupVo.setGrphoto(groupVo.getGrphoto());
			System.out.println("null"+groupVo.getGrphoto());
		}else {
			groupVo.setGrphoto(grPhoto);
			System.out.println("notnull"+groupVo.getGrphoto());
		}
		groupDao.groupInfoUpdate(groupVo);

		ProfileVo profileVo=new ProfileVo();
		profileVo.setPronum(groupVo.getPronum());
		HttpSession session = req.getSession();
		List<JoinGroupVo> joinGroup = memberDao.myJoinGroupSelectAll(profileVo.getPronum());
		session.setAttribute("joinGroup", joinGroup);
	}

	//가입된 유저정보 출력
	//페이지 한페이지에 10개 로우
	//검색으로 값이 넘어올경우 검색조건 유저정보 출력(keyword!=null)
	//페이지기능을 위한 가입유저조회 테이블 로우갯수 뽑기
	@Override
	public void groupUserAdminSelectAll(HttpServletRequest req, GroupVo groupVo, PageSearchVo pageSearchVo) {
		DateCalculate date=new DateCalculate();
		//첫화면불러올때 페이지넘버가 0이니까 1로 맞춰줌
		if(pageSearchVo.getPage()==0) {
			pageSearchVo.setPage(1);
		}		
		//첫화면불러올때나 검색안할때 null이 들어가므로 mysql은 null하고 ""하고 값이 다르기때문에 ""로 맞춰줌
		if(pageSearchVo.getKeyword()==null) {
			pageSearchVo.setKeyword("");
			groupVo.setPageSearch(pageSearchVo);		
			groupVo.getPageSearch().setTotalCount(groupDao.groupUserTotalCount(groupVo));
			req.setAttribute("userdetail", date.proidnumFormat(groupDao.groupUserSelectAll(groupVo)));
			req.setAttribute("pageSearch", groupVo.getPageSearch());
		} else {
			groupVo.setPageSearch(pageSearchVo);		
			groupVo.getPageSearch().setTotalCount(groupDao.groupUserTotalCount(groupVo));
			req.setAttribute("userdetail", date.proidnumFormat(groupDao.groupUserSearch(groupVo)));
			req.setAttribute("pageSearch", groupVo.getPageSearch());
		}
	}

	//가입된 유저 강퇴
	//그룹 가입총원 -@
	@Transactional
	@Override
	public void groupUserKick(HttpServletRequest req, GroupVo groupVo, JoinGroupVo joinGroupVo) {
		groupDao.groupUserKick(joinGroupVo);
		groupDao.groupTotalMinus(groupVo);
		ProfileVo profileVo=new ProfileVo();
		profileVo.setPronum(groupVo.getPronum());
		HttpSession session = req.getSession();
		List<JoinGroupVo> joinGroup = memberDao.myJoinGroupSelectAll(profileVo.getPronum());
		session.setAttribute("joinGroup", joinGroup);
	}

	//가입된 유저 전부강퇴 (그룹장 제외)
	//그룹 가입총원 -@
	@Transactional
	@Override
	public void groupUserAllKick(HttpServletRequest req, GroupVo groupVo) {
		groupDao.groupUserAllKick(groupVo);
		groupDao.groupTotalMinus(groupVo);

		ProfileVo profileVo=new ProfileVo();
		profileVo.setPronum(groupVo.getPronum());
		HttpSession session = req.getSession();
		List<JoinGroupVo> joinGroup = memberDao.myJoinGroupSelectAll(profileVo.getPronum());
		session.setAttribute("joinGroup", joinGroup);
	}

	//가입신청 유저정보 출력
	//페이지 한페이지에 5개 로우
	//페이지기능을 위한 가입신청조회 테이블 로우갯수 뽑기
	@Override
	public void groupRequestSelectAll(HttpServletRequest req, GroupVo groupVo, PageSearchVo pageSearchVo) {
		DateCalculate date=new DateCalculate();
		//첫화면불러올때 페이지넘버가 0이니까 1로 맞춰줌
		if(pageSearchVo.getPage2()==0) {
			pageSearchVo.setPage2(1);
		}
		groupVo.setPageSearch(pageSearchVo);
		groupVo.getPageSearch().setTotalCount2(groupDao.groupRequestTotalCount(groupVo));
		req.setAttribute("request", date.proidnumFormatt(groupDao.groupRequestSelectAll(groupVo)));
		req.setAttribute("pageSearch", groupVo.getPageSearch());
	}

	//가입신청 유저등록
	//그룹 가입총원 +@
	//업데이트테이블 데이터삭제(가입신청 거절 메소드 사용)
	@Transactional
	@Override
	public void groupRequestHello(HttpServletRequest req, UpdateWaitVo updateWaitVo, GroupVo groupVo) {
		
		groupDao.groupRequestHello(updateWaitVo);
		groupDao.groupTotalPlus(groupVo);
		groupDao.groupRequestSorry(updateWaitVo);
		ProfileVo profileVo=new ProfileVo();
		profileVo.setPronum(groupVo.getPronum());
		
		HttpSession session = req.getSession();
		List<JoinGroupVo> joinGroup = memberDao.myJoinGroupSelectAll(profileVo.getPronum());
		session.setAttribute("joinGroup", joinGroup);
	}

	//가입신청 거절
	@Override
	public void groupRequestSorry(HttpServletRequest req, UpdateWaitVo updateWaitVo, GroupVo groupVo) {
		groupDao.groupRequestSorry(updateWaitVo);
		
		ProfileVo profileVo=new ProfileVo();
		profileVo.setPronum(groupVo.getPronum());
		
		HttpSession session = req.getSession();
		List<JoinGroupVo> joinGroup = memberDao.myJoinGroupSelectAll(profileVo.getPronum());
		session.setAttribute("joinGroup", joinGroup);
	}

	//그룹 삭제
	@Override
	public void groupDeleteOne(HttpServletRequest req, GroupVo groupVo) {
		groupDao.groupDelete(groupVo);
		
		ProfileVo profileVo=new ProfileVo();
		profileVo.setPronum(groupVo.getPronum());
		
		HttpSession session = req.getSession();
		List<JoinGroupVo> joinGroup = memberDao.myJoinGroupSelectAll(profileVo.getPronum());
		session.setAttribute("joinGroup", joinGroup);
	}

	//가입된그룹 탈퇴
	//그룹 가입총원 -@
	@Transactional
	@Override
	public void groupOut(HttpServletRequest req, JoinGroupVo joinGroup, GroupVo groupVo) {

		groupDao.groupOut(joinGroup);
		groupDao.groupTotalMinus(groupVo);
		
		ProfileVo profileVo=new ProfileVo();
		profileVo.setPronum(joinGroup.getPronum());
		
		HttpSession session = req.getSession();
		List<JoinGroupVo> joinGroup1 = memberDao.myJoinGroupSelectAll(profileVo.getPronum());
		session.setAttribute("joinGroup", joinGroup1);
	}

	// 회원 팔로잉등록
	// 상대 팔로워등록
	// 내 팔로잉목록 갱신
	@Transactional
	@Override
	public void followInsertOne(HttpServletRequest req, MyFollowingVo myFollowing) {
		System.out.println("파라미터 : " + myFollowing);
		groupDao.myFollowingInsertOne(myFollowing);
		groupDao.yourFollowerInsertOne(myFollowing);
		HttpSession session = req.getSession();
		session.setAttribute("followlist", groupDao.myFollowingRenewal(myFollowing));
		System.out.println("등록 : " + req.getSession().getAttribute("followlist"));
	}

	// 회원 팔로잉해제
	// 상대 팔로워해제
	// 내 팔로잉목록 갱신
	@Transactional
	@Override
	public void followDeleteOne(HttpServletRequest req, MyFollowingVo myFollowing) {
		System.out.println("파라미터 : " + myFollowing);
		groupDao.myFollowingDeleteOne(myFollowing);
		groupDao.yourFollowerDeleteOne(myFollowing);
		HttpSession session = req.getSession();
		session.setAttribute("followlist", groupDao.myFollowingRenewal(myFollowing));
		System.out.println("해제 : " + req.getSession().getAttribute("followlist"));
	}

	//채팅방 접속시 실행
	@Override
	public void groupChatUser(HttpServletRequest req, GroupVo groupVo) {
		HttpSession session=req.getSession();
		ProfileVo profile=(ProfileVo) session.getAttribute("login");
		groupVo.setProfile(profile);
		groupDao.groupChatUserUpdate(groupVo);
		req.setAttribute("joinmember", groupDao.groupChatUser(groupVo));
	}




}
