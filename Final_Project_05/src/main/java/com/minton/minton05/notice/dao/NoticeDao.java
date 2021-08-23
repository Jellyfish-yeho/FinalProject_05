package com.minton.minton05.notice.dao;

import java.util.List;

import javax.naming.NoInitialContextException;

import com.minton.minton05.notice.dto.NoticeDto;

public interface NoticeDao {
	//공지사항 목록을 리턴하는 메소드 : dto를 이용하여 List<> 를 리턴
	public List<NoticeDto> getList(NoticeDto dto);
	
	//공지사항 글 개수를 리턴하는 메소드 : dto를 이용하여 int 리턴
	public int getCount(NoticeDto dto);
}
