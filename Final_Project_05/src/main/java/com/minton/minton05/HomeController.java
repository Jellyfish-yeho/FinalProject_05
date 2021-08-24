package com.minton.minton05;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	
	//home 이동 요청
	@RequestMapping({"/","/home"})
	public String home() {
		return "home";
	}
	
	//FAQ 이동 요청 
	@RequestMapping("/faq/faq")
	public String faq() {
		return "faq/faq";
	}
	
	//aboutClub 이동 요청 
	@RequestMapping("/info/aboutClub")
	public String aboutClub() {
		return "info/aboutClub";
	}
	
}
