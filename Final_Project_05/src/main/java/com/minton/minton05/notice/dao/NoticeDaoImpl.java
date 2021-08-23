package com.minton.minton05.notice.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minton.minton05.notice.dto.NoticeDto;

@Repository //spring bean container로부터 bean을 생성
public class NoticeDaoImpl implements NoticeDao{

	@Autowired private SqlSession session; //mybatis를 사용하기 위한 session 객체 주입
	
	//공지사항 목록을 리턴하는 메소드 : dto를 이용하여 List<> 를 리턴
	@Override
	public List<NoticeDto> getList(NoticeDto dto) {
		/*
		 * Mapper's namespace : notice
		 * sql's id : selectList
		 * parameterType : NoticeDto
		 * resultType : NoticeDto
		 */
		return session.selectList("notice.selectList", dto);
	}

	//공지사항 글 개수를 리턴하는 메소드 : dto를 이용하여 int 리턴
	@Override
	public int getCount(NoticeDto dto) {
		/*
		 * Mapper's namespace : notice
		 * sql's id : getCount
		 * parameterType : NoticeDto
		 * resultType : int
		 */
		return session.selectOne("notice.getCount", dto);
	}

}
