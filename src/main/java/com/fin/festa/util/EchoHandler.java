package com.fin.festa.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fin.festa.model.GroupDaoImpl;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.ProfileVo;

//에코서버
public class EchoHandler extends TextWebSocketHandler{

	List<WebSocketSession> sessions=new ArrayList<>();
	Map<String, WebSocketSession> userSessions = new HashMap<>();
	List<Integer> grList = new ArrayList<>();
	List<GroupVo> groupList = new ArrayList<>();
	
	@Autowired
	GroupDaoImpl groupDao;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("Connect");

        //전체 세션에 기존 로그인 세션 가져와서 넣기
		Map<String, Object> httpSession = session.getAttributes();
		System.out.println(session);
		ProfileVo login = (ProfileVo) httpSession.get("login");
		
		if(login!=null) {
			//group뽑기 
			String url=session.getUri()+"a";
	        String path[]=url.split("grnum");
	        path[1]=path[1].replace("=", "");
	        path[1]=path[1].replace("a", "");
	        String roomnum=path[1];
	        int grnum=Integer.parseInt(roomnum);
			
	        //그룹번호리스트에 접속한 채팅 그룹번호가 없을경우 그룹 추가
	        if(!grList.contains(grnum)) {
	        	grList.add(grnum);
	        	GroupVo group=new GroupVo();
	        	group.setGrnum(grnum);
	        	groupList.add(group);
	        }
	        if(groupList.size()>0) {
	        	for(int i=0; i<groupList.size(); i++) {
	        		//리스트 내 그룹과 내가 들어온 그룹이같을경우
	        		if(groupList.get(i).getGrnum()==grnum) {
	        			//해당그룹에 사람이 없을경우 새로운 유저리스트 생성 (내정보 담기)
	        			if(groupList.get(i).getList()==null||groupList.get(i).getList().isEmpty()) {
	        				List<ProfileVo> userList=new ArrayList<>();
	        				userList.add(login);
	        				groupList.get(i).setList(userList);
	        			}else {	//그룹리스트에 한명이라도 사람이 존재할 경우
	        				//그룹리스트 안에 프로필리스트의 회원번호를 set으로 정렬
	        				Set<Integer> set=new HashSet<Integer>(Arrays.asList(groupList.get(i).getList().get(i).getPronum()));
	        				//set안에 내 회원번호가 존재하지 않을 시 리스트에 추가
		        			if(!set.contains(login.getPronum())) {
		        				groupList.get(i).getList().add(login);
		        			}
	        			}
	        			break;
	        		}
	        	}
	        }
	        
			String senderName=login.getProname();
			String senderId=login.getProid();
			userSessions.put(senderId, session);
	
			System.out.println(senderName+"님이 "+roomnum+"번 방 입장!!");
			
			for(int i=0; i<grList.size(); i++) {
				if(grList.get(i)==grnum) {
					for(WebSocketSession sess:userSessions.values()) {
						sess.sendMessage(new TextMessage(senderName+"("+senderId+")님이 입장하였습니다.*"+roomnum+"*"+login.getProid()+"*"+login.getProname()+"*"+login.getProphoto()+"*"+login.getPronum()));
					}
				}
			}
		}
		
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println(session+":"+message);
		String msg=message.getPayload();
		System.out.println(msg);
		//split 조건처리1
		String msg1 = msg.replaceFirst("=", "＝");
		System.out.println(msg1);
		// split 조건처리2
		String msg2 = msg1.replaceAll("[|]", "｜");
		String path[] = msg2.split("＝");
		System.out.println(path[1]);
		
		
		Map<String, Object> httpSession = session.getAttributes();
		ProfileVo login = (ProfileVo) httpSession.get("login");
		
		if(login!=null) {
			String senderId=login.getProid();
			String senderName=login.getProname();
			String senderPhoto=login.getProphoto();
			String senderNum=Integer.toString(login.getPronum());
			
			SimpleDateFormat format = new SimpleDateFormat("HH:mm");
			Date today = new Date();
			String time=format.format(today);
			System.out.println (senderId+"|"+senderName+"|"+senderPhoto+"|"+path[1]+"|"+time);
	
			for(WebSocketSession sess : userSessions.values()) {
				sess.sendMessage(new TextMessage(senderId+"|"+senderName+"|"+senderPhoto+"|"+path[1]+"|"+time+"|"+path[0]+"|"+senderNum));
			}
		}
	}
	

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("Closed");
		
		Map<String, Object> httpSession = session.getAttributes();
		ProfileVo login = (ProfileVo) httpSession.get("login");
		
		if(login!=null) {

			String url=session.getUri()+"a";
	        String path[]=url.split("grnum");
	        path[1]=path[1].replace("=", "");
	        path[1]=path[1].replace("a", "");
	        String roomnum=path[1];
	        int grnum=Integer.parseInt(roomnum);
	        
			String senderName=login.getProname();
			String senderId=login.getProid();
	
			System.out.println(senderName+"님이 "+roomnum+"번 방 퇴장!!");
			userSessions.remove(senderId, session);
			for(int i=0; i<grList.size(); i++) {
				if(grList.get(i)==grnum) {
					for(WebSocketSession sess:userSessions.values()) {
						sess.sendMessage(new TextMessage(senderName+"("+senderId+")님이 퇴장하였습니다.*"+roomnum+"*"+login.getProid()+"*"+login.getProname()+"*"+login.getProphoto()+"*"+login.getPronum()));
					}
				}
			}
			
			for(int i=0; i<groupList.size(); i++) {
				//그룹리스트와 내 채팅 그룹번호가 같을 경우
				if(groupList.get(i).getGrnum()==grnum) {
					//내 채팅그룹의 회원리스트 담기
					List<ProfileVo> list=groupList.get(i).getList();
					for(int j=0; j<list.size(); j++) {
						//회원리스트번호와 내 번호가 같을 때 회원리스트에서 내 번호 삭제
						if(list.get(j).getPronum()==login.getPronum()) {
							list.remove(j);
							groupList.get(i).setList(list);
						}
					}
					//db 상태값 변경
					groupList.get(i).setProfile(login);
					groupDao.groupChatUserUpdateRe(groupList.get(i));
					break;
				}
			}
		
			session.close();
			if(session.isOpen()) {
				session.close();
			}
		}
	}
	
	
	
}
