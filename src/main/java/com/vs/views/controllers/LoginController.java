package com.vs.views.controllers;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.vs.views.databeans.CandidateDataBean;
import com.vs.views.databeans.ElectionListDataBean;
import com.vs.views.databeans.Identity;
import com.vs.views.databeans.LoginDataBean;
import com.vs.views.databeans.RegisterDataBean;
import com.vs.views.services.LoginService;

@Controller
public class LoginController {
	
	@Autowired LoginService loginService;

	
	@GetMapping("login")
	public ModelAndView getLogin() {
		return new ModelAndView("login","login",new LoginDataBean());
	}
	
	@PostMapping("login")
	public String submitLogin(@Valid @ModelAttribute("login") LoginDataBean login, BindingResult result, 
			ModelMap modelMap,RedirectAttributes redirectAttrs,HttpServletResponse response) {
		Map<String,Object> status=loginService.verifyCredentials(login);
		if(status.get("status").equals("200")) {
			 redirectAttrs.addFlashAttribute("error", "You are successfully Logged in.");
			 System.out.println("status.get(\"voterId\").toString():"+status.get("voterId").toString());
			 Cookie cookie = new Cookie("voterId", status.get("voterId").toString());
			 response.addCookie(cookie);
			 return "redirect:/election-list";
		}else {
			modelMap.addAttribute("emailId", login.getEmailId());
	        modelMap.addAttribute("password", login.getPassword());
	        redirectAttrs.addFlashAttribute("error", "Email Id or password not matched.");
			return "redirect:/login";
		} 
	}
	
	@GetMapping("register")
	public ModelAndView getRegister() {
		return new ModelAndView("register","register",new RegisterDataBean());
	}
	
	@PostMapping("register")
	public String submitRegister(@Valid @ModelAttribute("register") RegisterDataBean register, BindingResult result, 
			ModelMap modelMap,RedirectAttributes redirectAttrs) {
		
		Map<String,Object> mapResult=loginService.registerUser(register);
		if(mapResult.get("statusCode").equals("200")) {
			 redirectAttrs.addFlashAttribute("success", "You are successfully Registered.");
			 return "redirect:/login";
		}else if(mapResult.get("statusCode").equals("203")) {
			
	        redirectAttrs.addFlashAttribute("error", "Password and confirm password is not matching.");
			return "redirect:/register";
		} else {
			 redirectAttrs.addFlashAttribute("error", "Registration process failed.");
				return "redirect:/register";
		}
	}
	
	@GetMapping(value = "verify-identity")
	@ResponseBody
	public Map<String, Object> verifyVoterExist(@RequestParam("licenseNo")String licenseNo, @RequestParam("passportNo") String passportNo) {
		return loginService.verifyVoterExist(licenseNo,passportNo);
	}
	

	@GetMapping("election-list")
	public ModelAndView getElectionList(HttpServletRequest request,RedirectAttributes redirectAttrs) {
		ElectionListDataBean electionListDataBean=new ElectionListDataBean();
		  String voterId= Arrays.stream(request.getCookies())
		            .filter(c -> c.getName().equals("voterId"))
		            .findFirst()
		            .map(Cookie::getValue)
		            .orElse(null);
		  System.out.println("voterId:"+redirectAttrs.getFlashAttributes().toString());
		List<Map<String,Object>> arrayList=loginService.getElectionDtls(Integer.parseInt(voterId));
		JsonArray jsonArray2 = new Gson().toJsonTree(arrayList).getAsJsonArray();
		electionListDataBean.setElectionList(arrayList);
		electionListDataBean.setElectionJsonArray(jsonArray2);
		return new ModelAndView("home","home",electionListDataBean);
	}
	
	
	@GetMapping("open-election")
	public ModelAndView getElection(@RequestParam("voterId") int voterId,RedirectAttributes redirectAttrs) {
		List<Map<String,Object>> candidateDtlsList=loginService.getCandidateDtls(voterId);
		if(candidateDtlsList.get(0).containsKey("Code") && candidateDtlsList.get(0).get("Code").equals("203")) {
			 redirectAttrs.addFlashAttribute("error", "Already Votted!");
			 ElectionListDataBean electionListDataBean=new ElectionListDataBean();
			 List<Map<String,Object>> arrayList=loginService.getElectionDtls(voterId);
				JsonArray jsonArray2 = new Gson().toJsonTree(arrayList).getAsJsonArray();
				electionListDataBean.setElectionList(arrayList);
				electionListDataBean.setElectionJsonArray(jsonArray2);
				return new ModelAndView("home","home",electionListDataBean);
		}
		JsonArray jsonArray2 = new Gson().toJsonTree(candidateDtlsList).getAsJsonArray();
		CandidateDataBean candidateDataBean=new CandidateDataBean();
		System.out.println(candidateDtlsList);
		candidateDataBean.setCandidateList(candidateDtlsList);
		candidateDataBean.setCandidateJsonArrayList(jsonArray2);
		candidateDataBean.setListSize(candidateDtlsList.size());
		candidateDataBean.setVoterId(voterId);
		return new ModelAndView("ballot-paper","ballotPaper",candidateDataBean);
	}
	@GetMapping(value = "submit-ballot")
	@ResponseBody
	public Map<String, Object> submitBallot(@RequestParam("json_data") String jsonData,@RequestParam("voterId") String voterId) throws ParseException {
		Map<String,Object> resultMap= loginService.saveBallot(jsonData,voterId);
		System.out.print(resultMap.toString());
		return resultMap;
	}
	
	@GetMapping("success-vote")
	public ModelAndView successVote() {
		return new ModelAndView("success-vote","success-vote",new RegisterDataBean());
	}
}
