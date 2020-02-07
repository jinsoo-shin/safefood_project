package com.ssafy.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.model.dto.Food;
import com.ssafy.model.dto.FoodPageBean;
import com.ssafy.model.dto.User;
import com.ssafy.model.repository.FoodRepository;

@Transactional
@Service
public class FoodService {
	@Autowired
	FoodRepository repo;

//	 모든 food 검색
	public List<Food> selectAll() {
		return repo.selectAll();
	}

//	selectFoodBean food 검색
	public List<Food> selectFoodBean(FoodPageBean bean) {
		return repo.selectFoodBean(bean);
	}

//	food 코드로 food 검색 
	public Food select(String code) {
		return repo.select(code);
	}

//	food 코드로 food의 알레르기 정보 얻기
	public List<String> selectAllergy(Food food) {
		return repo.selectAllergy(food);
	}

//	유저 아이디로 사용자가 먹은 food 검색 foodcode가 반환된다
	public List<String> selectUserEat(User user) {
		return repo.selectUserEat(user);
	}

//	유저 아이디로 사용자가 먹은 food 삽입
	public int insertUserEat(String foodcode, User user) {
		return repo.insertUserEat(foodcode, user);
	}

//	유저 아이디로 사용자가 먹은 food 삭제
	public int deleteUserEat(String foodcode, User user) {
		return repo.deleteUserEat(foodcode, user);
	}

	public int deleteUserEatAll(User user) {
		return repo.deleteUserEatAll(user);
	}

	public List<String> selectIsUserEat(User user, String foodcode) {
		return repo.selectIsUserEat(user, foodcode);
	}
	
	//조회수
	public int insertHit(User user, String foodname) {
		return repo.insertHit(user, foodname);
	}
	public int updateHit(User user, String foodname) {
		return repo.updateHit(user, foodname);
	}
	//유저가 클릭한 food의 foodname반환
	public List<String>seleteHit(User user){
		return repo.selectHit(user);
	}
	
	
////섭취 구현함 무조건 이름은 moreeat
	// 먹은적이있나용
	public List<Food> selectUserMoreEatByUser(User user) {
		return repo.selectUserMoreEatByUser(user);
	}
	public List<Food> selectUserMoreEat(User user, String foodcode) {
		return repo.selectUserMoreEat(user,foodcode);
	}

//	유저 아이디로 사용자가 먹은 food 삽입
	public int insertUserMoreEat(String foodcode, User user,int count) {
		return repo.insertUserMoreEat(foodcode, user,count);
	}
//	유저 아이디로 사용자가 먹은 food 업데이트
	public int updateUserMoreEat(String foodcode, User user,int count) {
		return repo.updateUserMoreEat(foodcode, user,count);
	}

//	유저 아이디로 사용자가 먹은 food 삭제
	public int deleteUserMoreEat(String foodcode, User user) {
		return repo.deleteUserMoreEat(foodcode, user);
	}
	
	//사용자에 따라 클릭한 식품 보여주기
		public List<String> selectUserHit(User user,String foodname){
			return repo.selectUserHit(user, foodname);
		}
}
