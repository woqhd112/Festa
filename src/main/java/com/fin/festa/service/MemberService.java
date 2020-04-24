package com.fin.festa.service;

import java.io.IOException;
import java.util.concurrent.Future;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.fin.festa.model.entity.LoginVo;
import com.fin.festa.model.entity.ProfileVo;

public interface MemberService {
	
		void  memberInsertOne(Model model, ProfileVo profileVo);
		
		int  idCheck(Model model, LoginVo loginVo);
		 
		ProfileVo  findId(Model model, LoginVo loginVo);
		
		ProfileVo  findPw(Model model, LoginVo loginVo);

		String updatePw(Model model, ProfileVo profile);

		ProfileVo login(HttpServletRequest req, HttpServletResponse resp, LoginVo loginVo);

		void logout(HttpServletRequest req, HttpServletResponse resp);

		ProfileVo loginCookie(HttpServletRequest req, HttpServletResponse resp, LoginVo loginVo);

		void isKick(Model model, ProfileVo profile);

		void isStop(Model model, ProfileVo profile);

		ProfileVo emailCheck(HttpServletRequest req, HttpServletResponse resp, LoginVo loginVo) throws IOException;

		int dice();
}
