package com.ssafy.dto;

import java.util.*;

public class MarketPrice {
	private String item;
	private String price;
	public MarketPrice(String item, String price) {
		super();
		this.item = item;
		this.price = price;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "MarketPrice [item=" + item + ", price=" + price + "]";
	}
	public MarketPrice() {
		super();
	}
	
}
