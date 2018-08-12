package com.yeps.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yeps.model.ContsDTO;

@Service
public class ContsMapper {

	@Autowired
	private SqlSession sqlSession;

	public List<ContsDTO> getContsList() {
		return sqlSession.selectList("getContsList");
	}

	public int updateContsList(List<ContsDTO> contsList) {
		for (ContsDTO dto : contsList) {
			try {
				int res = sqlSession.selectOne("getContsNM", dto);
				if (res > 0) {
					res = sqlSession.update("updateContsCount", dto);
					if (res == 0) {
						return -1;
					}
				} else {
					sqlSession.insert("insertConts", dto);
				}
			} catch (Exception e) {
				return -1;
			}
		}

		return 1;
	}
}
