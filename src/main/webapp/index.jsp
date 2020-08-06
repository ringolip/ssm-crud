<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 引入标签库 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<!-- 获取项目路径 -->
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<!-- 引入JQuery -->
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<!-- 引入Bootstrap样式 -->
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>

	<%-- 引入bootstrap模态框，作为添加员工的输入框 --%>
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">lastName</label>
							<div class="col-sm-10">
								<input type="text" name= "empName" class="form-control" id="empName_add_input"
									placeholder="empName">
								<span class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_add_input" placeholder="email@gmail.com">
									<span class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<%-- radio-inline可以使这些控件排列在一行 --%>
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="男"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="女"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!-- 部门提交部门id即可 -->
								<select class="form-control" name="dId" id="dept_add_select">
								</select>
							</div>
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>

	<%-- 员工修改的模态框 --%>
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">lastName</label>
							<div class="col-sm-10">
								<input type="text" name= "empName" class="form-control" id="empName_update_input"
									placeholder="empName">
								<span class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_update_input" placeholder="email@gmail.com">
									<span class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<%-- radio-inline可以使这些控件排列在一行 --%>
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="男"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="女"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!-- 部门提交部门id即可 -->
								<select class="form-control" name="dId" id="dept_update_select">
								</select>
							</div>
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>

		<!-- 增删按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" type="button" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" type="button" id="emp_delete_all_btn">删除</button>
			</div>
		</div>

		<!-- 表格数据信息 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all">
							</th>
							<th>#</th>
							<th>lastName</th>
							<th>email</th>
							<th>gender</th>
							<th>depName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>

				</table>
			</div>
		</div>

		<!-- 分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>

			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>


	<script type="text/javascript">
		var totalRecord, currentPage; // 总记录数，当前页

		// 1.页面加载完成后，发送Ajax请求，获取分页数据
		$(function() {
			// 访问首页获取数据
			to_page(1);
		});

		// Ajax请求方法
		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "get",
				// 请求成功后的回调函数
				success : function(result) { // result服务器响应给浏览器的数据(JSON数据)
					// console.log(result);
					// 1.解析并显示员工信息
					build_emps_table(result)
					// 2.解析并显示分页文字信息
					build_page_info(result)
					// 3.解析并显示分页条信息
					build_page_nav(result)
				}
			});
		}

		// 解析并显示员工表格
		function build_emps_table(result) {
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			// 遍历员工数据
			$.each(emps,
					function(index, item) { // 遍历的元素，每次遍历的回调函数
						var checkBoxTd = $("<td></td>").append("<input type='checkbox' class='check_item'/>")
						var empIdTd = $("<td></td>").append(item.empId);
						var empNameTd = $("<td></td>").append(item.empName);
						var genderTd = $("<td></td>").append(item.gender);
						var emailTd = $("<td></td>").append(item.email);
						var depNameTd = $("<td></td>").append(
								item.department.deptName);
						var editBtn = $("<button></button>").addClass(
								"btn btn-info btn-sm edit_btn").append("<span></span>")
								.addClass("glyphicon glyphicon-pencil").append(
										"编辑");
						// 为编辑按键绑定员工ID属性
						editBtn.attr("edit_id", item.empId); 
						var delBtn = $("<button></button>").addClass(
								"btn btn-danger btn-sm delete_btn")
								.append("<span></span>").addClass(
										"glyphicon glyphicon-trash").append(
										"删除");
						// 为删除按键绑定员工ID属性
						delBtn.attr("edit_id", item.empId);
						var btnTd = $("<td></td>").append(editBtn).append(" ")
								.append(delBtn);

						// append方法执行完成以后还是返回原来的元素
						$("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd)
								.append(genderTd).append(emailTd).append(
										depNameTd).append(btnTd) // 编辑和删除键
								.appendTo("#emps_table tbody");
					})
		}

		// 解析并显示分页文字信息
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前第" + result.extend.pageInfo.pageNum + "页，共有"
							+ result.extend.pageInfo.pages + "页，总计"
							+ result.extend.pageInfo.total + "条记录")
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}

		// 解析并显示分页条信息
		function build_page_nav(result) {
			$("#page_nav_area").empty();
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));

			// 没有前一页时，禁用首页和前一页按键
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				// 添加单机事件
				firstPageLi.click(function() {
					to_page(1);
				})
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				})
			}

			var ul = $("<ul></ul>").addClass("pagination");
			// 将首页和上一页元素加入分页条
			ul.append(firstPageLi).append(prePageLi);

			// 遍历需要显示的页码，将页码加入分页条
			// $.each(需要遍历的元素,每次遍历的回调函数)
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				// 是当前页就将页码显示激活
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				// 为按键添加单机事件
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			});

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("尾页").attr("href", "#"));

			// 如果当前页没有下一页，将下一页和尾页按键禁用
			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("lastPageLi");
			} else {
				// 添加单机事件
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}

			// 将下一页和末页元素加入分页条
			ul.append(nextPageLi).append(lastPageLi);

			// 将列表元素加入bootstrap导航条元素
			var navEle = $("<nav></nav>").attr("aria-label", "Page navigation");
			navEle.append(ul).appendTo("#page_nav_area");
		}

		// 完全重置表单
		function reset_form(ele) { 
			// 清空表单数据
			$(ele)[0].reset();
			// 清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		 }

		// 单机新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function() {
			// 表单完全重置
			reset_form("#empAddModal form");
			// 查出部门信息，显示在下拉列表
			getDepts("#dept_add_select");
			// 弹出模态框
			$('#empAddModal').modal({
				backdrop : "static" // 点击时不关闭
			})
		});

		// 将部门信息显示在下拉列表
		function getDepts(ele) {
			// 清空之前下拉列表的数据
			$(ele).empty();

			$.ajax({
				url: "${APP_PATH}/depts",
				type: "get",
				success: function(result) {
					console.log(result);
					// 显示在部门下拉列表中
					$.each(result.extend.depts, function(index, item){
						var optionEle = $("<option></option>").append(item.deptName).attr("value", item.deptId);
						$(ele).append(optionEle);
					})
				}
			})
		}
		
		// 单机保存按键保存用户
		$("#emp_save_btn").click(function(){
			// 发送请求前先校验数据
			if(!validate_add_form()){
				return false;
			}

			// 用户名重复时禁用提交
			if($(this).attr("ajax-validate")=="error"){
				return false;
			}

			$.ajax({
				url: "${APP_PATH}/emp",
				// 序列化表格内容为字符串，作为请求参数
				data :$("#empAddModal form").serialize(),
				type: "post",
				success: function(result){
					// 后端校验
					if(result.code == 200){
						// 关闭模态框
						$('#empAddModal').modal('hide')
						// 跳转到最后一页
						to_page(totalRecord);
						alert(result.msg);
					} else {
						// 校验发现错误，显示错误信息
						console.log(result);
						// 有哪个字段的错误信息就显示哪个字段的
						if(undefined != result.extend.errorFields.email){
							show_validate_msg("#email_add_input", "has-error", result.extend.errorFields.email);
						}
						if(undefined != result.extend.errorFields.empName){
							show_validate_msg("#empName_add_input", "has-error", result.extend.errorFields.empName)
						}
					}
					
				}
			})
		})

		// 正则表达式校验数据
		function validate_add_form(){
			// 验证用户名格式
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			// 正则表达式校验数据
			if(!regName.test(empName)){
				show_validate_msg("#empName_add_input", "has-error", "用户名可以是2-5位中文或者6-16位英文和数字的组合")
				return false;
			} else {
				show_validate_msg("#empName_add_input", "has-success", "")
			}

			// 验证邮箱格式
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_add_input", "has-error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg("#email_add_input", "has-success", "");
			}
			return true;
		}

		// 显示验证信息
		function show_validate_msg(ele, status, msg){
			// 验证前先清除前一次的验证状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			// 验证
			$(ele).parent().addClass(status);
			$(ele).next("span").text(msg);
		}

		// 检测用户名是否重复
		$("#empName_add_input").change(function(){
			var empName = this.value;
			$.ajax({
				url: "${APP_PATH}/checkuser",
				data: "empName=" + empName,
				type: "post",
				success : function(result){
					// 如果用户名没有重复
					if(result.code == 200){
						show_validate_msg("#empName_add_input", "has-success", "用户名可用");
						$("#emp_save_btn").attr("ajax-validate", "success");
					} else if(result.code ==400){
						show_validate_msg("#empName_add_input", "has-error", result.extend.validate_msg);
						$("#emp_save_btn").attr("ajax-validate", "error")
					}
				}
			})
		})
			
		// 利用on方法为编辑按键绑定单机事件
		$(document).on("click", ".edit_btn", function () {
			// 查出员工信息并显示
			getEmp($(this).attr("edit_id"));
			// 查出部门信息并显示
			getDepts("#empUpdateModal select")
			// 将员工ID绑定为更新按键的属性
			$("#emp_update_btn").attr("edit_id", $(this).attr("edit_id"));
			// 显示更新模态框
			$('#empUpdateModal').modal({
				backdrop:"static"
			})
		});


		// 查处员工信息并显示
		function getEmp(id) { 
			$.ajax({
				url: "${APP_PATH}/emp/"+id,
				type: "get",
				success: function(result){
					console.log(result);
					// 显示员工数据
					var empData = result.extend.emp;
					$("#empName_update_input").val(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			});
		 }

		// 为更新按键绑定单机事件
		$("#emp_update_btn").click(function(){
			alert("更新");
			// 1.验证邮箱格式
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_update_input", "has-error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg("#email_update_input", "has-success", "");
			}

			// 2.发送Ajax，保存员工数据
			// $.ajax({
			// 	 url: "${APP_PATH}/emp/" + $(this).attr("edit_id"),
			// 	 data: $("#empUpdateModal form").serialize()+"&_method=PUT", // 序列化后的表单信息
			// 	 type: "post",
			// 	 success: function (result) { 
			// 		 alert(result.msg);
			// 	  }
			// })

			// 直接通过ajax发送PUT请求
			$.ajax({
				 url: "${APP_PATH}/emp/" + $(this).attr("edit_id"),
				 data: $("#empUpdateModal form").serialize(), // 序列化后的表单信息
				 type: "put",
				 success: function (result) { 
					//  alert(result.msg);
					// 1.关闭模态框
					$("#empUpdateModal").modal("hide");
					// 2.回到本页面
					to_page(currentPage);
				  }
			})
		})

		$(document).on("click", ".edit_btn", function () {
			// 查出员工信息并显示
			getEmp($(this).attr("edit_id"));
			// 查出部门信息并显示
			getDepts("#empUpdateModal select")
			// 将员工ID绑定为更新按键的属性
			$("#emp_update_btn").attr("edit_id", $(this).attr("edit_id"));
			// 显示更新模态框
			$('#empUpdateModal').modal({
				backdrop:"static"
			})
		});

		// 为删除按键绑定单机事件
		$(document).on("click", ".delete_btn", function(){
			// 获取empName
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			if(confirm("确认删除「" + empName + "」吗？")){
				$.ajax({
					url:"${APP_PATH}/emp/" + $(this).attr("edit_id"),
					type: "delete",
					success: function(result){
						// console.log(result);
						to_page(currentPage);
					}
				})
			}
		});

		// 为多选的删除按键绑定单击事件
		$("#emp_delete_all_btn").click(function(){
			var empNames = ""; // 选中删除的员工姓名
			var delIdStr = ""; // 选中删除的员工ID
			// 遍历选中的元素
			$.each($(".check_item:checked"), function(){
				empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
				delIdStr += $(this).parents("tr").find("td:eq(1)").text() + "-";
			});
			// 删除最后一个分隔符
			empNames = empNames.substring(0, empNames.length-1);
			delIdStr = delIdStr.substring(0, delIdStr.length-1);

			if(confirm("确认删除「" + empNames +"」吗？")){
				$.ajax({
					url: "${APP_PATH}/emp/" + delIdStr,
					type: "delete",
					success: function(result){
						console.log(result.msg);
						to_page(currentPage);
					}
				})
			}
		})

		// 绑定全选框单击事件
		$("#check_all").click(function(){
			// $(this).prop("checked");
			// prop获取dom原生对象属性
			$(".check_item").prop("checked", $(this).prop("checked"));
		})

		// 页面单选框全被选中时全选框也被选中
		$(document).on("click", ".check_item", function(){
			// 判断单选框是否全被选中
			var flag = $(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked", flag);
		})

	</script>
</body>
</html>