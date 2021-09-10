package com.minton.minton05.inquiry.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.minton.minton05.inquiry.dto.InquiryDto;
import com.minton.minton05.inquiry.service.InquiryService;

@Controller
public class InquiryController {
	@Autowired InquiryService service;
	
	//문의 목록 가기
	@RequestMapping("/users/inquiryList")
	public String inquiryList() {
		return "users/inquiryList";
	}
	
	//문의 페이징 처리
	@RequestMapping("/ajax/inquiry/paging")
	@ResponseBody
	public Map<String, Object> ajaxPaging(HttpServletRequest request){
		return service.ajaxPaging(request);
	}
	
	//문의 추가
	@RequestMapping("/ajax/inquiry/insert")
	@ResponseBody
	public Map<String, Object> ajaxInquiryInsert(InquiryDto dto, HttpServletRequest request){
		return service.ajaxInsertInquiry(dto, request);
	}
	//문의 해결 표시
	@RequestMapping("/ajax/inquiry/solved")
	@ResponseBody
	public Map<String, Object> ajaxInquirySolved(HttpServletRequest request){
		return service.ajaxInquirySolved(request);
	}
	//문의 글 자세히보기
	@RequestMapping("/ajax/inquiry/detail")
	@ResponseBody
	public InquiryDto ajaxInquiryDetail(HttpServletRequest request){
		return service.ajaxGetData(request);
	}
	//문의글 목록
	@RequestMapping("/ajax/inquiry/list")
	@ResponseBody
	public List<InquiryDto> ajaxInquiryList(HttpServletRequest request){
		return service.ajaxGetList(request);
	}
	
}
