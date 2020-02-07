package com.ssafy.dto;

public class Notice {
	private String img,title,text;

	

	public Notice(String img, String title, String text) {
		super();
		this.img = img;
		this.title = title;
		this.text = text;
	}

	public Notice() {
		super();
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	@Override
	public String toString() {
		return "Notice [img=" + img + ", title=" + title + ", text=" + text + "]";
	}

	
	
	

}
