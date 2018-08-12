package com.yeps.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yeps.model.RestaurantDTO;

@Service
public class RestaurantMapper {
	@Autowired
	private SqlSession sqlSession;

	public List<RestaurantDTO> listRest(int start, int end, String mode, List<Integer> prices, String location) {
		String sql=null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("location", location);
		map.put("mode", mode);
		
		if(prices.get(0)==0 && mode.equals("mode")) {// 가격 선택 X ,필터 선택 X
			System.out.println("가격 선택 X ,필터 선택 X");
//			return sqlSession.selectList("listRestaurant", map);
		}else if(prices.get(0)!=0 && mode.equals("mode")){ //가격 선택 O,필터 선택 X
					sql=String.valueOf(prices.get(0));
					map.put("sql", sql);
					map.put("pricesSql", prices);
			System.out.println("가격 선택 O,필터 선택 X");
//			return sqlSession.selectList("listRestaurant", map);
		}
		else if(prices.get(0)==0 && !mode.equals("mode")) {//가격 선택 X,필터 선택 O
			System.out.println("가격 선택 X,필터 선택 O");
			if (mode.equals("delivery")) {
				return sqlSession.selectList("listRestaurant_delivery", map);
			} 
			else if (mode.equals("reserv")) {
				return sqlSession.selectList("listRestaurant_reserv", map);
			} else if(mode.equals("open")){
				return sqlSession.selectList("listRestaurant_open_now", map);
			}	else {
				return sqlSession.selectList("listRestaurant_takeout", map);
			}	
		}
		else { //가격 선택 O,필터 선택 O
			System.out.println("가격 선택 O,필터 선택 O");
			sql=String.valueOf(prices.get(0));
			map.put("sql", sql);
			map.put("pricesSql", prices);
			return sqlSession.selectList("listRestaurant", map);
		}
		
		System.out.println("SQL="+sql);
		System.out.println("PriceSQL="+prices);
		System.out.println("Mode="+mode);

		return sqlSession.selectList("listRestaurant", map);
	}

	public int insertRest(RestaurantDTO dto) {
		return sqlSession.update("insertRestaurant", dto);
	}
	
	public List<RestaurantDTO> restaurantList(int start, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("restaurantList", map);
	}
	
	 public List<RestaurantDTO> findRestaurant_Manage(int startRow, int endRow, String search, String searchString) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("startRow", startRow);
			map.put("endRow", endRow);
			map.put("search", search);
			map.put("searchString", searchString);
			return sqlSession.selectList("findRestaurant_Manage", map);
		}
	
	public int deleteRestaurant(int rnum) {
		return sqlSession.delete("deleteRestaurant",rnum);
	}

	public RestaurantDTO getRest(int rnum) {
		return sqlSession.selectOne("getRest", rnum);
	}

	public RestaurantDTO getNewRestaurant() {
		return sqlSession.selectOne("getNewRestaurant");
	}

	public int getCount() {
		return sqlSession.selectOne("getCountBySeoul");
	}
	
	public int getCountBySeoul(String location) {
		return sqlSession.selectOne("getCountBySeoul", location);
	}

	public int getImageCount(int rnum) {
		return sqlSession.selectOne("getImageCount", rnum);
	}

	// ------------------------------------------------------------------

	public String review_write_getrname(int rnum) {
		return sqlSession.selectOne("review_write_getrname", rnum);
	}

	public RestaurantDTO GetRestaurantName_R(int GETrnum) {
		return sqlSession.selectOne("GetRestaurantName_R", GETrnum);
	}

	public List<RestaurantDTO> review_restaurantIMG() {
		return sqlSession.selectList("review_restaurantIMG");
	}

	public RestaurantDTO getHotAndNewRestaurant(int rnum) {
		RestaurantDTO dto =  sqlSession.selectOne("getHotAndNewRestaurant", rnum);
		if(dto == null) {
			dto =  sqlSession.selectOne("getHotAndNewRestaurant_noPhoto", rnum);
		}
		return dto;
	}

	// -------------- 이벤트랑 레스토랑 연결 ---------------------------
	public RestaurantDTO findRestaurant(String zipNo, String roadAddrPart1, String roadAddrPart2, String addrDetail) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("zipNo", zipNo);
		map.put("roadAddrPart1", roadAddrPart1);
		map.put("roadAddrPart2", roadAddrPart2);
		map.put("addrDetail", addrDetail);
		return sqlSession.selectOne("findRestaurant", map);
	}

	// 메인페이지 랜덤 사진 가져오기



	//////////////1월 4일 상우추가 
	public int get_review_restaurantFind_Count(HashMap<String, Object> searchMap){
		if(searchMap.get("SearchFind") == null ) {
			if(searchMap.get("SearchNear") == null) {
				return sqlSession.selectOne("get_review_restaurantFind_Count");
			}else {
				return sqlSession.selectOne("get_review_restaurantFind_CountByNear", searchMap);
			}
		}else {
			if(searchMap.get("SearchNear") == null) {
				return sqlSession.selectOne("get_review_restaurantFind_CountByFind", searchMap);
			}else {
				return sqlSession.selectOne("get_review_restaurantFind_CountByAll", searchMap);
			}
		}
		
	}



	public List<RestaurantDTO> review_restaurantFind(int start, int end, HashMap<String, Object> searchMap) {
		searchMap.put("start", start);
		searchMap.put("end", end);
		if(searchMap.get("SearchFind") == null ) {
			if(searchMap.get("SearchNear") == null) {
				return sqlSession.selectList("review_restaurantFind", searchMap);
			}else {
				return sqlSession.selectList("review_restaurantFindByNear", searchMap);
			}
		}else {
			if(searchMap.get("SearchNear") == null) {
				return sqlSession.selectList("review_restaurantFindByFind", searchMap);
			}else {
				return sqlSession.selectList("review_restaurantFindByAll", searchMap);
			}
		}
		
	}
	
	//---------------1월 5일 민우 추가
	public int getCountBySearchMap(HashMap<String,Object> searchMap) {
		if(searchMap.get("category") != null) {
			if(searchMap.get("location") != null) {
				if(searchMap.get("searchword") != null) {
					// category, location, searchword 셋 다 널이 아닐 경우
					return sqlSession.selectOne("getCountByCLS", searchMap);
				}else {
					//  category, location 널이 아닐 경우
					return sqlSession.selectOne("getCountByCL", searchMap);
				}
			}else {
				if(searchMap.get("searchword") != null) {
					// category, searchword 널이 아닐 경우
					return sqlSession.selectOne("getCountByCS", searchMap);
				}else {
					// category 널이 아닐 때
					return sqlSession.selectOne("getCountByC", searchMap);
				}
			}
		}else {
			if(searchMap.get("location") != null ) {
				if(searchMap.get("searchword") != null ) {
					//  location, searchword 널이 아닐 경우
					return sqlSession.selectOne("getCountByLS", searchMap);
				}else {
					//  location 널이 아닐 경우
					return sqlSession.selectOne("getCountByL", searchMap);
				}
			}else {
				if(searchMap.get("searchword") != null ) {
					//  searchword 널이 아닐 경우
					return sqlSession.selectOne("getCountByS", searchMap);
				}else {
					//  전부 널일 경우	
					return sqlSession.selectOne("getCount");
				}
			}
		}
	}
	
	public List<RestaurantDTO> listRestBySearchMap(int start, int end, HashMap<String,Object> searchMap){
		searchMap.put("start", start);
		searchMap.put("end", end);
		
		if(searchMap.get("category") != null) {
			if(searchMap.get("location") != null) {
				if(searchMap.get("searchword") != null) {
					// category, location, searchword 셋 다 널이 아닐 경우
					return sqlSession.selectList("listRestByCLS", searchMap);
				}else {
					//  category, location 널이 아닐 경우
					return sqlSession.selectList("listRestByCL", searchMap);
				}
			}else {
				if(searchMap.get("searchword") != null) {
					// category, searchword 널이 아닐 경우
					return sqlSession.selectList("listRestByCS", searchMap);
				}else {
					// category 널이 아닐 때
					return sqlSession.selectList("listRestByC", searchMap);
				}
			}
		}else {
			if(searchMap.get("location") != null) {
				if(searchMap.get("searchword") != null) {
					//  location, searchword 널이 아닐 경우
					return sqlSession.selectList("listRestByLS", searchMap);
				}else {
					//  location 널이 아닐 경우
					return sqlSession.selectList("listRestByL", searchMap);
				}
			}else {
				if(searchMap.get("searchword") != null) {
					//  searchword 널이 아닐 경우
					return sqlSession.selectList("listRestByS", searchMap);
				}else {
					//  전부 널일 경우	
					return sqlSession.selectList("listRestaurant", searchMap);
				}
			}
		}
	}
	

	  public int getSearchRestaurantCount(String search, String searchString) {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("search", search);
			map.put("searchString", searchString);
			try {
				return sqlSession.selectOne("getSearchRestaurantCount", map);
			} catch (Exception e) {
				return 0;
			}
		}

	public int deleteRestaurantByMemberNumber(int mnum) {
		return sqlSession.delete("deleteRestaurantByMemberNumber", mnum);
	}

}
