package com.yeps.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yeps.model.FileDTO;

@Service
public class FileMapper {

	@Autowired
	private SqlSession sqlSession;

	public int insertFile(FileDTO dto, String mode) {
		if (mode.equals("main")) {
			return sqlSession.insert("insertMainFile", dto);
		} else {
			return sqlSession.insert("insertFile", dto);
		}
	}

	public FileDTO getFile(String filename, int filenum) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("filename", filename);
		map.put("filenum", filenum);
		return sqlSession.selectOne("getFile", map);
	}

	public int deleteFileToFilename(String filename) {
		return sqlSession.delete("deleteFileToFilename", filename);
	}

	public List<FileDTO> getfileListForMe(int evnum, int mnum) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("evnum", evnum);
		map.put("mnum", mnum);
		return sqlSession.selectList("getfileListForMe", map);
	}

	public int updateFileContent(int filenum, String filecontent) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("filenum", filenum);
		map.put("filecontent", filecontent);
		return sqlSession.update("updateFileContent", map);
	}

	public List<FileDTO> getAllEventFiles(int evnum) {
		return sqlSession.selectList("getAllEventFiles", evnum);
	}

	public FileDTO getFYIEventFile(int evnum) {
		return sqlSession.selectOne("getFYIEventFile", evnum);
	}

	public int deleteAllFile(int evnum) {
		return sqlSession.delete("deleteAllFile", evnum);
	}

	public boolean isExistMainPhoto(int num, String mode) {
		if (mode.equals("event")) {
			try {
				String sql = "select count(*) from yeps_files where evnum = " + num + " and ismainphoto = 'y'";
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("sql", sql);
				int result_num = sqlSession.selectOne("isExistMainPhoto", map);
				if (result_num > 0) {
					return true;
				} else {
					return false;
				}
			} catch (Exception e) {
				return false;
			}
		} else if (mode.equals("restaurant")) {
			try {
				String sql = "select count(*) from yeps_files where rnum = " + num + " and ismainphoto = 'y'";
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("sql", sql);
				int result_num = sqlSession.selectOne("isExistMainPhoto", map);
				if (result_num > 0) {
					return true;
				} else {
					return false;
				}
			} catch (Exception e) {
				return false;
			}
		}
		return false;
	}

	public int deleteFile(String filename, int num, String ismainphoto, String mode) {
		if (ismainphoto.equals("y")) {
			int res = sqlSession.delete("deleteFileToFilename", filename);
			if(mode.equals("event")) {
				List<FileDTO> list = sqlSession.selectList("getAllEventFiles", num);
				if (list.size() > 0) {
					FileDTO dto = list.get(0);
					HashMap<String, Object> map = new HashMap<String, Object>();
					String sql = "update yeps_files set ismainphoto='y' where evnum=" + dto.getEvnum() + " and filenum=" + dto.getFilenum();
					map.put("sql", sql);
					sqlSession.update("setMainPhoto", map);
				}
				return res;
			} else {
				List<FileDTO> list = sqlSession.selectList("getAllRestaurantFiles", num);
				if(list.size() > 0) {
					FileDTO dto = list.get(0);
					HashMap<String, Object> map = new HashMap<String, Object>();
					String sql = "update yeps_files set ismainphoto='y' where rnum=" + dto.getRnum() + " and filenum=" + dto.getFilenum();
					map.put("sql", sql);
					sqlSession.update("setMainPhoto", map);
				}
			}
			return res;
		} else {
			return sqlSession.delete("deleteFileToFilename", filename);
		}
	}

	public int changeMainPhoto(int num, int filenum, String mode) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String sql = null;
		if (mode.equals("event")) {
			sql = "update yeps_files set ismainphoto='n' where evnum = " + num;
			map.put("sql", sql);
			int res = sqlSession.update("changeMainPhoto", map);
			if (res > 0) {
				sql = "update yeps_files set ismainphoto='y' where evnum=" + num + " and filenum=" + filenum;
				map.put("sql", sql);
				return sqlSession.update("setMainPhoto", map);
			} else {
				return 0;
			}
		} else if(mode.equals("restaurant")){
			sql = "update yeps_files set ismainphoto='n' where rnum = " + num;
			map.put("sql", sql);
			int res = sqlSession.update("changeMainPhoto", map);
			if (res > 0) {
				sql = "update yeps_files set ismainphoto='y' where rnum=" + num + " and filenum=" + filenum;
				map.put("sql", sql);
				return sqlSession.update("setMainPhoto", map);
			} else {
				return 0;
			}
		}
		return 0;
	}

	public List<FileDTO> getPagedEventFiles(int evnum, int start, int end) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("evnum", evnum);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("getPagedEventFiles", map);
	}

	// 레스토랑 파일 필요부분
	public List<FileDTO> getAllRestaurantFiles(int rnum) {
		return sqlSession.selectList("getAllRestaurantFiles", rnum);
	}

	public List<FileDTO> getRest_fileListForMe(int rnum, int mnum) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("rnum", rnum);
		map.put("mnum", mnum);
		return sqlSession.selectList("getRest_fileListForMe", map);
	}

	public int deleteRestaurantFile(String filename, int rnum) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("filename", filename);
		map.put("rnum", rnum);
		return sqlSession.delete("deleteRestaurantFile", map);
	}

	public List<FileDTO> getPagedFileList(int rnum, int start, int end) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("rnum", rnum);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("getPagedFileList", map);
	}

	public int getAllFileCount(int rnum) {
		return sqlSession.selectOne("getAllFileCount", rnum);
	}

	// 1월 6일 민곤 추가
	public int getRest_fileCountForMe(int rnum, int mnum) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("rnum", rnum);
		map.put("mnum", mnum);
		return sqlSession.selectOne("getRest_fileCountForMe", map);
	}

	public List<FileDTO> getPagedFileListForMe(int rnum, int mnum, int start, int end) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("rnum", rnum);
		map.put("mnum", mnum);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("getPagedFileListForMe", map);
	}
	
	public FileDTO getRandomRestaurantPhoto() {
		return sqlSession.selectOne("getRandomRestaurantPhoto");
	}

}
