package com.minton.minton05.gallery.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.minton.minton05.gallery.dto.GalleryDto;
import com.minton.minton05.notice.dto.NoticeDto;

public interface GalleryService {
	//갤러리의 list 가져오기
	public void getList(HttpServletRequest request);
	//갤러리에 사진 upload & DB 저장하기
	public void saveImage(GalleryDto dto, HttpServletRequest request);
	//갤러리에 사진 저장하기 - ajax
	public Map<String, Object> uploadAjaxImage(GalleryDto dto, HttpServletRequest request);
	//갤러리에 사진 저장하기 - db에만 저장(upload 작업은 이미 완료)
	public void insert(GalleryDto dto, HttpServletRequest request);
	//갤러리 detail 페이지 가져오기
	public void getDetail(ModelAndView mView, int num);
	//갤러리 글 수정하기 위해 데이터 불러오기
	public void getData(HttpServletRequest request);
	//갤러리 글 수정하기
	public void updateContent(GalleryDto dto);
	//갤러리 글 삭제하기
	public void deleteContent(int num);

	//갤러리 목록을 리턴하는 메소드 
	public List<GalleryDto> getList2(HttpServletRequest request);

	
	//ajax 요청용 - 갤러리 목록을 가져오는 메소드 
	public List<GalleryDto> ajaxGetListIndex(HttpServletRequest request);

}
