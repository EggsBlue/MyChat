package com.mychat;

import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.ChainBy;
import org.nutz.mvc.annotation.Encoding;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.IocBy;
import org.nutz.mvc.annotation.Modules;
import org.nutz.mvc.annotation.SetupBy;
import org.nutz.mvc.filter.CrossOriginFilter;
import org.nutz.mvc.ioc.provider.ComboIocProvider;

import com.mychat.filter.PassHttpFilter;
import com.mychat.setup.SystemSetup;

@Modules(scanPackage=true)
@IocBy(type=ComboIocProvider.class, args={"*js", "ioc/",// 这个package下所有带@IocBean注解的类,都会登记上
        "*anno", "com.mychat",
        "*tx", // 事务拦截 aop
        "*async"}) // 异步执行aop
@Encoding(input="utf-8",output="utf-8")
@Filters({@By(type=CrossOriginFilter.class)})
@ChainBy(args="mvc/nutzbook-mvc-chain.js")
@SetupBy(SystemSetup.class)
public class MainModule {
}
