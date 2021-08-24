package com.minton.minton05.notice.dto;

public class NoticeDto {
	private int num;
	private String writer;
	private String title;
	private String content;
	private int viewCount;
	private int startRowNum;
	private int endRowNum;
	private String regdate;
	private int prevNum;
	private int nextNum;
	private int startRowNum1;
	private int endRowNum1;

	public NoticeDto() {
	}

	public NoticeDto(int num, String writer, String title, String content, int viewCount, int startRowNum,
			int endRowNum, String regdate, int prevNum, int nextNum, int startRowNum1, int endRowNum1) {
		super();
		this.num = num;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.viewCount = viewCount;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
		this.regdate = regdate;
		this.prevNum = prevNum;
		this.nextNum = nextNum;
		this.startRowNum1 = startRowNum1;
		this.endRowNum1 = endRowNum1;
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

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
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

	public int getStartRowNum1() {
		return startRowNum1;
	}

	public void setStartRowNum1(int startRowNum1) {
		this.startRowNum1 = startRowNum1;
	}

	public int getEndRowNum1() {
		return endRowNum1;
	}

	public void setEndRowNum1(int endRowNum1) {
		this.endRowNum1 = endRowNum1;
	}

}