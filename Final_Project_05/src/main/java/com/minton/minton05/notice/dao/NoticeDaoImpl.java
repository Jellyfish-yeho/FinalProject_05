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

	//글 수정용 - 공지사항 글 하나에 대한 정보를 리턴하는 메소드 : 글번호 int를 이용하여 dto 리턴
	@Override
	public NoticeDto getData(int num) {
		/*
		 * Mapper's namespace : notice
		 * sql's id : getData
		 * parameterType : int
		 * resultType : NoticeDto
		 */
		return session.selectOne("notice.getData", num);
	}

	//글 자세히보기용 - 게시글에 들어가면 조회수 1을 증가시킬 메소드 : 글번호 int 를 이용
	@Override
	public void addViewCount(int num) {
		/*
		 * Mapper's namespace : notice
		 * sql's id : addViewCount
		 * parameterType : int
		 */
		session.update("notice.addViewCount", num);
	}

	//글 자세히보기용 - 공지사항 글 하나에 대한 정보를 리턴하는 메소드 : 글번호 int를 이용하여 dto 리턴
	@Override
	public NoticeDto getData(NoticeDto dto) {
		/*
		 * Mapper's namespace : notice
		 * sql's id : getData2
		 * parameterType : NoticeDto
		 * resultType : NoticeDto
		 */
		return session.selectOne("notice.getData2", dto);
	}

	//공지사항 글 추가하는 메소드 : dto를 이용
	@Override
	public void insert(NoticeDto dto) {
		/*
		 * Mapper's namespace : notice
		 * sql's id : insert
		 * parameterType : noticeDto
		 */
		session.insert("notice.insert", dto);
	}

	//공지사항 글 수정하는 메소드 : dto
	@Override
	public void update(NoticeDto dto) {
		/*
		 * Mapper's namespace : notice
		 * sql's id : update
		 * parameterType : noticeDto
		 */
		session.update("notice.update", dto);
	}

	//공지사항 글 삭제하는 메소드 : int num 글번호
	@Override
	public void delete(int num) {
		/*
		 * Mapper's namespace : notice
		 * sql's id : delete
		 * parameterType : int
		 */	
		session.delete("notice.delete", num);
	}

	//공지사항의 가장 최신글만 리턴하는 메소드 - 자유게시판용
	@Override
	public NoticeDto getFirstData() {
		/*
		 * Mapper's namespace : notice
		 * sql's id : getFirstData
		 * parameterType : NoticeDto
		 * resultType : NoticeDto
		 */	
		return session.selectOne("notice.getFirstData");
	}

}
