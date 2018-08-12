package com.yeps.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.yeps.service.MasterMapper;

@Controller
public class MasterController {

	@Autowired
	private MasterMapper masterMappger;

	@RequestMapping(value = "master_index")
	public String master_index() {
		return "master/index";
	}
 
	@RequestMapping(value = "master_setAuthorization")
	public ModelAndView master_setAuthorization
	// (HttpServletRequest req, @ModelAttribute List<String> select, @RequestParam
	// String checkbox_all) {
	(HttpServletRequest req) {

		String isManager = req.getParameter("isManager");
		String[] select = req.getParameterValues("select");

		if (select != null) {
			for (int i = 0; i < select.length; i++) {
				System.out.println("true목록:" + select[i]);
			}
		}
		System.out.println("all권한 true:" + isManager);

		ModelAndView mav = new ModelAndView();
		if (select != null) {
			mav.addObject("select", select);
		}

		mav.addObject("isManager", isManager);
		mav.setViewName("master/view");

		return mav;

		// int res = masterMappger.setAuthorization(select);
		// String msg = "";
		// String url = "";
		// ModelAndView mav = new ModelAndView();
		//
		// if(res > 0) {
		// msg = "권한부여 성공!!";
		// //권한부여에 성공했으니까 권한부여된 목록들 나오게끔 정보 가지고 url(권한부여된 목록들 보이는 jsp페이지 만들기)로 가기
		// url = "";
		// mav.addObject("msg", msg);
		// mav.addObject("url", url);
		// mav.setViewName("message");
		// }else{
		// msg = "권한부여 실패!!";
		// //다시 돌아가게 만드는 url주소 적어주기
		// url = "";
		// mav.addObject("msg", msg);
		// mav.addObject("url", url);
		// mav.setViewName("message");
		// }
		// return mav;

	}

}
