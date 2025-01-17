package com.ssafy.dto;

public class Detail {
	private String title, content;

	public Detail() {
		super();
	}

	public Detail(String title, String content) {
		super();
		this.title = title;
		this.content = content;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "Detail [title=" + title + ", content=" + content + "]";
	}

}
