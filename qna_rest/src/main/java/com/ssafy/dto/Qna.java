package com.ssafy.dto;

import java.sql.Date;

public class Qna {
	private Integer num;
	private String title,writer,content;
	private Date postdate;
	private String password;
	private Integer count;
	
	public Qna() {
		super();
	}

	public Qna(Integer num, String title, String writer, String content, Date postdate, String password,
			Integer count) {
		super();
		this.num = num;
		this.title = title;
		this.writer = writer;
		this.content = content;
		this.postdate = postdate;
		this.password = password;
		this.count = count;
	}

	

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	
	public Date getPostdate() {
		return postdate;
	}
	public void setPostdate(Date postdate) {
		this.postdate = postdate;
	}
	
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "Qna [num=" + num + ", title=" + title + ", writer=" + writer + ", content=" + content + ", postdate="
				+ postdate + ", password=" + password + ", count=" + count + "]";
	}

	
	
	
	
}
	
