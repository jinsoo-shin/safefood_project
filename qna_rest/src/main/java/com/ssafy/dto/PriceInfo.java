package com.ssafy.dto;

public class PriceInfo {
	private String item;
	private String tdprice;
	private String bmprice;

	public PriceInfo(String item, String tdprice, String bmprice) {
		super();
		this.item = item;
		this.tdprice = tdprice;
		this.bmprice = bmprice;
	}

	@Override
	public String toString() {
		return "PriceInfo [item=" + item + ", tdprice=" + tdprice + ", bmprice=" + bmprice + "]";
	}

	public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
	}

	public String getTdprice() {
		return tdprice;
	}

	public void setTdprice(String tdprice) {
		this.tdprice = tdprice;
	}

	public String getBmprice() {
		return bmprice;
	}

	public void setBmprice(String bmprice) {
		this.bmprice = bmprice;
	}

	public PriceInfo() {
		super();
	}

}
