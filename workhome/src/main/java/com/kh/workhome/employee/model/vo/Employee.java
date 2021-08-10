package com.kh.workhome.employee.model.vo;

import java.sql.Date;

public class Employee {

	private String empNo;
	private String empName;
	private String empPosition;
	private Date joinDate;
	private String phone;
	private String empPhone;
	private String email;
	private String address;
	private String empStatus;
	private String empAuto;
	private String password;
	private String deptNo;
	private String empId;
	
	public Employee() {}
	
	public Employee(String empNo, String empName, String empPosition, Date joinDate, String phone, String empPhone,
			String email, String address, String empStatus, String empAuto, String password, String deptNo, String empId) {
		super();
		this.empNo = empNo;
		this.empName = empName;
		this.empPosition = empPosition;
		this.joinDate = joinDate;
		this.phone = phone;
		this.empPhone = empPhone;
		this.email = email;
		this.address = address;
		this.empStatus = empStatus;
		this.empAuto = empAuto;
		this.password = password;
		this.deptNo = deptNo;
		this.empId = empId;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getEmpPosition() {
		return empPosition;
	}
	public void setEmpPosition(String empPosition) {
		this.empPosition = empPosition;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmpPhone() {
		return empPhone;
	}
	public void setEmpPhone(String empPhone) {
		this.empPhone = empPhone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmpStatus() {
		return empStatus;
	}
	public void setEmpStatus(String empStatus) {
		this.empStatus = empStatus;
	}
	public String getEmpAuto() {
		return empAuto;
	}
	public void setEmpAuto(String empAuto) {
		this.empAuto = empAuto;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getDeptNo() {
		return deptNo;
	}
	public void setDeptNo(String deptNo) {
		this.deptNo = deptNo;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	@Override
	public String toString() {
		return "Employee [empNo=" + empNo + ", empName=" + empName + ", empPosition=" + empPosition + ", joinDate="
				+ joinDate + ", phone=" + phone + ", empPhone=" + empPhone + ", email=" + email + ", address=" + address
				+ ", empStatus=" + empStatus + ", empAuto=" + empAuto + ", password=" + password + ", deptNo=" + deptNo
				+ ", empId=" + empId + "]";
	}
	
}
