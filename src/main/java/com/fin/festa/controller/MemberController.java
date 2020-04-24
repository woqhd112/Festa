package com.fin.festa.controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleOAuth2Template;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fin.festa.model.entity.LoginVo;
import com.fin.festa.model.entity.ProfileVo;
import com.fin.festa.model.entity.SocialGoogle;
import com.fin.festa.service.MemberService;

@Controller
@RequestMapping("/member/")
public class MemberController {

//////////////////////////////////////////////////////////////////////
//////////////////////////////�α��� ����//////////////////////////////
//////////////////////////////////////////////////////////////////////

	@Inject
	private SocialGoogle authInfo;
	
	@Autowired
	private GoogleOAuth2Template googleOAuth2Template;
	
	//@Autowired
	//private googleOAuth2Parameters OAuth2Parameters;
	
	@Autowired
	private MemberService memberService;

	// 로그인 화면 (팝업)
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login() {
		return "member/login";
	}

	// 로그인 처리
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public @ResponseBody ProfileVo login(HttpServletRequest req, HttpServletResponse resp,LoginVo loginVo) {
		ProfileVo profile = memberService.login(req, resp,loginVo);
		
		return profile;
	}
	
	//정지
	@RequestMapping(value = "stop", method = RequestMethod.GET)
	public String stop(Model model,ProfileVo profile) {
		memberService.isStop(model, profile);
		return "member/stop";
	}
	
	//추방
	@RequestMapping(value = "kick", method = RequestMethod.GET)
	public String kick(Model model, ProfileVo profile) {
		memberService.isKick(model, profile);
		return "member/kick";
	}

	// 로그아웃 (팝업)
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout() {
		return "member/logout";
	}

	// 로그아웃 (팝업>팝업 내 기능)
	@RequestMapping(value = "logout", method = RequestMethod.POST)
	public String logout(HttpServletRequest req,HttpServletResponse resp) {
		memberService.logout(req,resp);
		
		return "index";
	}

	// 회원가입 화면
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public String memberInsertOne() {
		return "member/join";
	}
	
	// 소셜회원가입 화면
	@RequestMapping(value = "socialJoin", method = RequestMethod.GET)
	@ResponseBody
	public ProfileVo socialMemberInsertOne(HttpServletRequest req,HttpServletResponse resp, LoginVo loginVo) {
		loginVo.setPw("123123123a");
		System.out.println(loginVo);
		ProfileVo profile = memberService.login(req, resp, loginVo);
		System.out.println("프로필!!!!!! : "+profile);
		return profile;
	}

	// ID중복체크
	@RequestMapping(value = "join/idcheck", method = RequestMethod.POST)
	@ResponseBody
	public int idCheck(Model model, LoginVo loginVo) {
		int result = memberService.idCheck(model, loginVo);
		return result;
	}

	// 회원가입 성공
	@RequestMapping(value = "join", method = RequestMethod.POST)
	public String memberInsertOne(Model model, ProfileVo profileVo) {
		System.out.println(profileVo);
		memberService.memberInsertOne(model, profileVo);
		return "member/success";
	}

	/*
	 * // ȸ������ ����
	 * 
	 * @RequestMapping(value = "success", method = RequestMethod.POST) public String
	 * memberInsertSuccess() { return "member/success"; }
	 */

	// ID찾기 화면 (팝업)
	@RequestMapping(value = "find_id", method = RequestMethod.GET)
	public String findId() {
		return "member/find_id";
	}

	// ID찾기 처리 (팝업>팝업 내 기능)
	@RequestMapping(value = "find_id", method = RequestMethod.POST)
	@ResponseBody
	public ProfileVo findId(Model model, LoginVo loginVo) {
		ProfileVo profile =  memberService.findId(model, loginVo);
		
		return profile;
	}

	// PW찾기 화면 (팝업)
	@RequestMapping(value = "find_pw", method = RequestMethod.GET)
	public String findPw() {
		return "member/find_pw";
	}
	
	//이메일인증
	@RequestMapping(value="emailCheck",method=RequestMethod.POST)
	@ResponseBody
	public ProfileVo emailCheck(HttpServletRequest req,HttpServletResponse resp,LoginVo loginVo) throws IOException {
		System.out.println("여기요~~");
		System.out.println("loginVo : "+loginVo);
		ProfileVo profile = memberService.emailCheck(req,resp, loginVo);
		return profile;
	}
	
	// PW찾기 처리 (팝업>팝업 내 기능)
	@RequestMapping(value = "find_pw", method = RequestMethod.POST)
	@ResponseBody
	public ProfileVo findPw(Model model, LoginVo loginVo) {
		ProfileVo profile =  memberService.findPw(model, loginVo);
		return profile;
	}
	
	@RequestMapping(value="dice",method=RequestMethod.POST)	
	@ResponseBody
	public int dice() {
		int dice = memberService.dice();
		return dice;
	}
	
	// PW 변경
	@RequestMapping(value="update_pw", method= RequestMethod.POST)
	public String updatePw(Model model,ProfileVo profile) {
		memberService.updatePw(model, profile);
		return "index";
	}
	
//	//구글 소셜로그인
//	@RequestMapping(value="google", method = { RequestMethod.GET, RequestMethod.POST })
//	public String googleCallback(HttpServletResponse resp,Model model) { 
//		String url = googleOAuth2Template.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
//		model.addAttribute("google_url", url);
//		return "member/login";
//	}
	
	//로그인유지
		@RequestMapping(value = "loginCookie", method = RequestMethod.POST)
		public @ResponseBody ProfileVo loginCookie(HttpServletRequest req, HttpServletResponse resp, LoginVo loginVo) {
			
			return memberService.loginCookie(req, resp, loginVo);
		}

	 //세션체크
	@RequestMapping(value = "loginSession", method = RequestMethod.POST)
	public @ResponseBody ProfileVo loginSession(HttpServletRequest req,HttpSession session) {
	         
	   return (ProfileVo) session.getAttribute("login");
	}
}
