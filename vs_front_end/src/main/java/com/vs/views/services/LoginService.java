package com.vs.views.services;

import javax.validation.Valid;

import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.vs.views.databeans.Identity;
import com.vs.views.databeans.LoginDataBean;

@Service
public class LoginService {
	RestTemplate restTemplate= new RestTemplate();

	public String verifyCredentials(@Valid LoginDataBean login) {
		HttpEntity<LoginDataBean> request=new HttpEntity<>(login);
		ResponseEntity<String> responseEntity=restTemplate.postForEntity("http://localhost:8080/login", request, String.class);
		return responseEntity.getBody();
	}
	
	public String verifyVoterExist(String licenseNo, String passportNo) {
		Identity identity=new Identity();
		identity.setLicenseNo(licenseNo);
		identity.setPassportNo(passportNo);
		HttpEntity<Identity> request=new HttpEntity<>(identity);
		ResponseEntity<String> responseEntity=restTemplate.postForEntity("http://localhost:8080/verify-identity", request, String.class);
		return responseEntity.getBody();
	}

}
