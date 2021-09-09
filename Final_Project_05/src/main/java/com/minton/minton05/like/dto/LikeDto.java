package com.minton.minton05.like.dto;

public class LikeDto {
	private int cafe_num;
	private int gallery_num;
	private String liked_user;
	
	public LikeDto() {}

	public LikeDto(int cafe_num, int gallery_num, String liked_user) {
		super();
		this.cafe_num = cafe_num;
		this.gallery_num = gallery_num;
		this.liked_user = liked_user;
	}

	public int getCafe_num() {
		return cafe_num;
	}

	public void setCafe_num(int cafe_num) {
		this.cafe_num = cafe_num;
	}

	public int getGallery_num() {
		return gallery_num;
	}

	public void setGallery_num(int gallery_num) {
		this.gallery_num = gallery_num;
	}

	public String getLiked_user() {
		return liked_user;
	}

	public void setLiked_user(String liked_user) {
		this.liked_user = liked_user;
	}


}
