package com.fin.festa.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.fin.festa.model.AdminDaoImpl;
import com.fin.festa.model.entity.CampReviewVo;
import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupNoticeCommentVo;
import com.fin.festa.model.entity.GroupNoticeVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.MyAdminVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.MyVentureVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.ProfileVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.model.entity.UpdateWaitVo;
import com.fin.festa.util.AgeCalculate;
import com.fin.festa.util.DateCalculate;
import com.fin.festa.util.StopUser;

@EnableScheduling
@Service
public class AdminServiceImpl implements AdminService{

	//등록,수정,삭제가 최소2개이상 들어가는 메소드는 꼭 트랜잭션 적용할것!!
	
	@Autowired
	AdminDaoImpl adminDao;
	
	//대시보드 전체사용자,그룹,사업자,캠핑장수 출력 (선 작업-후 다오)
	//대시보드 전체사용자,그룹,사업자,캠핑장수 출력 어제기준 (선 작업-후 다오)
	//대시보드 저번주 신규이용자정보 출력 (선 작업-후 다오)
	//대시보드 이번주 신규진행현황 출력 (선 작업-후 다오)
	//대시보드 전체회원의 생년월일 출력 (회원연령분포값 뽑을때 쓰임)// (선 다오-후 작업)
	//대시보드 선호관심지역정보 출력 (선 작업-후 다오)
	@Override
	public void adminDashBoard(Model model) {
		
		DateCalculate cal=new DateCalculate();
		AgeCalculate age=new AgeCalculate();
		
		model.addAttribute("today", cal.getTime());											//현재시간값
		model.addAttribute("allUser", adminDao.allCount());									//모든사용자값
		model.addAttribute("yesterday", adminDao.allCount_yesterday(cal.yesterday()));		//모든사용자값 어제기준
		model.addAttribute("lastWeek", adminDao.lastWeekNewUser(cal.lastWeekNewUser()));	//저번주 신규가입자
		model.addAttribute("week", adminDao.weekNewUserCount(cal.weekNewUser()));			//이번주 신규진행현황
		model.addAttribute("prefer", adminDao.preferLocation());							//선호관심지역
		model.addAttribute("userAge", age.userAgeDistribution(adminDao.allUserCount()));	//회원 연령분포
	}

	//그룹관리정보출력
	@Override
	public void adminGroupSelectAll(Model model, PageSearchVo pageSearchVo) {
		
		//첫화면불러올때 페이지넘버가 0이니까 1로 맞춰줌
		if(pageSearchVo.getPage()==0) {
			pageSearchVo.setPage(1);
		}
		
		//첫화면불러올떄나 검색안할때 null이 들어가므로 mysql은 null하고 ""하고 값이 다르기때문에 ""로 맞춰줌
		if(pageSearchVo.getKeyword()==null) {
			pageSearchVo.setKeyword("");
		}
		
		pageSearchVo.setTotalCount(adminDao.adminGroupCount(pageSearchVo));
		
		model.addAttribute("groupList", adminDao.adminGroupSelectAll(pageSearchVo));
		model.addAttribute("paging", pageSearchVo);
	}

	//그룹삭제 +@
	@Override
	public void adminGroupDeleteOne(Model model, GroupVo groupVo) {

		adminDao.groupDelete(groupVo);
	}
	
	//그룹정보출력
	//그룹공지사항출력
	//그룹피드출력
	//그룹댓글출력
	@Override
	public void adminGroupDetail(Model model, GroupVo groupVo) {

		PageSearchVo page = new PageSearchVo();
		page.setPage5(1);
		groupVo.setPageSearch(page);
		
		model.addAttribute("groupinfo", adminDao.groupInfo(groupVo));
		model.addAttribute("groupnotice", adminDao.groupNoticeInfo(groupVo));
		model.addAttribute("groupfeed", adminDao.groupFeedInfoSelectAll(groupVo));
		model.addAttribute("groupcmmt", adminDao.groupFeedCmmtInfoSelectAll(groupVo));
	}

	//그룹피드 스크롤더보기 비동기
	@Override
	public List<List<?>> adminGroupDetailScroll(Model model, GroupVo groupVo) {

		List<List<?>> list = new ArrayList<>();
		list.add(adminDao.groupFeedInfoSelectAll(groupVo));
		list.add(adminDao.groupFeedCmmtInfoSelectAll(groupVo));
		return list;
	}
	//그룹피드댓글 더보기 비동기
	@Override
	public List<GroupCommentVo> adminGroupDetailCmmt(Model model, GroupPostVo grouppost) {
		
		return adminDao.adminGroupDetailCmmt(grouppost);
	}

	//공지사항상세출력
	//공지사항댓글출력
	@Override
	public void adminGroupDetailNotice(Model model, GroupNoticeVo groupnoticeVo) {
		
		model.addAttribute("noticedetail", adminDao.groupNoticeDetail(groupnoticeVo));
		model.addAttribute("noticecmmt", adminDao.groupNoticeCmmtInfo(groupnoticeVo));
	}

	//그룹공지피드 댓글더보기 비동기
	@Override
	public List<GroupNoticeCommentVo> adminGroupNoticeCmmt(Model model, GroupNoticeVo groupnotice) {
		
		return adminDao.adminGroupNoticeCmmt(groupnotice);
	}
	
	//공지사항삭제
	@Override
	public void adminGroupDetailNoticeDelete(Model model, GroupNoticeVo groupNoticeVo) {
		
		adminDao.groupNoticeDelete(groupNoticeVo);
	}
	
	//공지사항댓글삭제
	@Override
	public void adminGroupDetailNoticeCmmtDelete(Model model, GroupNoticeCommentVo groupNoticeCommentVo) {

		adminDao.groupNoticeCmmtDelete(groupNoticeCommentVo);
	}
	
	//그룹피드삭제
	@Override
	public void adminGroupDetailDelete(Model model, GroupPostVo groupPostVo) {

		adminDao.groupFeedDelete(groupPostVo);
	}

	//그룹댓글삭제
	@Override
	public void adminGroupDetailCmmtdelete(Model model, GroupCommentVo groupCommentVo) {
		
		adminDao.groupFeedCmmtDelete(groupCommentVo);
	}

	//그룹원목록 출력 
	@Override
	public void adminGroupMemberList(HttpServletRequest req, GroupVo groupVo) {
		
		req.setAttribute("joingroup", adminDao.adminGroupMemberList(groupVo));
	}

	//유저관리정보 출력 (전체,정지중 조건처리)
	//총회원수 값 구하기
	@Override
	public void adminUserSelectAll(Model model, PageSearchVo pageSearchVo) {
		
		pageSearchVo.setSearch("");
		
		//첫화면불러올때 페이지넘버가 0이니까 1로 맞춰줌
		if(pageSearchVo.getPage2()==0) {
			pageSearchVo.setPage2(1);
		}
		
		//첫화면불러올떄나 검색안할때 null이 들어가므로 mysql은 null하고 ""하고 값이 다르기때문에 ""로 맞춰줌
		if(pageSearchVo.getKeyword()==null) {
			pageSearchVo.setKeyword("");
		}

		//카테고리의 값에따라 정지중,전체의 값 설정
		if(pageSearchVo.getCategory()==null||pageSearchVo.getCategory().equals("")) {
			pageSearchVo.setCategory("전체");
		}else if(pageSearchVo.getCategory().equals("정지 중")){
			pageSearchVo.setSearch("2");
		}
		
		//키워드값에따라 유동적으로 검색갯수를 리턴받아서 페이지에 넣어줌
		pageSearchVo.setTotalCount2(adminDao.adminUserCount(pageSearchVo));
		
		DateCalculate cal = new DateCalculate();
		//카테고리가 전체일때, 정지중일때 뿌리는값 처리
		if(pageSearchVo.getCategory().equals("전체")) {
			
			model.addAttribute("userlist", cal.proidnumFormat(adminDao.adminUserSelectAll(pageSearchVo)));
			
		}else if(pageSearchVo.getCategory().equals("정지 중")) {
			
			model.addAttribute("userlist", cal.proidnumFormat(adminDao.adminUserStopSelectAll(pageSearchVo)));
		}
		
		
		model.addAttribute("paging", pageSearchVo);
	}

	//유저 정지처리
	@Override
	public void adminUserStop(Model model, MyAdminVo myAdminVo) {
			
		adminDao.userStop(myAdminVo);
	}

	//유저 강퇴처리
	@Override
	public void adminUserKick(Model model, MyAdminVo myAdminVo) {

		adminDao.userKick(myAdminVo);
	}

	//유저상세페이지(유저관리)
	//유저팔로잉수
	//유저팔로워수
	//유저피드수
	//유저피드출력
	//유저피드댓글출력
	@Override
	public void adminUserDetail(HttpServletRequest req, ProfileVo profileVo) {
		
		PageSearchVo page = new PageSearchVo();
		page.setPage5(1);
		profileVo.setPageSearch(page);
		
		req.setAttribute("userdetail", adminDao.userInfo(profileVo));
		req.setAttribute("userfeed", adminDao.userFeed(profileVo));
		req.setAttribute("usercmmt", adminDao.userCmmt(profileVo));
		req.setAttribute("userfeedcount", adminDao.userFeedCount(profileVo));
		req.setAttribute("userfollowing", adminDao.userFollowingCount(profileVo));
		req.setAttribute("userfollower", adminDao.userFollowerCount(profileVo));
	}

	//유저피드 스크롤 더보기 비동기
	@Override
	public List<List<?>> adminUserDetailScroll(HttpServletRequest req, ProfileVo profileVo) {
		
		List<List<?>> list = new ArrayList<>();
		list.add(adminDao.userFeed(profileVo));
		list.add(adminDao.userCmmt(profileVo));
		return list;
	}

	//유저피드댓글더보기 비동기
	@Override
	public List<MyCommentVo> adminUserDetailCmmt(Model model, MyPostVo post) {
		
		return adminDao.adminUserDetailCmmt(post);
	}

	//유저피드 삭제
	@Override
	public void adminUserDelete(Model model, MyPostVo myPostVo) {
		
		adminDao.myFeedDelete(myPostVo);
	}
	
	//유저피드댓글 삭제
	@Override
	public void adminUserCmmtdelete(Model model, MyCommentVo myCommentVo) {

		adminDao.myFeedCmmtDelete(myCommentVo);
	}

	//유저 팔로워리스트출력 
	@Override
	public void adminUserfollowerList(Model model, ProfileVo profile) {
		
		System.out.println(adminDao.adminUserfollowerList(profile));
		model.addAttribute("myfollower", adminDao.adminUserfollowerList(profile));
	}

	//유저 팔로잉리스트출력 
	@Override
	public void adminUserfollowList(Model model, ProfileVo profile) {
		
		model.addAttribute("myfollowing", adminDao.adminUserfollowList(profile));
	}

	//캠핑장정보출력
	@Override
	public void adminCampSelectAll(Model model, PageSearchVo pageSearchVo) {
		
		//첫화면불러올때 페이지넘버가 0이니까 1로 맞춰줌
		if(pageSearchVo.getPage()==0) {
			pageSearchVo.setPage(1);
		}
		
		//첫화면불러올떄나 검색안할때 null이 들어가므로 mysql은 null하고 ""하고 값이 다르기때문에 ""로 맞춰줌
		if(pageSearchVo.getKeyword()==null) {
			pageSearchVo.setKeyword("");
		}
		
		pageSearchVo.setTotalCount(adminDao.adminCampCount(pageSearchVo));
		
		model.addAttribute("campList", adminDao.adminCampSelectAll(pageSearchVo));
		model.addAttribute("paging", pageSearchVo);
	}

	//캠핑장 삭제처리 +@
	@Override
	public void adminCampDeleteOne(Model model, CampVo campVo) {
		
		adminDao.campDelete(campVo);
	}
	
	//캠핑장 공식그룹유무체크
	//해당캠핑장 그룹정보출력
	//캠핑장정보출력
	//캠핑장한줄평출력
	//캠핑장한줄평갯수출력
	@Override
	public void adminCampDetail(Model model, CampVo campVo) {
		
		//첫화면불러올때 페이지넘버가 0이니까 1로 맞춰줌
		if(campVo.getPageSearch()==null) {
			PageSearchVo search = new PageSearchVo();
			search.setPage2(1);
			campVo.setPageSearch(search);
		}
		
		int campReviewCount=adminDao.campReviewCount(campVo);
		int ventureCheck=adminDao.groupVentureCheck(campVo);
		
		//페이지 총 로우갯수 
		campVo.getPageSearch().setTotalCount2(campReviewCount);
		
		//공식그룹 존재시 그룹정보리턴
		if(ventureCheck==1) {
			model.addAttribute("venturegroup", adminDao.ventureGroup(campVo));		//공식그룹 존재시 그룹정보리턴
		}
		
		model.addAttribute("campdetail", adminDao.campInfo(campVo));				//캠핑장정보 출력
		model.addAttribute("campreview", adminDao.campReviewInfo(campVo));			//해당캠핑장 한줄평 출력
		model.addAttribute("reviewcount", campReviewCount);							//해당캠핑장 한줄평갯수 출력
		model.addAttribute("venturecheck", ventureCheck);							//해당캠핑장 공식그룹유무 출력 (0 = x, 1 = o)
		model.addAttribute("paging", campVo.getPageSearch());
	}

	//해당캠핑장한줄평 삭제
	@Override
	public void reviewDeleteOne(Model model, CampReviewVo campReviewVo) {

		adminDao.campReviewDeleteOne(campReviewVo);
	}
	
	//사업자정보출력(검색값 사업자번호,캠핑장이름 조건처리)
	@Override
	public void adminVentureSelectAll(Model model, PageSearchVo pageSearchVo) {
		
		//첫화면불러올때 페이지넘버가 0이니까 1로 맞춰줌
		if(pageSearchVo.getPage()==0) {
			pageSearchVo.setPage(1);
		}
		
		//첫화면불러올떄나 검색안할때 null이 들어가므로 mysql은 null하고 ""하고 값이 다르기때문에 ""로 맞춰줌
		if(pageSearchVo.getKeyword()==null) {
			pageSearchVo.setKeyword("");
		}
		
		//첫화면불러올떄나 검색안할때 카테고리값 기본 캠핑장명으로
		if(pageSearchVo.getCategory()==null||pageSearchVo.getCategory().equals("")) {
			pageSearchVo.setCategory("캠핑장명");
		}
		
		String category=pageSearchVo.getCategory();

		//카테고리에따라 출력리스트,페이지 토탈카운트값 출력
		if(category.equals("캠핑장명")) {
			pageSearchVo.setTotalCount(adminDao.adminVentureCount_campName(pageSearchVo));
			model.addAttribute("venture", adminDao.adminVentureSelectAll_caname(pageSearchVo));
		}else if(category.equals("사업자등록번호")) {
			pageSearchVo.setTotalCount(adminDao.adminVentureCount_ventureNumber(pageSearchVo));
			model.addAttribute("venture", adminDao.adminVentureSelectAll_mvnumber(pageSearchVo));
		}
		model.addAttribute("paging", pageSearchVo);
	}

	//사업자삭제처리 +@
	//사업자 삭제처리시 공식그룹있는사람 리턴 -> 리스트값 리턴받은것을 GroupVo에 groupList에다가 대입
	//공식그룹 존재시 일반그룹으로 업데이트
	@Transactional
	@Override
	public void adminVentureDeleteOne(Model model, MyVentureVo myVentureVo) {

		GroupVo group=new GroupVo();
		
		//공식그룹있는사람들 리턴
		group.setGroupList(adminDao.ventureGroupCheck(myVentureVo));
		
		//해당 공식그룹들 일반그룹으로 업데이트
		if(!group.getGroupList().isEmpty()) {
			adminDao.ventureGroupDelete(group);
		}
		
		//해당 사업자들 삭제
		adminDao.ventureDelete(myVentureVo);
		
	}
	
	//사업자등록증 이미지출력
	@Override
	public void AdminVentureImg(Model model, MyVentureVo myVentureVo) {
		// TODO Auto-generated method stub
		
	}

	//사업자등록정보출력(검색값 사업자번호,캠핑장이름 조건처리)
	@Override
	public void adminVentureRequestSelectAll(Model model, PageSearchVo pageSearchVo) {

		//첫화면불러올때 페이지넘버가 0이니까 1로 맞춰줌
		if(pageSearchVo.getPage()==0) {
			pageSearchVo.setPage(1);
		}
		
		//첫화면불러올떄나 검색안할때 null이 들어가므로 mysql은 null하고 ""하고 값이 다르기때문에 ""로 맞춰줌
		if(pageSearchVo.getKeyword()==null) {
			pageSearchVo.setKeyword("");
		}
		
		//첫화면불러올떄나 검색안할때 카테고리값 기본 캠핑장명으로
		if(pageSearchVo.getCategory()==null||pageSearchVo.getCategory().equals("")) {
			pageSearchVo.setCategory("캠핑장명");
		}
		
		String category=pageSearchVo.getCategory();

		//카테고리에따라 출력리스트,페이지 토탈카운트값 출력
		if(category.equals("캠핑장명")) {
			pageSearchVo.setTotalCount(adminDao.adminVentureRequestCount_campName(pageSearchVo));
			model.addAttribute("ventureRequest", adminDao.adminVentureRequestSelectAll_caname(pageSearchVo));
		}else if(category.equals("사업자등록번호")) {
			pageSearchVo.setTotalCount(adminDao.adminVentureRequestCount_ventureNumber(pageSearchVo));
			model.addAttribute("ventureRequest", adminDao.adminVentureRequestSelectAll_mvnumber(pageSearchVo));
		}
		model.addAttribute("paging", pageSearchVo);
	}

	//사업자등록승인처리 +@
	//승인대기테이블 삭제처리
	//승인 시에 그룹있는유저 그룹정보리턴 -> 리스트값 리턴받은것을 GroupVo에 groupList에다가 대입
	//그룹 존재 시에 공식그룹전환
	@Transactional
	@Override
	public void adminVentureRequestHello(Model model, UpdateWaitVo updateWaitVo) {
		
		//승인된 사람중에 그룹이 존재하면 그룹값 뽑고 공식그룹으로 업데이트
		GroupVo group=new GroupVo();
		group.setGroupList(adminDao.groupCheck(updateWaitVo));
		if(!group.getGroupList().isEmpty()) {
			adminDao.groupVentureUpdate(group);
		}
		
		//사업자등록 승인처리
		adminDao.ventureInsert(updateWaitVo);
		
		//승인된사람 승인대기테이블 삭제
		adminDao.updateDelete(updateWaitVo);
	}

	//사업자등록거절처리 +@
	@Override
	public void adminVentureRequestSorry(Model model, UpdateWaitVo updateWaitVo) {
		
		adminDao.updateDelete(updateWaitVo);
	}

	//신고관리정보출력
	@Override
	public void adminReportSelectAll(Model model, PageSearchVo pageSearchVo) {
		

		//첫화면불러올때 페이지넘버가 0이니까 1로 맞춰줌
		if(pageSearchVo==null||pageSearchVo.getPage()==0) {
			pageSearchVo.setPage(1);
		}
		
		//첫화면불러올떄나 검색안할때 카테고리값 기본 캠핑장명으로
		if(pageSearchVo==null||pageSearchVo.getCategory()==null) {
			pageSearchVo.setCategory("");
		}
		
		//첫화면불러올때나 검색안할때 셀렉트박스값 ""로 설정하고
		//셀렉트박스에서 전체/처리완료/접수 일떄 값설정
		if(pageSearchVo==null||pageSearchVo.getSearch()==null||pageSearchVo.getSearch().equals("전체")) {
			pageSearchVo.setSearch("");
		}else if(pageSearchVo.getSearch().equals("접수")) {
			pageSearchVo.setSearch("1");
		}else if(pageSearchVo.getSearch().equals("처리완료")) {
			pageSearchVo.setSearch("2");
		}
		
		pageSearchVo.setTotalCount(adminDao.adminReportCount(pageSearchVo));
		
		model.addAttribute("reportlist", adminDao.adminReportSelectAll(pageSearchVo));
		model.addAttribute("paging", pageSearchVo);
		
		System.out.println(adminDao.adminReportSelectAll(pageSearchVo));
		System.out.println(pageSearchVo);
	}
	
	//신고처리완료로 업데이트 +@
	@Override
	public void adminReportComplete(Model model, ReportListVo reportListVo) {
		
		adminDao.adminReportUpdate(reportListVo);
	}

	//신고상세페이지출력
	@Override
	public void adminReportSelectOne(Model model, ReportListVo reportListVo) {
		
		model.addAttribute("reportdetail", adminDao.adminReportSelectOne(reportListVo));
	}

	long i;		//서버킬때 한번 동작하므로 그거 막는용
	
	//정지유저 날짜카운트 -1처리 (서버 킨시간 기준으로 24시간마다 카운팅)
	@Scheduled(fixedDelay = 60000*60*24)
	public void stopUserCheck() {
		
		if(i>1) {
			List<ProfileVo> stopUser = adminDao.stopUserList();
			//정지유저가 존재할경우 실행
			if(!stopUser.isEmpty()) {
				StopUser stop = new StopUser();
				Object[] obj = null;
				obj = stop.StopUserCount(adminDao.stopUserList());
				
				//다운캐스팅으로인한 위험도를 관리안함으로 설정
				//StopUser 클래스에서 List<ProfileVo> 타입으로 Object[]에 담았기때문에 형 안정성이 보장됨
				@SuppressWarnings("unchecked")
				List<ProfileVo> stop_zero = (List<ProfileVo>) obj[0];
				@SuppressWarnings("unchecked")
				List<ProfileVo> stop_over = (List<ProfileVo>) obj[1];
				
				ProfileVo profile1 = new ProfileVo();
				ProfileVo profile2 = new ProfileVo();
				
				profile1.setProfileList(stop_zero);
				profile2.setProfileList(stop_over);
				
		
				//정지값이 0일때 정지풀기
				if(!profile1.getProfileList().isEmpty()) {
					adminDao.updateStop_zero(profile1);
				}
				
				//정지값이 1이상일때 정지값 업데이트
				if(!profile2.getProfileList().isEmpty()) {
					adminDao.updateStop_over(profile2);
				}
			}
		}
		
		i++;
	}
	
}
