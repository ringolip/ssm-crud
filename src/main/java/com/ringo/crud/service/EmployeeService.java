package com.ringo.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ringo.crud.bean.Employee;
import com.ringo.crud.bean.EmployeeExample;
import com.ringo.crud.bean.EmployeeExample.Criteria;
import com.ringo.crud.dao.EmployeeMapper;


/**
 * 查询所有员工
 * @author ringo
 *
 */
@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	private EmployeeExample employeeExample;
	
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
	}
	
	/**
	 * 检查是否有相同的用户名
	 * @param empName
	 * @return
	 */
	public Boolean checkUser(String empName) {
		// 设置查找条件
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName); // 查找与输入用户名相同的记录
		
		// 按照条件查找符合的记录数
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}
	
	/**
	 * 查询员工信息
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}
	
	/**
	 * 更新员工信息
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	// 删除单个员工
	public void deleteEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}
	
	// 删除多个员工
	public void deleteBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		// 按员工是否在这个集合进行删除
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}

}
