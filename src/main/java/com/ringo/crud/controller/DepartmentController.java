package com.ringo.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ringo.crud.bean.Department;
import com.ringo.crud.bean.Msg;
import com.ringo.crud.service.DepartmentService;

@Controller
public class DepartmentController {
	@Autowired
	private DepartmentService departmentService;
	
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		// 调用Service查出部门信息
		List<Department> list = departmentService.getDepts();
		return Msg.success().add("depts", list);
	}
}
