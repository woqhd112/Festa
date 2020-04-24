package com.fin.festa.model.entity;

import java.sql.Date;

public class GroupChatVo {		//채팅

	private int grnum;			//그룹번호
	private int pronum;			//회원번호
	private int joinstatus;		//접속상태
	private ProfileVo profile;
	private String mymsg;		//내 메세지
	private Date msgdate;		//메세지등록일
	
	public GroupChatVo() {
		// TODO Auto-generated constructor stub
	}

	public int getGrnum() {
		return grnum;
	}

	public void setGrnum(int grnum) {
		this.grnum = grnum;
	}

	public int getPronum() {
		return pronum;
	}

	public void setPronum(int pronum) {
		this.pronum = pronum;
	}

	public int getJoinstatus() {
		return joinstatus;
	}

	public void setJoinstatus(int joinstatus) {
		this.joinstatus = joinstatus;
	}

	public String getMymsg() {
		return mymsg;
	}

	public void setMymsg(String mymsg) {
		this.mymsg = mymsg;
	}

	public Date getMsgdate() {
		return msgdate;
	}

	public void setMsgdate(Date msgdate) {
		this.msgdate = msgdate;
	}

	public ProfileVo getProfile() {
		return profile;
	}

	public void setProfile(ProfileVo profile) {
		this.profile = profile;
	}

	@Override
	public String toString() {
		return "GroupChatVo [grnum=" + grnum + ", pronum=" + pronum + ", joinstatus=" + joinstatus + ", mymsg=" + mymsg
				+ ", msgdate=" + msgdate + ", profile=" + profile + "]";
	}

	public GroupChatVo(int grnum, int pronum, int joinstatus, String mymsg, Date msgdate, ProfileVo profile) {
		super();
		this.grnum = grnum;
		this.pronum = pronum;
		this.joinstatus = joinstatus;
		this.mymsg = mymsg;
		this.msgdate = msgdate;
		this.profile = profile;
	}
	
	
	
}
