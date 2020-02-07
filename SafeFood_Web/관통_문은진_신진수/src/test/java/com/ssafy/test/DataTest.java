//package com.ssafy.test;
//
//import static org.hamcrest.CoreMatchers.is;
//import static org.junit.Assert.*;
//
//import java.util.Date;
//import java.util.List;
//
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.test.context.ContextConfiguration;
//import org.springframework.test.context.junit4.SpringRunner;
//import org.springframework.transaction.annotation.Transactional;
//
//import com.ssafy.config.ApplicationConfig;
//import com.ssafy.config.MVCConfig;
//import com.ssafy.model.dto.Book;
//import com.ssafy.model.service.BookService;
//
//@RunWith(SpringRunner.class)
//@ContextConfiguration(classes = { ApplicationConfig.class })
////@Transactional
//public class DataTest {
//
//	@Autowired
//	BookService service;
//
////	@Test
//	public void selectTest() {
//		Book result = service.select("1233-111-111");
//		assertThat(result.getCatalogue(), is("프로그래밍"));
//	}
//
////	@Test
//	public void selectAllTest() {
//		List<Book> result = service.selectAll();
////		assertThat(result.size(), is(2));
//	}
//
//	@Test
//	public void insertTest() {
//		int result = service.insert(
//				new Book("1233-111-133", "Java 초보", "프로그래밍", "국내도서", new Date(), "사무국", "사무국", 3000, "원", "java를 마시자"));
//		assertThat(result, is(1));
//	}
//
////	@Test
//	public void updateTest() {
//		int result = service.update(new Book("1233-111-133", 4000));
//		assertThat(result, is(1));
//	}
//
////	@Test
//	public void deleteTest() {
//		int result = service.delete("1233-111-133");
//		assertThat(result, is(1));
//	}
//
//}
