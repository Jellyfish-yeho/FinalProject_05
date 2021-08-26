package com.minton.minton05.cafe.dto;

public class CafeDto {
		private int num;
		private String writer;
		private String title;
		private String category;
		private String content;
		private int viewCount;
		private int likeCount;
		private String regdate;
		private int startRowNum;
		private int endRowNum;
		private int prevNum;
		private int nextNum;
		private int reply_count;
		private String profile;
		
		public CafeDto() {}

		public CafeDto(int num, String writer, String title, String category, String content, int viewCount,
				int likeCount, String regdate, int startRowNum, int endRowNum, int prevNum, int nextNum,
				int reply_count, String profile) {
			super();
			this.num = num;
			this.writer = writer;
			this.title = title;
			this.category = category;
			this.content = content;
			this.viewCount = viewCount;
			this.likeCount = likeCount;
			this.regdate = regdate;
			this.startRowNum = startRowNum;
			this.endRowNum = endRowNum;
			this.prevNum = prevNum;
			this.nextNum = nextNum;
			this.reply_count = reply_count;
			this.profile = profile;
		}

		public int getNum() {
			return num;
		}

		public void setNum(int num) {
			this.num = num;
		}

		public String getWriter() {
			return writer;
		}

		public void setWriter(String writer) {
			this.writer = writer;
		}

		public String getTitle() {
			return title;
		}

		public void setTitle(String title) {
			this.title = title;
		}

		public String getCategory() {
			return category;
		}

		public void setCategory(String category) {
			this.category = category;
		}

		public String getContent() {
			return content;
		}

		public void setContent(String content) {
			this.content = content;
		}

		public int getViewCount() {
			return viewCount;
		}

		public void setViewCount(int viewCount) {
			this.viewCount = viewCount;
		}

		public int getLikeCount() {
			return likeCount;
		}

		public void setLikeCount(int likeCount) {
			this.likeCount = likeCount;
		}

		public String getRegdate() {
			return regdate;
		}

		public void setRegdate(String regdate) {
			this.regdate = regdate;
		}

		public int getStartRowNum() {
			return startRowNum;
		}

		public void setStartRowNum(int startRowNum) {
			this.startRowNum = startRowNum;
		}

		public int getEndRowNum() {
			return endRowNum;
		}

		public void setEndRowNum(int endRowNum) {
			this.endRowNum = endRowNum;
		}

		public int getPrevNum() {
			return prevNum;
		}

		public void setPrevNum(int prevNum) {
			this.prevNum = prevNum;
		}

		public int getNextNum() {
			return nextNum;
		}

		public void setNextNum(int nextNum) {
			this.nextNum = nextNum;
		}

		public int getReply_count() {
			return reply_count;
		}

		public void setReply_count(int reply_count) {
			this.reply_count = reply_count;
		}

		public String getProfile() {
			return profile;
		}

		public void setProfile(String profile) {
			this.profile = profile;
		}

		
		

}
