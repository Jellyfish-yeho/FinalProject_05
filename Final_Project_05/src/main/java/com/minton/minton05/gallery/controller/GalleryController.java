package com.minton.minton05.gallery.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.minton.minton05.gallery.dao.GalleryDao;
import com.minton.minton05.gallery.dto.GalleryDto;
import com.minton.minton05.gallery.service.GalleryService;
import com.minton.minton05.like.dto.LikeDto;

@Controller
public class GalleryController {
	
	@Autowired
	private GalleryService service;
	@Autowired
	private GalleryDao dao;
	
	//갤러리 목록을 가져오는 메소드 - index용
	@RequestMapping("/ajax/gallery/listIndex")
	@ResponseBody 
	public List<GalleryDto> ajaxGetListIndex(HttpServletRequest request) {		
		return service.ajaxGetListIndex(request);
	}
	
	//갤러리 아이템 자세히보기를 가져오는 메소드 (이전페이지/다음페이지)
	@RequestMapping("/ajax/gallery/getDetail")
	@ResponseBody 
	public GalleryDto ajaxGetDetail(HttpServletRequest request) {		
		return service.ajaxGetDetail(request);
	}
	
	//ajax 요청에 대해 Gallery 하단 페이징 처리에 필요한 데이터 리턴하는 메소드
	@RequestMapping("/api/gallery/paging")
	@ResponseBody
	public Map<String, Object> paging(@RequestParam int pageNum){
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=9;
		//하단 페이지를 몇개씩 표시할 것인지
		final int PAGE_DISPLAY_COUNT=5;
		//하단 시작 페이지 번호 
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT) * PAGE_DISPLAY_COUNT;
		//하단 끝 페이지 번호
		int endPageNum = startPageNum + PAGE_DISPLAY_COUNT - 1;
		//전체 row 의 갯수
		int totalRow = dao.getCount();
		//전체 페이지의 갯수 구하기
		int totalPageCount = (int)Math.ceil(totalRow / (double)PAGE_ROW_COUNT);
		//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if(endPageNum > totalPageCount){
			endPageNum = totalPageCount; //보정해 준다. 
		}
		//json 문자열로 응답할 데이터를 일단 Map 에 담는다.
		Map<String, Object> map=new HashMap<>();
		map.put("startPageNum", startPageNum);
		map.put("endPageNum", endPageNum);
		map.put("totalPageCount", totalPageCount);
		// Map 을 리턴해주면 Map 에 담긴 데이터가 
		// {"startPageNum": x, "endPageNum":x, "totalPageCount":x} 의 json 문자열로 
		// 변환되어서 응답된다. 
		return map;
	}
	
	//gallery list 페이지로 이동
	@RequestMapping(value = "/gallery/list")
	public String getList(HttpServletRequest request) {
		//view 페이지에 사용될 데이터는 request 영역에 담는다.
		service.getList(request);
		return "gallery/list";
	}
	
	//gallery 사진 업로드 form - ajax form
	@RequestMapping(value = "/gallery/ajax_form")
	public ModelAndView authAjaxForm(HttpServletRequest request) {
		return new ModelAndView("gallery/ajax_form");
	}

	//gallery 사진 업로드 - ajax / json 으로 return 
	@RequestMapping(value = "/gallery/ajax_upload")
	@ResponseBody
	public Map<String, Object> authAjaxUpload(GalleryDto dto, HttpServletRequest request){		
		//form 에서 dto 로 데이터 받아옴
		//dto : MultipartFile image 를 가지고 있다.
		//request : imagePath 만드는데 사용, session 영역의 id 가져오는데 사용
		//return : { "imagePath" : "/upload/123456img_name.png" } 형식의 JSON 응답
		return service.uploadAjaxImage(dto, request);
	}
	
	
	//ajax 요청에 대해 Gallery 목록을 출력할 컨트롤러 메소드  -vue페이지 용
	@RequestMapping("/api/gallery/list")
	@ResponseBody 
	public List<GalleryDto> getList2(HttpServletRequest request){
		return service.getList2(request);
	}
	
	//gallery 사진 업로드 - ajax -vue페이지용
	//json 으로 return 할 것
	@RequestMapping(value = "/gallery/ajax_upload2")
	@ResponseBody
	public Map<String, Object> testAjaxUpload2(GalleryDto dto, HttpServletRequest request){		
		//form 에서 dto 로 데이터 받아옴
		//dto : MultipartFile image 를 가지고 있다.
		//request : imagePath 만드는데 사용, session 영역의 id 가져오는데 사용
		//return : { "imagePath" : "/upload/123456img_name.png" } 형식의 JSON 응답
		return service.uploadAjaxImage(dto, request);
	}	
	
	//imagePath 구성 X -> dto 로 imagePath 를 받아서 DB 에 저장하기
	@RequestMapping(value = "/gallery/insert")
	public ModelAndView authInsert(GalleryDto dto, HttpServletRequest request, ModelAndView mView) {
		//dto : caption, imagePath 가지고 있다.
		//request : dto 에 writer(id) 추가
		service.insert(dto, request);
		return new ModelAndView("gallery/upload");
	}
	
	//imagePath 구성 X -> dto 로 imagePath 를 받아서 DB 에 저장하기
	@RequestMapping(value = "/gallery/ajax_insert")
	@ResponseBody
	public Map<String, Object> authAjaxInsert(GalleryDto dto, HttpServletRequest request) {
		//dto : caption, imagePath 가지고 있다.
		//request : dto 에 writer(id) 추가
		service.insert(dto, request);
		Map<String, Object> map=new HashMap<>();
		map.put("isSuccess", true);
		return map;
	}	
	
	//gallery detail 페이지 
	@RequestMapping(value = "/gallery/detail", method = RequestMethod.GET)
	public ModelAndView detail(ModelAndView mView, @RequestParam int num) {
		//갤러리 detail 페이지에 필요한 data를 num 으로 가져와, ModelAndView 에 저장
		service.getDetail(mView, num);
		mView.setViewName("gallery/detail");
		return mView;
	}
	
	//gallery 글 수정 요청 처리 
	@RequestMapping(value = "/gallery/update", method = RequestMethod.POST)
	public String update(GalleryDto dto) {
		service.updateContent(dto);
		return "gallery/update";
	}
	
	//gallery 글 수정
	@RequestMapping("/gallery/updateform")
	public String updateForm(HttpServletRequest request) {
		service.getData(request);
		return "gallery/updateform";
	}
	
	//gallery 글 삭제 
	@RequestMapping("/gallery/delete")
	public String delete(HttpServletRequest request, @RequestParam int num) {
		service.deleteContent(num);
		return "gallery/delete";
	}
	
	//꽉 찬 하트일 때 
		@RequestMapping(value="/ajax/gallery/offLike", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> ajaxOffLike(LikeDto likeDto){
			Map<String, Object>	map=new HashMap<>();
			dao.like_delete(likeDto);
			dao.minusLikeCount(likeDto.getGallery_num());
			map.put("isSuccess", true);
			return map;
		}
		
		//빈 하트일 때 
		@RequestMapping(value="/ajax/gallery/onLike", method = {RequestMethod.GET, RequestMethod.POST})
		@ResponseBody
		public Map<String, Object> ajaxOnLike(LikeDto likeDto){
			Map<String, Object>	map=new HashMap<>();
			//중복 좋아요를 방지하기 위해 확인 후 insert
			if(service.ajaxCheckLike(likeDto)!=null) {
				dao.like_insert(likeDto);
				dao.addLikeCount(likeDto.getGallery_num());
				map.put("isSuccess", true);
			}else {
				map.put("isSuccess", false);
			}		
			return map;
		}
		
		//로그인 유저 확인하기
		@RequestMapping("/ajax/gallery/isLogin")
		@ResponseBody
		public Map<String, Object> ajaxIsLogin(HttpServletRequest request){
			return service.ajaxCheckLogin(request);
		}
		
		//로그인 유저가 특정 게시물을 추천했는지 확인
		@RequestMapping(value="/ajax/gallery/isLiked", method = RequestMethod.GET)
		@ResponseBody
		public Map<String, Object> ajaxIsLiked(LikeDto likeDto){
			return service.ajaxCheckLike(likeDto);
		}	
}
