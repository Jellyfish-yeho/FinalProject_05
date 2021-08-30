package com.minton.minton05.gallery.dao;

import java.util.List;
import com.minton.minton05.gallery.dto.GalleryDto;

public interface GalleryDao {
	//gallery 리스트 가져오기
	public List<GalleryDto> getList(GalleryDto dto);
	
	//gallery 모든 ROW 의 개수
	public int getCount();
	
	//gallery 사진게시글 저장
	public void insert(GalleryDto dto);
	
	//gallery 사진게시글 수정
	public void update(GalleryDto dto);
	
	//gallery 게시글 하나의 data 가져오기
	public GalleryDto getData(int num);
	
	//gallery 사진게시글 삭제
	public void delete(int num);
	
	//좋아요 수 증가시키기
	//public void addLikeCount(int num);
}
