package com.minton.minton05;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	//popup을 띄우지 않기 위한 요청
	@RequestMapping("/popup/nopopup")
	public String noPopup(HttpServletRequest request,
			HttpServletResponse response) {
	   // isPopup 이라는 파라미터명으로 넘어오는 값이 있는지 읽어와 본다. 
	   String isPopup=request.getParameter("isPopup");
	   //만일 null 이 아니면 팝업을 띄우지 않겠다고 체크 한것이다.
	   if(isPopup != null){
	      //팝업을 일정시간 띄우지 않겠다는 정보를 쿠키에 저장한다.
	      Cookie cook=new Cookie("isPopup", isPopup);
	      cook.setMaxAge(60);//초단위
	      //응답할때 쿠키도 같이 응답한다. 
	      response.addCookie(cook);
	   }
		return "popup/nopopup";	   
	}
	
	//popup 띄우기 여부 확인
	@RequestMapping("/popup/isPopup")
	@ResponseBody
	public Map<String, Object> isPopup(HttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>();
		//쿠키 읽어오기
		Cookie[] cookies=request.getCookies();
		if(cookies != null) {
			for(Cookie tmp:cookies) {
				if(tmp.getName().equals("isPopup")) {
					map.put("isPopup", false);
				}
			}
		}
		return map;
	}
	
	//popup 요청
	@RequestMapping("/popup/popup")
	public String popup() {
		return "popup/popup";
	}
	
}






