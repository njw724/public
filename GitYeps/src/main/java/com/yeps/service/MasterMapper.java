package com.yeps.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MasterMapper {

	@Autowired
	private SqlSession sqlSession;

	// public int setAuthorization(List<String> select) {
	// return sqlSession.update("setAuthorization", select);
	// }

}
