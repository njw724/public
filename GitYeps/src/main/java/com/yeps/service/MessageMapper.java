package com.yeps.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yeps.model.MemberDTO;
import com.yeps.model.MessageDTO;

@Service
public class MessageMapper {

	@Autowired
	private SqlSession sqlSession;

	public MessageDTO getContent(int msgnum) {
		try {
			return sqlSession.selectOne("getContent", msgnum);
		} catch (Exception e) {
			return null;
		}
	}

	public int deleteMessage(int msgnum) {
		return sqlSession.delete("deleteMessage", msgnum);
	}

	public int writeMessage(MessageDTO dto) {
		return sqlSession.insert("writeMessage", dto);
	}

	public List<MessageDTO> messageList(int start, int end, String lMode, String email) {
		String sql = null;
		if (lMode.equals("allList")) {
			// 로그인한 회원의 받은 쪽지를 전부 가져온다.
			sql = "select * from (select rownum rn, A.* from (select * from yeps_message where receiver='" + email
					+ "' and isIssue=0 order by msgNum desc)A)" + " where  rn between " + start + " and " + end;
		} else if (lMode.equals("allLocker")) {
			// 로그인한 회원의 보관함에 있는 쪽지를 가져온다.
			sql = "select * from (select rownum rn, A.* from (select * from yeps_message where receiver='" + email
					+ "' and islocker=1 and isIssue=0 order by msgNum desc)A)" + " where rn between " + start + " and "
					+ end;
		} else if (lMode.equals("msgBoxList")) {
			// 로그인한 회원의 쪽지함에 있는 쪽지를 가져온다.
			sql = "select * from (select rownum rn, A.* from (select * from yeps_message where receiver='" + email
					+ "' and islocker!=1 and isIssue=0 order by msgNum desc)A) " + "where rn between " + start + " and "
					+ end;
		} else if (lMode.equals("sender")) {
			// 로그인한 회원의 보낸 쪽지 전부를 가져온다.
			sql = "select * from (select rownum rn, A.* from (select * from yeps_message where sender='" + email
					+ "' and isIssue=0 order by msgNum desc)A) " + "where rn between " + start + " and " + end;
		} else if (lMode.equals("readMsg")) {
			// 읽은 쪽지중 쪽지함에 있는 쪽지
			sql = "select * from (select rownum rn, A.* from (select * from yeps_message where receiver='" + email
					+ "' and readNum=1 and isIssue=0 and islocker=0 order by msgNum desc)A)" + " where rn between " + start
					+ " and " + end;
		} else if (lMode.equals("readLocker")) {
			// 읽은 쪽지중 보관함에 있는 쪽지
			sql = "select * from (select rownum rn, A.* from (select * from yeps_message where receiver='" + email
					+ "' and readNum=1 and islocker=1 and isIssue=0 order by msgNum desc)A)" + " where rn between "
					+ start + " and " + end;
		} else if (lMode.equals("noneMsg")) {
			// 안읽은 쪽지함 쪽지
			sql = "select * from (select rownum rn, A.* from (select * from yeps_message where receiver='" + email
					+ "' and readNum=0 and islocker=0 and isIssue=0 order by msgNum desc)A)" + " where rn between "
					+ start + " and " + end;
		} else if (lMode.equals("noneLocker")) {
			// 안읽은 보관함 쪽지
			sql = "select * from (select rownum rn, A.* from (select * from yeps_message where receiver='" + email
					+ "' and readNum=0 and islocker=1 and isIssue=0 order by msgNum desc)A) " + "where rn between "
					+ start + " and " + end;
		} else if (lMode.equals("alertMsg")) {
			// 이슈 모든 쪽지
			sql = "select * from (select rownum rn, A.* from (select * from yeps_message where receiver='" + email
					+ "' and isIssue=1 order by msgNum desc)A) " + "where rn between " + start + " and " + end;
		} else if (lMode.equals("readAlert")) {
			// 이슈 읽은 쪽지
			sql = "select * from (select rownum rn, A.* from (select * from yeps_message where receiver='" + email
					+ "' and readnum=1 and isIssue=1 order by msgNum desc)A) " + "where rn between " + start + " and "
					+ end;
		} else if (lMode.equals("noneAlert")) {
			// 이슈 안읽은 쪽지
			sql = "select * from (select rownum rn, A.* from (select * from yeps_message where receiver='" + email
					+ "' and readnum=0 and isIssue=1 order by msgNum desc)A) " + "where rn between " + start + " and "
					+ end;
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sql", sql);
		return sqlSession.selectList("messageList", map);
	}

	public String getSender(int mnum) {
		try {
			return sqlSession.selectOne("sender", mnum);
		} catch (Exception e) {
			return null;
		}
	}

	public int updateReadDate(int msgNum) {
		return sqlSession.update("updateReadDate", msgNum);
	}

	public int updateReadNum1(int msgNum) {
		return sqlSession.update("updateReadNum1", msgNum);
	}

	public int updateReadNum0(int msgNum) {
		return sqlSession.update("updateReadNum0", msgNum);
	}

	public MemberDTO getMember(int mnum) {
		try {
			return sqlSession.selectOne("getMember", mnum);
		} catch (Exception e) {
			return null;
		}
	}

	public int getMessageCount() {
		try {
			return sqlSession.selectOne("getMessageCount");
		} catch (Exception e) {
			return 0;
		}
	}

	public int getLockerCount(String receiver) {
		try {
			return sqlSession.selectOne("getLockerCount", receiver);
		} catch (Exception e) {
			return 0;
		}
	}

	public int getSendCount(String sender) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sender", sender);
		try {
			return sqlSession.selectOne("getSendCount", map);
		} catch (Exception e) {
			return 0;
		}
	}

	public int getReceiveCount(String receiver) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("receiver", receiver);
		try {
			return sqlSession.selectOne("getReceiveCount", map);
		} catch (Exception e) {
			return 0;
		}
	}

	public int noneMessageCount(String receiver) {
		try {
			return sqlSession.selectOne("noneMessageCount", receiver);
		} catch (Exception e) {
			return 0;
		}
	}

	public int readMessageCount(String receiver) {
		try {
			return sqlSession.selectOne("readMessageCount", receiver);
		} catch (Exception e) {
			return 0;
		}
	}

	public int noneLockerCount(String receiver) {
		try {
			return sqlSession.selectOne("noneLockerCount", receiver);
		} catch (Exception e) {
			return 0;
		}
	}

	public int readLockerCount(String receiver) {
		try {
			return sqlSession.selectOne("readLockerCount", receiver);
		} catch (Exception e) {
			return 0;
		}
	}

	public int allAlertCount(String receiver) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("receiver", receiver);

		try {
			return sqlSession.selectOne("allAlertCount", map);
		} catch (Exception e) {
			return 0;
		}
	}

	public int readAlertCount(String receiver) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("receiver", receiver);
		try {
			return sqlSession.selectOne("readAlertCount", map);
		} catch (Exception e) {
			return 0;
		}
	}

	public int moveToLocker(int msgNum) {
		return sqlSession.update("moveToLocker", msgNum);
	}

	public int lockerToMsgBox(int msgnum) {
		return sqlSession.update("lockerToMsgBox", msgnum);
	}
	
	public int deleteMessageByMemberNumber(int mnum) {
		return sqlSession.delete("deleteMessageByMemberNumber", mnum);
	}

}