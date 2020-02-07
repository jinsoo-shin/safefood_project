package com.ssafy.model.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ssafy.model.dto.Food;
import com.ssafy.model.dto.FoodPageBean;
import com.ssafy.model.dto.User;

@Repository
public class FoodRepository {

	private static final Logger logger = LoggerFactory.getLogger(FoodRepository.class);
	private static final String ns = "com.ssafy.model.mapper.Food.";

	@Autowired
	SqlSessionTemplate template;

//	 모든 food 검색
	public List<Food> selectAll() {
		String statement = ns + "selectAll";
		return template.selectList(statement);
	}

//	selectFoodBean food 검색
	public List<Food> selectFoodBean(FoodPageBean bean) {
		String statement = ns + "selectAll";
		if (bean.getKey().equals("name")) {
			statement = ns + "selectFoodBeanName";
//			System.out.println("이름으로 검색");
		} else if (bean.getKey().equals("maker")) {
			statement = ns + "selectFoodBeanMaker";
//			System.out.println("메이커로 검색");
		} else if (bean.getKey().equals("material")) {
//			System.out.println("원재료로 검색");
			statement = ns + "selectFoodBeanMaterial";
		}
		return template.selectList(statement, bean);
	}

//	food 코드로 food 검색 
	public Food select(String code) {
		String statement = ns + "select";
//		logger.trace("select :{}" + code);
		return template.selectOne(statement, code);
	}
	
//	food 코드로 food의 알레르기 정보 얻기
//	public List<String> selectAllergy(Food food) {
	public List<String> selectAllergy(Food food) {
		String statement = ns + "selectAllergy";
//		logger.trace("selectAllergy :{}" + food);
		return template.selectList(statement, food);
	}

//	유저 아이디로 사용자가 먹은 food 검색 foodcode가 반환된다
	public List<String> selectUserEat(User user) {
		String statement = ns + "selectUserEat";
//		logger.trace("selectUserEat :{}" + user);
		return template.selectList(statement, user);
	}

	// 먹은적이있나용
	public List<String> selectIsUserEat(User user, String foodcode) {
		String statement = ns + "selectIsUserEat";
		Map<String, Object> map = new HashMap<>();
		map.put("foodCode", foodcode);
		map.put("userId", user.getId());
		logger.trace("selectIsUserEat :{}" + user);
		return template.selectList(statement, map);
	}

//	유저 아이디로 사용자가 먹은 food 삽입
	public int insertUserEat(String foodcode, User user) {
		String statement = ns + "insertUserEat";
		logger.trace("insertUserEat :{}" + foodcode);
		Map<String, Object> map = new HashMap<>();
		map.put("foodCode", foodcode);
		map.put("userId", user.getId());
		return template.insert(statement, map);
	}

//	유저 아이디로 사용자가 먹은 food 삭제
	public int deleteUserEat(String foodcode, User user) {
		String statement = ns + "deleteUserEat";
		Map<String, Object> map = new HashMap<>();
		map.put("foodCode", foodcode);
		map.put("userId", user.getId());
		return template.delete(statement, map);
	}

	public int deleteUserEatAll(User user) {
		String statement = ns + "deleteUserEatAll";
		return template.delete(statement, user.getId());
	}
	
	
	
	////섭취 구현함 무조건 이름은 moreeat
	public List<Food> selectUserMoreEatByUser(User user) {
		String statement = ns + "selectUserMoreEatByUser";
		Map<String, Object> map = new HashMap<>();
		map.put("userId", user.getId());
		return template.selectList(statement, map);
	}
	
	// 먹은적이있나용
	public List<Food> selectUserMoreEat(User user, String foodcode) {
		String statement = ns + "selectUserMoreEat";
		Map<String, Object> map = new HashMap<>();
		map.put("foodCode", foodcode);
		map.put("userId", user.getId());
		return template.selectList(statement, map);
	}

//	유저 아이디로 사용자가 먹은 food 삽입
	public int insertUserMoreEat(String foodcode, User user,int count) {
		String statement = ns + "insertUserMoreEat";
		logger.trace("insertUserEat :{}" + foodcode);
		Map<String, Object> map = new HashMap<>();
		map.put("foodCode", foodcode);
		map.put("count", count);
		map.put("userId", user.getId());
		return template.insert(statement, map);
	}
//	유저 아이디로 사용자가 먹은 food 업데이트
	public int updateUserMoreEat(String foodcode, User user,int count) {
		String statement = ns + "updateUserMoreEat";
		logger.trace("insertUserEat :{}" + foodcode);
		Map<String, Object> map = new HashMap<>();
		map.put("foodCode", foodcode);
		map.put("count", count);
		map.put("userId", user.getId());
		return template.update(statement, map);
	}

//	유저 아이디로 사용자가 먹은 food 삭제
	public int deleteUserMoreEat(String foodcode, User user) {
		String statement = ns + "deleteUserMoreEat";
		Map<String, Object> map = new HashMap<>();
		map.put("foodCode", foodcode);
		map.put("userId", user.getId());
		return template.delete(statement, map);
	}
	
	
	public int insertHit(User user, String foodname) {
		String statement =ns+"insertHit";
		Map<String,Object>map = new HashMap<>();
		map.put("userid", user.getId());
		map.put("foodname", foodname);
		return template.insert(statement,map);
	}
	public int updateHit(User user, String foodname) {
		String statement =ns+"updateHit";
		Map<String,Object>map = new HashMap<>();
		map.put("userid", user.getId());
		map.put("foodname", foodname);
		return template.insert(statement,map);
	}
	//사용자에 따라 클릭한 식품 보여주기
	public List<String> selectHit(User user){
		String statement = ns+"selectHit";
		
		
		
		return template.selectList(statement, user);
	}
	//사용자에 따라 클릭한 식품 보여주기
	public List<String> selectUserHit(User user,String foodname){
		String statement = ns+"selectUserHit";
		Map<String,Object>map = new HashMap<>();
		map.put("userid", user.getId());
		map.put("foodname", foodname);
		
		
		return template.selectList(statement, map);
	}
	
	
	
	
	
	
	
}
