package com.minton.minton05.users.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minton.minton05.users.dao.UsersDao;

@Service
public class UsersServiceImpl {
	@Autowired
	private UsersDao dao;
	

}
