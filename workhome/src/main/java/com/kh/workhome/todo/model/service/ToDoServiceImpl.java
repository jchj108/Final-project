package com.kh.workhome.todo.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.workhome.todo.model.dao.ToDoDAO;
import com.kh.workhome.todo.model.vo.ToDo;

@Service("tService")
public class ToDoServiceImpl implements ToDoService {

@Autowired
private ToDoDAO tDAO;

@Autowired
private SqlSessionTemplate sqlSession;

	@Override
	public int insertToDo(ToDo toDo) {
		return tDAO.insertToDo(sqlSession, toDo);
	}

	@Override
	public ArrayList<ToDo> getAllList(String empNo) {
		return tDAO.getAllList(sqlSession, empNo);
	}
}
