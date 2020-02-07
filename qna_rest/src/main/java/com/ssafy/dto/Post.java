package com.ssafy.dto;

public class Post {
	private String index;
	private String title;
	private String url;

	public String getindex() {
		return index;
	}

	public void setindex(String index) {
		this.index = index;
	}

	public Post(String index, String title, String url) {
		super();
		this.index = index;
		this.title = title;
		this.url = url;
	}

	@Override
	public String toString() {
		return "Post [title=" + title + ", url=" + url ;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

}
