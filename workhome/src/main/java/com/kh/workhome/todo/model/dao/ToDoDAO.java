package com.kh.workhome.todo.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.workhome.todo.model.vo.ToDo;

@Repository("tDAO")
public class ToDoDAO {

	public int insertToDo(SqlSessionTemplate sqlSession, ToDo toDo) {
		return sqlSession.insert("toDoMapper.insertToDo", toDo);
	}

	public ArrayList<ToDo> getAllList(SqlSessionTemplate sqlSession, String empNo) {
		return (ArrayList)sqlSession.selectList("toDoMapper.getAllList", empNo);
	}
}
