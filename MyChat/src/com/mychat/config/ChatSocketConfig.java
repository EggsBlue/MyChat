package com.mychat.config;

import java.util.Set;

import javax.websocket.Endpoint;
import javax.websocket.server.ServerApplicationConfig;
import javax.websocket.server.ServerEndpointConfig;
/**
 * Describe:Socket清单
 * Author:陆小不离
 * Age:Eighteen
 * Time:2017年5月5日 下午2:02:59
 */
public class ChatSocketConfig implements ServerApplicationConfig{

	@Override
	public Set<Class<?>> getAnnotatedEndpointClasses(Set<Class<?>> arg0) {
		System.out.println("socket初始化成功..."+arg0.size());
		return arg0;
	}

	@Override
	public Set<ServerEndpointConfig> getEndpointConfigs(Set<Class<? extends Endpoint>> arg0) {
		// TODO Auto-generated method stub
		return null;
	}

}
