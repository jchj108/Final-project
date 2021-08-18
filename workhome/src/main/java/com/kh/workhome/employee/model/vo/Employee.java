package com.kh.workhome.employee.model.vo;

import java.sql.Date;

public class Employee {

	private String empNo; // 사원번호
	private String empName; // 성명
	private String empPosition; // 직급
	private Date joinDate; // 입사일
	private String phone; // 개인번호
	private String empPhone; // 내선번호
	private String email; // 이메일
	private String address; // 주소
	private String empStatus; //상태 Y- 재직중, N-퇴사, A-관리자 권한
	private String empAuto; // **** 사용 x ****
	private String password; // 비밀번호
	private String deptNo; // 부서번호
	private String deptName; // 부서명
	
	public Employee() {}

	public Employee(String empNo, String empName, String empPosition, Date joinDate, String phone, String empPhone,
			String email, String address, String empStatus, String empAuto, String password, String deptNo,
			String deptName) {
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
		this.deptName = deptName;
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

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	@Override
	public String toString() {
		return "Employee [empNo=" + empNo + ", empName=" + empName + ", empPosition=" + empPosition + ", joinDate="
				+ joinDate + ", phone=" + phone + ", empPhone=" + empPhone + ", email=" + email + ", address=" + address
				+ ", empStatus=" + empStatus + ", empAuto=" + empAuto + ", password=" + password + ", deptNo=" + deptNo
				+ ", deptName=" + deptName + "]";
	}
	
}
