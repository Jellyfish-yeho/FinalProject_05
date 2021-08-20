package com.minton.minton05;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	
	/*
	 *  "/home.do" 요청이 왔을 때 이 메소드로 요청으로 처리하기
	 *  
	 *  .do는 생략 가능하다. 
	 */
	@RequestMapping("/home")
	public String home(HttpServletRequest request) {
		//공지사항이라고 가정하기
		List<String> notice=new ArrayList<String>();
		notice.add("너무더워");
		notice.add("더위 조심");
		notice.add("졸려...");
		notice.add("소비 주간");
		//공지사항을 request 영역에 담기
		request.setAttribute("notice", notice);
		//view 페이지(jsp페이지)로 forward 이동해서 응답
		return "home";
	}
	
	//aspect test용 메소드
	@RequestMapping("/aspect/home")
	public ModelAndView authHome(HttpServletRequest request, ModelAndView mView){
		//db에서 읽어온 공지사항이라고 가정하기
		List<String> notice=new ArrayList<String>();
		notice.add("너무더워");
		notice.add("더위 조심");
		notice.add("졸려...");
		notice.add("소비 주간");
		//공지사항을 request 영역에 담기
		request.setAttribute("notice", notice);
		mView.setViewName("home");
		return mView;
	}
	
}
