package com.kh.workhome.approval.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.workhome.approval.model.dao.ApprovalDAO;
import com.kh.workhome.approval.model.vo.Approval;

@Service("apService")
public class ApprovalService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	ApprovalDAO apDAO;

	public int insertApproval(Approval ap) {
		return apDAO.insertApproval(sqlSession, ap);
	}

	public ArrayList<Approval> selectApprovalList(String empNo) {
		return apDAO.selectApprovalList(sqlSession, empNo);
	}

	public Approval selectApprovalDetail(String apNo) {
		return apDAO.selectApprovalDetail(sqlSession, apNo);
	}

	public int updateAp(Approval ap) {
		return apDAO.updateAp(sqlSession, ap);
	}

	public ArrayList<Approval> selectApListByAr(String[] array) {
		return apDAO.selectApListByAr(sqlSession, array);
	}

	public int deleteAp(String apNo) {
		return apDAO.deleteAp(sqlSession, apNo);
	}

	public ArrayList<Approval> selectDeptVacation(ArrayList<String> emp) {
		return apDAO.selectDeptVacation(sqlSession, emp);
	}

}
