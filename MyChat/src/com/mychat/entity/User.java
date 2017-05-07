package com.mychat.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;
/**
 * Describe:用户表
 * Author:陆小不离
 * Age:Eighteen
 * Time:2017年5月5日 下午2:04:53
 */
@Table("user")
public class User {
	public static final String ID = "id";
	public static final String USERNAME = "username";
	public static final String PWD = "pwd";
	public static final String SIGN = "sign";
	public static final String AVATAR = "avatar";
	
	@Id
	private int id;
	@Column
	private String username;
	@Column
	private String pwd;
	@Column
	private String sign;
	@Column
	private String avatar;
	@Column
	private String status;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", pwd=" + pwd + ", sign=" + sign + ", avatar=" + avatar
				+ ", status=" + status + "]";
	}
}
