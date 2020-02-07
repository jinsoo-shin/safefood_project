package com.ssafy.test;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.RequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.ssafy.config.ApplicationConfig;
import com.ssafy.config.MVCConfig;

@RunWith(SpringRunner.class)
@ContextConfiguration(classes= {ApplicationConfig.class, MVCConfig.class})
@WebAppConfiguration
public class ControllerTest {

	@Autowired
	WebApplicationContext ctx;

	MockMvc mockMvc;

	@Before
	public void setUp() throws Exception {
		mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}

	@Test
	public void testJoinGet() throws Exception {
		RequestBuilder builder = MockMvcRequestBuilders.get("/join");
		mockMvc.perform(builder).andExpect(status().isOk())
		.andExpect(view().name("user/joinform"));
	}

}
