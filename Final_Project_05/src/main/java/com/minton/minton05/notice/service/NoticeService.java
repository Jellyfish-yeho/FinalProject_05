package com.minton.minton05.notice.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.minton.minton05.notice.dto.NoticeDto;

public interface NoticeService {
	//공지사항 목록을 가져오는 메소드 - request 영역에 저장 
	public void getList(HttpServletRequest request);
	public List<NoticeDto> getList2(HttpServletRequest request);
	
	//공지사항 글 1개에 대한 정보를 가져오는 메소드 - request 영역에 저장
	public void getData(HttpServletRequest request); 
	
	//공지사항 글 1개 추가하는 메소드 
	public void saveContent(NoticeDto dto);
	
	//공지사항 글 수정을 위해 글정보 불러오는 메소드 - 글 번호로 글정보 가져와서 request에 저장
	public void getUpdateData(HttpServletRequest request, int num);
	
	//공지사항 글 수정하는 메소드 - 해당글로 갈 수 있도록 글번호를 request에 저장
	public void updateContent(HttpServletRequest request, NoticeDto dto);
	
	//공지사항 글 삭제하는 메소드
	public void deleteContent(int num);
}
