package com.minton.minton05.inquiry.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minton.minton05.inquiry.dao.InquiryDao;
import com.minton.minton05.inquiry.dto.InquiryDto;

@Service
public class InquiryServiceImpl implements InquiryService{
	
	@Autowired private InquiryDao dao;

	//문의글 목록
	@Override
	public List<InquiryDto> ajaxGetList(HttpServletRequest request) {
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=10;
		
		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum=1;
		//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		String strPageNum=request.getParameter("pageNum");
		//만일 페이지 번호가 파라미터로 넘어 온다면
		if(strPageNum != null){
			//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum=Integer.parseInt(strPageNum);
		}
		
		//보여줄 페이지의 시작 ROWNUM
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지의 끝 ROWNUM
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		//Dto 객체에 startRowNum 과 endRowNum 을 담는다.
		InquiryDto dto=new InquiryDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		return dao.getList(dto);
	}
	
	//문의글 자세히 보기
	@Override
	public InquiryDto ajaxGetData(HttpServletRequest request) {
		int num=Integer.parseInt(request.getParameter("num"));
		return dao.getData(num);
	}
	
	//문의글 추가
	@Override
	public Map<String, Object> ajaxInsertInquiry(InquiryDto dto, HttpServletRequest request) {
		dao.insert(dto);
		Map<String, Object> map=new HashMap<>();
		map.put("isSuccess", true);
		return map;
	}
	
	//문의글 해결 표시
	@Override
	public Map<String, Object> ajaxInquirySolved(HttpServletRequest request) {
		int num=Integer.parseInt(request.getParameter("num"));
		dao.update(num);
		Map<String, Object> map=new HashMap<>();
		map.put("isSuccess", true);
		return map;
	}
	
	//문의목록 페이징
	@Override
	public Map<String, Object> ajaxPaging(HttpServletRequest request) {
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		//한페이지에 표시할 게시글 수
		final int PAGE_ROW_COUNT=10;
		//하단에 표시할 페이지 개수
		final int PAGE_DISPLAY_COUNT=5;		
		//하단 시작 페이지 번호 
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//하단 끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		
		InquiryDto dto=new InquiryDto();
		//전체 row 개수
		int totalRow=dao.getCount();
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if(endPageNum > totalPageCount){
			endPageNum=totalPageCount; //보정해 준다. 
		}
		//json 문자열로 응답할 데이터를 Map에 담는다.
		Map<String, Object>	map=new HashMap<>();
		map.put("startPageNum", startPageNum);
		map.put("endPageNum", endPageNum);
		map.put("totalPageCount", totalPageCount);
		//Map을 리턴해주면, Map에 담긴 데이터가
		//{"startPageNum": x, "endPageNum":x, "totalPageCount":x}
		//의 json 문자열로 변환되어서 응답된다. 
		return map;
	}

}
