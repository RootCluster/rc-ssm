<%--
  ~ Copyright (C) 2018 Jerry xu Open Source Project
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~      http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  --%>

<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 5/9/2018
  Time: 12:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>jsp数据绑定</title>
    <%--web 路径：
        不以"/"开始的相对路径，找资源，以当前资源的路径为基准，容易出问题。
        以"/"开始的相对路径，找资源，以服务器的路径为标准（http://localhost:3306）；需要加上项目名
                http://localhost:3306/{projectName}--%>
    <%
        application.setAttribute("PROJECT_PATH", request.getContextPath());
    %>
    <!-- 引入样式 -->
    <script type="text/javascript" src="${PROJECT_PATH}/static/js/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="${PROJECT_PATH}static/css/bootstrap.min.css">
    <script type="text/javascript" src="${PROJECT_PATH}static/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <div class="row ">
        <div class="col-md-12"><h2>项目：SSM</h2></div>
    </div>

    <%--<br><br><br>--%>
    <div class="row justify-content-end">
        <div class="col-2">
            <button type="button" class="btn btn-primary">新增</button>
            <button type="button" class="btn btn-danger">删除</button>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover table-bordered">
                <thead>
                <tr>
                    <th scope="col">编号</th>
                    <th scope="col">姓名</th>
                    <th scope="col">性别</th>
                    <th scope="col">邮箱</th>
                    <th scope="col">所在部门</th>
                    <th scope="col">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <th scope="row">${emp.empId}</th>
                        <td>${emp.empName}</td>
                        <td>${emp.gender=="M"?"男":"女"}</td>
                        <td>${emp.email}</td>
                        <td>${emp.department.departName}</td>
                        <td>
                            <button type="button" class="btn btn-outline-primary btn-sm">
                                新增
                            </button>
                            <button type="button" class="btn btn-outline-danger btn-sm">删除</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            当前第<span class="badge badge-primary">${pageInfo.pageNum}</span>页，共<span
                class="badge badge-primary">${pageInfo.pages}</span>页，共<span
                class="badge badge-primary">${pageInfo.total}</span>条记录
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-end">
                    <li class="page-item"><a class="page-link" href="${PROJECT_PATH}/emp?pageNumber=1">首页</a></li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li class="page-item active">
                            <a class="page-link" href="${PROJECT_PATH}/emp?pageNumber=${pageInfo.pageNum-1}"
                               tabindex="-1">Previous</a>
                        </li>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="pageNumber">
                        <c:if test="${pageNumber==pageInfo.pageNum}">
                            <li class="page-item active"><a class="page-link" href="#">${pageNumber}</a></li>
                        </c:if>
                        <c:if test="${pageNumber!=pageInfo.pageNum}">
                            <li class="page-item"><a class="page-link"
                                                     href="${PROJECT_PATH}/emp?pageNumber=${pageNumber}">${pageNumber}</a>
                            </li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link active"
                               href="${PROJECT_PATH}/emp?pageNumber=${pageInfo.pageNum+1}">Next</a>
                        </li>
                    </c:if>
                    <li class="page-item"><a class="page-link"
                                             href="${PROJECT_PATH}/emp?pageNumber=${pageInfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>

</body>
</html>
