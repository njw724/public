package com.yeps.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.yeps.model.CategoryDTO;
import com.yeps.service.CategoryMapper;

@Controller
public class CategoryController {

	@Autowired 
	private CategoryMapper categoryMapper;

	@RequestMapping(value = "/category_list")
	public ModelAndView listCate() {
		List<CategoryDTO> list = categoryMapper.listCategory();
		return new ModelAndView("category/category_list", "categoryList", list);
	}

	@RequestMapping(value = "/category_insert", method = RequestMethod.GET)
	public String insertFormCate() {
		return "category/category_insert";
	}

	@RequestMapping(value = "/category_insert", method = RequestMethod.POST)
	public ModelAndView insertProCate(HttpServletRequest req) {
		String cname = req.getParameter("cname");
		if (cname == null || cname.trim().equals("")) {
			return new ModelAndView("redirect:category_list");
		}

		ModelAndView mav = new ModelAndView();
		int result = categoryMapper.insertCategory(cname);
		if (result > 0) {
			mav.setViewName("redirect:category_list");
			return mav;
		} else {
			mav.addObject("msg", "카테고리 등록 실패");
			mav.addObject("url", "category_insert");
		}
		mav.setViewName("message");
		return mav;
	}

	@RequestMapping(value = "/category_delete")
	public ModelAndView deleteCate(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String cnum = req.getParameter("cnum");
		if (cnum == null || cnum.trim().equals("")) {
			mav.setViewName("redirect:category_list");
			return mav;
		}

		int result = categoryMapper.deleteCategory(Integer.parseInt(cnum));
		if (result > 0) {
			mav.setViewName("redirect:category_list");
			return mav;
		} else {
			mav.addObject("msg", "카테고리 삭제 실패");
			mav.addObject("url", "category_list");
			mav.setViewName("message");
			return mav;
		}
	}

	@RequestMapping(value = "/category_edit", method = RequestMethod.GET)
	public ModelAndView updateFormCate(HttpServletRequest req) {
		String cnum = req.getParameter("cnum");
		ModelAndView mav = new ModelAndView();
		if (cnum == null || cnum.trim().equals("")) {
			mav.setViewName("redirect:category_list");
			return mav;
		}

		CategoryDTO dto = categoryMapper.getCategory(Integer.parseInt(cnum));
		mav.addObject("getCategory", dto);
		mav.setViewName("category/category_edit");
		return mav;
	}

	@RequestMapping(value = "/category_edit", method = RequestMethod.POST)
	public ModelAndView updateProCate(HttpServletRequest req) {
		String cnum = req.getParameter("cnum");
		String cname = req.getParameter("cname");

		if (cnum == null || cnum.trim().equals("") || cname == null || cname.trim().equals("")) {
			return new ModelAndView("redirect:category_list");
		}

		int result = categoryMapper.updateCategory(Integer.parseInt(cnum), cname);
		ModelAndView mav = new ModelAndView();
		if (result > 0) {
			mav.addObject("msg", "카테고리를 수정하였습니다.");
			mav.addObject("url", "category_list");
			mav.setViewName("message");
			return mav;
		} else {
			mav.addObject("msg", "카테고리 수정 실패. 관리자에게 문의하세요.");
			mav.addObject("url", "category_list");
			mav.setViewName("message");
			return mav;
		}
	}
}
