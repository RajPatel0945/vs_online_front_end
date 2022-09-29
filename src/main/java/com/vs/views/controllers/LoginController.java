package com.vs.views.controllers;

import javax.validation.Valid;


import org.springframework.beans.factory.annotation.Autowired;
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
			ModelMap modelMap,RedirectAttributes redirectAttrs) {
		String status=loginService.verifyCredentials(login);
		if(status.equals("200")) {
			return "home";	
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
	
	@GetMapping(value = "verify-identity")
	@ResponseBody
	public String verifyVoterExist(@RequestParam String licenseNo, @RequestParam String passportNo) {
		System.out.print(licenseNo+"::"+passportNo);
		return loginService.verifyVoterExist(licenseNo,passportNo);
	}
	
}
