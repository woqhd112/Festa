package com.fin.festa.model.entity;

public class PreferableLocationVo {		//대시보드-선호관심지역Vo

	private int addrcnt;		//선호지역 인원수
	private String proaddr;		//선호지역 명
	private int rn;				//출력로우넘버
	
	@Override
	public String toString() {
		return "PreferableLocationVo [addrcnt=" + addrcnt + ", proaddr=" + proaddr + ", rn="+rn+"]";
	}

	public PreferableLocationVo() {
		// TODO Auto-generated constructor stub
	}

	
	public int getAddrcnt() {
		return addrcnt;
	}

	public void setAddrcnt(int addrcnt) {
		this.addrcnt = addrcnt;
	}

	public String getProaddr() {
		return proaddr;
	}

	public void setProaddr(String proaddr) {
		this.proaddr = proaddr;
	}
	
	public int getRn() {
		return rn;
	}

	public void setRn(int rn) {
		this.rn = rn;
	}

	public PreferableLocationVo(int addrcnt, String proaddr, int rn) {
		super();
		this.addrcnt = addrcnt;
		this.proaddr = proaddr;
		this.rn = rn;
	}
	
	
}
