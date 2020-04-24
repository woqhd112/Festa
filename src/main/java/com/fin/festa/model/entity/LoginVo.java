package com.fin.festa.model.entity;

public class LoginVo {			//로그인 관련 

	private String id;			//로그인 ID 체크
	private String pw;			//로그인 PW 체크
	private String proname;		//ID 찾기에 사용
	private String proidnum;	//PW 찾기에 사용
	
	@Override
	public String toString() {
		return "LoginVo [id=" + id + ", pw=" + pw + ", proname=" + proname + ", proidnum=" + proidnum + "]";
	}
	
	public LoginVo() {
		// TODO Auto-generated constructor stub
	}

	public LoginVo(String id, String pw, String proname, String proidnum) {
		super();
		this.id = id;
		this.pw = pw;
		this.proname = proname;
		this.proidnum = proidnum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getProname() {
		return proname;
	}

	public void setProname(String proname) {
		this.proname = proname;
	}

	public String getProidnum() {
		return proidnum;
	}

	public void setProidnum(String proidnum) {
		this.proidnum = proidnum;
	}
	
	
}
