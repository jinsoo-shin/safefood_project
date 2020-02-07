package com.ssafy.dto;

import java.sql.Date;

public class Bean {
	private String key,word;
	
	
	
	public Bean() {
		super();
	}

	public Bean(String key, String word) {
		super();
		this.key = key;
		this.word = word;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}

	@Override
	public String toString() {
		return "Bean [key=" + key + ", word=" + word + "]";
	}
	
	
	
	

}
