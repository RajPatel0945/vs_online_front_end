package com.vs.views.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.vs.views.databeans.Identity;
import com.vs.views.databeans.LoginDataBean;
import com.vs.views.databeans.RegisterDataBean;

@Service
public class LoginService {
	@Value("${com.back.end.service.url}")
	private String backEndServiceUrl;
	
	RestTemplate restTemplate= new RestTemplate();

	public Map<String,Object> verifyCredentials(@Valid LoginDataBean login) {
		Map<String,Object> responseBody=restTemplate.exchange(backEndServiceUrl+"/login?emailId={emailId}&pass={pass}", HttpMethod.GET, null, HashMap.class,login.getEmailId(),login.getPassword()).getBody();
		return responseBody;
	}
	
	public Map<String,Object> verifyVoterExist(String licenseNo, String passportNo) {
		Map<String,Object> responseBody=restTemplate.exchange(backEndServiceUrl+"/verify-identity?licenseNo={licenseNo}&passportNo={passportNo}", HttpMethod.GET, null, HashMap.class,licenseNo,passportNo).getBody();
		return responseBody;
	}

	public Map<String,Object> registerUser(@Valid RegisterDataBean register) {
		Map<String,Object> responseBody=restTemplate.exchange(backEndServiceUrl+"/register-user?voterId={voterId}&emailId={emailId}&pass={pass}&confirmPass={confirmPass}", HttpMethod.GET, null, HashMap.class,register.getVoterId(),register.getEmailId(),register.getPass(),register.getConfPass()).getBody();
		return responseBody;
	}

	public  List<Map<String,Object>> getElectionDtls(int voterId) {
		List<Map<String,Object>> result=restTemplate.exchange(backEndServiceUrl+"/get-election-dtls?voterId={voterId}", HttpMethod.GET,null,ArrayList.class,voterId).getBody();
		return result;
	}

	public List<Map<String, Object>> getCandidateDtls(int voterId) {
		List<Map<String,Object>> result=restTemplate.exchange(backEndServiceUrl+"/get-candidate-dtls?voterId={voterId}", HttpMethod.GET,null,ArrayList.class,voterId).getBody();
		return result;
	}

	public Map<String, Object> saveBallot(String jsonData, String voterId) {
		Map<String,Object> responseBody=restTemplate.exchange(backEndServiceUrl+"/save-ballot?vote={jsonData}&voterId={voterId}", HttpMethod.GET, null, HashMap.class,jsonData,voterId).getBody();
		return responseBody;
	}
	

}
