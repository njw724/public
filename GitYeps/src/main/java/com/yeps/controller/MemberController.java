package com.yeps.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.yeps.model.MemberDTO;
import com.yeps.model.MemberPhotoDTO;
import com.yeps.service.EventMapper;
import com.yeps.service.EventReviewMapper;
import com.yeps.service.MemberMapper;
import com.yeps.service.MemberPhotoMapper;
import com.yeps.service.MessageMapper;
import com.yeps.service.QnAMapper;
import com.yeps.service.RandomNum;
import com.yeps.service.RestaurantMapper;
import com.yeps.service.ReviewMapper;
import com.yeps.service.S3Connection;
import com.yeps.service.SHA256Util;
import com.yeps.service.SendEmail;
import com.yeps.service.YepsPager;

@Controller
public class MemberController {

	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private RandomNum randomNum;
	@Autowired
	private MemberPhotoMapper memberPhotoMapper;
	@Autowired
	private SendEmail sendEmail;
	@Autowired
	private MessageMapper messageMapper;
	@Autowired
	private EventMapper eventMapper;
	@Autowired
	private EventReviewMapper eventReviewMapper;
	@Autowired
	private QnAMapper qnaMapper;
	@Autowired
	private ReviewMapper reviewMapper;
	@Autowired
	private RestaurantMapper restaurantMapper;

	@RequestMapping(value = "/manager_managerPage")
	public ModelAndView managerPage(HttpServletRequest req, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String msg = null, url = null;
		MemberDTO dto = (MemberDTO) session.getAttribute("memberinfo");
		if (dto == null) {
			msg = "회원관리권한이 없습니다.";
			url = "main";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}

		if (!dto.getIsmaster().equals("y") && !dto.getIsmanager().equals("y")) {
			msg = "회원관리권한이 없습니다.";
			url = "main";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}
		mav.setViewName("manager/managerPage");
		return mav;
	}

	@RequestMapping(value = "/member_manager")
	public ModelAndView listMember(HttpServletRequest req, HttpSession session,
			@RequestParam(defaultValue = "1") int curPage) {

		MemberDTO dto = (MemberDTO) session.getAttribute("memberinfo");
		ModelAndView mav = new ModelAndView();
		String msg = null, url = null;
		if (!dto.getIsmaster().equals("y") && !dto.getIsmanager().equals("y")) {
			msg = "회원관리권한이 없습니다.";
			url = "main";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}

		String mnum = req.getParameter("mnum");
		MemberDTO memberProfile = null;
		MemberPhotoDTO memberMainPhoto = null;
		if (mnum != null) {
			try {
				memberProfile = memberMapper.getMemberProfile(Integer.parseInt(mnum));
				memberMainPhoto = memberPhotoMapper.getMemberMainPhoto(Integer.parseInt(mnum));
			} catch (Exception e) {
				memberProfile = null;
			}
		}

		if (memberProfile == null || mnum == null || mnum.trim().equals("")) {
			List<MemberDTO> memberList = null;
			String search = req.getParameter("search");
			String searchString = req.getParameter("searchString");

			int count = 0;
			if (searchString == null || searchString.trim().equals("") || search == null || search.trim().equals("")) {
				count = memberMapper.getMemberCount();
			} else {
				count = memberMapper.getSearchMemberCount(search, searchString);
			}
			// 페이지 나누기 관련 처리
			YepsPager yepsPager = new YepsPager(count, curPage, 20, 10);
			int start = yepsPager.getPageBegin();
			int end = yepsPager.getPageEnd();

			if (searchString == null || searchString.trim().equals("") || search == null || search.trim().equals("")) {
				memberList = memberMapper.listMember(start, end);
			} else {
				memberList = memberMapper.findMember(start, end, search, searchString);
			}
			List<MemberPhotoDTO> memberPhotoList = new ArrayList<MemberPhotoDTO>();
			if (memberList != null) {
				for (int i = 0; i < memberList.size(); i++) {
					int memberNum = memberList.get(i).getMnum();
					MemberPhotoDTO memberPhotoDTO = memberPhotoMapper.getMemberMainPhoto(memberNum);
					memberPhotoList.add(memberPhotoDTO);
				}
			}

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("listMemberPhoto", memberPhotoList);
			map.put("listMember", memberList); // list
			map.put("count", count); // 레코드의 갯수
			map.put("yepsPager", yepsPager);
			map.put("search", search);
			map.put("searchString", searchString);
			mav.addObject("count", count); // 레코드의 갯수
			mav.addObject("curPage", curPage); 
			mav.addObject("yepsPager", yepsPager);
			mav.addObject("map", map);
			mav.setViewName("member/memberManager");
		} else {
			mav.addObject("memberMainPhoto", memberMainPhoto);
			mav.addObject("memberProfile", memberProfile);
			mav.setViewName("member/memberManager");
		}

		return mav;
	}

	@RequestMapping(value = "/member_join", method = RequestMethod.GET)
	public ModelAndView joinMemberForm(HttpSession session, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String msg = null, url = null;
		if (session.getAttribute("memberinfo") != null) {
			String old_url = req.getHeader("referer");
			String[] urls = old_url.split("/");
			if (old_url != null && !old_url.trim().equals("")) {
				old_url = null;
				for (int i = 4; i < urls.length; i++) {
					if (i == 4) {
						old_url = urls[i];
					} else {
						old_url = "/" + urls[i];
					}
				}
			}
			msg = "로그아웃을 먼저 해주세요.";
			if (old_url != null && !old_url.trim().equals("")) {
				url = old_url;
			} else {
				url = "main";
			}

			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}
		return new ModelAndView("member/memberJoin");
	}

	@RequestMapping(value = "/member_join", method = RequestMethod.POST)
	public ModelAndView joinMemberPro(HttpServletRequest req, @ModelAttribute MemberDTO dto, HttpSession session,
			BindingResult result) {
		if (result.hasErrors()) { // 에러가 날 경우를 대비해 BindingResult result를 만들어주고 여기에서 초기값을 잡아주면 된다.
			dto.setMnum(0);
			dto.setReviewcount(0);
			dto.setImagecount(0);
		}

		ModelAndView mav = new ModelAndView();
		String msg = null, url = null;
		if (dto.getName() == null || dto.getName().trim().equals("")) {
			msg = "회원가입페이지로 이동합니다";
			url = "member_login?mode=signup";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}

		String ssn2 = dto.getSsn2();
		ssn2 = SHA256Util.getEncrypt(ssn2, "yeps"); // 주민번호 뒷자리는 salt값을 yeps로 줌
		dto.setSsn2(ssn2);

		boolean isExistJumin = memberMapper.checkJumin(dto);
		if (isExistJumin) {
			msg = "이미 가입된 회원입니다. 로그인 페이지로 이동합니다.";
			url = "member_login";
		} else {
			dto.setEmail(req.getParameter("email1") + "@" + req.getParameter("email2"));
			String salt = SHA256Util.generateSalt();
			dto.setSalt(salt);
			String passwd = dto.getPasswd();
			passwd = SHA256Util.getEncrypt(passwd, salt);
			dto.setPasswd(passwd);

			int res = memberMapper.insertMember(dto);
			if (res > 0) {
				MemberDTO newMemberDTO = memberMapper.getMemberForEmail(dto.getEmail());

				MemberPhotoDTO memberPhotoDTO = new MemberPhotoDTO();
				memberPhotoDTO.setFilenum(0);
				memberPhotoDTO.setMnum(newMemberDTO.getMnum());
				memberPhotoDTO.setMember_filename("30s.jpg");
				memberPhotoDTO.setFilesize(707);
				memberPhotoDTO.setOrigin_filename("30s.jpg");
				memberPhotoMapper.insertMemberPhoto(memberPhotoDTO, "main");

				MemberDTO getLoginMemberDTO = memberMapper.loginMember(dto);
				MemberPhotoDTO mainPhoto = memberPhotoMapper.getMemberMainPhoto(getLoginMemberDTO.getMnum());
				session.setAttribute("mainPhoto", mainPhoto);

				String old_url = req.getParameter("old_url");
				if (getLoginMemberDTO.getIsmaster().equals("y")) {
					session.setAttribute("memberinfo", getLoginMemberDTO);
				} else if (getLoginMemberDTO.getIsmanager().equals("y")) {
					session.setAttribute("memberinfo", getLoginMemberDTO);
				} else {
					session.setAttribute("memberinfo", getLoginMemberDTO);
				}
				String[] urls = old_url.split("/");
				if (old_url != null && !old_url.trim().equals("")) {
					old_url = null;
					for (int i = 4; i < urls.length; i++) {
						if (i == 4) {
							old_url = urls[i];
						} else {
							old_url = "/" + urls[i];
						}
					}
					if (old_url.contains("member_login")) {
						return new ModelAndView("redirect:/main");
					} else {
						mav.setViewName("redirect:" + old_url);
						return mav;
					}
				}
				return new ModelAndView("redirect:/main");
			} else {
				msg = "회원가입실패!! 회원가입페이지로 이동합니다";
				url = "member_login?mode=";
			}
		}
		mav.setViewName("message");
		mav.addObject("msg", msg);
		mav.addObject("url", url);
		return mav;
	}

	@RequestMapping(value = "/member_confirmEmail", method = RequestMethod.GET)
	public ModelAndView confirmEmailForm(HttpServletRequest req) {
		String email = req.getParameter("email");
		if (email == null) {
			email = req.getParameter("email1") + "@" + req.getParameter("email2");
		}
		MemberDTO dto = memberMapper.confirmEmail(email);
		ModelAndView mav = new ModelAndView();
		if (dto == null) {
			mav.addObject("isMember", 0);
		} else {
			mav.addObject("isMember", 1);
		}
		mav.addObject("email", email);
		mav.setViewName("member/confirmEmail");
		return mav;
	}

	@RequestMapping(value = "/member_delete")
	public ModelAndView deleteMember(HttpServletRequest req, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		String msg = null, url = null;

		MemberDTO dto = (MemberDTO) session.getAttribute("memberinfo");
		if (!dto.getIsmaster().equals("y")) {
			msg = "회원관리권한이 없습니다.";
			url = "main";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}
		String num = req.getParameter("mnum");
		int mnum = 0;
		try {
			mnum = Integer.parseInt(num);
		} catch (Exception e) {
			mnum = 0;
		}
		if (mnum == 0) {
			msg = "회원관리페이지로 이동합니다.";
			url = "member_manager";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}
		int res = memberMapper.deleteMember(mnum);
		if (res > 0) {
			eventMapper.deleteEventByMemberNumber(mnum);
			eventReviewMapper.deleteEventReviewByMemberNumber(mnum);
			memberPhotoMapper.deleteMemberPhotosByMemberNumber(mnum);
			messageMapper.deleteMessageByMemberNumber(mnum);
			qnaMapper.deleteQnAByMemberNumber(mnum);
			reviewMapper.deleteReviewByMemberNumber(mnum);
			restaurantMapper.deleteRestaurantByMemberNumber(mnum);

			msg = "회원삭제성공!! 회원목록보기페이지로 이동합니다.";
			url = "member_manager";
		} else {
			msg = "회원삭제실패!! 회원목록보기페이지로 이동합니다.";
			url = "member_manager";
		}
		mav.setViewName("message");
		mav.addObject("msg", msg);
		mav.addObject("url", url);
		return mav;
	}

	@RequestMapping(value = "/member_login", method = RequestMethod.GET)
	public ModelAndView loginMemberForm(HttpSession session, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String msg = null, url = null;
		if (session.getAttribute("memberinfo") != null) {
			msg = "로그아웃을 먼저 해주세요.";
			url = "main";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}
		String old_url = req.getHeader("referer");
		mav.addObject("old_url", old_url);
		mav.setViewName("member/memberLogin");
		return mav;
	}

	@RequestMapping(value = "/member_login", method = RequestMethod.POST)
	public ModelAndView loginMemberPro(@ModelAttribute MemberDTO dto, HttpSession session, HttpServletRequest req,
			HttpServletResponse resp) {
		ModelAndView mav = new ModelAndView();
		String msg = null, url = null;
		if (dto.getEmail().trim().equals("") || dto.getPasswd().trim().equals("")) {
			msg = "로그인페이지로 이동합니다.";
			url = "member_login";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}
		String salt = memberMapper.getSaltByEmail(dto);
		if (salt == null) {
			msg = "존재하지 않는 이메일 입니다.";
			url = "member_login";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}
		String passwd = dto.getPasswd();

		passwd = SHA256Util.getEncrypt(passwd, salt);
		dto.setPasswd(passwd);

		MemberDTO getLoginMemberDTO = memberMapper.loginMember(dto);
		if (getLoginMemberDTO != null) {
			String email = getLoginMemberDTO.getEmail();
			int noReadMessage = messageMapper.noneMessageCount(email);
			session.setAttribute("noneCount", noReadMessage);
			MemberPhotoDTO mainPhoto = memberPhotoMapper.getMemberMainPhoto(getLoginMemberDTO.getMnum());
			session.setAttribute("mainPhoto", mainPhoto);

			String old_url = req.getParameter("old_url");
			if (getLoginMemberDTO.getIsmaster().equals("y")) {
				session.setAttribute("memberinfo", getLoginMemberDTO);
			} else if (getLoginMemberDTO.getIsmanager().equals("y")) {
				session.setAttribute("memberinfo", getLoginMemberDTO);
			} else {
				session.setAttribute("memberinfo", getLoginMemberDTO);
			}
			String[] urls = old_url.split("/");
			try {
				if (old_url != null && !old_url.trim().equals("")) {
					old_url = null;
					for (int i = 4; i < urls.length; i++) {
						if (i == 4) {
							old_url = urls[i];
						} else {
							old_url = "/" + urls[i];
						}
					}
					if (old_url.contains("member_login")) {
						return new ModelAndView("redirect:/main");
					} else {
						mav.setViewName("redirect:" + old_url);
						return mav;
					}
				} else {
					return new ModelAndView("redirect:/main");
				}
			} catch (Exception e) {
				return new ModelAndView("redirect:/main");
			}
		} else {
			msg = "비밀번호를 확인해주세요.";
			url = "member_login";
		}
		mav.setViewName("message");
		mav.addObject("msg", msg);
		mav.addObject("url", url);
		return mav;
	}

	@RequestMapping(value = "/member_emailAuth")
	public ModelAndView emailAuth(HttpServletResponse resp, HttpServletRequest req) {
		String email = req.getParameter("email");
		String authNum = ""; // RandomNum함수 호출해서 리턴값 저장

		authNum = randomNum.getKey(7, false);

		SendEmail.sendEmail(email.toString(), authNum);
		ModelAndView mav = new ModelAndView();
		String[] emailsplit = email.split("@");
		String email1 = emailsplit[0];
		String email2 = emailsplit[1];
		mav.setViewName("member/emailAuth");
		mav.addObject("email", email);
		mav.addObject("email1", email1);
		mav.addObject("email2", email2);
		mav.addObject("authNum", authNum);

		return mav;
	}

	@RequestMapping(value = "/member_findEmail", method = RequestMethod.GET)
	public ModelAndView findEmailForm() {
		return new ModelAndView("member/findEmail");
	}

	@RequestMapping(value = "/member_findEmail", method = RequestMethod.POST)
	public ModelAndView findEmailPro(@ModelAttribute MemberDTO dto) {
		ModelAndView mav = new ModelAndView();

		String msg = null, url = null;
		if (dto.getName().trim().equals("") || dto.getSsn1().trim().equals("") || dto.getSsn2().trim().equals("")) {
			msg = "로그인페이지로 이동합니다.";
			url = "member_login";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}

		String ssn2 = dto.getSsn2();
		ssn2 = SHA256Util.getEncrypt(ssn2, "yeps");
		dto.setSsn2(ssn2);

		List<String> emailList = memberMapper.findMemberEmail(dto);
		if (emailList != null) {
			mav.addObject("emailList", emailList);
		}

		System.out.println(emailList.size());
		mav.setViewName("member/findEmailOK");
		return mav;
	}

	@RequestMapping(value = "/member_findPasswd", method = RequestMethod.GET)
	public ModelAndView findPasswdForm() {
		return new ModelAndView("member/findPasswd");
	}

	@RequestMapping(value = "/member_findPasswd", method = RequestMethod.POST)
	public ModelAndView findPasswdPro(@ModelAttribute MemberDTO dto) {
		ModelAndView mav = new ModelAndView();

		String msg = null, url = null;
		if (dto.getName().trim().equals("") || dto.getSsn1().trim().equals("") || dto.getSsn2().trim().equals("")
				|| dto.getEmail().trim().equals("")) {
			msg = "로그인페이지로 이동합니다.";
			url = "member_login";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}

		String ssn2 = dto.getSsn2();
		ssn2 = SHA256Util.getEncrypt(ssn2, "yeps");
		dto.setSsn2(ssn2);

		int res = memberMapper.findMemberPasswd(dto);
		if (res > 0) {
			String authNum = ""; // RandomNum함수 호출해서 리턴값 저장
			authNum = randomNum.getKey(10, false);
			String passwd = authNum;

			String salt = memberMapper.getSaltByEmail(dto);
			passwd = SHA256Util.getEncrypt(passwd, salt);
			dto.setPasswd(passwd);

			int result = memberMapper.temporaryPasswd(dto);
			if (result > 0) {
				String email = dto.getEmail();
				SendEmail.sendTemporaryPasswd(email.toString(), authNum);
				mav.addObject("temporaryPw", 1);
			} else {
				mav.addObject("temporaryPw", 0);
			}
		} else {
			mav.addObject("temporaryPw", -1);
		}
		mav.setViewName("member/findPasswdOK");
		return mav;
	}

	@RequestMapping(value = "/member_logout", method = RequestMethod.GET)
	public ModelAndView logoutMemberForm(HttpSession session, HttpServletRequest req) {
		session.invalidate();
		ModelAndView mav = new ModelAndView();
		String old_url = req.getHeader("referer");
		String[] urls = old_url.split("/");
		if (old_url != null && !old_url.trim().equals("")) {
			old_url = null;
			for (int i = 4; i < urls.length; i++) {
				if (i == 4) {
					old_url = urls[i];
				} else {
					old_url = "/" + urls[i];
				}
			}
			if (old_url.contains("member_login")) {
				return new ModelAndView("redirect:/main");
			} else {
				mav.setViewName("redirect:" + old_url);
				return mav;
			}
		}
		return new ModelAndView("redirect:/main");
	}

	@RequestMapping(value = "/member_profile", method = RequestMethod.GET)
	public ModelAndView profileMemberForm() {
		return new ModelAndView("member/memberProfile");
	}

	@RequestMapping(value = "/member_profile", method = RequestMethod.POST)
	public ModelAndView profileMemberPro(HttpServletRequest req, @ModelAttribute MemberDTO updateMemberDTO,
			HttpSession session, BindingResult result) {
		if (result.hasErrors()) {
			updateMemberDTO.setMnum(0);
			updateMemberDTO.setReviewcount(0);
			updateMemberDTO.setImagecount(0);
		}

		String mnum = req.getParameter("mnum");
		String name = req.getParameter("name");
		String nickname = req.getParameter("nickname");
		String address = req.getParameter("address");

		if (name == null || name.trim().equals("")) {
			return new ModelAndView("member/memberProfile");
		}

		ModelAndView mav = new ModelAndView();
		String msg = null, url = null;
		MemberDTO dto = (MemberDTO) session.getAttribute("memberinfo");
		int res = 0;
		if (mnum != null) {
			if (!dto.getIsmaster().equals("y")) {
				msg = "회원관리권한이 없습니다.";
				url = "main";
				mav.setViewName("message");
				mav.addObject("msg", msg);
				mav.addObject("url", url);
				return mav;
			} else {
				updateMemberDTO.setNickname(nickname);
				updateMemberDTO.setIsmanager("n");
				updateMemberDTO.setControlcate("n");
				updateMemberDTO.setControlevent("n");
				updateMemberDTO.setControlmember("n");
				updateMemberDTO.setControlreview("n");
				updateMemberDTO.setControlstore("n");

				String[] controlckbox = req.getParameterValues("controlckbox");

				if (controlckbox != null) {
					updateMemberDTO.setIsmanager("y");
					for (int i = 0; i < controlckbox.length; i++) {
						if (controlckbox[i].equals("controlcate")) {
							updateMemberDTO.setControlcate("y");
						} else if (controlckbox[i].equals("controlevent")) {
							updateMemberDTO.setControlevent("y");
						} else if (controlckbox[i].equals("controlmember")) {
							updateMemberDTO.setControlmember("y");
						} else if (controlckbox[i].equals("controlreview")) {
							updateMemberDTO.setControlreview("y");
						} else if (controlckbox[i].equals("controlstore")) {
							updateMemberDTO.setControlstore("y");
						}
					}
				}

				res = memberMapper.updateMemberProfileByMaster(updateMemberDTO);
				if (res > 0) {
					url = "member_manager?mnum=" + updateMemberDTO.getMnum();
				} else {
					url = "member_manager?mnum=" + updateMemberDTO.getMnum();
				}
			}
		} else {
			int memberNum = dto.getMnum();
			res = memberMapper.updateMemberProfile(memberNum, name, nickname, address);
			if (res > 0) {
				url = "member_profile?mode=profile";
				dto.setName(name);
				dto.setNickname(nickname);
				dto.setAddress(address);
				session.setAttribute("memberinfo", dto);
			} else {
				url = "member_profile?mode=profile";
			}
		}
		mav.setViewName("usingOnlyURL");
		mav.addObject("url", url);

		return mav;
	}

	@RequestMapping(value = "/member_password", method = RequestMethod.POST)
	public ModelAndView PasswordMemberPro(HttpSession session, HttpServletRequest req) {
		String passwd = req.getParameter("passwd");
		String passwd1 = req.getParameter("passwd1");
		if (passwd == null || passwd.trim().equals("") || passwd1 == null || passwd1.trim().equals("")) {
			return new ModelAndView("member/memberProfile");
		}

		ModelAndView mav = new ModelAndView();
		String msg = null, url = null;

		MemberDTO dto = (MemberDTO) session.getAttribute("memberinfo");

		String salt = memberMapper.getSaltByEmail(dto);
		if (salt == null) {
			msg = "존재하지 않는 이메일 입니다. 다시 로그인 해주세요.";
			url = "member_login";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}
		passwd = SHA256Util.getEncrypt(passwd, salt);
		passwd1 = SHA256Util.getEncrypt(passwd1, salt);

		if (passwd.equals(passwd1)) {
			msg = "변경하고자 하는 비밀번호와 이전 비밀번호와 같습니다.";
			url = "member_profile?mode=passwd";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}

		int res = memberMapper.updateMemberPasswd(dto.getMnum(), passwd, passwd1);

		if (res > 0) {
			msg = "비밀번호를 변경하였습니다.";
			url = "member_profile?mode=passwd";
		} else {
			msg = "비밀번호를 다시 확인해주세요.";
			url = "member_profile?mode=passwd";
			mav.addObject("mode", "passwd");
		}
		mav.setViewName("message");
		mav.addObject("msg", msg);
		mav.addObject("url", url);

		return mav;
	}

	@RequestMapping(value = "/member_leave", method = RequestMethod.POST)
	public ModelAndView LeaveMemberPro(HttpSession session, HttpServletRequest req) {
		String passwd = req.getParameter("passwd");
		if (passwd == null || passwd.trim().equals("")) {
			return new ModelAndView("member/memberProfile");
		}

		ModelAndView mav = new ModelAndView();
		String msg = null, url = null;

		MemberDTO dto = (MemberDTO) session.getAttribute("memberinfo");
		String salt = memberMapper.getSaltByEmail(dto);
		if (salt == null) {
			msg = "존재하지 않는 이메일 입니다. 다시 로그인 해주세요.";
			url = "member_login";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}
		passwd = SHA256Util.getEncrypt(passwd, salt);
		dto.setPasswd(passwd);
		int res = memberMapper.leaveMember(dto);
		eventMapper.deleteEventByMemberNumber(dto.getMnum());
		eventReviewMapper.deleteEventReviewByMemberNumber(dto.getMnum());
		memberPhotoMapper.deleteMemberPhotosByMemberNumber(dto.getMnum());
		messageMapper.deleteMessageByMemberNumber(dto.getMnum());
		qnaMapper.deleteQnAByMemberNumber(dto.getMnum());
		reviewMapper.deleteReviewByMemberNumber(dto.getMnum());
		restaurantMapper.deleteRestaurantByMemberNumber(dto.getMnum());
 
		if (res > 0) {
			msg = "회원 탈퇴 성공!";
			session.invalidate();
			url = "main";
		} else {
			msg = "회원 탈퇴 실패! 비밀번호를 다시 확인해주세요.";
			url = "member_profile?mode=memberleave";
		}
		mav.setViewName("message");
		mav.addObject("msg", msg);
		mav.addObject("url", url);

		return mav;
	}

	@RequestMapping(value = "/member_login_ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, String> loginMemberAjaxPro(HttpServletRequest req, @ModelAttribute MemberDTO dto,
			HttpSession session) {
		HashMap<String, String> map = new HashMap<String, String>();
		if (session.getAttribute("memberinfo") != null) {
			map.put("msg", "로그아웃을 먼저 해주세요.");
			return map;
		}

		if (dto.getEmail() == null || dto.getPasswd() == null || dto.getEmail().trim().equals("")
				|| dto.getPasswd().trim().equals("")) {
			map.put("msg", "잘못된 접근입니다.");
			return map;
		}

		String salt = memberMapper.getSaltByEmail(dto);
		if (salt == null) {
			map.put("msg", "존재하지 않는 이메일 입니다.");
			return map;
		}
		String passwd = dto.getPasswd();

		passwd = SHA256Util.getEncrypt(passwd, salt);
		dto.setPasswd(passwd);

		MemberDTO getLoginMemberDTO = memberMapper.loginMember(dto);
		if (getLoginMemberDTO != null) {
			if (getLoginMemberDTO.getIsmaster().equals("y")) {
				session.setAttribute("memberinfo", getLoginMemberDTO);
			} else if (getLoginMemberDTO.getIsmanager().equals("y")) {
				session.setAttribute("memberinfo", getLoginMemberDTO);	
			} else {
				session.setAttribute("memberinfo", getLoginMemberDTO);
			}
			MemberPhotoDTO mainPhoto = memberPhotoMapper.getMemberMainPhoto(getLoginMemberDTO.getMnum());
			session.setAttribute("mainPhoto", mainPhoto);

		} else {
			map.put("msg", "비밀번호를 확인해주세요.");
		}
		return map;
	}

	@RequestMapping(value = "/member_join_ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, String> joinMemberAjaxPro(HttpServletRequest req, @ModelAttribute MemberDTO dto,
			HttpSession session, BindingResult result) {
		HashMap<String, String> map = new HashMap<String, String>();
		if (result.hasErrors()) { // 에러가 날 경우를 대비해 BindingResult result를 만들어주고 여기에서 초기값을 잡아주면 된다.
			dto.setMnum(0);
			dto.setReviewcount(0);
			dto.setImagecount(0);
		}
		if (dto.getName() == null || dto.getName().trim().equals("")) {
			map.put("msg", "잘못된 접근입니다.");
			return map;
		}

		String ssn2 = dto.getSsn2();
		ssn2 = SHA256Util.getEncrypt(ssn2, "yeps"); // 주민번호 뒷자리는 salt값을 yeps로 줌
		dto.setSsn2(ssn2);

		boolean isExistJumin = memberMapper.checkJumin(dto);
		if (isExistJumin) {
			map.put("msg", "이미 가입된 회원입니다.");
			return map;
		} else {
			dto.setEmail(req.getParameter("email1") + "@" + req.getParameter("email2"));
			String salt = SHA256Util.generateSalt();
			dto.setSalt(salt);
			String passwd = dto.getPasswd();
			passwd = SHA256Util.getEncrypt(passwd, salt);
			dto.setPasswd(passwd);

			int res = memberMapper.insertMember(dto);
			if (res > 0) {
				map.put("msg", "회원 가입 성공! 환영합니다");

				MemberDTO newMemberDTO = memberMapper.getMemberForEmail(dto.getEmail());

				MemberPhotoDTO memberPhotoDTO = new MemberPhotoDTO();
				memberPhotoDTO.setFilenum(0);
				memberPhotoDTO.setMnum(newMemberDTO.getMnum());
				memberPhotoDTO.setMember_filename("30s.jpg");
				memberPhotoDTO.setFilesize(707);
				memberPhotoDTO.setOrigin_filename("30s.jpg");
				memberPhotoMapper.insertMemberPhoto(memberPhotoDTO, "main");

				MemberDTO getLoginMemberDTO = memberMapper.loginMember(dto);
				if (getLoginMemberDTO.getIsmaster().equals("y")) {
					session.setAttribute("memberinfo", getLoginMemberDTO);
					map.put("msg", "마스터 아이디로 로그인 하셨습니다");
				} else if (getLoginMemberDTO.getIsmanager().equals("y")) {
					session.setAttribute("memberinfo", getLoginMemberDTO);
					map.put("msg", "관리자 아이디로 로그인 하셨습니다.");
				} else {
					session.setAttribute("memberinfo", getLoginMemberDTO);
				}
				MemberPhotoDTO mainPhoto = memberPhotoMapper.getMemberMainPhoto(getLoginMemberDTO.getMnum());
				session.setAttribute("mainPhoto", mainPhoto);

			} else {
				map.put("msg", "회원 가입에 실패했습니다.");
			}
		}
		return map;
	}

	@RequestMapping(value = "/member_details", method = RequestMethod.GET)
	public ModelAndView detailsMemberForm(HttpServletRequest req, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String mnum = req.getParameter("mnum");
		MemberDTO memberDTO = null;
		List<MemberPhotoDTO> getPhotoList = null;
		if (mnum == null || mnum.trim().equals("")) {
			memberDTO = (MemberDTO) session.getAttribute("memberinfo");
			if (memberDTO == null) {
				return new ModelAndView("redirect:/main");
			}
			getPhotoList = memberPhotoMapper.getMemberPhotoList(memberDTO.getMnum());
		} else {
			memberDTO = memberMapper.getMemberByMnum(Integer.parseInt(mnum));
			if (memberDTO == null) {
				return new ModelAndView("redirect:/main");
			}
			getPhotoList = memberPhotoMapper.getMemberPhotoList(Integer.parseInt(mnum));
		}
		int reviewcount = memberDTO.getReviewcount();
		String email = memberDTO.getEmail();
		int noneCount = messageMapper.noneMessageCount(email);
		mav.addObject("noneCount", noneCount);
		mav.addObject("reviewcount", reviewcount);
		mav.addObject("memberDTO", memberDTO);
		mav.addObject("getPhotoList", getPhotoList);
		mav.setViewName("member/memberDetails");
		return mav;
	}

	@RequestMapping(value = "/member_photos")
	public ModelAndView insertPhoto_Member(HttpServletRequest req) {
		return new ModelAndView("member/memberPhotos");
	}

	@RequestMapping(value = "/member_fileUpLoad")
	@ResponseBody
	public HashMap<String, Object> fileUpLoad_member(HttpServletRequest req) {
		HttpSession session = req.getSession();
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
		return uploadFileLoop(mr, session);
	}

	public HashMap<String, Object> uploadFileLoop(MultipartHttpServletRequest mr, HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		Iterator<String> it = mr.getFileNames();
		String origin_fileName = null;
		int fileSize = 0;
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberinfo");

		int imageCount = 0;
		while (it.hasNext()) {
			imageCount++;
			MultipartFile mf = mr.getFile(it.next());
			origin_fileName = mf.getOriginalFilename();
			fileSize = (int) mf.getSize();
			String genId = UUID.randomUUID().toString();
			String contentType = getExtension(origin_fileName);
			String saveFileName = genId + "." + contentType;

			File file = new File(saveFileName);
			if (mf.getSize() != 0) {
				try {
					mf.transferTo(file);
					S3Connection.getInstance().putObjectAsync("yepsbucket", "images/" + saveFileName, file,
							"image/" + contentType);

					MemberPhotoDTO MemberPhotoDTO = new MemberPhotoDTO();
					MemberPhotoDTO.setMnum(memberDTO.getMnum());
					MemberPhotoDTO.setMember_filename(saveFileName);
					MemberPhotoDTO.setOrigin_filename(origin_fileName);
					MemberPhotoDTO.setFilesize(fileSize);

					boolean isExistMainPhoto = memberPhotoMapper.isExistMemberMainPhoto(memberDTO.getMnum());
					int result = 0;
					if (!isExistMainPhoto) {
						result = memberPhotoMapper.insertMemberPhoto(MemberPhotoDTO, "main");
					} else {
						result = memberPhotoMapper.insertMemberPhoto(MemberPhotoDTO, "");
					}

					if (result > 0) {
						map.put("success", "파일 등록 성공");
					} else {
						memberPhotoMapper.deleteMemberPhotoToFilename(saveFileName);
						S3Connection.getInstance().deleteObject("yepsbucket", "images/" + saveFileName);
						map.put("failed", "파일 등록에 실패했습니다. 잠시후 다시 시도해주세요.");
						imageCount--;
						file.delete();
					}
				} catch (Exception e) {
					e.printStackTrace();
					origin_fileName = null;
					fileSize = 0;
					file = null;
					map.put("created_fail", "파일 생성 실패, 잠시 후 다시 시도하세요.");
				}
			} else {
				map.put("upload_failed", "업로드할 수 없는 파일이 존재합니다.");
			}
		}
		memberMapper.updateImageCount(memberDTO.getMnum(), imageCount);
		memberDTO.setImagecount(memberDTO.getImagecount() + imageCount);
		session.setAttribute("memberinfo", memberDTO);

		MemberPhotoDTO mainPhoto = memberPhotoMapper.getMemberMainPhoto(memberDTO.getMnum());
		session.setAttribute("mainPhoto", mainPhoto);
		map.put("mnum", memberDTO.getMnum());
		return map;
	}

	public String getExtension(String fileName) {
		int dotPosition = fileName.lastIndexOf('.');

		if (-1 != dotPosition && fileName.length() - 1 > dotPosition) {
			return fileName.substring(dotPosition + 1);
		} else {
			return "";
		}
	}

	@RequestMapping(value = "/member_photolist")
	public ModelAndView photolist_Member(HttpServletRequest req, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String mnum = req.getParameter("mnum");
		if (mnum == null || mnum.trim().equals("")) {
			return new ModelAndView("redirect:/main");
		}
		MemberDTO dto = memberMapper.getMemberByMnum(Integer.parseInt(mnum));
		if (dto == null) {
			return new ModelAndView("redirect:/main");
		}
		List<MemberPhotoDTO> memberPhotoList = memberPhotoMapper.getMemberPhotoList(dto.getMnum());
		mav.addObject("memberDTO", dto);
		mav.addObject("memberPhotoList", memberPhotoList);
		mav.setViewName("member/memberPhotoList");
		return mav;
	}

	@RequestMapping(value = "/member_photo_update", method = RequestMethod.GET)
	public ModelAndView updatePhoto_Member_get(HttpServletRequest req, HttpSession session) {
		return new ModelAndView("redirect:/main");
	}

	@RequestMapping(value = "/member_photo_update", method = RequestMethod.POST)
	public ModelAndView updatePhoto_Member(HttpServletRequest req, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String filenum = req.getParameter("filenum");
		String mnum = req.getParameter("mnum");

		String msg = null, url = null;
		if (filenum == null || mnum == null || filenum.trim().equals("") || mnum.trim().equals("")) {
			msg = "잘못된 접근입니다.";
			url = "main";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}

		MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberinfo");
		MemberDTO userDTO = memberMapper.getMemberByMnum(Integer.parseInt(mnum)); // 변경한 사진을 가진 유저의 정보
		if (memberDTO.getMnum() == Integer.parseInt(mnum) || memberDTO.getIsmanager().equals("y")) {
			int res = memberPhotoMapper.changeMemberMainPhoto(Integer.parseInt(filenum), Integer.parseInt(mnum));
			if (res > 0) {
				if (memberDTO.getMnum() == userDTO.getMnum()) { // 내 사진을 변경했는지(내 사진을 변경했다면 현재 나의 메인 사진을 바꿔줘야함)
					MemberPhotoDTO mainPhoto = memberPhotoMapper.getMemberMainPhoto(memberDTO.getMnum());
					session.setAttribute("mainPhoto", mainPhoto);
				}
				mav.addObject("mode", "successUpdate");
			} else {
				mav.addObject("mode", "failedUpdate");
			}
		}
		List<MemberPhotoDTO> memberPhotoList = memberPhotoMapper.getMemberPhotoList(userDTO.getMnum());
		mav.addObject("memberDTO", userDTO);
		mav.addObject("memberPhotoList", memberPhotoList);
		mav.setViewName("member/memberPhotoList");
		return mav;
	}

	@RequestMapping(value = "/member_photo_delete", method = RequestMethod.GET)
	public ModelAndView deletePhoto_Member_get(HttpServletRequest req, HttpSession session) {
		return new ModelAndView("redirect:/main");
	}

	@RequestMapping(value = "/member_photo_delete", method = RequestMethod.POST)
	public ModelAndView deletePhoto_Member(HttpServletRequest req, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String filenum = req.getParameter("filenum");
		String mnum = req.getParameter("mnum");
		String filename = req.getParameter("filename");
		String ismainphoto = req.getParameter("ismainphoto");

		String msg = null, url = null;
		if (filenum.trim().equals("") || filenum == null || mnum.trim().equals("") || mnum == null) {
			msg = "잘못된 접근입니다.";
			url = "main";
			mav.setViewName("message");
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}

		MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberinfo");
		MemberDTO userDTO = memberMapper.getMemberByMnum(Integer.parseInt(mnum)); // 변경한 사진을 가진 유저의 정보
		if (memberDTO.getMnum() == Integer.parseInt(mnum) || memberDTO.getIsmanager().equals("y")) {
			int res = memberPhotoMapper.deleteMemberPhoto(Integer.parseInt(filenum), Integer.parseInt(mnum),
					ismainphoto);
			if (res > 0) {
				S3Connection.getInstance().deleteObject("yepsbucket", "images/" + filename);
				memberDTO.setImagecount(memberDTO.getImagecount() - 1);
				session.setAttribute("memberinfo", memberDTO);
				if (memberDTO.getMnum() == userDTO.getMnum()) { // 내 사진을 변경했는지(내 사진을 변경했다면 현재 나의 메인 사진을 바꿔줘야함)
					MemberPhotoDTO mainPhoto = memberPhotoMapper.getMemberMainPhoto(memberDTO.getMnum());
					session.setAttribute("mainPhoto", mainPhoto);
				}
				mav.addObject("mode", "successDelete");
			} else {
				mav.addObject("mode", "failedDelete");
			}
		}
		List<MemberPhotoDTO> memberPhotoList = memberPhotoMapper.getMemberPhotoList(userDTO.getMnum());
		mav.addObject("memberDTO", userDTO);
		mav.addObject("memberPhotoList", memberPhotoList);
		mav.setViewName("member/memberPhotoList");
		return mav;
	}
}