package com.fin.festa.model.entity;

public class SocialGoogle {
	private String client_Id;
	private String client_Secret;
	
	public SocialGoogle(String client_Id,String client_Secret) {
		this.client_Id = client_Id;
		this.client_Secret = client_Secret;
	}
	
	public String getClientId() {
		return client_Id;
	}
	
	public String getClientSecret() {
		return client_Secret;
	}
}
