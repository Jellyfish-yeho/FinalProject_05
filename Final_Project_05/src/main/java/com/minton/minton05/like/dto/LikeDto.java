package com.minton.minton05.like.dto;

public class LikeDto {
	private int cafe_num;
	private String liked_user;
	
	public LikeDto() {}

	public LikeDto(int cafe_num, String liked_user) {
		super();
		this.cafe_num = cafe_num;
		this.liked_user = liked_user;
	}

	public int getCafe_num() {
		return cafe_num;
	}

	public void setCafe_num(int cafe_num) {
		this.cafe_num = cafe_num;
	}

	public String getLiked_user() {
		return liked_user;
	}

	public void setLiked_user(String liked_user) {
		this.liked_user = liked_user;
	}
	
	

}
