package com.ssafy.model.dto;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;

public class User implements Serializable{
	private String id;
	private String password;
	private String name;
	private String address;
	private String phone;
	private List<String> allergy;
	public User() {
		
	}
	public User(String id,List<String> allergy) {
		this.id = id;
	
		this.allergy = allergy;
	}
	public User(String id, String password, String name, String address, String phone) {
		this.id = id;
		this.password = password;
		this.name = name;
		this.address = address;
		this.phone = phone;
		
	}
	public User(String id, String password, String name, String address, String phone, List<String> allergy) {
		this.id = id;
		this.password = password;
		this.name = name;
		this.address = address;
		this.phone = phone;
		this.allergy = allergy;
	}
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public List<String> getAllergy() {
		return allergy;
	}
	public void setAllergy(List<String> allergy) {
		this.allergy = allergy;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", password=" + password + ", name=" + name + ", address=" + address + ", phone="
				+ phone + ", allergy=" + allergy + "]";
	}
	
	
	
	

}
