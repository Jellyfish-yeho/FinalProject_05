package com.minton.minton05.notice.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.minton.minton05.notice.service.NoticeService;

@Controller
public class NoticeController {

	@Autowired private NoticeService service; //service 주입
	
	//공지사항 목록을 가져오는 메소드
	@RequestMapping("/notice/list")
	public String getList(HttpServletRequest request) {
		//service에서 request 영역에 저장한 데이터  
		service.getList(request);
		return "notice/list"; //같은 위치로 리턴
	}
	
	//공지사항 글 자세히보기
	@RequestMapping("/notice/detail")
	public String detail(HttpServletRequest request) {
		service.getData(request);
		return "notice/detail";
	}
}
