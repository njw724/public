package com.yeps.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.yeps.model.MemberDTO;
import com.yeps.model.QnADTO;
import com.yeps.service.YepsPager;
import com.yeps.service.QnAMapper;

@Controller
public class QnAController {

	@Autowired
	private QnAMapper qnaMapper;

	@RequestMapping(value = "/qna_list")
	public ModelAndView listQnA(HttpServletRequest req, @RequestParam(defaultValue = "1") int curPage) {
		List<QnADTO> list = null;
		String searchString = req.getParameter("searchString");
		int count = 0;
		if (searchString == null || searchString.trim().equals("")) {
			count = qnaMapper.getQnACount();
		} else {
			count = qnaMapper.getSearchQnACount(searchString);
		}
		// 페이지 나누기 관련 처리
		YepsPager yepsPager = new YepsPager(count, curPage, 10, 10);
		int start = yepsPager.getPageBegin();
		int end = yepsPager.getPageEnd();

		if (searchString == null || searchString.trim().equals("")) {
			list = qnaMapper.listQnA(start, end);
		} else {
			list = qnaMapper.findQnA(start, end, searchString);
		}
		
		int article_count = count - 10 * (curPage - 1);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("listQnA", list); // list
		map.put("count", count); // 레코드의 갯수
		map.put("yepsPager", yepsPager);
		map.put("searchString", searchString);
		map.put("curPage", curPage);

		ModelAndView mav = new ModelAndView();
		mav.addObject("map", map);
		mav.addObject("article_count", article_count);
		mav.setViewName("qna/qnaList");
		return mav;
	}

	@RequestMapping(value = "/qna_write", method = RequestMethod.GET)
	public ModelAndView writeQnAForm() {
		return new ModelAndView("qna/qnaWriteForm");
	}

	@RequestMapping(value = "/qna_write", method = RequestMethod.POST)
	public ModelAndView writeQnAPro(HttpServletRequest req, @ModelAttribute QnADTO dto, HttpSession session,
			BindingResult result) {
		if (result.hasErrors()) {
			dto.setQnum(0);
		}
		if (dto.getSecret() == null || !dto.getSecret().equals("y")) {
			dto.setSecret("n");
		}

		MemberDTO dto2 = (MemberDTO) session.getAttribute("memberinfo");
		dto.setMnum(dto2.getMnum());
		dto.setWriter(dto2.getEmail());
		dto.setIp(req.getRemoteAddr());

		int res = qnaMapper.insertQnA(dto);

		String msg = null, url = null;
		ModelAndView mav = new ModelAndView();
		if (res > 0) {
			msg = "게시글 작성 완료";
			url = "qna_list?mode=qna";
		} else {
			msg = "게시글 작성 실패";
			url = "qna_list?mode=qna";
		}

		mav.setViewName("message");
		mav.addObject("msg", msg);
		mav.addObject("url", url);
		return mav;
	}

	@RequestMapping(value = "/qna_content")
	public ModelAndView getQnA(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String msg = null, url = null;
		if (req.getParameter("qnum") == null) {
			msg = "메인 페이지로 이동합니다.";
			url = "main";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}
		String qnum = req.getParameter("qnum");

		boolean isCookie = false;
		Cookie[] cookies = req.getCookies();

		QnADTO dto = null;

		if (cookies != null) {
			for (Cookie tmp : cookies) {
				String name = tmp.getName();
				String value = tmp.getValue();

				if (name.equals(qnum) && value.equals(qnum)) {
					dto = qnaMapper.getQnA(Integer.parseInt(qnum), "existCookie"); // content를 넣어줘야 readcount가 된다
					isCookie = true;
					break;
				}
			}
		}

		if (isCookie == false) {
			dto = qnaMapper.getQnA(Integer.parseInt(qnum), "content"); // content를 넣어줘야 readcount가 된다
			Cookie cook = new Cookie(qnum, qnum);
			cook.setMaxAge(60 * 60 * 24);
			resp.addCookie(cook);
		}

		if (dto == null) {
			msg = "존재하지 않는 글입니다.";
			url = "qna_list?mode=qna";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}

		MemberDTO dto2 = (MemberDTO) session.getAttribute("memberinfo");
		if (dto.getSecret().equals("y")) {
			if (dto2 == null) {
				msg = "비밀글 접근 권한이 없습니다.";
				url = "qna_list?mode=qna";
				mav.setViewName("message");
				mav.addObject("msg", msg);
				mav.addObject("url", url);
				return mav;
			} else {
				if (!dto2.getEmail().equals(dto.getWriter()) && !dto2.getIsmanager().equals("y")) {
					msg = "비밀글 접근 권한이 없습니다.";
					url = "qna_list?mode=qna";
					mav.setViewName("message");
					mav.addObject("msg", msg);
					mav.addObject("url", url);
					return mav;
				}
			}
		}
		if (dto.getReply() != null && !dto.getReply().trim().equals("")) {
			boolean isExistReply = true;
			mav.addObject("isExistReply", isExistReply);
		}
		mav.addObject("getQnA", dto);
		mav.setViewName("qna/qnaContent");
		return mav;
	}

	@RequestMapping(value = "/qna_delete")
	public ModelAndView deleteQnA(HttpServletRequest req, HttpSession session) {
		String qnum = req.getParameter("qnum");
		ModelAndView mav = new ModelAndView();
		String msg = null, url = null;
		if (qnum == null) {
			msg = "메인 페이지로 이동합니다.";
			url = "main";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}

		MemberDTO dto2 = (MemberDTO) session.getAttribute("memberinfo");
		QnADTO dto = qnaMapper.getQnAInfo(Integer.parseInt(qnum));
		if (dto == null) {
			msg = "해당 글이 존재하지 않습니다.";
			url = "qna_list?mode=qna";
		} else {
			boolean isDelete = false;
			if (dto2.getIsmanager().equals("y")) {
				isDelete = true;
			} else if (dto.getWriter().equals(dto2.getEmail())) {
				if (dto.getReply() == null || dto.getReply().trim().equals("")) {
					isDelete = true;
				} else {
					msg = "답변이 완료된 글은 삭제 할 수 없습니다.";
					url = "qna_list";
					mav.setViewName("message");
					mav.addObject("msg", msg);
					mav.addObject("url", url);
					return mav;
				}
			}
			if (isDelete == true) {

				int res = qnaMapper.deleteQnA(Integer.parseInt(qnum));
				if (res > 0) {
					msg = "게시글삭제성공!! Q&A목록보기페이지로 이동합니다.";
					url = "qna_list?mode=qna";
				} else {
					msg = "게시글삭제실패!! Q&A목록보기페이지로 이동합니다.";
					url = "qna_list?mode=qna";
				}
			} else {
				msg = "삭제 권한이 없습니다.";
				url = "qna_list?mode=qna";
			}
		}
		mav.setViewName("message");
		mav.addObject("msg", msg);
		mav.addObject("url", url);
		return mav;
	}

	@RequestMapping(value = "/qna_update", method = RequestMethod.GET)
	public ModelAndView updateQnA(HttpServletRequest req, HttpSession session) {
		String qnum = req.getParameter("qnum");
		ModelAndView mav = new ModelAndView();
		String msg = null, url = null;
		if (qnum == null) {
			msg = "메인 페이지로 이동합니다.";
			url = "main";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}

		MemberDTO dto2 = (MemberDTO) session.getAttribute("memberinfo");
		QnADTO dto = qnaMapper.getQnA(Integer.parseInt(qnum), "update");

		if (dto.getWriter().equals(dto2.getEmail())) {
			if (dto.getReply() == null || dto.getReply().trim().equals("")) {
				mav.setViewName("qna/qnaUpdateForm");
				mav.addObject("getQnA", dto);
				return mav;
			} else {
				msg = "답변이 완료된 글은 수정 할 수 없습니다.";
				url = "qna_content?qnum=" + dto.getQnum();
			}
		} else {
			msg = "게시글 수정 권한이 없습니다";
			url = "qna_list?mode=qna";
		}

		mav.setViewName("message");
		mav.addObject("msg", msg);
		mav.addObject("url", url);
		return mav;
	}

	@RequestMapping(value = "/qna_update", method = RequestMethod.POST)
	public ModelAndView updateQnAPro(HttpServletRequest req, @ModelAttribute QnADTO dto, HttpSession session,
			BindingResult result) {
		ModelAndView mav = new ModelAndView();
		String msg = null, url = null;
		if (result.hasErrors()) {
			msg = "메인 페이지로 이동합니다.";
			url = "main";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}

		if (dto.getSecret() == null || !dto.getSecret().equals("y")) {
			dto.setSecret("n");
		}

		MemberDTO dto2 = (MemberDTO) session.getAttribute("memberinfo");

		if (dto.getWriter().equals(dto2.getEmail())) {
			if (dto.getReply() == null || dto.getReply().trim().equals("")) {
				int res = qnaMapper.updateQnA(dto);
				if (res > 0) {
					msg = "게시글 수정 성공!";
					url = "qna_list?mode=qna";
				} else {
					msg = "게시글 수정 실패";
					url = "qna_list?mode=qna";
				}
			} else {
				msg = "답변이 완료된 글은 수정 할 수 없습니다.";
				url = "qna_list?mode=qna";
			}
		} else {
			msg = "게시글 수정 권한이 없습니다";
			url = "qna_list?mode=qna";
		}

		mav.setViewName("message");
		mav.addObject("msg", msg);
		mav.addObject("url", url);
		return mav;
	}

	@RequestMapping(value = "/qna_reply", method = RequestMethod.POST)
	public ModelAndView replyQnAPro(HttpServletRequest req, @ModelAttribute QnADTO dto, HttpSession session,
			BindingResult result) {
		ModelAndView mav = new ModelAndView();
		String msg = null, url = null;
		if (result.hasErrors()) {
			msg = "메인 페이지로 이동합니다.";
			url = "main";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}

		MemberDTO dto2 = (MemberDTO) session.getAttribute("memberinfo");

		if (dto2.getIsmanager().equals("y")) {
			int res = qnaMapper.replyQnA(dto);
			if (res > 0) {
				msg = "답변 작성 및 수정 성공";
				url = "qna_content?qnum=" + dto.getQnum();
			} else {
				msg = "답변 작성 및 수정 실패";
				url = "qna_content?qnum=" + dto.getQnum();
			}
		} else { 
			msg = "Q&A 답변 권한이 없습니다.";
			url = "qna_list?mode=qna";
		}

		mav.setViewName("message");
		mav.addObject("msg", msg);
		mav.addObject("url", url);
		return mav;
	}
}