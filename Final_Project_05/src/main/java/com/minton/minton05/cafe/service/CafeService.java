package com.minton.minton05.cafe.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestParam;

import com.minton.minton05.cafe.dto.CafeCommentDto;
import com.minton.minton05.cafe.dto.CafeDto;


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


}
