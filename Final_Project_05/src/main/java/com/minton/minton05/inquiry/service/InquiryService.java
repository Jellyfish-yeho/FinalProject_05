package com.minton.minton05.inquiry.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.minton.minton05.inquiry.dto.InquiryDto;

public interface InquiryService {
	//문의글 목록
	public List<InquiryDto> ajaxGetList(HttpServletRequest request);
	
	//문의글 자세히 보기
	public InquiryDto ajaxGetData(HttpServletRequest request);
	
	//문의글 추가
	public Map<String, Object> ajaxInsertInquiry(InquiryDto dto, HttpServletRequest request);
	
	//문의글 해결 표시
	public Map<String, Object> ajaxInquirySolved(HttpServletRequest request);
	
	//문의목록 페이징
	public Map<String, Object> ajaxPaging(HttpServletRequest request);
}
