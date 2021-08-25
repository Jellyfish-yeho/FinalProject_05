package com.minton.minton05.main.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
//		
//		//navbar : thisPage 파라미터 명으로 전달되는 문자열 읽어와서 request에 저장
//		@RequestMapping("/*")
//		public String getThisPage(HttpServletRequest request) {
//			String thisPage=request.getParameter("thisPage");
//			request.setAttribute("thisPage", thisPage);
//			return "*";
//		}
//		
//		//navbar : 로그인된 아이디 읽어와서 request에 저장
//		@RequestMapping("/*")
//		public String getId(HttpServletRequest request) {
//			String id=(String)request.getSession().getAttribute("id");
//			//id가 null이 아니면 db에서 가입정보 얻어오기
//			//
//			return "*";
//		}
//		
//		//navbar : url 값을 읽어와서 넘어오는 값이 없으면 index로 이동
//		@RequestMapping("/*")
//		public String getUrl(HttpServletRequest request) {
//			String url=request.getParameter("url");
//			if(url==null) {
//				String cPath=request.getContextPath();
//				url=cPath+"/home.do";
//			}
//			request.setAttribute("url", url);
//			return "*";
//		}
		
		//home : main page 요청 시 notice list 불러오기
		
}
