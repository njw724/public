package com.yeps.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yeps.model.EventReviewDTO;
import com.yeps.model.MemberDTO;

@Service
public class EventReviewMapper {

	@Autowired
	private SqlSession sqlSession;

	public List<EventReviewDTO> listEventReview(int evnum) {
		return sqlSession.selectList("listEventReview", evnum);
	}

	public int insertEventReview(int evnum, int mnum, String eventReview_content, String ip) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("evnum", evnum);
		map.put("mnum", mnum);
		map.put("eventReview_content", eventReview_content);
		map.put("ip", ip);
		return sqlSession.insert("insertEventReview", map);
	}
	
	public int deleteAllEventReivew(int evnum) {
		return sqlSession.delete("deleteAllEventReivew", evnum);
	}
	
	public List<EventReviewDTO> eventReviewList(int start, int end){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("eventReviewList", map);
	}
	
    public int deleteEventReview(int evrvnum) {
    	return sqlSession.delete("deleteEventReview", evrvnum);
    }
    
    public int eventReviewCount() {
    	return sqlSession.selectOne("eventReviewCount");
    }
    
    public List<EventReviewDTO> getEventReview(int evrvnum){
    	return sqlSession.selectList("getEventReview",evrvnum);
    }
    

    public int getSearchEventReviewCount(String search, String searchString) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("search", search);
		map.put("searchString", searchString);
		try {
			return sqlSession.selectOne("getSearchEventReviewCount", map);
		} catch (Exception e) {
			return 0;
		}
	}
    
    public List<EventReviewDTO> findEventReview(int startRow, int endRow, String search, String searchString) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("search", search);
		map.put("searchString", searchString);
		return sqlSession.selectList("findEventReview", map);
	}

    public int deleteEventReviewByMemberNumber(int mnum) {
    	return sqlSession.delete("deleteEventReviewByMemberNumber", mnum);
    }

}
