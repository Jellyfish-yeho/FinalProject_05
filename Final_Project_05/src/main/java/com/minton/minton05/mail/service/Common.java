package com.minton.minton05.mail.service;

import org.apache.commons.mail.MultiPartEmail;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.stereotype.Service;

@Service
public class Common {
	public void sendEmail(String email, String id) {
		//1. 기본 이메일 전송 처리
		sendSimple(email, id);

	};
	
	private void sendSimple(String email, String id) {
		SimpleEmail mail = new SimpleEmail();
		
		mail.setHostName("smtp.naver.com");	//메일 전송 서버 지정, 네이버 메일 - 환경설정 - pop3 설정
		mail.setCharset("utf-8"); //인코딩 설정
		mail.setDebug(true); //메일 전송 과정 추적해서 콘솔에 띄워줌
		
		mail.setAuthentication("kurer456", "2017yessherlock!"); //로그인하기 위해 정보 입력
		mail.setSSLOnConnect(true); //입력한 정보로 로그인 요청
		
		try {
			mail.setFrom("kurer456@naver.com", "관리자");	//보내는 사람 메일 / 이름 설정
			mail.addTo(email, id); //받는 사람 메일 / 이름, 회원가입 페이지에에서 가져온다.
			
			mail.setSubject("High-clear 회원이 되신 것을 축하드립니다."); //메일 제목
			mail.setMsg(id + "님! 가입을 축하드립니다. 많은 활동 부탁드립니다."); //메일 내용
			
			mail.send(); //메일 발송 
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
}
}