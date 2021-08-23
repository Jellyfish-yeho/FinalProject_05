package com.minton.minton05.cafe.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.minton.minton05.cafe.service.CafeService;


@Controller
public class CafeController {
	@Autowired
	private CafeService service;
	
	@RequestMapping("/cafe/list")
	public String getList(HttpServletRequest request) {
		
		service.getList(request);
		
		return "cafe/list";
	}
}











