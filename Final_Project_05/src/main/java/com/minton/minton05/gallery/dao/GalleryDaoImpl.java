package com.minton.minton05.gallery.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minton.minton05.gallery.dto.GalleryDto;

@Repository
public class GalleryDaoImpl implements GalleryDao{
	
	@Autowired
	private SqlSession session;
	
	/*
	 * Mapper's namespace : gallery
	 * sql's id : getList
	 * parameterType : GalleryDto
	 * resultType : GalleryDto
	 */
	//gallery 의 모든 리스트 가져오기
	@Override
	public List<GalleryDto> getList(GalleryDto dto) {
		return session.selectList("gallery.getList", dto);
	}
	
	/*
	 * Mapper's namespace : gallery
	 * sql's id : getCount
	 * resultType : int
	 */
	//gallery 모든 ROW 의 개수
	@Override
	public int getCount() {
		return session.selectOne("gallery.getCount");
	}
	
	/*
	 * Mapper's namespace : gallery
	 * sql's id : insert
	 * parameterType : GalleryDto
	 */
	//gallery 사진게시글 저장
	@Override
	public void insert(GalleryDto dto) {
		session.insert("gallery.insert", dto);
	}
	//gallery 사진게시글 수정
	@Override
	public void update(GalleryDto dto) {
		session.update("gallery.update", dto);
	}
	/*
	 * Mapper's namespace : gallery
	 * sql's id : getData
	 * parameterType : int
	 * resultType : GalleryDto
	 */
	//gallery 사진게시글 한개정보
	@Override
	public GalleryDto getData(int num) {
		return session.selectOne("gallery.getData", num);
	}
	//gallery 사진게시글 삭제
	@Override
	public void delete(int num) {
		session.delete("gallery.delete", num);
	}
	//좋아요 수 증가시키기
	//@Override
	//public void addLikeCount(int num) {
	//	session.update("gallery.addLikeCount", num);
	//}
}
