package com.minton.minton05.users.dao;

import com.minton.minton05.users.dto.UsersDto;

public interface UsersDao {
	//가입 전 아이디 체크 
	public boolean isExist(String inputId);
	//회원가입
	public void insert(UsersDto dto);
	//로그인 정보 
	public UsersDto getData(String id);
	//비밀번호 변경
	public void updatePwd(UsersDto dto);
	//이메일 프로필 변경
	public void update(UsersDto dto);
	//아이디 삭제
	public void delete(String id);
}
