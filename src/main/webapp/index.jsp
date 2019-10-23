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
  Date: 5/10/2018
  Time: 12:55 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>json数据解析</title>
    <%--web 路径：
        不以"/"开始的相对路径，找资源，以当前资源的路径为基准，容易出问题。
        以"/"开始的相对路径，找资源，以服务器的路径为标准（http://localhost:3306）；需要加上项目名
                http://localhost:3306/{projectName}--%>
    <%
        application.setAttribute("PROJECT_PATH", request.getContextPath());
    %>
    <!-- 引入样式 -->
    <script type="text/javascript" src="${PROJECT_PATH}/static/js/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="${PROJECT_PATH}/static/css/bootstrap.min.css">
    <script type="text/javascript" src="${PROJECT_PATH}/static/js/bootstrap.min.js"></script>
</head>
<body>
<%--新增用户弹窗--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">添加员工</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group row">
                        <label for="empName" class="col-sm-2 col-form-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empName" name="empName" placeholder="您的姓名">
                            <div class="tip_text"></div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="email" class="col-sm-2 col-form-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="email" name="email"
                                   placeholder="name@example.com">
                            <div class="tip_text"></div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">性别</label>
                        <div class="col-sm-10">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="gender_m"
                                       value="M" checked>
                                <label class="form-check-label" for="gender_m">男</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="gender_f"
                                       value="F">
                                <label class="form-check-label" for="gender_f">女</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">部门</label>
                        <div class="col-sm-5">
                            <label>
                                <select class="custom-select" name="depId"></select>
                            </label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save">保存</button>
            </div>
        </div>
    </div>
</div>
<%--修改用户弹窗--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">修改员工</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group row">
                        <label for="update_emp_name" class="col-sm-2 col-form-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" readonly class="form-control-plaintext" id="update_emp_name">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="email_update" class="col-sm-2 col-form-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="email_update" name="email"
                                   placeholder="name@example.com">
                            <div class="tip_text"></div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">性别</label>
                        <div class="col-sm-10">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="gender_m_update"
                                       value="M" checked>
                                <label class="form-check-label" for="gender_m_update">男</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="gender_f_update"
                                       value="F">
                                <label class="form-check-label" for="gender_f_update">女</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">部门</label>
                        <div class="col-sm-5">
                            <label>
                                <select class="custom-select" name="depId"></select>
                            </label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update">更新</button>
            </div>
        </div>
    </div>
</div>
<%--删除提醒弹窗--%>
<div class="modal" tabindex="-1" role="dialog" id="empDeleteModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">删除员工</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p id="delete_tip"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="confirm_delete">确认</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row ">
        <div class="col-md-12"><h2>项目：SSM</h2></div>
    </div>
    <div class="row justify-content-end">
        <div class="col-2">
            <button type="button" class="btn btn-primary" data-toggle="modal" id="emp_add_modal">新增
            </button>
            <button type="button" class="btn btn-danger" data-toggle="modal" id="emp_delete_all">删除
            </button>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover table-bordered" id="emp_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="check_all"></th>
                    <th scope="col">编号</th>
                    <th scope="col">姓名</th>
                    <th scope="col">性别</th>
                    <th scope="col">邮箱</th>
                    <th scope="col">所在部门</th>
                    <th scope="col">操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6" id="page_info_area"></div>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
    <script type="text/javascript">
        // 记录数据最后总数
        var totalRecord;
        // 记录当前页
        var currentPage;
        var verificationName;
        var verificationEmail;
        var singleElection = false;

        $(function () {
            to_page(1);
        });

        function to_page(pn) {
            $.ajax({
                url: "${PROJECT_PATH}/empList",
                data: "pageNumber=" + pn,
                dataType: 'json',
                type: "GET",
                success: function (result) {
                    // 加载表格数据
                    build_emp_table(result);
                    // 加载分页信息
                    build_page_info(result);
                    // 加载分页导航数据
                    build_page_nav(result);
                }
            });
        }

        // 加载表格数据
        function build_emp_table(result) {
            // 清空表格数据
            $("#emp_table tbody").empty();
            var empData = result.data.extended.list;
            $.each(empData, function (index, item) {
                var checkboxTd = $("<td><input type='checkbox' class='check_item'></td>");
                var employeeIdTd = $("<td></td>").append(item.empId);
                var employeeNameTd = $("<td></td>").append(item.empName);
                var employeeGenderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
                var employeeEmailTd = $("<td></td>").append(item.email);
                var employeeDepartNameTd = $("<td></td>").append(item.department.departName);
                // 按钮
                var editBtn = $("<button></button>").addClass("btn btn-outline-primary btn-sm emp_update_btn").append("编辑");
                // 自定义给编辑按钮加入员工的id字段，方便修改获取当前用户的id
                editBtn.attr("emp_id", item.empId);
                var deleteBtn = $("<button></button>").addClass("btn btn-outline-danger btn-sm emp_delete_btn").append("删除");
                // 自定义给删除按钮加入员工的id字段，方便修改获取当前用户的id
                deleteBtn.attr("emp_id", item.empId);
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
                $("<tr></tr>").append(checkboxTd).append(employeeIdTd)
                    .append(employeeNameTd)
                    .append(employeeGenderTd)
                    .append(employeeEmailTd)
                    .append(employeeDepartNameTd)
                    .append(btnTd)
                    .appendTo("#emp_table tbody");
            });
        }

        // 加载分页信息
        function build_page_info(result) {
            $("#page_info_area").empty();
            $("#page_info_area").append("当前第<span class='badge badge-primary'>" + result.data.extended.pageNum + "</span>页，共" +
                "<span class='badge badge-primary'>" + result.data.extended.pages + "</span>页，共" +
                "<span class='badge badge-primary'>" + result.data.extended.total + "</span>条记录");
            totalRecord = result.data.extended.total;
            currentPage = result.data.extended.pageNum;
        }

        // 加载分页导航数据
        function build_page_nav(result) {
            $("#page_nav_area").empty();
            var ul = $("<ul class='pagination justify-content-end'></ul>");
            var firstPageLi = $("<li class='page-item'></li>").append($("<a class='page-link' href='#'>首页</a>"));
            var prePageLi = $("<li class='page-item'></li>").append($("<a class='page-link' href='#'>&laquo;</a>"));
            if (result.data.extended.hasPreviousPage == false) {
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            } else {
                ul.append(firstPageLi).append(prePageLi);
                firstPageLi.click(function () {
                    to_page(1)
                });
                prePageLi.click(function () {
                    to_page(result.data.extended.pageNum - 1)
                });
            }
            var nextPageLi = $("<li class='page-item'></li>").append($("<a class='page-link' href='#'>&raquo;</a>"));
            var lastPageLi = $("<li class='page-item'></li>").append($("<a class='page-link' href='#'>末页</a>"));
            if (result.data.extended.hasNextPage == false) {
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            } else {
                nextPageLi.click(function () {
                    to_page(result.data.extended.pageNum + 1)
                });
                lastPageLi.click(function () {
                    to_page(result.data.extended.pages)
                });
            }
            $.each(result.data.extended.navigatepageNums, function (index, item) {
                var numLi = $("<li></li>").addClass("page-item").append($("<a class='page-link' href='#'>" + item + "</a>"));
                if (result.data.extended.pageNum == item) {
                    numLi.addClass("active");
                }
                numLi.click(function () {
                    to_page(item);
                });
                ul.append(numLi);
            });
            // 下一页和末页提示
            ul.append(nextPageLi).append(lastPageLi);
            $("<nav></nav>").attr("aria-label", "Page navigation").append(ul).appendTo("#page_nav_area");
        }

        // 获取部门数据
        function get_dept(ele) {
            // 清空下拉列表数据
            $(ele).empty();
            $.ajax({
                url: "${PROJECT_PATH}/dept",
                dataType: 'json',
                type: "GET",
                success: function (result) {
                    $.each(result.data.extended, function () {
                        var optionEle = $("<option></option>").append(this.departName).attr("value", this.departId);
                        optionEle.appendTo(ele)
                    })
                }
            });
        }

        // 修改员工信息
        $(document).on("click", ".emp_update_btn", function () {
            // 重置表单
            reset_form("#empUpdateModal form");
            // 获取部门数据
            get_dept("#empUpdateModal select");
            // 获取用信息
            $.ajax({
                url: "${PROJECT_PATH}/emp/" + $(this).attr("emp_id"),
                dataType: 'json',
                type: "GET",
                success: function (result) {
                    // 修改用户弹框默认值
                    $("#update_emp_name").val(result.data.emp.empName);
                    $("#email_update").val(result.data.emp.email);
                    var genderValue = result.data.emp.gender;
                    // radio 赋值
                    $("#empUpdateModal input[name=gender]").val([genderValue]);
                    // select 下拉框赋值
                    $("#empUpdateModal select[name=depId]").val([result.data.emp.depId]);
                }
            });
            // 员工id传递给修改模态框
            $("#emp_update").attr("emp_id", $(this).attr("emp_id"));
            $('#empUpdateModal').modal({
                    backdrop: 'static'
                }
            );

        });

        // 新增员工
        $("#emp_add_modal").click(function () {
            // 重置表单
            reset_form("#empAddModal form");
            // 获取部门数据
            get_dept("#empAddModal select");
            // 弹出模态框
            $('#empAddModal').modal({
                    backdrop: 'static'
                }
            );
        });

        // 单个删除员工
        $(document).on("click", ".emp_delete_btn", function () {
            $("#delete_tip").text("确认删除 【" + $(this).parents("tr").find("td:eq(2)").text() + "】 员工吗？");
            // 员工id传递给删除模态框
            $("#confirm_delete").attr("emp_id", $(this).attr("emp_id"));
            // 弹出模态框
            $('#empDeleteModal').modal({
                    backdrop: 'static'
                }
            );
        });

        // 单选
        $(document).on("click", ".check_item", function () {
            var flag = $(".check_item:checked").length == $(".check_item").length
            $("#check_all").prop("checked", flag);
        });

        // 全选/全不选
        $("#check_all").click(function () {
            $(".check_item").prop("checked", $(this).prop("checked"));
        });

        // 全部删除
        $("#emp_delete_all").click(function () {
            var empName = "";
            var empIds = "";
            $.each($(".check_item:checked"), function () {
                empName += $(this).parents("tr").find("td:eq(2)").text() + ",";
                empIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
            });
            var newEmpName = empName.substring(0, empName.length - 1);
            var newEmpId = empIds.substring(0, empIds.length - 1);
            $("#delete_tip").text("确认删除 【" + newEmpName + "】 员工吗？");
            // 员工id传递给删除模态框
            $("#confirm_delete").attr("emp_id", newEmpId);
            // 初始化单选标识
            singleElection = true;
            // 弹出模态框
            $('#empDeleteModal').modal({
                    backdrop: 'static'
                }
            );
        });

        // 更新员工
        $("#emp_update").click(function () {
            // 验证邮箱
            if (verificationEmail) {
                $.ajax({
                    url: "${PROJECT_PATH}/emp/" + $(this).attr("emp_id"),
                    // 方式一POST请求
                    /*type: "POST",
                    data: $("#empUpdateModal form").serialize()+"&_method=PUT",*/
                    // 方式二PUT请求
                    type: "PUT",
                    data: $("#empUpdateModal form").serialize(),
                    success: function (result) {
                        if (result.code == 0) {
                            // 服务端校验返回失败信息
                            if (undefined != result.data.errorFields.email) {
                                // 显示邮箱的错误信息
                                show_validate_msg("#email", "error", result.data.errorFields.email);
                            }
                            if (undefined != result.data.errorFields.empName) {
                                show_validate_msg("#empName", "error", result.data.errorFields.empName);
                            }
                        } else {
                            // 关闭添加员工弹框
                            $("#empUpdateModal").modal("hide");
                            // 跳转修改当前页
                            to_page(currentPage);
                        }
                    }
                });
            }
        });

        // 保存员工
        $("#emp_save").click(function () {
            if (verificationName && verificationEmail) {
                $.ajax({
                    url: "${PROJECT_PATH}/emp",
                    type: "POST",
                    data: $("#empAddModal form").serialize(),
                    success: function (result) {
                        if (result.code == 0) {
                            // 服务端校验返回失败信息
                            if (undefined != result.data.errorFields.email) {
                                // 显示邮箱的错误信息
                                show_validate_msg("#email", "error", result.data.errorFields.email);
                            }
                            if (undefined != result.data.errorFields.empName) {
                                show_validate_msg("#empName", "error", result.data.errorFields.empName);
                            }
                        } else {
                            // 关闭添加员工弹框
                            $("#empAddModal").modal("hide");
                            // 跳转到最后一页
                            to_page(totalRecord);
                        }
                    }
                });
            }
        });

        // 删除员工
        $("#confirm_delete").click(function () {
            if (singleElection) {
                // 多选
                deleteEmp();
                singleElection = false;
            } else {
                // 单选删除
                deleteEmp();
            }
        });

        function deleteEmp() {
            $.ajax({
                url: "${PROJECT_PATH}/emp/" + $(this).attr("emp_id"),
                type: "DELETE",
                data: $("#empAddModal form").serialize(),
                success: function (result) {
                    if (result.code == 0) {

                    } else {
                        // 关闭添加员工弹框
                        $("#empDeleteModal").modal("hide");
                        // 跳转到当前页
                        to_page(currentPage);
                    }
                }
            });
        };

        // 用户名输入改变时进行校验
        $("#empName").change(function () {
            // 1.先校验格式是否满足
            var empName = $("#empName").val();
            // 正则规则英文字符6—16，中文2—8个字符
            var regName = new RegExp("/(^[a-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,8}$)/");
            if (regName.test(empName)) {
                // 校验失败
                show_validate_msg("#empName", "error", "用户名可以是6-16位英文字符，或者2-8位中文字符");
                return false;
            }
            // 2.校验服务器是否有重复用户
            $.ajax({
                url: "${PROJECT_PATH}/check/user",
                type: "GET",
                data: "userName=" + this.value,
                success: function (result) {
                    // 用户名重复
                    if (result.data.result) {
                        verificationName = true;
                        show_validate_msg("#empName", "success", "有效的用户名");
                    } else {
                        verificationName = false;
                        show_validate_msg("#empName", "error", result.data.ver_msg);
                    }
                }
            });
        });

        // 新增员工邮箱输入改变时进行校验
        $("#email").change(function () {
            verificationEmailDate("#email");
        });

        // 修改员工邮箱输入改变时进行校验
        $("#email_update").change(function () {
            verificationEmailDate("#email_update");
        });

        // 邮箱格式及数据校验
        function verificationEmailDate(ele) {
            var email = $(ele).val();
            var regMail = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$");
            if (!regMail.test(email)) {
                // 校验失败
                show_validate_msg(ele, "error", "请输入正缺格式邮箱，如：name@example.com");
                verificationEmail = false;
                return false;
            } else {
                show_validate_msg(ele, "success", "有效的邮箱");
                verificationEmail = true;
            }
        }

        // 显示验证信息
        function show_validate_msg(ele, status, msg) {
            // 清除当前元素状态
            $(ele).removeClass("is-valid is-invalid");
            $(ele).next("div").removeClass("valid-feedback invalid-feedback");
            // 清除提示文字
            $(ele).find(".tip_text").text("");
            if ("success" == status) {
                $(ele).addClass("is-valid");
                $(ele).next("div").addClass("valid-feedback").text(msg);
            } else if ("error" == status) {
                $(ele).addClass("is-invalid");
                $(ele).next("div").addClass("invalid-feedback").text(msg);
            }
        }

        // 重置表单
        function reset_form(ele) {
            // 清除表单数据
            $(ele)[0].reset();
            // 清除表单样式
            $(ele).find("*").removeClass("is-valid is-invalid valid-feedback invalid-feedback");
            // 清除文字提示
            $(ele).next("div").text("");
        }
    </script>
</div>

</body>
</html>

