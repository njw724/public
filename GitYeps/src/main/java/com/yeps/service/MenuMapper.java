package com.yeps.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class MenuMapper {

	@Autowired
	private SqlSession sqlSession;

	public int deleteMenuByMemberNumber(int mnum) {
		return sqlSession.delete("deleteMenuByMemberNumber", mnum);
	}
}
