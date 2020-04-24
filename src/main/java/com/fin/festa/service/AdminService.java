package com.fin.festa.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

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

public interface AdminService {
	
		void adminDashBoard(Model model);
		
		void adminGroupSelectAll(Model model, PageSearchVo pageSearchVo);

		void adminGroupDeleteOne(Model model, GroupVo groupVo);
		
		void adminGroupDetail(Model model, GroupVo groupVo);
		
		List<List<?>> adminGroupDetailScroll(Model model, GroupVo groupVo);
		
		void adminGroupDetailNotice(Model model, GroupNoticeVo grroupnoticeVo);
		
		void adminGroupDetailNoticeDelete(Model model, GroupNoticeVo groupNoticeVo);
		
		void adminGroupDetailNoticeCmmtDelete(Model model, GroupNoticeCommentVo groupNoticeCommentVo);
		
		void adminGroupDetailDelete(Model model, GroupPostVo groupPostVo);
		
		void adminGroupDetailCmmtdelete(Model model, GroupCommentVo groupCommentVo);
		
		void adminGroupMemberList(HttpServletRequest req, GroupVo groupVo);
		
		void adminUserSelectAll(Model model, PageSearchVo pageSearchVo);
		
		void adminUserStop(Model model, MyAdminVo myAdminVo);
		
		void adminUserKick(Model model, MyAdminVo myAdminVo);
		
		void adminUserDetail(HttpServletRequest req, ProfileVo profileVo);
		
		List<List<?>> adminUserDetailScroll(HttpServletRequest req, ProfileVo profileVo);
		
		void adminUserDelete(Model model, MyPostVo myPostVo);
		
		void adminUserCmmtdelete(Model model, MyCommentVo myCommentVo);
		
		void adminUserfollowerList(Model model, ProfileVo profile);
		
		void adminUserfollowList(Model model, ProfileVo profile);
		
		void adminCampSelectAll(Model model, PageSearchVo pageSearchVo);
		
		void adminCampDeleteOne(Model model, CampVo campVo);
		
		void adminCampDetail(Model model, CampVo campVo);
		
		void reviewDeleteOne(Model model, CampReviewVo campReviewVo);
		
		void adminVentureSelectAll(Model model, PageSearchVo pageSearchVo);
		
		void adminVentureDeleteOne(Model model, MyVentureVo myVentureVo);
		
		void adminVentureRequestSelectAll(Model model, PageSearchVo pageSearchVo);
		
		void adminVentureRequestHello(Model model, UpdateWaitVo updateWaitVo);
		
		void adminVentureRequestSorry(Model model, UpdateWaitVo updateWaitVo);
		
		void adminReportSelectAll(Model model, PageSearchVo pageSearchVo);
		
		void adminReportComplete(Model model, ReportListVo reportListVo);
		
		void AdminVentureImg(Model model, MyVentureVo myVentureVo);
		
		void adminReportSelectOne(Model model, ReportListVo reportListVo);
		
		List<MyCommentVo> adminUserDetailCmmt(Model model, MyPostVo post);
		
		List<GroupCommentVo> adminGroupDetailCmmt(Model model, GroupPostVo grouppost);
		
		List<GroupNoticeCommentVo> adminGroupNoticeCmmt(Model model, GroupNoticeVo groupnotice);
		
		public void stopUserCheck();
}
