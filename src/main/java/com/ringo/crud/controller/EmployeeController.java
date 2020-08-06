package com.ringo.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ringo.crud.bean.Employee;
import com.ringo.crud.bean.Msg;
import com.ringo.crud.service.EmployeeService;

/**
 * 处理员工CRUD请求
 * 
 * @author ringo
 *
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	@ResponseBody
	@RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
	public Msg empMsg(@PathVariable("ids") String ids) {
		// 处理多选删除的请求
		if(ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			
			// 组装id到集合
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
		} else { // 处理单选删除的请求
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);	
		}
		return Msg.success();
	}
	
	/**
	 * 更新员工信息
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	public Msg empMsg(Employee employee) {
		System.out.println("将要更新的员工信息：" + employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	/**
	 * 根据id查询员工信息
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value ="/emp/{id}", method = RequestMethod.GET)
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	
	/**
	 * 保存员工
	 * 
	 * @param employee
	 * @param result   校验结果
	 * @return
	 */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		// 如果校验出错误
		if (result.hasErrors()) {
			// 在模态框中显示校验错误的信息
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> fieldErrors = result.getFieldErrors(); // 获取所有字段的校验信息
			for (FieldError fieldError : fieldErrors) {
				System.out.println("错误的字段名：" + fieldError.getField()); // 错误的字段名
				System.out.println("错误信息：" + fieldError.getDefaultMessage()); // 错误信息
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		} else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}

	/**
	 * 检测用户名是否可用
	 * 
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/checkuser", method = RequestMethod.POST)
	public Msg checkUser(String empName) {
		// 先判断用户名是否合法
		String reg = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if (!empName.matches(reg)) {
			return Msg.fail().add("validate_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
		}

		Boolean b = employeeService.checkUser(empName);
		// 如果没有相同的用户名
		if (b) {
			return Msg.success();
		} else {
			// 添加验证不可用的信息
			return Msg.fail().add("validate_msg", "用户名不可用");
		}
	}

	/**
	 * 查询员工数据，直接返回JSON数据
	 * 
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody // 直接返回数据
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 引入PageHelper分页插件
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll(); // 查询所有员工数据

		// 使用PageInfo包装查询后的结果，包含查询出的员工信息，以及连续显示的页数
		PageInfo pageInfo = new PageInfo(emps, 5); // 显示页码数量：5
		return Msg.success().add("pageInfo", pageInfo);
	}

	/**
	 * 查询员工数据，分页查询
	 * 
	 * @return
	 */
//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		// 引入PageHelper分页插件
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll(); // 查询所有员工数据

		// 使用PageInfo包装查询后的结果，包含查询出的员工信息，以及连续显示的页数
		PageInfo pageInfo = new PageInfo(emps, 5); // 显示页码数量：5
		model.addAttribute("pageInfo", pageInfo); // 将PageInfo放入请求域
		return "list";
	}

}
