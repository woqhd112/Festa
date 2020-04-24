package com.fin.festa.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.LoginVo;
import com.fin.festa.model.entity.MyAdminVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyFollowerVo;
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.MyVentureVo;
import com.fin.festa.model.entity.ProfileVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.model.entity.UpdateWaitVo;

public interface UserService {

		List<MyCommentVo> userDetailCmmt(Model model,MyPostVo post);
	
		void feedInsertOne(HttpServletRequest req, MultipartFile[] files, MyPostVo myPostVo);

		void feedDeleteOne(Model model, MyPostVo myPostVo);

		void feedCmmtDeleteOne(Model model, MyCommentVo myCommentVo);

		void likeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo);

		void likeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo);
		
		void followDeleteOne(HttpServletRequest req, MyFollowingVo myFollowingVo);
		
		void myProfile(HttpServletRequest req, ProfileVo profileVo);
		
		void myAdmin(Model model, ProfileVo prifileVo);
		
		int myAdminCheck(Model model, LoginVo loginVo);
		
		void myAdminUpdateOne(HttpServletRequest req, ProfileVo profileVo);
		
		void ventureInsertOne(HttpServletRequest req, MultipartFile[] files, UpdateWaitVo updateWaitVo);

		void ventureAdmin(HttpServletRequest req);
		
		void ventureAdminUpdateOne(HttpServletRequest req, MyVentureVo myVenture);
		
		void campAdmin(HttpServletRequest req);

		void feedCmmtInsertOne(HttpServletRequest req, MyCommentVo myCommentVo);

		void myFeedDetail(Model model, MyPostVo myPostVo);

		void feedUpdateOne(HttpServletRequest req, MultipartFile[] filess, MyPostVo myPostVo);

		void feedSelectOne(HttpServletRequest req, ProfileVo profile);

		void followerList(HttpServletRequest req, ProfileVo profile);

		void followList(HttpServletRequest req, ProfileVo profile);

		int myProfileUpdateOne(HttpServletRequest req, MultipartFile[] files, ProfileVo profileVo);

		void campUpdateOne(HttpServletRequest req, MultipartFile[] files, CampVo campVo);

		GroupVo groupInsertOne(HttpServletRequest req, MultipartFile[] files, GroupVo groupVo);

		CampVo campInsertOne(HttpServletRequest req, MultipartFile[] files, CampVo campVo);

		void followInsertOne(HttpServletRequest req, MyFollowingVo myFollowingVo);

		void userReport(HttpServletRequest req, MultipartFile[] files, ReportListVo reportListVo);

		void feedReport(HttpServletRequest req, MultipartFile[] files, ReportListVo reportListVo);

		int isFollow(HttpServletRequest req, MyFollowerVo myFollowerVo);

		int myAdminInactive(HttpServletRequest req, HttpServletResponse resp, MyAdminVo myAdminVo);

		int myAdminGoodbye(HttpServletRequest req, HttpServletResponse resp, ProfileVo profileVo);
}
