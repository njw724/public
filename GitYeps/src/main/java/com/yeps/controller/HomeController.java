package com.yeps.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.yeps.model.FileDTO;
import com.yeps.model.RestaurantDTO;
import com.yeps.model.ReviewDTO;
import com.yeps.service.FileMapper;
import com.yeps.service.RestaurantMapper;
import com.yeps.service.ReviewMapper;

@Controller
public class HomeController {

	@Autowired
	private ReviewMapper reviewMapper;
	@Autowired
	private RestaurantMapper restaurantMapper;
	@Autowired
	private FileMapper fileMapper;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model, HttpServletRequest req) {
		// 최고평점을 index page로 보내주기
		ModelAndView mav = new ModelAndView();
		int NBPmnum = reviewMapper.new_BestGradePoint();
		ReviewDTO review_of_the_day_reviewDTO = reviewMapper.review_mylist_info(NBPmnum);
		RestaurantDTO review_of_the_day_restaurantDTO = null;
		if (review_of_the_day_reviewDTO != null) {
			reviewMapper.review_mylist_updatedata(review_of_the_day_reviewDTO.getRvnum());
			review_of_the_day_restaurantDTO = restaurantMapper
					.GetRestaurantName_R(review_of_the_day_reviewDTO.getRnum());
		}
		// // 최근활동 리뷰/사진을 index page로 보내주기
		// // ★미구현:설정된 위치지역일때의 정보들을 꺼내서 index에 뿌려주기
		// // ★미구현:file 부분 미구현
		List<ReviewDTO> recentReviewInfoList = reviewMapper.recentReviewInfo(); // rvnum, gradepoint, content값 가져오는dto

		List<Integer> gethotAndNewReview = reviewMapper.gethotAndNewReview();
		Set<RestaurantDTO> hotAndNewSet = new LinkedHashSet<RestaurantDTO>();
		for (int i = 0; i < 3; i++) {
				RestaurantDTO dto = restaurantMapper.getHotAndNewRestaurant(gethotAndNewReview.get(i));
			if(dto != null) {
				hotAndNewSet.add(dto);
			} else {
				hotAndNewSet.add(dto);
			}
		}

		List<Integer> reviewCount = new ArrayList<Integer>();
		List<Integer> starAvg = new ArrayList<Integer>();

		Iterator<RestaurantDTO> it = hotAndNewSet.iterator();
		while (it.hasNext()) {
			RestaurantDTO dto = it.next();
			reviewCount.add(reviewMapper.getRestaurantReviewCount(dto.getRnum()));
			starAvg.add(reviewMapper.getStarAvg(dto.getRnum()));
		}
		
		Cookie[] cookies = req.getCookies();
		List<String> locationList = new ArrayList<String>();
		if(cookies!=null) {
			int j = 0;
			for (int i = cookies.length-1 ; i>=0; i--) {
				String name = cookies[i].getName(); 
				try {
					String value = URLDecoder.decode(cookies[i].getValue(),"utf-8");
					if(name.contains("location")) {
						String[] addr = value.split(" ");
						
						if(addr.length >=3) {
							value= addr[1] + " " + addr[2];
						}
						
						boolean isExistlocation = false;
						for( String location : locationList) {
							if(location.equals(value)) {
								isExistlocation = true;
							}
						}
						if(isExistlocation == false) {
						locationList.add(value);
						}
						
						j+=1;
						if(j == 6) {
							break;
						}
					}
				}catch(Exception e) {
					System.out.println("불러오기 실패");
				}
			}
		}
		
		FileDTO randomPhoto = fileMapper.getRandomRestaurantPhoto();
		int randomPhoto_reivewCount = reviewMapper.getRestaurantReviewCount(randomPhoto.getRnum());
		int randomPhoto_starAvg = reviewMapper.getStarAvg(randomPhoto.getRnum());
		
		//랜덤 사진
		mav.addObject("randomPhoto", randomPhoto);
		mav.addObject("randomPhoto_reivewCount", randomPhoto_reivewCount);
		mav.addObject("randomPhoto_starAvg", randomPhoto_starAvg);
		//최근 검색 리스트
		mav.addObject("locationList", locationList);

		// restaurantMapper.getRandomImage();
		mav.addObject("recentReviewInfoList", recentReviewInfoList);
		mav.addObject("review_of_the_day_restaurantDTO", review_of_the_day_restaurantDTO);
		mav.addObject("review_of_the_day_reviewDTO", review_of_the_day_reviewDTO);

		// Hot & New
		mav.addObject("hotAndNewSet", hotAndNewSet);
		mav.addObject("reviewCount", reviewCount);
		mav.addObject("starAvg", starAvg);
		mav.setViewName("mainPage");
		return mav;
	}

	@RequestMapping(value = "/main")
	public ModelAndView main(HttpServletRequest req) {
		// 최고평점을 index page로 보내주기
		ModelAndView mav = new ModelAndView();
		int NBPmnum = reviewMapper.new_BestGradePoint();
		ReviewDTO review_of_the_day_reviewDTO = reviewMapper.review_mylist_info(NBPmnum);
		
		RestaurantDTO review_of_the_day_restaurantDTO = null;
		if (review_of_the_day_reviewDTO != null) {
			reviewMapper.review_mylist_updatedata(review_of_the_day_reviewDTO.getRvnum());
			review_of_the_day_restaurantDTO = restaurantMapper
					.GetRestaurantName_R(review_of_the_day_reviewDTO.getRnum());
		}
		// // 최근활동 리뷰/사진을 index page로 보내주기
		// // ★미구현:설정된 위치지역일때의 정보들을 꺼내서 index에 뿌려주기
		// // ★미구현:file 부분 미구현
		List<ReviewDTO> recentReviewInfoList = reviewMapper.recentReviewInfo(); // rvnum, gradepoint, content값 가져오는dto

		List<Integer> gethotAndNewReview = reviewMapper.gethotAndNewReview();
		Set<RestaurantDTO> hotAndNewSet = new LinkedHashSet<RestaurantDTO>();
		for (int i = 0; i < 3; i++) {
				RestaurantDTO dto = restaurantMapper.getHotAndNewRestaurant(gethotAndNewReview.get(i));
			if(dto != null) {
				hotAndNewSet.add(dto);
			} else {
				hotAndNewSet.add(dto);
			}
		}

		List<Integer> reviewCount = new ArrayList<Integer>();
		List<Integer> starAvg = new ArrayList<Integer>();

		Iterator<RestaurantDTO> it = hotAndNewSet.iterator();
		while (it.hasNext()) {
			RestaurantDTO dto = it.next();
			reviewCount.add(reviewMapper.getRestaurantReviewCount(dto.getRnum()));
			starAvg.add(reviewMapper.getStarAvg(dto.getRnum()));
		}
		
		Cookie[] cookies = req.getCookies();
		List<String> locationList = new ArrayList<String>();
		if(cookies!=null) {
			int j = 0;
			for (int i = cookies.length-1 ; i>=0; i--) {
				String name = cookies[i].getName(); 
				try {
					String value = URLDecoder.decode(cookies[i].getValue(),"utf-8");
					if(name.contains("location")) {
						String[] addr = value.split(" ");
						
						if(addr.length >=3) {
							value= addr[1] + " " +addr[2];
						}
						boolean isExistlocation = false;
						for( String location : locationList) {
							if(location.equals(value)) {
								isExistlocation = true;
							}
						}
						if(isExistlocation == false) {
						locationList.add(value);
						}
						
						j+=1;
						if(j == 6) {
							break;
						}
					}
				}catch(Exception e) {
					System.out.println("불러오기 실패");
				}
			}
		}
		FileDTO randomPhoto = fileMapper.getRandomRestaurantPhoto();
		int randomPhoto_reivewCount = reviewMapper.getRestaurantReviewCount(randomPhoto.getRnum());
		int randomPhoto_starAvg = reviewMapper.getStarAvg(randomPhoto.getRnum());
		
		//랜덤 사진 
		mav.addObject("randomPhoto", randomPhoto);
		mav.addObject("randomPhoto_reivewCount", randomPhoto_reivewCount);
		mav.addObject("randomPhoto_starAvg", randomPhoto_starAvg);
		//최근 검색 리스트
		mav.addObject("locationList", locationList);

		mav.addObject("recentReviewInfoList", recentReviewInfoList);
		mav.addObject("review_of_the_day_restaurantDTO", review_of_the_day_restaurantDTO);
		mav.addObject("review_of_the_day_reviewDTO", review_of_the_day_reviewDTO);

		// Hot & New
		mav.addObject("hotAndNewSet", hotAndNewSet);
		mav.addObject("reviewCount", reviewCount);
		mav.addObject("starAvg", starAvg);
		mav.setViewName("mainPage");
		return mav;
	}

	@RequestMapping(value = "/test")
	public String test() {
		return "test";
	}

}
