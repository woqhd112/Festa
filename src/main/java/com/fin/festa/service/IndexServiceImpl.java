package com.fin.festa.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.fin.festa.model.IndexDaoImpl;
import com.fin.festa.model.entity.ProfileVo;

@Service
public class IndexServiceImpl implements IndexService{

	//등록,수정,삭제가 최소2개이상 들어가는 메소드는 꼭 트랜잭션 적용할것!!
	
	@Autowired
	IndexDaoImpl indexDao;
	
	//메인화면출력 인원수많은순 그룹리스트-비로그인
	//가입하지않은 선호지역기반 그룹리스트-로그인 출력 
	//좋아요많은순 캠핑장리스트 출력
	@Override
	public void index(HttpServletRequest req) {
		
		//로그인상태일때 가입하지않는 그룹중 내 선호지역기반 출력
		if(req.getSession().getAttribute("login")!=null) {
			req.setAttribute("grouplist", indexDao.addrGroupSelectAll((ProfileVo)req.getSession().getAttribute("login")));
		//로그인상태가아닐때 가입인원많은 그룹 출력
		}else {
			req.setAttribute("grouplist", indexDao.totalGroupSelectAll());
		}
		req.setAttribute("camplist", indexDao.veryHotCampSelectAll());
	}


}
