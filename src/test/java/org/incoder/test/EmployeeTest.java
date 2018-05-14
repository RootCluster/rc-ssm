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

package org.incoder.test;

import com.github.pagehelper.PageInfo;
import org.incoder.bean.Employee;
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

import java.util.List;

/**
 * Description.
 *
 * @author : Jerry xu
 * @version : 1.0
 * @since : 5/9/2018 3:57 PM
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "file:src/main/resources/applicationContext.xml"})
public class EmployeeTest {

    // 传入SpringMVC的ioc
    @Autowired
    WebApplicationContext context;
    // 模拟mvc请求，获取到处理结果
    MockMvc mockMvc;

    @Before
    public void initMokcMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        // 模拟请求获取到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emp").param("pageNumber", "1")).andReturn();
        // 请求成功后，请求域中会有pageInfo进行验证数据
        MockHttpServletRequest request = result.getRequest();
        PageInfo attribute = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码：" + attribute.getPageNum());
        System.out.println("总页码：" + attribute.getPages());
        System.out.println("总记录数：" + attribute.getTotal());
        System.out.println("在页面需要连续显示的页码");
        int[] nums = attribute.getNavigatepageNums();
        for (int num : nums) {
            System.out.print("  " + num);
        }

        // 获取员工数据
        List<Employee> employeeList = attribute.getList();
        for (Employee employee : employeeList) {
            System.out.println("\n获取员工数据==ID:" + employee.getEmpId() + ",Name:" + employee.getEmpName());
        }
    }
}
