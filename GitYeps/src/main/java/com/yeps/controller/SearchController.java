package com.yeps.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yeps.model.ContsDTO;
import com.yeps.model.MemberDTO;
import com.yeps.model.RestaurantDTO;
import com.yeps.model.ReviewDTO;
import com.yeps.service.ContsMapper;
import com.yeps.service.ContsSingleton;
import com.yeps.service.GpsToAddress;
import com.yeps.service.Jaso;
import com.yeps.service.RandomNum;
import com.yeps.service.RestaurantMapper;
import com.yeps.service.ReviewMapper;
import com.yeps.service.YepsPager;

@Controller
public class SearchController {

	@Autowired
	private ContsMapper contsMapper;
	
	@Autowired
	private RestaurantMapper restaurantMapper;
	
	@Autowired
	private ReviewMapper reviewMapper; 

	@Autowired
	private Jaso jaso;
 
	@Autowired
	private RandomNum randomNum;

	@RequestMapping(value = "/search_auto_complete", method = RequestMethod.POST)
	@ResponseBody
	public List<String> searchAutoComplete(@RequestParam(value = "searchData") String searchData) {

		ContsSingleton conts = ContsSingleton.getContsSingletonObject();
		List<ContsDTO> contsList = conts.getContsList();
		String initial = jaso.getInitial(searchData);

		List<String> autoCompleteList = new ArrayList<String>();

		if (contsList != null) {
			if (!initial.trim().equals("")) {
				for (ContsDTO contsDTO : contsList) {
					if (contsDTO.getConts_nm_div().contains(initial)) {
						autoCompleteList.add(contsDTO.getConts_nm());
					}
					if (autoCompleteList.size() >= 5) {
						break;
					}
				}
			}
		}
		return autoCompleteList;
	}

	@RequestMapping(value = "/recent_location_list", method = RequestMethod.POST)
	@ResponseBody
	public List<String> nearLocation(HttpServletRequest req) {
		Cookie[] cookies = req.getCookies();
		List<String> locationList = new ArrayList<String>();
		if(cookies!=null) {
			int j = 0;
			for (int i = cookies.length-1 ; i>=0; i--) {
				String name = cookies[i].getName(); 
				try {
					String value = URLDecoder.decode(cookies[i].getValue(),"utf-8");
					if(name.contains("location")) {
						locationList.add(value);
						j+=1;
						if(j == 5) {
							break;
						}
					}
				}catch(Exception e) {
					System.out.println("불러오기 실패");
				}
			}
			return locationList;
		}else {
			return null;
		}
	}

	@RequestMapping(value = "/yeps_main_saerch")
	public ModelAndView MainSearchPro(HttpServletRequest req, HttpServletResponse resp, HttpSession session, @RequestParam(defaultValue = "1") int curPage) {

		ModelAndView mav = new ModelAndView();

		String category = req.getParameter("category");
		String location = req.getParameter("location");
		String searchword = req.getParameter("searchword");
		String latitude = req.getParameter("latitude");
		String longitude = req.getParameter("longitude");
		
		if(category == null || category.trim().equals("")) {
			category = null;
		}
		if(location == null || location.trim().equals("")) {
			location = null;
		}
		if(searchword == null || searchword.trim().equals("")) {
			searchword = null;
		}

		if(location != null && location.equals("Current Location")) {
			if(latitude != null && !latitude.trim().equals("") && longitude != null && !longitude.trim().equals("")) {
				try {
					GpsToAddress gps = new GpsToAddress(Double.parseDouble(latitude), Double.parseDouble(longitude));
					String[] addr = gps.getAddress().split(" ");
					if(addr.length >=3) {
						location = addr[1] + " " + addr[2] + " " + addr[3];
					}else {
						location = addr[1] + " " + addr[2];
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
			}else {
				System.out.println("null변환");
				location = "";
			}
		}


		MemberDTO memberDTO =  (MemberDTO) session.getAttribute("memberinfo");
		if(memberDTO != null && location != null && location.equals("Home")) {
			String[] addr = memberDTO.getAddress().split(" ");
			location = addr[1] + " " + addr[2] + " " +addr[3];
		}

		if(location != null  && !location.equals("Home")) {
			Cookie[] cookies = req.getCookies();
			if(cookies!=null) {
				for (Cookie cookie : cookies) {
					String name = cookie.getName(); 
					try {
						String value = URLDecoder.decode(cookie.getValue(),"utf-8");
						if(name.contains("location") && value.equals(location)) {
							try {
								cookie.setMaxAge(0);	
								cookie.setPath("/");
								resp.addCookie(cookie);			// 쿠키저장
							}catch(Exception e){
								System.out.println("쿠키 저장 실패");
							}
							break;
						}
					}catch(Exception e) {
						System.out.println("출력 실패");
					}
				}
			}
			if(location != null && !location.equals("Current Location")) {
				String authNum = ""; // RandomNum함수 호출해서 리턴값 저장
				authNum = randomNum.getKey(7, false);
				try {
					Cookie cookie = new Cookie("location"+authNum, URLEncoder.encode(location, "UTF-8"));
					cookie.setMaxAge(60*60*24*30);	// 쿠키 유지 기간 - 30일
					cookie.setPath("/");			// 모든 경로에서 접근 가능하도록 
					resp.addCookie(cookie);			// 쿠키저장
				}catch(Exception e){
					System.out.println("쿠키 저장 실패");
				}
			}
		}

		if (searchword != null) {
			ContsSingleton conts = ContsSingleton.getContsSingletonObject();
			ContsDTO contsDTO = new ContsDTO();
			String initial = jaso.getInitial(searchword);
			contsDTO.setConts_nm(searchword);
			contsDTO.setConts_nm_div(initial);
			conts.addContsUploadList(contsDTO);
		}

		//----------------------------여기부터 검색작업-------------------
		
		if(location == null) {
			location = "서울특별시";
		}

		HashMap<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("category", category);
		searchMap.put("location", location);
		searchMap.put("searchword", searchword);
		
		int count = restaurantMapper.getCountBySearchMap(searchMap);
		System.out.println(count);
		int pageScale = 10;
		int blockScale = 10;
		// 페이지 나누기 관련 처리
		YepsPager YepsPager = new YepsPager(count, curPage, pageScale, blockScale);
		int start = YepsPager.getPageBegin();
		int end = YepsPager.getPageEnd();
		
		List<RestaurantDTO> list = restaurantMapper.listRestBySearchMap(start, end, searchMap);
		System.out.println(list.size());
		List<Integer> reviewCount = new ArrayList<Integer>();
		List<Integer> StarAvg = new ArrayList<Integer>();

		List<ReviewDTO> LastReview = new ArrayList<ReviewDTO>();
		for (int i = 0; i < list.size(); i++) {
			LastReview.add(reviewMapper.getLastReview(list.get(i).getRnum()));
			reviewCount.add(reviewMapper.getRestaurantReviewCount(list.get(i).getRnum()));
			StarAvg.add(reviewMapper.getStarAvg(list.get(i).getRnum()));
		}

		// RestaurantDTO test = restaurantMapper.getNewRestaurant();
		// System.out.println(test.getRnum());

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("category", category);
		map.put("location", location);
		map.put("searchword", searchword);
		
		map.put("list", list); // list
		map.put("count", count); // 레코드의 갯수
		map.put("YepsPager", YepsPager);
		map.put("LastReview", LastReview);
		map.put("reviewCount", reviewCount);
		map.put("StarAvg", StarAvg);
		mav.addObject("map", map);
		mav.setViewName("restaurant/restaurant_list");

		return mav;
	}
}
