package com.ringo.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.ringo.crud.bean.Employee;

/**
 * 使用Spring测试模块的测试请求功能，测试CRUD的正确性
 * @author ringo
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration // 自动装配IOC容器本身
@ContextConfiguration(locations = {"classpath:applicationContext.xml", 
				"file:src/main/webapp/WEB-INF/springDispatcherServlet-servlet.xml"}) // 指定Spring，SpringMVC配置文件的位置
public class MVCTest {
	// 传入SpringMVC的IOC容器
	@Autowired
	WebApplicationContext context;
	
	// MockMvc模拟MVC请求发送
	MockMvc mockMvc;
	
	// 初始化MockMvc
	@Before
	public void initMockMvc() {
		// 创建MockMvc
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build(); 
	}
	
	@Test
	public void testPage() throws Exception {
		// 模拟请求发送，并拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		// 在请求域中取出PageInfo
		MockHttpServletRequest request = result.getRequest();
		PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
		System.out.println("当前页码：" + pageInfo.getPageNum());
		System.out.println("总页码：" + pageInfo.getPages());
		System.out.println("总记录数：" + pageInfo.getTotal());
		System.out.println("在页面需要连续显示的页码：");
		
		int[] nums = pageInfo.getNavigatepageNums(); // 连续显示的页码数组
		for (int i : nums) {
			System.out.println(" " + i);
		}
		
		// 获取员工数据
		List<Employee> emps = pageInfo.getList();
		for(Employee employee : emps) {
			System.out.println("ID: " + employee.getEmpId() + "==>Name: " + employee.getEmpName());
		}
	}	
}






