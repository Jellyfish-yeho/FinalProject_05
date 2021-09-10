package com.minton.minton05.inquiry.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minton.minton05.inquiry.dto.InquiryDto;

@Repository
public class InquiryDaoImpl implements InquiryDao{
	
	@Autowired private SqlSession session;
	
	//문의글 목록
	@Override
	public List<InquiryDto> getList(InquiryDto dto) {		
		return session.selectList("inquiry.getList", dto);
	}
	
	//문의글 추가
	@Override
	public void insert(InquiryDto dto) {
		session.insert("inquiry.insert",dto);		
	}

	//문의글 정보 
	@Override
	public InquiryDto getData(int num) {		
		return session.selectOne("inquiry.getData", num);
	}

	//해결 표시
	@Override
	public void update(int num) {
		session.update("inquiry.update", num);		
	}

	//글 총 개수
	@Override
	public int getCount() {
		return session.selectOne("inquiry.getCount");
	}

}
