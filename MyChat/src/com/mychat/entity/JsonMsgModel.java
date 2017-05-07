package com.mychat.entity;

import java.util.List;
/**
 * Describe:消息模型
 * Author:陆小不离
 * Age:Eighteen
 * Time:2017年4月25日 下午3:43:20
 */
public class JsonMsgModel {
	private int code;
	private int pages;
	private List<Message> data;
	
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public int getPages() {
		return pages;
	}
	public void setPages(int pages) {
		this.pages = pages;
	}
	public List<Message> getData() {
		return data;
	}
	public void setData(List<Message> data) {
		this.data = data;
	}
	
	
	@Override
	public String toString() {
		return "JsonMsgModel [code=" + code + ", pages=" + pages + ", data=" + data + "]";
	}
}
