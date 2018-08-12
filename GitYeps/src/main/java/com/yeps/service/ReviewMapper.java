package com.yeps.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yeps.model.ReviewDTO;

@Service
public class ReviewMapper {

   @Autowired
   private SqlSession sqlSession;

   public List<ReviewDTO> listReview() {
      return sqlSession.selectList("listReview");
   }

   public int insertReview(ReviewDTO dto) {
      return sqlSession.insert("insertReview", dto);
   }

   public int deleteReview(int rvnum) {
      return sqlSession.delete("deleteReview", rvnum);
   }

   public int updateReview(ReviewDTO dto) {
      return sqlSession.update("updateReview", dto);
   }

   public ReviewDTO getReview(int rvnum) {
      return sqlSession.selectOne("getReview", rvnum);
   }

   public int new_BestGradePoint() {
      return sqlSession.selectOne("new_BestGradePoint");
   }

   public String getSelectedRestaurant_Rname(int rnum) {
      return sqlSession.selectOne("getgetSelectedRestaurant_Rname", rnum);
   }

   public List<ReviewDTO> getSelectedRestaurant_Rv(int rnum, int start, int end) {
      HashMap<String, Integer> map = new HashMap<String, Integer>();
      map.put("rnum", rnum);
      map.put("start", start);
      map.put("end", end);
      return sqlSession.selectList("getSelectedRestaurant_Rv", map);
   }

   public List<ReviewDTO> getRandomRestaurant_Rv(int rnum) {
      return sqlSession.selectList("getRandomRestaurant_Rv", rnum);
   }

   public ReviewDTO review_mylist_info(int NBPmnum) {
      return sqlSession.selectOne("review_mylist_info", NBPmnum);
   }

   public int review_mylist_updatedata(int rvnum) {
      return sqlSession.update("review_mylist_updatedata", rvnum);
   }

   public int GetRestaurantName_Rv(int NBPmnum) {
      return sqlSession.selectOne("GetRestaurantName_Rv", NBPmnum);
   }

   public List<ReviewDTO> recentReviewInfo() {
      return sqlSession.selectList("recentReviewInfo");
   }

   public ReviewDTO numList(int reviewIntList) {
      return sqlSession.selectOne("numList", reviewIntList);
   }

   public List<ReviewDTO> previous_reviews_Num() {
      return sqlSession.selectList("previous_reviews_Num");
   }

   public List<ReviewDTO> previous_Rv() {
      return sqlSession.selectList("previous_Rv");
   }

   public List<ReviewDTO> review_keyword(String SearchKeyword, int rnum, int start, int end) {
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("SearchKeyword", SearchKeyword);
      map.put("rnum", rnum);
      map.put("start", start);
      map.put("end", end);
      return sqlSession.selectList("review_keyword", map);
   }

   public int review_keywordCount(String SearchKeyword) {
      return sqlSession.selectOne("review_keywordCount", SearchKeyword);
   }

   public ReviewDTO getLastReview(int rnum) {
      return sqlSession.selectOne("getLastReview", rnum);
   }

   public int getRestaurantReviewCount(int rnum) {
      return sqlSession.selectOne("getRestaurantReviewCount", rnum);
   }

   public int getStarAvg(int rnum) {
      if (sqlSession.selectOne("getStarAvg", rnum) == null) {
         return 0;
      }
      return sqlSession.selectOne("getStarAvg", rnum);
   }

   public List<Integer> getSelectedRestaurant_Rv_M(int rnum) {
      return sqlSession.selectList("getSelectedRestaurant_Rv_M", rnum);
   }

   public List<ReviewDTO> listRestReview(int start, int end) {
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("start", start);
      map.put("end", end);
      return sqlSession.selectList("listRestaurantReview", map);
   }

   public String Get_InsertReviewDate() {
      return sqlSession.selectOne("Get_InsertReviewDate");
   }

   // 12월 31일 지원 추가
   public List<Integer> gethotAndNewReview() {
      return sqlSession.selectList("gethotAndNewReview");
   }

   // 1월 3일 상우 추가
   public int getPreviousReviewCount() {
      return sqlSession.selectOne("getPreviousReviewCount");
   }

   public List<ReviewDTO> previous_Rv(int start, int end) {
      HashMap<String, Integer> map = new HashMap<String, Integer>();
      map.put("start", start);
      map.put("end", end);
      return sqlSession.selectList("previous_Rv", map);
   }

   // 2018.1.4 승지 추가
   public List<ReviewDTO> getMemberReview(int mnum, int start, int end){
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("mnum", mnum);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("getMemberReview", map);
	}
   
   // 2018. 1. 5일 민곤 추가
   public ReviewDTO findMyReview(int rnum, int mnum) {
	   HashMap<String, Object> map = new HashMap<String, Object>();
	   map.put("rnum", rnum);
	   map.put("mnum", mnum);
	 
	   return sqlSession.selectOne("findMyReview", map);
   }
   
   // 2018. 1. 6일 새벽 상우 추가 
   public int review_write_update(String contentUpdate, int gradepoint, int rvnum) {
	   HashMap<String, Object> map = new HashMap<String, Object>();
	   map.put("contentUpdate", contentUpdate); 
	   map.put("gradepoint", gradepoint);
	   map.put("rvnum", rvnum);
	   return sqlSession.update("review_write_update", map);
   }
   
   public int deleteReviewByMemberNumber(int mnum) {
	   return sqlSession.delete("deleteReviewByMemberNumber", mnum);
   }
   
   public int getMyReviewCount(int mnum) {
	   return sqlSession.selectOne("getMyReviewCount", mnum);
   }
   
   public int getAllReviewCount() {
	   return sqlSession.selectOne("getAllReviewCount");
   }
   
   public List<ReviewDTO> getAllReviews(int start, int end) {
	   HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
	   return sqlSession.selectList("getAllReviews", map);
   }
}