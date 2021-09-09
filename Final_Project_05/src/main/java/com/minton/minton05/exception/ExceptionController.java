package com.minton.minton05.exception;

import org.springframework.dao.DataAccessException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

//예외 컨트롤러를 bean으로 만들기 위한 어노테이션
@ControllerAdvice
public class ExceptionController {
	//spring framework가 동작하는 중에 NotDeleteException type의 예외가 발생하면 호출되는 메소드
	@ExceptionHandler(NotDeleteException.class)
	public ModelAndView notDelete(NotDeleteException nde) {//메소드의 인자로 예외 객체가 전달된다.
		//ModelAndView 객체를 생성해서
		ModelAndView mView=new ModelAndView();
		//exception이라는 키값으로 예외 객체를 담고
		mView.addObject("exception", nde);
		//view page(/WEB-INF/views/error/info.jsp)로 forward 이동해서 예외 정보 응답하기
		mView.setViewName("error/info");
		return mView;
	}

	
	//DB 관련 작업을 하다가 발생하는 예외를 처리하는 컨트롤러
	@ExceptionHandler(DataAccessException.class)
	public ModelAndView dataAccess(DataAccessException dae) {
		ModelAndView mView=new ModelAndView();
		mView.addObject("exception", dae);
		mView.setViewName("error/info");
		return mView;
	}
	
	//로그인을 하지 않았을 때 
	@ExceptionHandler(RuntimeException.class)
	public ModelAndView runAccess(RuntimeException re) {
		ModelAndView mView=new ModelAndView();
		mView.addObject("exception", re);
		mView.setViewName("error/info");
		return mView;
	}
	
}
