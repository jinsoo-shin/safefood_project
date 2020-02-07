package com.ssafy.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.model.dto.User;
import com.ssafy.model.repository.UserDaoImple;

@Service
public class UserService {
	@Autowired
	UserDaoImple dao;
	
	public User ulogin(String id, String pw) {
		User tmp = dao.select(id);
		if(tmp!=null&&tmp.getPassword().equals(pw)) {
			return tmp;
		}else {
			return null;
		}
	}
	public int addRegister(User user) {
		int result=-1;
		result=dao.insert(user);
		if(result!=-1) {
			dao.insertAllergy(user);
		}
		return result;
	}
	public int update(User user) {
		int result = -1;
		result = dao.update(user);
		if(result!=-1) {
			dao.updateAllergy(user);
		}
		return result;
		
	}
	
	

}
