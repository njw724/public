package com.yeps.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yeps.model.MemberDTO;

@Service
public class MemberMapper {

	@Autowired
	private SqlSession sqlSession;

	public int getMemberCount() {
		try {
			return sqlSession.selectOne("getMemberCount");
		} catch (Exception e) {
			return 0;
		}
	}

	public int getSearchMemberCount(String search, String searchString) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("search", search);
		map.put("searchString", searchString);
		try {
			return sqlSession.selectOne("getSearchMemberCount", map);
		} catch (Exception e) {
			return 0;
		}
	}

	public List<MemberDTO> listMember(int startRow, int endRow) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);

		return sqlSession.selectList("listMember", map);
	}

	public List<MemberDTO> listMemberForMessage() {
		return sqlSession.selectList("listMemberForMessage");
	}

	public List<MemberDTO> findMember(int startRow, int endRow, String search, String searchString) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("search", search);
		map.put("searchString", searchString);
		return sqlSession.selectList("findMember", map);
	}

	public MemberDTO getMemberProfile(int mnum) {
		return sqlSession.selectOne("getMemberProfile", mnum);
	}

	public boolean checkJumin(MemberDTO dto) {
		int count = 0;
		try {
			count = sqlSession.selectOne("checkJumin", dto);
			if (count > 0) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			return false;
		}
	}

	public int insertMember(MemberDTO dto) {
		int res = sqlSession.insert("insertMember", dto);
		return res;
	}

	public MemberDTO confirmEmail(String email) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("email", email);
		try {
			return sqlSession.selectOne("confirmEmail", map);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public int deleteMember(int mnum) {
		return sqlSession.delete("deleteMember", mnum);
	}

	public MemberDTO loginMember(MemberDTO dto) {
		try {
			return sqlSession.selectOne("loginMember", dto);
		} catch (Exception e) {
			return null;
		}
	}

	public String getSaltByEmail(MemberDTO dto) {
		try {
			return sqlSession.selectOne("getSaltByEmail", dto);
		} catch (Exception e) {
			return null;
		}
	}

	public List<String> findMemberEmail(MemberDTO dto) {
		try {
			return sqlSession.selectList("findMemberEmail", dto);
		} catch (Exception e) {
			return null;
		}
	}

	public int findMemberPasswd(MemberDTO dto) {
		try {
			return sqlSession.selectOne("findMemberPasswd", dto);
		} catch (Exception e) {
			return 0;
		}
	}

	public int temporaryPasswd(MemberDTO dto) {
		return sqlSession.update("temporaryPasswd", dto);
	}

	public int updateMemberProfile(int mnum, String name, String nickname, String address) {
		MemberDTO dto = new MemberDTO();
		dto.setMnum(mnum);
		dto.setName(name);
		dto.setNickname(nickname);
		dto.setAddress(address);
		return sqlSession.update("updateMemberProfile", dto);
	}

	public int updateMemberProfileByMaster(MemberDTO dto) {
		return sqlSession.update("updateMemberProfileByMaster", dto);
	}

	public int updateMemberPasswd(int mnum, String passwd, String passwd1) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("mnum", mnum);
		map.put("passwd", passwd);
		map.put("passwd1", passwd1);
		return sqlSession.update("updateMemberPasswd", map);
	}

	public int leaveMember(MemberDTO dto) {
		return sqlSession.delete("leaveMember", dto);
	}

	/*--------------------------------------------*/

	public MemberDTO mylist_info(int NBPmnum) {
		return sqlSession.selectOne("mylist_info", NBPmnum);
	}

	// public MemberDTO mylist_info(int NBPmnum) {
	// return sqlSession.selectOne("mylist_info", NBPmnum);
	// }

	public List<MemberDTO> getSelectedRestaurant_M(int mnum) {
		return sqlSession.selectList("getSelectedRestaurant_M", mnum);
	}

	public MemberDTO getMemberForEmail(String email) {
		return sqlSession.selectOne("getMemberForEmail", email);
	}

	public List<MemberDTO> previous_M(int mnum) {
		return sqlSession.selectList("previous_M", mnum);
	}

	// 12월 29일 추가

	public MemberDTO getMemberByMnum(int mnum) {
		try {
			return sqlSession.selectOne("getMemberByMnum", mnum);
		} catch (Exception e) {
			return null;
		}
	}

	public int updateReviewCount(int mnum, int reviewcount) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("mnum", mnum);
		map.put("reviewcount", reviewcount);
		return sqlSession.update("reviewCount", map);
	}

	public int getMemberReviewCount(int mnum) {
		return sqlSession.selectOne("getMemberReviewCount", mnum);
	}

	// 12월 31일 상우 추가
	public List<MemberDTO> SearchedDTO_M(int mnum) {
		return sqlSession.selectList("SearchedDTO_M", mnum);
	}
	
	// 1월 4일 민곤 추가
	public int updateImageCount(int mnum, int imageCount) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("mnum", mnum);
		map.put("imageCount", imageCount);
		return sqlSession.update("updateImageCount", map);
	}
}