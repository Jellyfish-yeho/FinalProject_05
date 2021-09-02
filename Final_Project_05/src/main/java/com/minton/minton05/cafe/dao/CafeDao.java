package com.minton.minton05.cafe.dao;

import java.util.List;

import com.minton.minton05.cafe.dto.CafeDto;
import com.minton.minton05.like.dto.LikeDto;
import com.minton.minton05.users.dto.UsersDto;


public interface CafeDao {
	//글목록
	public List<CafeDto> getList(CafeDto dto); 
	//글의 갯수
    public int getCount(CafeDto dto);
    //글 추가
    public void insert(CafeDto dto);
    //글정보 얻어오기
    public CafeDto getData(int num);
    //키워드를 활용한 글정보 얻어오기
    public CafeDto getData(CafeDto dto);
    //조회수 증가 시키기
    public void addViewCount(int num);
    //조회수 내리기
    public void minusViewCount(int num);
    //글 삭제
    public void delete(int num);
    //글 수정
    public void update(CafeDto dto);
    
   
    //게시글의 댓글개수 업데이트하기
    public void updateReplyCount(int num);
    
    //로그인한 유저가 게시물을 추천했는지 확인
    public LikeDto isLiked(LikeDto dto);
    
    //추천하기
    public void like_insert(LikeDto dto);
    
    //추천 없애기
    public void like_delete(LikeDto dto);
}
