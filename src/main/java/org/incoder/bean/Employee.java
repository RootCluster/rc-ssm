package org.incoder.bean;

import javax.validation.constraints.Pattern;

public class Employee {
    private Integer empId;

    private Integer depId;

    @Pattern(regexp = "(^[a-z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,8}$)/", message = "用户名必须是6—16位数字，字母或者是2—8位中文字符")
    private String empName;

    private String gender;

    // @Email
    @Pattern(regexp = "[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$",message = "请输入正缺格式邮箱，如：name@example.com    ")
    private String email;

    private Department department;

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public Integer getDepId() {
        return depId;
    }

    public void setDepId(Integer depId) {
        this.depId = depId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Employee() {
    }

    public Employee(Integer empId, Integer depId, String empName, String gender, String email) {
        this.empId = empId;
        this.depId = depId;
        this.empName = empName;
        this.gender = gender;
        this.email = email;
    }
}