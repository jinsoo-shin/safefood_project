package com.ssafy.dto;

public class Recipe {
	private Integer index;
	private String title;
	private String url;
	private String html;

	public Integer getindex() {
		return index;
	}

	public void setindex(Integer index) {
		this.index = index;
	}

	public Recipe(Integer index, String title, String url, String html) {
		super();
		this.index = index;
		this.title = title;
		this.url = url;
		this.html = html;
	}

	public Recipe(String title, String url, String html) {
		super();
		this.title = title;
		this.url = url;
		this.html = html;
	}

	public Recipe(String title, String url) {
		super();
		this.title = title;
		this.url = url;
	}

	@Override
	public String toString() {
		return "Recipe [title=" + title + ", url=" + url + ", html=" + html + "]";
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

	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

}
