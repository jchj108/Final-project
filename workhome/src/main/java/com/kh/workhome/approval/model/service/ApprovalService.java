package com.kh.workhome.approval.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.workhome.approval.model.dao.ApprovalDAO;
import com.kh.workhome.approval.model.vo.Approval;

@Service("aService")
public class ApprovalService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	ApprovalDAO aDAO;

	public int insertApproval(Approval ap) {
		return aDAO.insertApproval(sqlSession, ap);
	}

	public ArrayList<Approval> selectApprovalList(String empNo) {
		return aDAO.selectApprovalList(sqlSession, empNo);
	}

	public Approval selectApprovalDetail(String apNo) {
		return aDAO.selectApprovalDetail(sqlSession, apNo);
	}

	public int updateAp(Approval ap) {
		return aDAO.updateAp(sqlSession, ap);
	}

	public ArrayList<Approval> selectApListByAr(String[] array) {
		return aDAO.selectApListByAr(sqlSession, array);
	}

	public int deleteAp(String apNo) {
		return aDAO.deleteAp(sqlSession, apNo);
	}

	public ArrayList<Approval> selectDeptVacation(ArrayList<String> emp) {
		return aDAO.selectDeptVacation(sqlSession, emp);
	}
}
