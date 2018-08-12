package com.yeps.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yeps.model.MemberPhotoDTO;

@Service
public class MemberPhotoMapper {

	@Autowired
	private SqlSession sqlSession;

	public int insertMemberPhoto(MemberPhotoDTO dto, String mode) {
		if (mode.equals("main")) {
			return sqlSession.insert("insertMemberMainPhoto", dto);
		} else {
			return sqlSession.insert("insertMemberPhoto", dto);
		}

	}

	public int deleteMemberPhotoToFilename(String filename) {
		return sqlSession.delete("deleteMemberPhotoToFilename", filename);
	}

	public List<MemberPhotoDTO> getMemberPhotoList(int mnum) {
		return sqlSession.selectList("getMemberPhotoList", mnum);
	}

	public boolean isExistMemberMainPhoto(int mnum) {
		try {
			int num = sqlSession.selectOne("isExistMemberMainPhoto", mnum);
			if (num > 0) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			return false;
		}
	}

	public MemberPhotoDTO getMemberMainPhoto(int mnum) {
		try {
			return sqlSession.selectOne("getMemberMainPhoto", mnum);
		} catch (Exception e) {
			return null;
		}
	}

	public int changeMemberMainPhoto(int filenum, int mnum) {
		int res = sqlSession.update("changeMemberMainPhoto", mnum);
		if (res > 0) {
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			map.put("filenum", filenum);
			map.put("mnum", mnum);
			return sqlSession.update("setMemberMainPhoto", map);
		} else {
			return 0;
		}
	}

	public int deleteMemberPhoto(int filenum, int mnum, String ismainphoto) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("filenum", filenum);
		map.put("mnum", mnum);

		if (ismainphoto.equals("y")) {
			int res = sqlSession.delete("deleteMemberPhoto", map);
			List<MemberPhotoDTO> list = sqlSession.selectList("getMemberPhotoList", mnum);
			if (list.size() > 0) {
				MemberPhotoDTO dto = list.get(0);
				HashMap<String, Integer> map2 = new HashMap<String, Integer>();
				map2.put("filenum", dto.getFilenum());
				map2.put("mnum", dto.getMnum());
				sqlSession.update("setMemberMainPhoto", map2);
			}
			return res;
		} else {
			return sqlSession.delete("deleteMemberPhoto", map);
		}
	}
	
	public int deleteMemberPhotosByMemberNumber(int mnum) {
		return sqlSession.delete("deleteMemberPhotosByMemberNumber", mnum);
	}

	/*
	 * 
	 * public MemberPhotoDTO getFile(String filename, int filenum) { HashMap<String,
	 * Object> map = new HashMap<String, Object>(); map.put("filename", filename);
	 * map.put("filenum", filenum); return sqlSession.selectOne("getFile", map); }
	 * 
	 * public int deleteFile(int filenum) { return sqlSession.delete("deleteFile",
	 * filenum); }
	 * 
	 * public int deleteFileToFilename(String filename) { return
	 * sqlSession.delete("deleteFileToFilename", filename); }
	 * 
	 * public List<MemberPhotoDTO> getfileListForMe(int evnum, int mnum) {
	 * HashMap<String, Integer> map = new HashMap<String, Integer>();
	 * map.put("evnum", evnum); map.put("mnum", mnum); return
	 * sqlSession.MemberPhotoDTO("getfileListForMe", map); }
	 * 
	 * public int updateFileContent(int filenum, String filecontent) {
	 * HashMap<String, Object> map = new HashMap<String, Object>();
	 * map.put("filenum", filenum); map.put("filecontent", filecontent); return
	 * sqlSession.update("updateFileContent", map); }
	 * 
	 * public List<MemberPhotoDTO> getTargetEventFiles(int evnum) { return
	 * sqlSession.selectList("getTargetEventFiles", evnum); }
	 * 
	 * public MemberPhotoDTO getFYIEventFile(int evnum) { return
	 * sqlSession.selectOne("getFYIEventFile", evnum); }
	 */
}