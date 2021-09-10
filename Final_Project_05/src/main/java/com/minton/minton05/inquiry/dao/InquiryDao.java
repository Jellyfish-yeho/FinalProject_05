package com.minton.minton05.inquiry.dao;

import java.util.List;

import com.minton.minton05.inquiry.dto.InquiryDto;

public interface InquiryDao {
	//문의글 목록
	public List<InquiryDto> getList(InquiryDto dto);
	
	//문의글 추가
	public void insert(InquiryDto dto);
	
	//문의글 정보 
	public InquiryDto getData(int num);
	
	//해결 표시
	public void update(int num);
	
	//글 총 개수
	public int getCount();
}
