package com.vs.views.databeans;

public class RegisterDataBean {

	private String licenseNoInput;
	public String getLicenseNoInput() {
		return licenseNoInput;
	}
	public void setLicenseNoInput(String licenseNoInput) {
		this.licenseNoInput = licenseNoInput;
	}
	private String passportNoInput;
	private String emailId;
	private String voterId;
	public String getVoterId() {
		return voterId;
	}
	public void setVoterId(String voterId) {
		this.voterId = voterId;
	}
	private String pass;
	private String confPass;
	
	
	
	public String getPassportNoInput() {
		return passportNoInput;
	}
	public void setPassportNoInput(String passportNoInput) {
		this.passportNoInput = passportNoInput;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getConfPass() {
		return confPass;
	}
	public void setConfPass(String confPass) {
		this.confPass = confPass;
	}
	
	
}
