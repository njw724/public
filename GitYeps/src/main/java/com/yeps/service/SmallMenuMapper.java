package com.yeps.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yeps.model.SmallMenuDTO;

@Service
public class SmallMenuMapper {

	@Autowired
	private SqlSession sqlSession;

	public int insertSmallMenu(SmallMenuDTO dto) {
		return sqlSession.insert("insertSmallMenu", dto);
	}

	public List<SmallMenuDTO> listSmallMenu(int large_menunum) {
		return sqlSession.selectList("listSmallMenu", large_menunum);
	}
	
	public int deleteSmallMenuByMemberNumber(int mnum) {
		return sqlSession.delete("deleteSmallMenuByMemberNumber", mnum);
	}
	
}
