package com.fin.festa.model.entity;

public class AllCountVo {		//대시보드-전체이용자수Vo

	private int profile;		//전체사용자 수
	private int group1;			//전체그룹 수
	private int myventure;		//전체사업자 수
	private int camp;			//전체캠핑장 수
	
	@Override
	public String toString() {
		return "AllCountVo [profile=" + profile + ", group1=" + group1 + ", myventure=" + myventure + ", camp=" + camp
				+ "]";
	}
	
	public AllCountVo() {
		// TODO Auto-generated constructor stub
	}

	public AllCountVo(int profile, int group1, int myventure, int camp) {
		super();
		this.profile = profile;
		this.group1 = group1;
		this.myventure = myventure;
		this.camp = camp;
	}

	public int getProfile() {
		return profile;
	}

	public void setProfile(int profile) {
		this.profile = profile;
	}

	public int getGroup1() {
		return group1;
	}

	public void setGroup1(int group1) {
		this.group1 = group1;
	}

	public int getMyventure() {
		return myventure;
	}

	public void setMyventure(int myventure) {
		this.myventure = myventure;
	}

	public int getCamp() {
		return camp;
	}

	public void setCamp(int camp) {
		this.camp = camp;
	}
	
}
