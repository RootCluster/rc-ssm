/*
 * Copyright (C) 2018 Jerry xu Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.incoder.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.incoder.BaseResponse;
import org.incoder.bean.Employee;
import org.incoder.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 员工控制器.
 *
 * @author : Jerry xu
 * @version : 1.0
 * @since : 5/9/2018 3:44 PM
 */
@Controller
public class EmployeeController {

    private final EmployeeService employeeService;

    @Autowired
    public EmployeeController(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    /**
     * 获取员工信息
     *
     * @param pageNumber 页码
     * @return 封装返回
     */
    @ResponseBody
    @RequestMapping("/empList")
    public BaseResponse getEmpList(@RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber) {
        // 引入PageHelper分页插件
        PageHelper.startPage(pageNumber, 5);
        // 分页查询数据
        List<Employee> emp = employeeService.getAll();
        // 包装查询出的信息
        PageInfo<? extends Employee> info = new PageInfo<Employee>(emp, 5);
        return BaseResponse.success().add("extended", info);
    }

    /**
     * 分页查询所有员工
     *
     * @param pageNumber 当前页
     * @param model      模型
     * @return 字符
     */
    @RequestMapping("/empBind")
    public String getEmp(@RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber, Model model) {
        // 引入PageHelper分页插件
        PageHelper.startPage(pageNumber, 5);
        // 分页查询数据
        List<Employee> emp = employeeService.getAll();
        // 包装查询出的信息
        PageInfo<? extends Employee> info = new PageInfo<Employee>(emp, 5);
        model.addAttribute("pageInfo", info);
        return "list";
    }

    /**
     * 保存员工
     *
     * @param employee 员工对象
     * @return 封装返回
     */
    @ResponseBody
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    public BaseResponse saveEmp(@Valid Employee employee, BindingResult result) {
        // 服务端校验
        if (result.hasErrors()) {
            Map<String, Object> map = new HashMap<String, Object>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                map.put(fieldError.getField(), fieldError.getRejectedValue());
            }
            return BaseResponse.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return BaseResponse.success();
        }
    }

    /**
     * 员工用户名校验
     *
     * @param userName 用户名
     * @return 封装返回
     */
    @ResponseBody
    @RequestMapping("/check/user")
    public BaseResponse checkUser(@RequestParam("userName") String userName) {
        // 校验用户名是否合法
        String reg = "(^[a-z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,8}$)";
        if (!userName.matches(reg)) {
            return BaseResponse.fail().add("ver_msg", "用户名必须是6—16位数字，字母或者是2—8位中文字符");
        }
        // 服务器数据库用户名是否重复校验
        boolean result = employeeService.checkUser(userName);
        if (result) {
            return BaseResponse.success().add("result", true);
        } else {
            return BaseResponse.success().add("result", false).add("ver_msg", "用户名不可用");
        }
    }

    /**
     * 根据用户id获取用户信息
     *
     * @param id 用户id
     * @return 用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    public BaseResponse getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmployById(id);
        return BaseResponse.success().add("emp", employee);
    }

    @RequestMapping(value = "/emp/{id}", method = RequestMethod.PUT)
    public BaseResponse updateEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return BaseResponse.success();
    }


}
