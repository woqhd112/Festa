package com.fin.festa.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import java.util.concurrent.Future;

import javax.inject.Inject;
import javax.mail.Session;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.fin.festa.model.MemberDaoImpl;
import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.JoinGroupVo;
import com.fin.festa.model.entity.LoginVo;
import com.fin.festa.model.entity.MyAdminVo;
import com.fin.festa.model.entity.MyBookMarkVo;
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.ProfileVo;

@Service
public class MemberServiceImpl implements MemberService {

	// 등록,수정,삭제가 최소2개이상 들어가는 메소드는 꼭 트랜잭션 적용할것!!

	@Autowired
	MemberDaoImpl memberDao;
	
	int dice = 0;
//	AsyncResult<ModelAndView> asyncResult ;
	@Inject // ���񽺸� ȣ���ϱ� ���ؼ� �������� ����
	JavaMailSender mailSender;

	// 로그인처리 유무, 회원이 있을시 해당회원정보 출력 v
	// 로그인완료시 계정비활성화 활성화로 업데이트 v
	// 로그인완료시 정지,추방,관리자 계정인지 체크 v
	// 로그인완료시 해당회원의 가입그룹목록 출력 v
	// 로그인완료시 해당회원의 북마크목록 출력 v
	// 로그인완료시 추천그룹리스트 출력 v
	// 로그인완료시 추천캠핑장리스트 출력 v
	// 로그인완료시 내좋아요목록 출력 v
	// 내 팔로잉리스트 출력(세션이 값만 담아두기 다른사람프로필 접속시 팔로우 유무체크하기위함) v
	@Override
	public ProfileVo login(HttpServletRequest req,HttpServletResponse resp, LoginVo loginVo) {
		ProfileVo profile = memberDao.login(loginVo);
		if (profile.getLogincheck() != 0) {
			HttpSession session = req.getSession();
			session.setAttribute("login", profile);
			// 정지,강퇴 아니면1 해당이면 2ش��̸� 2
			MyAdminVo myAdmin = memberDao.stopAndKickMember(profile);
			if (myAdmin.getProstop() == 2) {
				// 정지회원
				profile.setProrn(1);
				session.invalidate();
			} else if (myAdmin.getProkick() == 2) {
				// 추방회원
				profile.setProrn(2);
				session.invalidate();
			} else if (myAdmin.getPropublic() == 3) {
				// 관리자
				Cookie userCookie = new Cookie("loginCookie",profile.getProid());
				userCookie.setMaxAge(60*60*24);
				userCookie.setPath("/");
				resp.addCookie(userCookie);
				
				profile.setProrn(3);
			} else {
				memberDao.inactiveUpdate(profile);
				List<JoinGroupVo> joinGroup = memberDao.myJoinGroupSelectAll(profile);
				List<MyBookMarkVo> bookMark = memberDao.myBookMarkSelectAll(profile);
				List<GroupVo> goodgroup = memberDao.goodGroupSelectAll();
				List<CampVo> goodcamp = memberDao.goodCampSelectAll();
				List<MyGoodVo> goodlist = memberDao.myGoodSelectAll(profile);
				List<MyFollowingVo> followlist = memberDao.myFollowingList(profile);

				session.setAttribute("joinGroup", joinGroup);
				session.setAttribute("bookMark", bookMark);
				session.setAttribute("goodgroup", goodgroup);
				session.setAttribute("goodcamp", goodcamp);
				session.setAttribute("goodlist", goodlist);
				session.setAttribute("followlist", followlist);

				Cookie userCookie = new Cookie("loginCookie",profile.getProid());
				userCookie.setMaxAge(60*60*24);
				userCookie.setPath("/");
				resp.addCookie(userCookie);
				
				profile.setProrn(0);
			}
		} else {
			profile.setProrn(4);
		}
		return profile;
	}

	// 해당회원 로그아웃처리
	@Override
	public void logout(HttpServletRequest req,HttpServletResponse resp) {
		HttpSession session = req.getSession();
		session.invalidate();
		Cookie[] userCookies = req.getCookies();
	    for(int i=0; i<userCookies.length; i++) {
	         userCookies[i].setMaxAge(0);
	         userCookies[i].setPath("/");
	         resp.addCookie(userCookies[i]);
	    }
	}

	// 회원가입 등록처리
	// 소셜회원가입,일반회원가입 구분
	// 회원가입 등록완료시 내관리테이블 생성
	@Override
	public void memberInsertOne(Model model, ProfileVo profileVo) {
		String proidnum = profileVo.getProidnum();
		StringBuffer sb = new StringBuffer(proidnum);
		
		sb.insert(4,"년");
		sb.insert(7, "월");
		proidnum = sb.toString();
		proidnum +="일";
		
		profileVo.setProidnum(proidnum);
		System.out.println(profileVo);
		if(profileVo.getProprovide() == 0) {
			
			
			memberDao.memberInsert_nomal(profileVo);
			profileVo = memberDao.find_pronum(profileVo);
			memberDao.myadminInsert(profileVo);
			model.addAttribute("join",profileVo);
		}else {
			memberDao.memberInsert_social(profileVo);
			profileVo = memberDao.find_pronum(profileVo);
			memberDao.myadminInsert(profileVo);
			model.addAttribute("join",profileVo);
		}

	}

	// 아이디중복체크
	@Override
	public int idCheck(Model model, LoginVo loginVo) {
		int result = memberDao.idDuplicate(loginVo);
		model.addAttribute("result",result);
		return result;
	}

	// 아이디찾기
	@Override
	public ProfileVo findId(Model model, LoginVo loginVo) {
		ProfileVo profile = null;
		if(loginVo.getProidnum().length()==8 && loginVo.getProidnum() != null) {
			StringBuffer sb = new StringBuffer(loginVo.getProidnum());
			sb.insert(4,"년");
			sb.insert(7, "월");
			String proidnum = sb.toString();
			proidnum +="일";
			loginVo.setProidnum(proidnum);
			profile = memberDao.findId(loginVo);
		}
		return profile;
	}

	//이메일 인증
	@Async
	@Override
	public ProfileVo emailCheck(HttpServletRequest req,HttpServletResponse resp,LoginVo loginVo) throws IOException{
		ProfileVo profile = null;
		if(loginVo.getProidnum().length()==8) {
			StringBuffer sb = new StringBuffer(loginVo.getProidnum());
			sb.insert(4,"년");
			sb.insert(7, "월");
			String proidnum = sb.toString();
			proidnum +="일";
			loginVo.setProidnum(proidnum);
			profile = memberDao.findPw(loginVo);
			
			Random r = new Random();
			dice = r.nextInt(4589362) + 49311; 

			String setfrom = "ekema572@gmail.com";
			String tomail = profile.getProid();
			String title = "FESTA 이메일 인증번호입니다.";
			StringBuffer sb1 = new StringBuffer();
			String content = dice+"";
			sb1.append("<!DOCTYPE html>");

			sb1.append("<html lang=\"ko\">"); 

			sb1.append("<head>");

			sb1.append("<meta charset=\"UTF-8\">");

			sb1.append("<meta http-equiv=\"Content-Type\" content=\"text/html\" />");

			sb1.append("<title>FESTA</title>");

			sb1.append("</head>");

			sb1.append("<body style=\"font-size: 15px;\">");

			sb1.append("<div id=\"wrap\" style=\"width: 720px; margin: 0 auto; padding: 30px 0 10px; border-top: 3px solid #1edeb9; border-bottom: 1px solid #dcdcdc;\">");

			sb1.append("<h1 style=\"margin: 0;\"><img src=\"https://h62j8n.github.io/images/ico/logo.png\" alt=\"FESTA\"></h1>");
			
			sb1.append("<h2 style=\"margin-top: 50px; font-size: 18px; font-weight: 500;\">이메일 인증번호 확인</h2>");
			
			sb1.append("<p>\r\n" + "안녕하세요. 페스타입니다.<br>");

			sb1.append("<b style=\"color:#1edeb9\">");
			
			sb1.append(profile.getProname());

			sb1.append("</b> 회원님, 비밀번호 변경을 위해 아래 인증번호를 입력해주세요.<br>");

			sb1.append("</p>");

			sb1.append("<p style=\"width: 300px; margin: 50px auto; border: 1px solid #ddd; background: #eee; padding: 25px; text-align: center;\">");
			
			sb1.append("<b style=\"font-size: 18px;\">"+content+"</b>"+"</p>");

			sb1.append("<p style=\"text-align: right; font-size: 13px; color: #999;\">\r\n" + 
					"		FESTA<br>\r\n" + 
					"		서울 강남구 테헤란로5길 11 YBM빌딩 2층<br>\r\n" + 
					"		02-3453-5404\r\n" + 
					"	</p>");

			sb1.append("</div>\r\n" + 
					"</body>\r\n" + 
					"</html>");

//				Properties props = new Properties();
//				props.setProperty("mail.tarnsport.protocol", "smtp");
//				props.setProperty("mail.host", "smtp.mymailserver.com");
			try {
				MimeMessage message = mailSender.createMimeMessage();
//				Session mailSession = Session.getDefaultInstance(props,null);
//				MimeMessage message = new MimeMessage(mailSession);
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

				messageHelper.setFrom(setfrom); // �����»�� �����ϸ� �����۵��� ����
				messageHelper.setTo(tomail); // �޴»�� �̸���
				messageHelper.setSubject(title); // ���������� ������ �����ϴ�
				messageHelper.setText(sb1.toString(),true); // ���� ����
				
//				message.setContent("<h1 style=\"color: red;\">hello world</h1>"+content+"<h2>hello world</h2>","text/html");
				mailSender.send(message);
			} catch (Exception e) {
				System.out.println(e);
			}

			
		}
		System.out.println("profile : "+profile);
		req.setAttribute("email",profile);
		
		return profile;
	}
	
	@Override
	public int dice() {
		System.out.println(dice);
		return dice;
	}
	
	// 비밀번호찾기
	// 비밀번호 재설정
	@Override
	public ProfileVo findPw(Model model, LoginVo loginVo) {
		ProfileVo profile = null;
		if(loginVo.getProidnum().length()==8) {
			StringBuffer sb = new StringBuffer(loginVo.getProidnum());
			sb.insert(4,"년");
			sb.insert(7, "월");
			String proidnum = sb.toString();
			proidnum +="일";
			loginVo.setProidnum(proidnum);
			profile = memberDao.findPw(loginVo);
			if(profile !=null) {
				if(profile.getProid().contentEquals(loginVo.getId()) && profile.getProidnum().equals(loginVo.getProidnum())) {
					memberDao.pwUpdate(profile);
				}
				else {
					return null;
				}
			}
		}
		return profile;
	}
	//비밀번호변경
	@Override
	public String updatePw(Model model,ProfileVo profile) {
		System.out.println(profile.getPronum());
		System.out.println(profile.getPropw());
		memberDao.pwUpdate(profile);
		return "index";
	}

	//로그인유지
		@Override
		public ProfileVo loginCookie(HttpServletRequest req, HttpServletResponse resp, LoginVo loginVo) {

			ProfileVo profile = memberDao.loginCookie(loginVo);
			loginVo.setPw(profile.getPropw());
			
			profile = memberDao.login(loginVo);
			System.out.println(profile);
			if (profile.getLogincheck() != 0) {
				HttpSession session = req.getSession();
				session.setAttribute("login", profile);
				// ����,���� �ƴϸ�1 �ش��̸� 2
				MyAdminVo myAdmin = memberDao.stopAndKickMember(profile);
				if (myAdmin.getProstop() == 2) {
					// ����ȸ��
					profile.setProrn(1);
				} else if (myAdmin.getProkick() == 2) {
					// �߹�ȸ��
					profile.setProrn(2);
				} else if (myAdmin.getPropublic() == 3) {
					// ������
					Cookie userCookie = new Cookie("loginCookie", profile.getProid());
					userCookie.setMaxAge(60*60*24);
					userCookie.setPath("/");
					resp.addCookie(userCookie);
					
					profile.setProrn(3);
				} else {
					memberDao.inactiveUpdate(profile);
					List<JoinGroupVo> joinGroup = memberDao.myJoinGroupSelectAll(profile);
					List<MyBookMarkVo> bookMark = memberDao.myBookMarkSelectAll(profile);
					List<GroupVo> goodgroup = memberDao.goodGroupSelectAll();
					List<CampVo> goodcamp = memberDao.goodCampSelectAll();
					List<MyGoodVo> goodlist = memberDao.myGoodSelectAll(profile);
					List<MyFollowingVo> followlist = memberDao.myFollowingList(profile);

					session.setAttribute("joinGroup", joinGroup);
					session.setAttribute("bookMark", bookMark);
					session.setAttribute("goodgroup", goodgroup);
					session.setAttribute("goodcamp", goodcamp);
					session.setAttribute("goodlist", goodlist);
					session.setAttribute("followlist", followlist);
					
					Cookie userCookie = new Cookie("loginCookie", profile.getProid());
					userCookie.setMaxAge(60*60*24);
					userCookie.setPath("/");
					resp.addCookie(userCookie);

					profile.setProrn(0);
					
				}
			} else {
				profile.setProrn(4);
			}
			return profile;
		}
		
		//추방
		@Override
		public void isKick(Model model,ProfileVo profile) {
			MyAdminVo myAdmin = memberDao.stopAndKickMember(profile);
			model.addAttribute("kick",myAdmin);
		}
		
		//정지
		@Override
		public void isStop(Model model,ProfileVo profile) {
			MyAdminVo myAdmin = memberDao.stopAndKickMember(profile);
			Date date = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월dd일");
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.add(Calendar.DATE, myAdmin.getStoplv());
			
			model.addAttribute("stop",myAdmin);
			
			String nalja= sf.format(cal.getTime());
			model.addAttribute("stoplv",nalja);
		}
}
