package com.minton.minton05.notice.service;

import javax.servlet.http.HttpServletRequest;

import com.minton.minton05.notice.dto.NoticeDto;

public interface NoticeService {
	//공지사항 목록을 가져오는 메소드 - request 영역에 저장 
	public void getList(HttpServletRequest request);
	
	//공지사항 글 1개에 대한 정보를 가져오는 메소드 - request 영역에 저장
	public void getData(HttpServletRequest request); 
	
	//공지사항 글 1개 추가하는 메소드 
	public void saveContent(NoticeDto dto);
}
