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
				<button class="btn btn-primary" type="button">新增</button>
				<button class="btn btn-danger" type="button">删除</button>
			</div>
		</div>

		<!-- 表格数据信息 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>lastName</th>
						<th>email</th>
						<th>gender</th>
						<th>depName</th>
						<th>操作</th>
					</tr>
					<!-- 遍历数据 -->
					<c:forEach items="${pageInfo.list}" var="emp">
						<tr>
							<th>${emp.empId }</th>
							<th>${emp.empName }</th>
							<th>${emp.email }</th>
							<th>${emp.gender }</th>
							<th>${emp.department.deptName }</th>
							<th>
								<button class="btn btn-info btn-sm" type="button">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true">编辑</span>
								</button>
								<button class="btn btn-danger btn-sm" type="button">
									<span class="glyphicon glyphicon-trash" aria-hidden="true">删除</span>
								</button>
							</th>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>

		<!-- 分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">当前第${pageInfo.pageNum }页，共有${pageInfo.pages }页，总计${ pageInfo.total}条记录
			</div>

			<!-- 分页条信息 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
					<ul class="pagination">
						<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
						<!-- 在第一页时不显示前一页标志 -->
						<c:if test="${pageInfo.hasPreviousPage}">
							<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>
						<!-- 遍历需要在页面显示的页码数组 -->
						<c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
							<!-- 当前页高亮显示 -->
							<c:if test="${page_Num == pageInfo.pageNum }">
								<li class="active"><a href="#">${page_Num }</a></li>
							</c:if>
							<c:if test="${page_Num != pageInfo.pageNum }">
								<li><a href="${APP_PATH }/emps?pn=${page_Num }">${page_Num }</a></li>
							</c:if>
						</c:forEach>
						<c:if test="${pageInfo.hasNextPage }">
							<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:if>
						<li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">尾页</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>