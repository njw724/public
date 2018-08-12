package com.yeps.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.yeps.model.EventReviewDTO;
import com.yeps.model.MemberDTO;
import com.yeps.service.EventReviewMapper;
import com.yeps.service.YepsPager;

@Controller
public class EventReviewController {

	@Autowired
	private EventReviewMapper eventReviewMapper;

	@RequestMapping(value = "/eventReview_insert")
	public ModelAndView insertEventReviewForm(HttpServletRequest req) {
		String evnum = req.getParameter("evnum");
		String mnum = req.getParameter("mnum");
		String eventReview_content = req.getParameter("eventReview_content");
		String ip = req.getRemoteAddr();
 
		ModelAndView mav = new ModelAndView();
		if (eventReview_content == null || eventReview_content.trim().equals("")) {
			mav.setViewName("redirect: event_content?evnum=" + evnum + "&mode=empty_content");
			return mav;
		}

		int result = eventReviewMapper.insertEventReview(Integer.parseInt(evnum), Integer.parseInt(mnum),
				eventReview_content, ip);
		if (result > 0) {
			mav.setViewName("redirect: event_content?evnum=" + evnum + "&mode=insert_eventReview");
		} else {
			mav.addObject("msg", "잠시후 다시 시도해주세요.");
			mav.addObject("url", "event_content?evnum=" + evnum);
			mav.setViewName("message");
		}
		return mav;
	}
	
	@RequestMapping(value = "/eventReview_list")
	public ModelAndView eventReview_list(HttpServletRequest req, @RequestParam(defaultValue = "1") int curPage) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		MemberDTO loginMember = (MemberDTO) session.getAttribute("memberinfo");
		if(loginMember == null || !loginMember.getIsmanager().equals("y") || !loginMember.getIsmaster().equals("y")) {
			mav.addObject("msg", "권한이 없습니다.");
			mav.addObject("url", "main");
			mav.setViewName("message");
			return mav;
		}
		
		String search = req.getParameter("search");
		String searchString = req.getParameter("searchString");
		int count = 0;
		if (searchString == null || searchString.trim().equals("") || search == null || search.trim().equals("")) {
			count = eventReviewMapper.eventReviewCount();
		} else {
			count = eventReviewMapper.getSearchEventReviewCount(search, searchString);
		}

		int pageScale = 10;
		int blockScale = 10;
		YepsPager YepsPager = new YepsPager(count, curPage, pageScale, blockScale);
		int start = YepsPager.getPageBegin();
		int end = YepsPager.getPageEnd();
		List<EventReviewDTO> eventReview = null;
		if (searchString == null || searchString.trim().equals("") || search == null || search.trim().equals("")) {
			eventReview = eventReviewMapper.eventReviewList(start,end);
		} else {
			eventReview = eventReviewMapper.findEventReview(start, end, search, searchString);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
	
		map.put("search", search);
		map.put("searchString", searchString);
		mav.addObject("count", count); 
		mav.addObject("curPage", curPage); 
		mav.addObject("yepsPager", YepsPager);
		mav.addObject("map", map);
		mav.addObject("eventReviewList", eventReview);
		mav.setViewName("manager/eventReview");
		return mav;
	}
	
	@RequestMapping(value = "/eventReview_delete")
	public ModelAndView eventReview_delete(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		int eventReview_num = Integer.parseInt(req.getParameter("eventReview_num"));
		int res = eventReviewMapper.deleteEventReview(eventReview_num);
		String msg = null, url = null;
		
		if(res > 0) {
			msg = "이벤트 리뷰를 삭제하였습니다.";
			url = "manager/eventReview";
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			mav.setViewName("message");
			
		}else {
			msg = "이벤트 리뷰 삭제에 실패하엿습니다.";
			url = "manager/eventReview";
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			mav.setViewName("message");
		}
		return mav;
	}
	
	@RequestMapping(value = "/eventReview_edit", method = RequestMethod.GET)
	public ModelAndView eventReview_edit(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		int eventReview_num = Integer.parseInt(req.getParameter("eventReview_num"));
		List<EventReviewDTO> list = eventReviewMapper.getEventReview(eventReview_num);
		mav.addObject("eventReview", list);
		mav.setViewName("manager/eventReview_edit");
		return mav;
	}
	
	@RequestMapping(value = "/eventReview_edit", method = RequestMethod.POST)
	public ModelAndView eventReview_edit_input(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
}
