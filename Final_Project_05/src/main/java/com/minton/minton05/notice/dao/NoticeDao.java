package com.minton.minton05.notice.dao;

import java.util.List;

import javax.naming.NoInitialContextException;

import com.minton.minton05.notice.dto.NoticeDto;

public interface NoticeDao {
	//공지사항 목록을 리턴하는 메소드 : dto를 이용하여 List<> 를 리턴
	public List<NoticeDto> getList(NoticeDto dto);
	
	//공지사항 글 개수를 리턴하는 메소드 : dto를 이용하여 int 리턴
	public int getCount(NoticeDto dto);
	
	//글 수정용 - 공지사항 글 하나에 대한 정보를 리턴하는 메소드 : 글번호 int를 이용하여 dto 리턴
	public NoticeDto getData(int num);
	
	//글 자세히보기용 - 공지사항 글 하나에 대한 정보를 리턴하는 메소드 : 글번호 int를 이용하여 dto 리턴
	public NoticeDto getData(NoticeDto dto);
	
	//글 자세히보기용 - 게시글에 들어가면 조회수 1을 증가시킬 메소드 : 글번호 int 를 이용
	public void addViewCount(int num);
	
	//공지사항 글 추가하는 메소드 : dto를 이용
	public void insert(NoticeDto dto);
}
