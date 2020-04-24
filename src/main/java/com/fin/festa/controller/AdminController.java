package com.fin.festa.controller;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
import com.fin.festa.service.AdminService;

@Controller
@RequestMapping("/admin/")
public class AdminController {

//////////////////////////////////////////////////////////////////////
//////////////////////////////관리자 관련//////////////////////////////
//////////////////////////////////////////////////////////////////////

	@Autowired
	private AdminService adminService;

	//메인 대시보드
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String adminDashBoard(Model model) {
		adminService.adminDashBoard(model);
		return "admin/index";
	}
	
	//그룹 관리
	@RequestMapping(value = "group", method = RequestMethod.GET)
	public String adminGroupSelectAll(Model model, PageSearchVo pageSearchVo) {
		adminService.adminGroupSelectAll(model, pageSearchVo);
		return "admin/group/index";
	}

	//그룹 삭제 (내부팝업 기능)
	@RequestMapping(value = "group/del", method = RequestMethod.POST)
	public String adminGroupDeleteOne(Model model, GroupVo groupVo) {
		
		adminService.adminGroupDeleteOne(model, groupVo);
		return "admin/group/index";
	}
	
	//그룹 디테일 (새창)
	@RequestMapping(value = "group/detail", method = RequestMethod.GET)
	public String adminGroupDetail(Model model, GroupVo groupVo) {
		
		adminService.adminGroupDetail(model, groupVo);
		return "admin/group/detail";
	}
	
	//그룹 피드스크롤 더보기 비동기
	@RequestMapping(value = "group/detail/scroll", method = RequestMethod.GET)
	public @ResponseBody List<List<?>> adminGroupDetailScroll(Model model, GroupVo groupVo) {
		
		return adminService.adminGroupDetailScroll(model, groupVo);
	}
	
	//그룹피드댓글 더보기 비동기
	@RequestMapping(value = "group/detail/cmmt", method = RequestMethod.GET)
	public @ResponseBody List<GroupCommentVo> adminGroupDetailCmmt(Model model, GroupPostVo grouppost){
		
		return adminService.adminGroupDetailCmmt(model, grouppost);
	}
		
	//그룹 공지사항 상세 (새창>팝업)
	@RequestMapping(value = "group/detail/ntc_feed", method = RequestMethod.GET)
	public String adminGroupDetailNotice(Model model, GroupNoticeVo grroupnoticeVo) {
		
		adminService.adminGroupDetailNotice(model, grroupnoticeVo);
		return "admin/group/feed";		
	}
	
	//그룹공지피드댓글 더보기 비동기
	@RequestMapping(value = "group/detail/notice/cmmt", method = RequestMethod.GET)
	public @ResponseBody List<GroupNoticeCommentVo> adminGroupDetailCmmt(Model model, GroupNoticeVo groupNoticeVo){
		
		return adminService.adminGroupNoticeCmmt(model, groupNoticeVo);
	}
	
	//그룹 공지사항 삭제 (새창>팝업>내부팝업 기능)
	@RequestMapping(value = "group/detail/ntc_feed/del", method = RequestMethod.POST)
	public String adminGroupDetailNoticeDelete(Model model, GroupNoticeVo groupNoticeVo) {
		
		adminService.adminGroupDetailNoticeDelete(model, groupNoticeVo);
		return "admin/group/detail";
	}
	
	//그룹 공지사항 댓글삭제 (새창>팝업>내부팝업 기능)
	@RequestMapping(value = "group/detail/ntc_feed/cmmtdel", method = RequestMethod.POST)
	public String adminGroupDetailNoticeCmmtDelete(Model model, GroupNoticeCommentVo groupNoticeCommentVo) {
		
		adminService.adminGroupDetailNoticeCmmtDelete(model, groupNoticeCommentVo);
		return "admin/group/detail";
	}
	
	//그룹 피드 삭제 (새창>내부팝업 기능)
	@RequestMapping(value = "group/detail/del", method = RequestMethod.POST)
	public String adminGroupDetailDelete(Model model, GroupPostVo groupPostVo) {
		
		adminService.adminGroupDetailDelete(model, groupPostVo);
		return "admin/group/detail";
	}
	
	//그룹 피드 댓글 삭제 (새창>내부팝업 기능)
	@RequestMapping(value = "group/detail/cmmtdel", method = RequestMethod.POST)
	public String adminGroupDetailCmmtdelete(Model model, GroupCommentVo groupCommentVo) {
		
		adminService.adminGroupDetailCmmtdelete(model, groupCommentVo);
		return "admin/group/detail";
	}
	
	//그룹원 목록(새창>팝업)
	@RequestMapping(value = "group/detail/member", method = RequestMethod.GET)
	public String adminGroupMemberList(HttpServletRequest req, GroupVo groupVo){
		
		adminService.adminGroupMemberList(req, groupVo);
		return "admin/group/member";
	}
	
	//유저 관리
	@RequestMapping(value = "user", method = RequestMethod.GET)
	public String adminUserSelectAll(Model model, PageSearchVo pageSearchVo) {
		
		adminService.adminUserSelectAll(model, pageSearchVo);
		return "admin/user/index";
	}
	
	//유저 정지 (내부팝업 기능)
	@RequestMapping(value = "user/stop", method = RequestMethod.POST)
	public String adminUserStop(Model model, MyAdminVo myAdminVo) {
		
		adminService.adminUserStop(model, myAdminVo);
		return "admin/user/index";
	}
	
	//유저 추방 (내부팝업 기능)
	@RequestMapping(value = "user/kick", method = RequestMethod.POST)
	public String adminUserKick(Model model, MyAdminVo myAdminVo) {
		
		adminService.adminUserKick(model, myAdminVo);
		return "admin/user/index";
	}
	
	//유저 피드 디테일 (새창)
	@RequestMapping(value = "user/detail", method = RequestMethod.GET)
	public String adminUserDetail(HttpServletRequest req, ProfileVo profileVo) {
		
		adminService.adminUserDetail(req, profileVo);
		return "admin/user/detail";
	}
	
	//유저 피드 스크롤 더보기 비동기
	@RequestMapping(value = "user/detail/scroll", method = RequestMethod.GET)
	public @ResponseBody List<List<?>> adminUserDetailScroll(HttpServletRequest req, ProfileVo profileVo) {
		
		return adminService.adminUserDetailScroll(req, profileVo);
	}
	
	//피드댓글 더보기 비동기
	@RequestMapping(value = "user/detail/cmmt", method = RequestMethod.GET)
	public @ResponseBody List<MyCommentVo> adminUserDetailCmmt(Model model, MyPostVo post){
		
		return adminService.adminUserDetailCmmt(model, post);
	}
	
	//유저 피드 삭제 (새창>내부팝업 기능)
	@RequestMapping(value = "user/detail/del", method = RequestMethod.POST)
	public String adminUserDelete(Model model, MyPostVo myPostVo) {
		
		adminService.adminUserDelete(model, myPostVo);
		return "admin/user/detail";
	}
	
	//유저 피드 댓글 삭제 (새창>내부팝업 기능)
	@RequestMapping(value = "cmmt/del", method = RequestMethod.POST)
	public String adminUserCmmtdelete(Model model, MyCommentVo myCommentVo) {
		
		adminService.adminUserCmmtdelete(model, myCommentVo);
		return "admin/user/detail";
	}
	
	//유저 팔로워 리스트 (새창>팝업)
	@RequestMapping(value = "follower", method = RequestMethod.GET)
	public String adminUserfollowerList(Model model, ProfileVo profile){
		
		adminService.adminUserfollowerList(model, profile);
		return "admin/user/follower";
	}
	
	//유저 팔로우 리스트 (새창>팝업)
	@RequestMapping(value = "following", method = RequestMethod.GET)
	public String adminUserfollowList(Model model, ProfileVo profile){
		
		adminService.adminUserfollowList(model, profile);
		return "admin/user/following";
	}
	
	//캠핑장 관리
	@RequestMapping(value = "camp", method = RequestMethod.GET)
	public String adminCampSelectAll(Model model, PageSearchVo pageSearchVo) {
		
		adminService.adminCampSelectAll(model, pageSearchVo);
		return "admin/camp/index";
	}
	
	//캠핑장 삭제 (내부팝업 기능)
	@RequestMapping(value = "camp/del", method = RequestMethod.POST)
	public String adminCampDeleteOne(Model model, CampVo campVo){
		
		adminService.adminCampDeleteOne(model, campVo);
		return "admin/camp/index";
	}
	
	//캠핑장 디테일 (새창)
	@RequestMapping(value = "camp/detail", method = RequestMethod.GET)
	public String adminCampDetail(Model model, CampVo campVo) {
		
		adminService.adminCampDetail(model, campVo);
		return "admin/camp/detail";
	}
	
	//캠핑장 한줄평 삭제 (새창>내부팝업 기능)
	@RequestMapping(value = "camp/detail/revdel", method = RequestMethod.POST)
	public String reviewDeleteOne(Model model, CampReviewVo campReviewVo) {
		
		adminService.reviewDeleteOne(model, campReviewVo);
		return "admin/camp/detail";
	}
	
	//사업자 관리
	@RequestMapping(value = "venture", method = RequestMethod.GET)
	public String adminVentureSelectAll(Model model, PageSearchVo pageSearchVo) {
		
		adminService.adminVentureSelectAll(model, pageSearchVo);
		return "admin/venture/index";
	}
	
	//사업자 삭제 (내부팝업 기능)
	@RequestMapping(value = "venture/out", method = RequestMethod.POST)
	public String adminVentureDeleteOne(Model model, MyVentureVo myVentureVo) {
		
		adminService.adminVentureDeleteOne(model, myVentureVo);
		return "admin/venture/index";
	}
	
	//사업자등록증 이미지(내부팝업 기능)
	@RequestMapping(value ="venture/img", method = RequestMethod.POST)
	public String AdminVentureImg(Model model, MyVentureVo myVentureVo, @RequestParam("where") int where) {
		return "admin/venture/index";
		//return "admin/venture/req";
	}
	
	//사업자 신청 관리
	@RequestMapping(value = "venture/req", method = RequestMethod.GET)
	public String adminVentureRequestSelectAll(Model model, PageSearchVo pageSearchVo) {
		adminService.adminVentureRequestSelectAll(model, pageSearchVo);
		return "admin/venture/req";
	}
	
	//사업자 신청 승인 (내부팝업 기능)
	@RequestMapping(value = "venture/reqhi", method = RequestMethod.POST)
	public String adminVentureRequestHello(Model model, UpdateWaitVo updateWaitVo) {
		
		adminService.adminVentureRequestHello(model, updateWaitVo);
		return "admin/venture/req";
	}
	
	//사업자 신청 거절 (내부팝업 기능)
	@RequestMapping(value = "venture/reqbye", method = RequestMethod.POST)
	public String adminVentureRequestSorry(Model model, UpdateWaitVo updateWaitVo) {
		
		adminService.adminVentureRequestSorry(model, updateWaitVo);
		return "admin/venture/req";
	}
	
	//신고 조회
	@RequestMapping(value = "report", method = RequestMethod.GET)
	public String adminReportSelectAll(Model model, PageSearchVo pageSearchVo) {
		
		adminService.adminReportSelectAll(model, pageSearchVo);
		return "admin/report/index";
	}

	//신고 처리 (내부팝업 기능)
	@RequestMapping(value = "report/complate", method = RequestMethod.POST)
	public String adminReportComplate(Model model, ReportListVo reportListVo) {
		
		adminService.adminReportComplete(model, reportListVo);
		return "admin/report/index";
	}

	//신고 디테일 (내부팝업 기능)
	@RequestMapping(value = "report/detail", method = RequestMethod.GET)
	public String adminReportSelectOne(Model model, ReportListVo reportListVo) {
		
		adminService.adminReportSelectOne(model, reportListVo);
		return "admin/report/detail";
	}
	
	@RequestMapping(value = "camp/gl_camp", method = RequestMethod.GET)
	public String adminCampLocation() {
		
		return "admin/camp/gl_camp";
	}
}
