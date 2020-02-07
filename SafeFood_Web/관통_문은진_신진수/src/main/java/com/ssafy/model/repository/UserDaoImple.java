package com.ssafy.model.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ssafy.model.dto.User;

@Repository
public class UserDaoImple {
	static Map<String, String>change;
	public UserDaoImple() {
		change= new HashMap<>();
		change.put("bighead", "대두");
		change.put("pinut", "땅콩");
		change.put("milk", "우유");
		change.put("crab", "게");
		change.put("shrimp", "새우");
		change.put("tuna", "참치");
		change.put("salmon", "연어");
		change.put("ssook", "쑥");
		change.put("beef", "소고기");
		change.put("chicken", "닭고기");
		change.put("pork", "돼지고기");
		change.put("peach", "복숭아");
		change.put("mindulle", "민들레");
		change.put("eggWhite", "계란흰자");
	}
	
	
	
	private static final String ns = "com.ssafy.model.mapper.User.";
	@Autowired
	SqlSessionTemplate tem;

	public int insert(User user) {
		String statement = ns + "insert";
		return tem.insert(statement, user);
	}

	public int insertAllergy(User user) {
		String statement =null;
		int result=0;
		for(int i=0;i<user.getAllergy().size();i++) {
			Map<String, String>map = new HashMap<>();
			map.put("id", user.getId());
			String tmp=change.get(user.getAllergy().get(i));
			map.put("allergy",tmp);
			statement = ns + "insertAllergy";
			result=tem.insert(statement, map);
		}
		return result;
	}

	public int update(User user) {
		String statement = ns + "update";
		return tem.update(statement, user);
	}

	public int updateAllergy(User user) {
		String statement =null;
		int result=0;
		for(int i=0;i<user.getAllergy().size();i++) {
			Map<String, String>map = new HashMap<>();
			map.put("id", user.getId());
			String tmp=change.get(user.getAllergy().get(i));
			map.put("allergy",tmp);
			statement = ns + "insertAllergy";
			result=tem.insert(statement, map);
		}
		return result;
	}

	public int deleteAllergy(String id) {
		String statement = ns + "deleteAllergy";
		return tem.delete(statement, id);
	}
	public int delete(String id) {
		String statement = ns + "delete";
		return tem.delete(statement, id);
	}
	public User select(String id) {
		String statement=ns+"select";
		return tem.selectOne(statement, id);
	}
	public List<String>selectAllergy(String id){
		String statement = ns+"selectAllergy";
		
		return tem.selectList(statement,id);
	}

}
