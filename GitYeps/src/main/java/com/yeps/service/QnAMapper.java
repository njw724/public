package com.yeps.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yeps.model.QnADTO;

@Service
public class QnAMapper {

	@Autowired
	private SqlSession sqlSession;

	public int getQnACount() {
		try {
			return sqlSession.selectOne("getQnACount");
		} catch (Exception e) {
			return 0;
		}
	}

	public int getSearchQnACount(String searchString) {
		try {
			return sqlSession.selectOne("getSearchQnACount", searchString);
		} catch (Exception e) {
			return 0;
		}
	}

	public List<QnADTO> listQnA(int startRow, int endRow) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);

		return sqlSession.selectList("listQnA", map);
	}

	public List<QnADTO> findQnA(int startRow, int endRow, String searchString) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("searchString", searchString);
		return sqlSession.selectList("findQnA", map);
	}

	public int insertQnA(QnADTO dto) {
		return sqlSession.insert("insertQnA", dto);
	}

	public QnADTO getQnA(int qnum, String mode) {
		try {
			if (mode.equals("content")) {
				sqlSession.update("qnaReadCount", qnum);
			}
			return sqlSession.selectOne("getQnA", qnum);
		} catch (Exception e) {
			return null;
		}
	}

	public QnADTO getQnAInfo(int qnum) {
		try {
			return sqlSession.selectOne("getQnAInfo", qnum);
		} catch (Exception e) {
			return null;
		}
	}

	public int deleteQnA(int qnum) {
		return sqlSession.delete("deleteQnA", qnum);
	}

	public int updateQnA(QnADTO dto) {
		return sqlSession.update("updateQnA", dto);
	}

	public int replyQnA(QnADTO dto) {
		return sqlSession.update("replyQnA", dto);
	}
	
	public int deleteQnAByMemberNumber(int mnum) {
		return sqlSession.delete("deleteQnAByMemberNumber", mnum);
	}
}