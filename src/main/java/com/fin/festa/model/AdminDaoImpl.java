package com.fin.festa.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fin.festa.model.entity.AllCountVo;
import com.fin.festa.model.entity.CampReviewVo;
import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupNoticeCommentVo;
import com.fin.festa.model.entity.GroupNoticeVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.JoinGroupVo;
import com.fin.festa.model.entity.MyAdminVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyFollowerVo;
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.MyVentureVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.PreferableLocationVo;
import com.fin.festa.model.entity.ProfileVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.model.entity.UpdateWaitVo;
import com.fin.festa.model.entity.WeekCountVo;
import com.fin.festa.model.entity.WeekVo;
import com.fin.festa.util.DateCalculate;

@Repository
public class AdminDaoImpl implements AdminDao{
	
	@Autowired
	SqlSession sqlSession;

	//////////////////////////////////////////////////////////////
	/////////////////////대시보드 화면출력////////////////////////
	//////////////////////////////////////////////////////////////
	
	//대시보드 전체사용자,그룹,사업자,캠핑장수 출력
	@Override
	public AllCountVo allCount() {
		
		return sqlSession.selectOne("admin.allCount");
	}

	//대시보드 전체사용자,그룹,사업자,캠핑장수 출력 어제기준
	@Override
	public AllCountVo allCount_yesterday(String time) {
		
		return sqlSession.selectOne("admin.allCount_yesterday", time);
	}

	//대시보드 저번주 신규이용자정보 출력
	@Override
	public WeekVo lastWeekNewUser(DateCalculate cal) {
		
		return sqlSession.selectOne("admin.lastWeekNewUser", cal);
	}

	//대시보드 이번주 신규진행현황 출력
	@Override
	public WeekCountVo weekNewUserCount(DateCalculate cal) {
		
		return sqlSession.selectOne("admin.weekNewUserCount", cal);
	}

	//대시보드 전체회원의 생년월일 출력 (회원연령분포값 뽑을때 쓰임)
	@Override
	public List<ProfileVo> allUserCount() {
		
		return sqlSession.selectList("admin.allUserCount");
	}

	//대시보드 선호관심지역정보 출력
	@Override
	public List<PreferableLocationVo> preferLocation() {
		
		return sqlSession.selectList("admin.preferLocation");
	}

	//////////////////////////////////////////////////////////////
	/////////////////////////그룹관리/////////////////////////////
	//////////////////////////////////////////////////////////////

	//그룹원 수 페이지값 구하기
	@Override
	public int adminGroupCount(PageSearchVo search) {
		
		return sqlSession.selectOne("admin.adminGroupCount", search);
	}

	//그룹관리정보출력
	@Override
	public List<GroupVo> adminGroupSelectAll(PageSearchVo search) {
		
		return sqlSession.selectList("admin.adminGroupSelectAll", search);
	}

	//그룹삭제 +@
	@Override
	public int groupDelete(GroupVo group) {
		
		return sqlSession.delete("admin.groupDelete", group);
	}
	
	//그룹상세정보
	@Override
	public GroupVo groupInfo(GroupVo group) {
		
		return sqlSession.selectOne("admin.groupInfo", group);
	}

	//그룹공지사항출력
	@Override
	public List<GroupNoticeVo> groupNoticeInfo(GroupVo group) {
		
		return sqlSession.selectList("admin.groupNoticeInfo", group);
	}

	//그룹공지사항 상세페이지출력
	@Override
	public GroupNoticeVo groupNoticeDetail(GroupNoticeVo groupnotice) {
		
		return sqlSession.selectOne("admin.groupNoticeDetail", groupnotice);
	}

	//그룹공지피드 댓글더보기 비동기
	@Override
	public List<GroupNoticeCommentVo> adminGroupNoticeCmmt(GroupNoticeVo groupnotice) {
		
		return sqlSession.selectList("admin.adminGroupNoticeCmmt", groupnotice);
	}

	//그룹공지사항 댓글출력
	@Override
	public List<GroupNoticeCommentVo> groupNoticeCmmtInfo(GroupNoticeVo groupnotice) {
		
		return sqlSession.selectList("admin.groupNoticeCmmtInfo", groupnotice);
	}
	
	//그룹피드 출력
	@Override
	public List<GroupPostVo> groupFeedInfoSelectAll(GroupVo group) {
		
		return sqlSession.selectList("admin.groupFeedInfoSelectAll", group);
	}

	//그룹피드 댓글출력
	@Override
	public List<GroupCommentVo> groupFeedCmmtInfoSelectAll(GroupVo group) {
		
		return sqlSession.selectList("admin.groupFeedCmmtInfoSelectAll", group);
	}
	
	//그룹피드댓글 더보기 비동기
	@Override
	public List<GroupCommentVo> adminGroupDetailCmmt(GroupPostVo grouppost) {
		
		return sqlSession.selectList("admin.adminGroupDetailCmmt", grouppost);
	}

	
	//그룹멤버리스트 출력
	@Override
	public List<JoinGroupVo> adminGroupMemberList(GroupVo group) {
		
		return sqlSession.selectList("admin.adminGroupMemberList", group);
	}

	//그룹공지사항 삭제처리
	@Override
	public int groupNoticeDelete(GroupNoticeVo groupnotice) {
		
		return sqlSession.delete("admin.groupNoticeDelete", groupnotice);
	}

	//그룹공지사항댓글 삭제처리
	@Override
	public int groupNoticeCmmtDelete(GroupNoticeCommentVo groupnoticecmmt) {
		
		return sqlSession.delete("admin.groupNoticeCmmtDelete", groupnoticecmmt);
	}

	//그룹피드 삭제처리
	@Override
	public int groupFeedDelete(GroupPostVo grouppost) {
		
		return sqlSession.delete("admin.groupFeedDelete", grouppost);
	}

	//그룹피드 댓글삭제처리
	@Override
	public int groupFeedCmmtDelete(GroupCommentVo groupcmmt) {
		
		return sqlSession.delete("admin.groupFeedCmmtDelete", groupcmmt);
	}

	//////////////////////////////////////////////////////////////
	/////////////////////////유저관리/////////////////////////////
	//////////////////////////////////////////////////////////////
	
	//검색값 포함 총회원수 출력
	@Override
	public int adminUserCount(PageSearchVo pageSearchVo) {
		
		return sqlSession.selectOne("admin.adminUserCount", pageSearchVo);
	}
	
	//유저관리정보 전체 출력
	@Override
	public List<ProfileVo> adminUserSelectAll(PageSearchVo search) {
		
		return sqlSession.selectList("admin.adminUserSelectAll", search);
	}

	//유저관리정보 정지대상만 출력
	@Override
	public List<ProfileVo> adminUserStopSelectAll(PageSearchVo search) {
		
		return sqlSession.selectList("admin.adminUserStopSelectAll", search);
	}

	//유저 정지
	@Override
	public int userStop(MyAdminVo admin) {
		
		return sqlSession.update("admin.userStop", admin);
	}

	//유저 강퇴
	@Override
	public int userKick(MyAdminVo admin) {
		
		return sqlSession.update("admin.userKick", admin);
	}

	//////////////////////////////////////////////////////////////
	//////////////////////유저 상세페이지/////////////////////////
	//////////////////////////////////////////////////////////////
	
	//유저정보(상세페이지)
	@Override
	public ProfileVo userInfo(ProfileVo profile) {
		
		return sqlSession.selectOne("admin.userInfo", profile);
	}

	//유저피드출력
	@Override
	public List<MyPostVo> userFeed(ProfileVo profile) {
		
		return sqlSession.selectList("admin.userFeed", profile);
	}

	//유저피드 댓글출력
	@Override
	public List<MyCommentVo> userCmmt(ProfileVo profile) {
		
		return sqlSession.selectList("admin.userCmmt", profile);
	}
	
	//유저피드 댓글 더보기출력
	@Override
	public List<MyCommentVo> adminUserDetailCmmt(MyPostVo post) {
		
		return sqlSession.selectList("admin.adminUserDetailCmmt", post);
	}
	
	//유저피드갯수 출력
	@Override
	public int userFeedCount(ProfileVo profile) {
		
		return sqlSession.selectOne("admin.userFeedCount", profile);
	}

	//유저 팔로잉수 출력
	@Override
	public int userFollowingCount(ProfileVo profile) {
		
		return sqlSession.selectOne("admin.userFollowingCount", profile);
	}

	//유저 팔로워수 출력
	@Override
	public int userFollowerCount(ProfileVo profile) {
		
		return sqlSession.selectOne("admin.userFollowerCount", profile);
	}
	
	//해당유저 팔로워리스트
	@Override
	public List<MyFollowerVo> adminUserfollowerList(ProfileVo profile) {
		
		return sqlSession.selectList("admin.adminUserfollowerList", profile);
	}

	//해당유저 팔로잉리스트
	@Override
	public List<MyFollowingVo> adminUserfollowList(ProfileVo profile) {
		
		return sqlSession.selectList("admin.adminUserfollowList", profile);
	}

	//내피드 삭제
	@Override
	public int myFeedDelete(MyPostVo post) {
		
		return sqlSession.delete("admin.myFeedDelete", post);
	}
	
	//내피드댓글 삭제
	@Override
	public int myFeedCmmtDelete(MyCommentVo cmmt) {

		return sqlSession.delete("admin.myFeedCmmtDelete", cmmt);
	}

	//정지유저 리스트값 뽑아오기
	@Override
	public List<ProfileVo> stopUserList() {
		
		return sqlSession.selectList("admin.stopUserList");
	}

	//정지값이 0일때 정지풀기
	@Override
	public int updateStop_zero(ProfileVo profile) {
		
		return sqlSession.update("admin.updateStop_zero", profile);
	}

	//정지값이 1이상일때 정지값 업데이트
	@Override
	public int updateStop_over(ProfileVo profile) {
		
		return sqlSession.update("admin.updateStop_over", profile);
	}

	//////////////////////////////////////////////////////////////
	////////////////////////캠핑장관리////////////////////////////
	//////////////////////////////////////////////////////////////

	//캠핑장 페이지 토탈카운트갯수 구하는것
	@Override
	public int adminCampCount(PageSearchVo pageSearchVo) {
		
		return sqlSession.selectOne("admin.adminCampCount", pageSearchVo);
	}

	//캠핑장관리정보 출력
	@Override
	public List<CampVo> adminCampSelectAll(PageSearchVo search) {
		
		return sqlSession.selectList("admin.adminCampSelectAll", search);
	}

	//캠핑장삭제 +@
	@Override
	public int campDelete(CampVo camp) {
		
		return sqlSession.delete("admin.campDelete", camp);
	}
	
	//캠핑장정보 출력
	@Override
	public CampVo campInfo(CampVo camp) {
		
		return sqlSession.selectOne("admin.campInfo", camp);
	}
	
	//해당캠핑장 삭제처리
	@Override
	public int campDeleteOne(CampVo camp) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	//해당캠핑장 공식그룹유무 체크
	@Override
	public int groupVentureCheck(CampVo camp) {
		
		return sqlSession.selectOne("admin.groupVentureCheck", camp);
	}

	//캠핑장 한줄평출력
	@Override
	public List<CampReviewVo> campReviewInfo(CampVo camp) {
		
		return sqlSession.selectList("admin.campReviewInfo", camp);
	}

	//해당캠핑장 한줄평갯수
	@Override
	public int campReviewCount(CampVo camp) {
		
		return sqlSession.selectOne("admin.campReviewCount", camp);
	}
	
	//해당캠핑장한줄평 삭제처리
	@Override
	public int campReviewDeleteOne(CampReviewVo campreview) {
		
		return sqlSession.delete("admin.campReviewDeleteOne", campreview);
	}

	//공식그룹있을시 공식그룹정보출력
	@Override
	public GroupVo ventureGroup(CampVo camp) {
		
		return sqlSession.selectOne("admin.ventureGroup", camp);
	}
	
	//////////////////////////////////////////////////////////////
	////////////////////////사업자관리////////////////////////////
	//////////////////////////////////////////////////////////////
	
	//사업자관리정보 출력(검색값-사업자번호)
	@Override
	public List<MyAdminVo> adminVentureSelectAll_mvnumber(PageSearchVo search) {
		
		return sqlSession.selectList("admin.adminVentureSelectAll_mvnumber", search);
	}

	//사업자관리정보 출력(검색값-캠핑장이름)
	@Override
	public List<MyAdminVo> adminVentureSelectAll_caname(PageSearchVo search) {
		
		return sqlSession.selectList("admin.adminVentureSelectAll_caname", search);
	}

	//사업자관리정보 로우갯수(검색값-사업자번호)
	@Override
	public int adminVentureCount_ventureNumber(PageSearchVo pageSearchVo) {
		
		return sqlSession.selectOne("admin.adminVentureCount_ventureNumber", pageSearchVo);
	}

	//사업자관리정보 로우갯수(검색값-캠핑장이름)
	@Override
	public int adminVentureCount_campName(PageSearchVo pageSearchVo) {
		
		return sqlSession.selectOne("admin.adminVentureCount_campName", pageSearchVo);
	}
	
	//해당 사업자사진출력
	@Override
	public MyVentureVo AdminVentureImg(MyVentureVo myVentureVo) {
		// TODO Auto-generated method stub
		return null;
	}

	//사업자 삭제처리 +@
	@Override
	public int ventureDelete(MyVentureVo venture) {
		
		return sqlSession.delete("admin.ventureDelete", venture);
	}
	
	//사업자 삭제시 공식그룹 있는사람 리턴
	@Override
	public List<GroupVo> ventureGroupCheck(MyVentureVo venture) {
		
		return sqlSession.selectList("admin.ventureGroupCheck", venture);
	}

	//공식그룹 존재시 일반그룹으로 업데이트
	@Override
	public int ventureGroupDelete(GroupVo group) {
		
		return sqlSession.update("admin.ventureGroupDelete", group);
	}

	//////////////////////////////////////////////////////////////
	//////////////////////사업자등록관리//////////////////////////
	//////////////////////////////////////////////////////////////

	//사업자등록신청정보 로우갯수(캠핑장명)
	@Override
	public int adminVentureRequestCount_campName(PageSearchVo pageSearchVo) {
		
		return sqlSession.selectOne("admin.adminVentureRequestCount_campName", pageSearchVo);
	}

	//사업자등록신청정보 로우갯수(사업자번호)
	@Override
	public int adminVentureRequestCount_ventureNumber(PageSearchVo pageSearchVo) {
		
		return sqlSession.selectOne("admin.adminVentureRequestCount_ventureNumber", pageSearchVo);
	}

	//사업자등록신청정보 출력(검색값-사업자번호)
	@Override
	public List<UpdateWaitVo> adminVentureRequestSelectAll_mvnumber(PageSearchVo search) {
		
		return sqlSession.selectList("admin.adminVentureRequestSelectAll_mvnumber", search);
	}

	//사업자등록신청정보 출력(검색값-캠핑장이름)
	@Override
	public List<UpdateWaitVo> adminVentureRequestSelectAll_caname(PageSearchVo search) {
		
		return sqlSession.selectList("admin.adminVentureRequestSelectAll_caname", search);
	}

	//사업자등록승인 처리 +@
	@Override
	public void ventureInsert(UpdateWaitVo wait) {
		
		sqlSession.insert("admin.ventureInsert", wait);
	}

	//승인대기테이블 정보삭제 or 사업자등록 거절처리 +@ (둘다 쓰임)
	@Override
	public int updateDelete(UpdateWaitVo wait) {
		
		return sqlSession.delete("admin.updateDelete", wait);
	}

	//사업자등록처리 시 그룹있는 유저의 그룹정보리턴
	@Override
	public List<GroupVo> groupCheck(UpdateWaitVo wait) {
		
		return sqlSession.selectList("admin.groupCheck", wait);
	}

	//사업자등록처리 시 그룹존재하면 공식그룹으로 업데이트
	@Override
	public int groupVentureUpdate(GroupVo group) {
		
		return sqlSession.update("admin.groupVentureUpdate", group);
	}

	//////////////////////////////////////////////////////////////
	/////////////////////////신고관리/////////////////////////////
	//////////////////////////////////////////////////////////////

	//신고관리정보 로우갯수
	@Override
	public int adminReportCount(PageSearchVo search) {
		
		return sqlSession.selectOne("admin.adminReportCount", search);
	}

	//신고관리정보 출력 
	@Override
	public List<ReportListVo> adminReportSelectAll(PageSearchVo search) {
		
		return sqlSession.selectList("admin.adminReportSelectAll", search);
	}

	//신고 처리완료업데이트
	@Override
	public int adminReportUpdate(ReportListVo report) {
		
		return sqlSession.update("admin.adminReportUpdate", report);
	}

	//신고상세페이지출력
	@Override
	public ReportListVo adminReportSelectOne(ReportListVo reportListVo) {
		
		return sqlSession.selectOne("admin.adminReportSelectOne", reportListVo);
	}


}
