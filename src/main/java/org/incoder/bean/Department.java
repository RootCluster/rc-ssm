package org.incoder.bean;

public class Department {
    private Integer departId;

    private String departName;

    public Integer getDepartId() {
        return departId;
    }

    public void setDepartId(Integer departId) {
        this.departId = departId;
    }

    public String getDepartName() {
        return departName;
    }

    public void setDepartName(String departName) {
        this.departName = departName == null ? null : departName.trim();
    }

    public Department(Integer departId, String departName) {
        this.departId = departId;
        this.departName = departName;
    }

    public Department() {
    }
}