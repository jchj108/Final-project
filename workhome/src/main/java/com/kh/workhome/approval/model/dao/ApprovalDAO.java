package com.kh.workhome.approval.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.workhome.approval.model.vo.Approval;

@Repository("apDAO")
public class ApprovalDAO {

	public int insertApproval(SqlSessionTemplate sqlSession, Approval ap) {
		return sqlSession.update("approvalMapper.insertApproval", ap);
	}

	public ArrayList<Approval> selectApprovalList(SqlSessionTemplate sqlSession, String empNo) {
		return (ArrayList)sqlSession.selectList("approvalMapper.selectApprovalList", empNo);
	}

	public Approval selectApprovalDetail(SqlSessionTemplate sqlSession, String apNo) {
		return (Approval)sqlSession.selectOne("approvalMapper.selectApprovalDetail", apNo);
	}

	public int updateAp(SqlSessionTemplate sqlSession, Approval ap) {
		return sqlSession.update("approvalMapper.updateAp", ap);
	}

	public ArrayList<Approval> selectApListByAr(SqlSessionTemplate sqlSession, String[] array) {
		return (ArrayList)sqlSession.selectList("approvalMapper.selectApListByAr",array);
	}

	public int deleteAp(SqlSessionTemplate sqlSession, String apNo) {
		return sqlSession.update("approvalMapper.deleteAp", apNo);
	}

	public ArrayList<Approval> selectDeptVacation(SqlSessionTemplate sqlSession, ArrayList<String> list) {
		return (ArrayList)sqlSession.selectList("approvalMapper.selectDeptVacation",list);
	}

}
