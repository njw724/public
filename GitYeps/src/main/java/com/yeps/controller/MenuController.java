package com.yeps.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.yeps.model.LargeMenuDTO;
import com.yeps.model.RestaurantDTO;
import com.yeps.model.SmallMenuDTO;
import com.yeps.service.LargeMenuMapper;
import com.yeps.service.RestaurantMapper;
import com.yeps.service.SmallMenuMapper;

@Controller
public class MenuController {

	@Autowired 
	private LargeMenuMapper largeMenuMapper;
	@Autowired
	private SmallMenuMapper smallMenuMapper;
	@Autowired
	private RestaurantMapper restaurantMapper;
	
	@RequestMapping(value="/restaurant_insertMenuForm",method = RequestMethod.GET)
	public ModelAndView insertMenuForm(HttpServletRequest req) {
		String rnum = req.getParameter("rnum");
		if (rnum == null || rnum.trim().equals("")) {
			return new ModelAndView("redirect:restaurant_list");
		}
		ModelAndView mav=new ModelAndView();
		mav.addObject("rnum",rnum);
		mav.setViewName("restaurant/restaurant_insertMenuForm");
		return mav;
	}
	
	@RequestMapping(value="/restaurant_updateMenuForm",method = RequestMethod.GET)
	public ModelAndView updateMenuForm(HttpServletRequest req) {
		String rnum=req.getParameter("rnum");
		if(rnum==null||rnum.trim().equals("")) {
			return new ModelAndView("redirect:restaurant_list");
		}
		ModelAndView mav=new ModelAndView();
		mav.addObject("rnum",rnum);
		return mav;
	}
	
	@RequestMapping(value = "/restaurant_insertMenu")
	public ModelAndView insertMenu(HttpServletRequest req, @ModelAttribute LargeMenuDTO large_dto,@ModelAttribute SmallMenuDTO small_dto) {
		String rnum = req.getParameter("rnum");
		if(rnum==null||rnum.trim().equals("")) {
			return new ModelAndView("redirect:restaurant_list");
		}
		
		String[] small = req.getParameterValues("small_length");
		int[] small_length = new int[small.length];
		for (int i = 0; i < small.length; i++) {
			small_length[i] = Integer.parseInt(small[i]);
		}
		int count = 0;

		for (int i = 0; i < large_dto.getLargeMenuList().size(); i++) {
			large_dto.setLarge_name(large_dto.getLargeMenuList().get(i).getLarge_name());
			large_dto.setRnum(Integer.parseInt(rnum));
			largeMenuMapper.insertLargeMenu(large_dto);
			int large_menunum = largeMenuMapper.getLastLargeMenu();
			for (int j = 0; j < small_length[i]; j++) {
				small_dto.setLarge_menunum(large_menunum);
				small_dto.setSmall_name(small_dto.getSmallMenuList().get(count).getSmall_name());
				small_dto.setSmall_content(small_dto.getSmallMenuList().get(count).getSmall_content());
				small_dto.setSmall_price(small_dto.getSmallMenuList().get(count).getSmall_price());
				smallMenuMapper.insertSmallMenu(small_dto);
				count++;
			}
		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName("restaurant/restaurant_listMenu");
		return mav;
	}

	@RequestMapping(value = "/restaurant_listMenu")
	public ModelAndView listMenu(HttpServletRequest req) {
		int rnum = Integer.parseInt(req.getParameter("rnum"));
		RestaurantDTO dto = restaurantMapper.getRest(rnum);
		
		List<LargeMenuDTO>largeList=largeMenuMapper.listLargeMenu(rnum);		
		List<SmallMenuDTO>smallList=new ArrayList<SmallMenuDTO>();
		List<Integer>smallSize=new ArrayList<Integer>();
		for(int i=0;i<largeList.size();i++) {
			smallList.addAll(smallMenuMapper.listSmallMenu(largeList.get(i).getLarge_menunum()));
			smallSize.add(smallList.size());
		}
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("getRest", dto);
		mav.addObject("largeList", largeList);
		mav.addObject("smallList", smallList);
		mav.addObject("smallSize",smallSize);
		mav.setViewName("restaurant/restaurant_listMenu");
		return mav;
	}
}
