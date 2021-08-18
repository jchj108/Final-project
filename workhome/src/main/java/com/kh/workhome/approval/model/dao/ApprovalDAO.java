package com.kh.workhome.approval.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.workhome.approval.model.vo.Approval;

@Repository("aDAO")
public class ApprovalDAO {

	public int insertApproval(SqlSessionTemplate sqlSession, Approval ap) {
		return sqlSession.update("approvalMapper.insertApproval", ap);
	}

	public ArrayList<Approval> selectApprovalList(SqlSessionTemplate sqlSession, String empNo) {
		return (ArrayList)sqlSession.selectList("approvalMapper.selectApprovalList", empNo);
	}

	

}
