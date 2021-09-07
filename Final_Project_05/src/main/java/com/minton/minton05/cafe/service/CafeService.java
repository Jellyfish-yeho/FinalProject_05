package com.minton.minton05.cafe.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestParam;

import com.minton.minton05.cafe.dto.CafeCommentDto;
import com.minton.minton05.cafe.dto.CafeDto;
import com.minton.minton05.like.dto.LikeDto;
import com.minton.minton05.notice.dto.NoticeDto;


public interface CafeService {
	   public void getList(HttpServletRequest request);
	   public void getDetail(HttpServletRequest request);
	   public void saveContent(CafeDto dto);
	   public void updateContent(CafeDto dto);
	   public void deleteContent(int num, HttpServletRequest request);
	   public void saveComment(HttpServletRequest request);//댓글 저장 
	   public void deleteComment(HttpServletRequest request);//댓글 삭제
	   public void updateComment(CafeCommentDto dto);//댓글 수정
	   public void moreCommentList(HttpServletRequest request);//댓글 추가 응답
	   public void getData(HttpServletRequest request); //글 수정하기 위해 정보 불러오는 기능
	   //게시글의 댓글 개수 업데이트하기
	   public void updateReplyCount(int num);

	   //ajax 요청용 - cafe 글 목록을 리턴하는 메소드
	   public List<CafeDto> ajaxGetList(HttpServletRequest request);
	   //ajax 요청용 - cafe 글하단 페이징 처리에 필요한 데이터를 리턴하는 메소드
	   public Map<String, Object> ajaxPaging(HttpServletRequest request);
	   //ajax 요청용 - 공지사항 첫번째 글을 리턴하는 메소드
	   public NoticeDto ajaxGetFirstNotice();
	   
	   //로그인한 유저가 게시물을 추천했는지 확인
	   public Map<String, Object> ajaxCheckLike(LikeDto dto);
	   
	   //로그인 확인하기
	   public Map<String, Object> ajaxCheckLogin(HttpServletRequest request);
	   
	   //ajax - 글 정보 가져오기
	   public CafeDto ajaxDetail(HttpServletRequest request);
	   
	   //ajax 요청용 - cafe 글 목록을 리턴하는 메소드 - index용
	   public List<CafeDto> ajaxGetListIndex(HttpServletRequest request);
	   
	   //ajax 요청용 - cafe 댓글 목록을 리턴하는 메소드
	   public List<CafeCommentDto> ajaxGetCommentList(HttpServletRequest request);
	   
	   //ajax 요청용 - cafe 글하단 페이징 처리에 필요한 데이터를 리턴하는 메소드
	   public Map<String, Object> ajaxGetCommentPaging(HttpServletRequest request);
	   
	   
}
