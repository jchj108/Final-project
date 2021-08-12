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

	
}
