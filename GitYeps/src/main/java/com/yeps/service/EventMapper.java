package com.yeps.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yeps.model.EventDTO;

@Service
public class EventMapper {

	@Autowired
	private SqlSession sqlSession;

	public int getEventCount(String mode, String search) {
		if (mode.equals("normal")) {
			return sqlSession.selectOne("getEventCount", search);
		} else if (mode.equals("free")) {
			return sqlSession.selectOne("getEventCountForFree", search);
		} else {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("event_category", mode);
			map.put("search", search);
			return sqlSession.selectOne("getEventCountForCategory", map);
		}
	}

	public List<EventDTO> listEvent(String mode, int start, int end, String search) {
		String sql = null;
		if (mode == null || mode.trim().equals("") || mode.trim().equals("recently")) {
			sql = "select * from (select rownum rn, A.* from (select * from yeps_event where replace(upper(store_address),' ','') like '%'||replace(upper('"+ search +"'),' ','')||'%' order by evnum desc)A) where rn between '"
					+ start + "' and '" + end + "'";
		} else if (mode.equals("free")) {
			sql = "select * from (select rownum rn, A.* from (select * from yeps_event where discount like '%무료%' and replace(upper(store_address),' ','') like '%'||replace(upper('"+ search +"'),' ','')||'%' order by evnum desc)A) where rn between '"
					+ start + "' and '" + end + "'";
		} else if (mode.equals("date")) {
			sql = "select * from (select rownum rn, A.* from (select * from yeps_event where replace(upper(store_address),' ','') like '%'||replace(upper('"+ search +"'),' ','')||'%' order by evnum asc)A) where rn between '"
					+ start + "' and '" + end + "'";
		} else {
			sql = "select * from (select rownum rn, A.* from (select * from yeps_event where event_category = '" + mode
					+ "' and replace(upper(store_address),' ','') like '%'||replace(upper('"+ search +"'),' ','')||'%' order by evnum desc)A) where rn between '" + start + "' and '" + end + "'";
		}

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("sql", sql);
		return sqlSession.selectList("listEvent", map);
	}
	
	public List<EventDTO> manage_eventList(int start, int end) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("manage_eventList", map);
	}

	public int insertEvent(EventDTO dto) {
		return sqlSession.insert("insertEvent", dto);
	}

	public EventDTO getEventContent(int evnum) {
		return sqlSession.selectOne("getEventContent", evnum);
	}

	public int getEvnum(String eventName, String store_address) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("eventname", eventName);
		map.put("store_address", store_address);
		return sqlSession.selectOne("getEvnum", map);
	}

	public boolean RedundancyCheck(String eventName) {
		EventDTO dto = sqlSession.selectOne("RedundancyCheck", eventName);
		if (dto == null) {
			return true;
		} else {
			return false;
		}
	}

	public int updateFilenum(int filenum, int evnum) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("filenum", filenum);
		map.put("evnum", evnum);
		return sqlSession.update("updateFilenum", map);
	}

	public List<EventDTO> getThisWeek_EventList() {
		try {
			return sqlSession.selectList("getThisWeek_EventList");
		} catch (Exception e) {
			return null;
		}
	}

	public List<EventDTO> getRandom_EventList() {
		try {
			return sqlSession.selectList("getRandom_EventList");
		} catch (Exception e) {
			return null;
		}
	}

	public int deleteEvent(int evnum) {
		return sqlSession.delete("deleteEvent", evnum);
	}

	public int updateEvent(EventDTO dto) {
		return sqlSession.update("updateEvent", dto);
	}
	
	public int eventCount() {
		return sqlSession.selectOne("eventCount");
	}
	
	public int deleteEventByMemberNumber(int mnum) {
		return sqlSession.delete("deleteEventByMemberNumber", mnum);
	}
	
	public EventDTO getEventContentNoPhoto(int evnum) {
		return sqlSession.selectOne("getEventContentNoPhoto", evnum);
	}
}
