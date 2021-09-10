package com.minton.minton05.inquiry.dto;

public class InquiryDto {
	private int num;
	private String id;
	private String title;
	private String content;
	private String phone;
	private String regdate;
	private String solved;
	private int startRowNum;
	private int endRowNum;
	private int prevNum;
	private int nextNum;
	
	public InquiryDto() {}

	public InquiryDto(int num, String id, String title, String content, String phone, String regdate, String solved,
			int startRowNum, int endRowNum, int prevNum, int nextNum) {
		super();
		this.num = num;
		this.id = id;
		this.title = title;
		this.content = content;
		this.phone = phone;
		this.regdate = regdate;
		this.solved = solved;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
		this.prevNum = prevNum;
		this.nextNum = nextNum;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getSolved() {
		return solved;
	}

	public void setSolved(String solved) {
		this.solved = solved;
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

	
	
}
