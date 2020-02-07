package com.ssafy.config;

import javax.sql.DataSource;

import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.annotation.PropertySource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.ssafy.model.repository.FoodRepository;
import com.ssafy.model.repository.UserDaoImple;
import com.ssafy.model.service.FoodService;
import com.ssafy.model.service.UserService;


@Configuration
@EnableTransactionManagement
@PropertySource({ "classpath:/config.properties" })
@ComponentScan(basePackageClasses={FoodRepository.class,FoodService.class,UserDaoImple.class,UserService.class})
public class ApplicationConfig {

	//bean을 설정하세요 => service, repositoy같은거
	
	
	private static final Logger logger = LoggerFactory.getLogger(ApplicationConfig.class);
	
	@Bean
	public DataSource ds(@Value("${db.driverClassName}") String driver,
			@Value("${db.url}") String url,
			@Value("${db.userName}") String user,
			@Value("${db.password}") String pass) {
//		logger.trace("db connection: {},{},{},{}", driver, url, user, pass);
		DriverManagerDataSource ds = new DriverManagerDataSource();
		ds.setDriverClassName(driver);
		ds.setUrl(url);
		ds.setUsername(user);
		ds.setPassword(pass);
		return ds;
	}

	@Bean
	public SqlSessionFactoryBean sqlSessionFactoryBean(DataSource ds, ApplicationContext ctx) {
		SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
		bean.setDataSource(ds);
		String location = "classpath:/mybatis/mybatis_config.xml";
		bean.setConfigLocation(ctx.getResource(location));
		return bean;
	}

	@Bean
	public SqlSessionTemplate template(SqlSessionFactoryBean factory) throws Exception {
		SqlSessionTemplate template = new SqlSessionTemplate(factory.getObject());
		return template;
	}

	@Bean
	public PlatformTransactionManager transactionManager(DataSource ds) {
		return new DataSourceTransactionManager(ds);
	}
}
