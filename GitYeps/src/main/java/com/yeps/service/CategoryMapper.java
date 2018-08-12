package com.yeps.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yeps.model.CategoryDTO;

@Service
public class CategoryMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<CategoryDTO> listCategory() {
		return sqlSession.selectList("listCategory");
	}
	
	public int insertCategory(String cname) {
		return sqlSession.insert("insertCategory", cname);
	}
	
	public int deleteCategory(int cnum) {
		return sqlSession.delete("deleteCategory", cnum);
	}
	
	public CategoryDTO getCategory(int cnum) {
		return sqlSession.selectOne("getCategory", cnum);
	}
	
	public int updateCategory(int cnum, String cname) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cnum", cnum);
		map.put("cname", cname);
		return sqlSession.update("editCategory", map);
	}
}
