package com.minton.minton05.cafe.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.minton.minton05.cafe.dao.CafeDao;
import com.minton.minton05.cafe.dto.CafeCommentDto;
import com.minton.minton05.cafe.dto.CafeDto;
import com.minton.minton05.cafe.service.CafeService;
import com.minton.minton05.like.dto.LikeDto;
import com.minton.minton05.notice.dto.NoticeDto;

@Controller
public class CafeController {
	
	@Autowired private CafeService service;
	@Autowired private CafeDao cafeDao;
	
	//새 글 저장 - ajax 요청에 대한 폼 제출
	@RequestMapping("/cafe/ajax/insert")
	@ResponseBody
	public Map<String, Object> authAjaxInsert(CafeDto dto, HttpServletRequest request) {
		//글 작성자는 세션에서 얻어낸다. 
		String id=(String)request.getSession().getAttribute("id");
		//CafeDto 객체에 글 작성자도 담기
		dto.setWriter(id);
		service.saveContent(dto);
		Map<String, Object>	map=new HashMap<>();
		map.put("isSuccess", true);
		return map;
	}
	
	//꽉 찬 하트일 때 
	@RequestMapping(value="/ajax/cafe/offLike", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ajaxOffLike(LikeDto likeDto){
		Map<String, Object>	map=new HashMap<>();
		cafeDao.like_delete(likeDto);
		cafeDao.minusViewCount(likeDto.getCafe_num());
		map.put("isSuccess", true);
		return map;
	}
	
	//빈 하트일 때 
	@RequestMapping(value="/ajax/cafe/onLike", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ajaxOnLike(LikeDto likeDto){
		Map<String, Object>	map=new HashMap<>();
		cafeDao.like_insert(likeDto);
		cafeDao.addViewCount(likeDto.getCafe_num());
		map.put("isSuccess", true);
		return map;
	}
	
	//로그인 유저 확인하기
	@RequestMapping("/ajax/cafe/isLogin")
	@ResponseBody
	public Map<String, Object> ajaxIsLogin(HttpServletRequest request){
		return service.ajaxCheckLogin(request);
	}
	
	//로그인 유저가 특정 게시물을 추천했는지 확인
	@RequestMapping("/ajax/cafe/isLiked")
	@ResponseBody
	public Map<String, Object> ajaxIsLiked(LikeDto likeDto){
		return service.ajaxCheckLike(likeDto);
	}	
	
	//ajax 요청에 대해 cafe 글 하단 페이징 처리에 필요한 데이터를 리턴
	@RequestMapping("/ajax/cafe/paging")
	@ResponseBody
	public Map<String, Object> ajaxPaging(@RequestParam int pageNum,
			@RequestParam String keyword, @RequestParam String condition){
		return service.ajaxPaging(pageNum, keyword, condition);
	}
	
	//ajax 요청에 대해 notice 첫번째글 정보 응답
	@RequestMapping("/ajax/cafe/firstNotice")
	@ResponseBody
	public NoticeDto ajaxGetFirstNotice(){
		return service.ajaxGetFirstNotice();
	}
	
	//ajax 요청에 대해 cafe 글 목록을 출력
	@RequestMapping("/ajax/cafe/list")
	@ResponseBody
	public List<CafeDto> ajaxGetList(HttpServletRequest request){
		return service.ajaxGetList(request);
	}
	
	@RequestMapping("/cafe/list")
	public String getList(HttpServletRequest request) {
		service.getList(request);		
		return "cafe/list";
	}
	
	@RequestMapping("/cafe/insertform")
	public String authInsertForm(HttpServletRequest request) {		
		return "cafe/insertform";
	}
	//새글 저장 요청 처리 - auth 처리
	@RequestMapping("/cafe/insert")
	public String authInsert(CafeDto dto, HttpServletRequest request) {
		//글 작성자는 세션에서 얻어낸다. 
		String id=(String)request.getSession().getAttribute("id");
		//CafeDto 객체에 글 작성자도 담기
		dto.setWriter(id);
		service.saveContent(dto);
		
		return "cafe/insert";
	}
	//글 자세히 보기 요청 처리
	@RequestMapping("/cafe/detail")
	public String detail(HttpServletRequest request, 
			@RequestParam int num) {
		service.updateReplyCount(num);
		service.getDetail(request);
		return "cafe/detail";
	}
	//새로운 댓글 저장 요청 처리 
	@RequestMapping("/cafe/comment_insert")
	public String authCommentInsert(HttpServletRequest request, 
			@RequestParam int ref_group) {
		service.saveComment(request);
		
		return "redirect:/cafe/detail.do?num="+ref_group;
	}
	//댓글 더보기 요청 처리
	@RequestMapping("/cafe/ajax_comment_list")
	public String ajaxCommentList(HttpServletRequest request) {
		
		service.moreCommentList(request);
		
		return "cafe/ajax_comment_list";
	}
    //댓글 삭제 요청 처리
    @RequestMapping("/cafe/comment_delete")
    @ResponseBody
    public Map<String, Object> authCommentDelete(HttpServletRequest request) {
	      service.deleteComment(request);
	      Map<String, Object> map=new HashMap<String, Object>();
	      map.put("isSuccess", true);
	      // {"isSuccess":true} 형식의 JSON 문자열이 응답되도록 한다. 
	      return map;
    }
	//댓글 수정 요청처리 (JSON 을 응답하도록 한다)
	@RequestMapping("/cafe/comment_update")
	@ResponseBody
	public Map<String, Object> authCommentUpdate(CafeCommentDto dto){
	      service.updateComment(dto);
	      Map<String, Object> map=new HashMap<String, Object>();
	      map.put("isSuccess", true);
	      // {"isSuccess":true} 형식의 JSON 문자열이 응답되도록 한다. 
	      return map;
	}
	//카페글 삭제 요청 처리
	@RequestMapping("/cafe/delete")
	public String authDelete(@RequestParam int num, HttpServletRequest request) {
		
		service.deleteContent(num, request);
		
		return "redirect:/cafe/list.do";
	}
	
	//카페글 수정 처리
	@RequestMapping("/cafe/updateform")
	public String authUpdateForm(HttpServletRequest request) {		
		service.getData(request);		
		return "cafe/updateform";
	}
	//카페글 수정 요청 처리
	@RequestMapping(value= "/cafe/update", method = RequestMethod.POST)
	public String authUpdate(CafeDto dto, HttpServletRequest request) {
		service.updateContent(dto);
		return "cafe/update";
	}
}











