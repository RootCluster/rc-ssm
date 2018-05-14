package org.incoder.test;

import org.apache.ibatis.session.SqlSession;
import org.incoder.bean.Department;
import org.incoder.bean.Employee;
import org.incoder.dao.DepartmentMapper;
import org.incoder.dao.EmployeeMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author Jerry
 * 1.导入Spring模块
 * 2.ContextConfiguration注解指定Spring配置文件的位置
 * 3.直接autowired使用的模块
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    /**
     * 原始方法
     */
    @Test
    public void testCRUD() {
        //1.创建spring ioc容器
        /*ApplicationContext context = new ClassPathXmlApplicationContext();
        //2.从容器中获取mapper
        DepartmentMapper mapper = context.getBean(DepartmentMapper.class);*/
    }

    /**============================推荐使用spring的单元测试(@ContextConfiguration)============================**/
    /**
     * 部门创建
     */
    @Test
    public void springDepartmentCreate() {
        departmentMapper.insertSelective(new Department(null, "开发部"));
        departmentMapper.insertSelective(new Department(null, "产品部"));
        departmentMapper.insertSelective(new Department(null, "运维部"));
        departmentMapper.insertSelective(new Department(null, "测试部"));
        departmentMapper.insertSelective(new Department(null, "设计部"));
    }

    /**
     * 部门删除
     */
    @Test
    public void springDepartmentDelete() {

    }


    /**
     * 部门更新
     */
    @Test
    public void springDepartmentUpdate() {

    }

    /**
     * 部门查询
     */
    @Test
    public void springDepartmentRetrieve() {

    }

    /**
     * 人员新增
     */
    @Test
    public void springEmployeeCreate() {
        // 插入单个人员数据
//        employeeMapper.insertSelective(new Employee(null, 11, "Jerry", "M", "Jerry.x@outlook.com"));
        // 批量插入人员数据
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 500; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, 1, uid, "M", uid + "@outlook.com"));
        }
        System.out.println("批量完成添加人员");
    }

    /**
     * 人员删除
     */
    @Test
    public void springEmployeeDelete() {

    }

    /**
     * 人员更新
     */
    @Test
    public void springEmployeeUpdate() {

    }

    /**
     * 人员查询
     */
    @Test
    public void springEmployeeRetrieve() {

    }

}
