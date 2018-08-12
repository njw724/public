package com.yeps.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.yeps.model.MemberDTO;
import com.yeps.model.MessageDTO;
import com.yeps.model.RestaurantDTO;
import com.yeps.service.EventMapper;
import com.yeps.service.MemberMapper;
import com.yeps.service.MessageMapper;
import com.yeps.service.RestaurantMapper;
import com.yeps.service.YepsPager;

@Controller
public class MessageController {

	@Autowired
	private MessageMapper messageMapper;

	@Autowired
	private RestaurantMapper restaurantMapper;

	@Autowired
	private MemberMapper memberMapper;

	@Autowired
	private EventMapper eventMapper;

	public ModelAndView pagingMessageList(HttpServletRequest req, @RequestParam String lMode, String email) {
		ModelAndView mav = new ModelAndView();
		// 각각의 메시지 총 수를 구한다.
		int cnt = 0;
		int count = messageMapper.getMessageCount();// 총 메시지 카운트. 하지만 보여지는 페이지에선 나오지 않을듯
		int lCount = messageMapper.getLockerCount(email);// 보관함 쪽지 개수
		int sCount = messageMapper.getSendCount(email);// 보낸 쪽지 개수
		int mCount = messageMapper.getReceiveCount(email);// 받은 쪽지 개수
		int aCount = messageMapper.allAlertCount(email);
		int rCount = messageMapper.readAlertCount(email);
		int noneCount = messageMapper.noneMessageCount(email);
		int curPage = req.getParameter("curPage") != null ? Integer.parseInt(req.getParameter("curPage")) : 1;
		// lMode로 여러 종류의 리스트를 구분하여 카운트를 설정한다.
		if (lMode == null) {
			lMode = req.getParameter("lMode") != null ? req.getParameter("lMode") : "msgBoxList";

		}
		if (lMode.equals("allLocker")) {
			cnt = lCount;
		} else if (lMode.equals("msgBoxList")) {
			cnt = mCount;
		} else if (lMode.equals("allList")) {
			cnt = count - aCount;
		} else if (lMode.equals("noneMsg")) {

			cnt = noneCount;
		} else if (lMode.equals("readMsg")) {

			cnt = messageMapper.readMessageCount(email);
		} else if (lMode.equals("noneLocker")) {

			cnt = messageMapper.noneLockerCount(email);
		} else if (lMode.equals("readLocker")) {

			cnt = messageMapper.readLockerCount(email);
		} else if (lMode.equals("alertMsg")) {

			cnt = aCount;
		} else if (lMode.equals("readAlert")) {

			cnt = rCount;
		} else if (lMode.equals("noneAlert")) {

			cnt = aCount - rCount;
		} else if (lMode.equals("sender")) {

			cnt = sCount;
		}
		int pageScale = 10, blockScale = 5;
		YepsPager yepsPager = new YepsPager(cnt, curPage, pageScale, blockScale);
		int start = yepsPager.getPageBegin();
		int end = yepsPager.getPageEnd();

		int num = count - pageScale * (curPage - 1) + 1;

		if (lMode == null || email == null) {
			mav.setViewName("mainPage");
			return mav;
		}

		// 페이징처리된 리스트를 구한다.
		List<MessageDTO> list = messageMapper.messageList(start, end, lMode, email);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("lMode", lMode);
		map.put("list", list); // list
		map.put("count", count);
		map.put("yepsPager", yepsPager);

		mav.addObject("mCount", mCount);
		mav.addObject("lCount", lCount);
		mav.addObject("sCount", sCount);
		mav.addObject("aCount", aCount);
		mav.addObject("count", count);
		mav.addObject("num", num);
		mav.addObject("map", map);

		req.getSession().setAttribute("noneCount", noneCount);
		// 로그인 회원이 마스터나 매니져인지 확인후 권한 주기
		MemberDTO member = (MemberDTO) req.getSession().getAttribute("memberinfo");
		String key = null;
		if (member.getIsmanager().equals("y")) {
			key = "almighty";
		} else {
			key = "ordinary";
		}

		// lMode에 따라 보내질 페이지를 구분한다.
		String where = null;
		if (lMode.equals("allLocker") || lMode.equals("readLocker") || lMode.equals("noneLocker")) {
			where = "locker";
			mav.addObject("where", where);
			mav.addObject("mode", "locker");

		} else if (lMode.equals("alertMsg") || lMode.equals("readAlert") || lMode.equals("noneAlert")) {
			where = "alert";
			mav.addObject("where", where);

		} else {
			String mode = req.getParameter("mode");
			where = "yeps";
			mav.addObject("where", where);
			if (mode == null) {
				mav.addObject("mode", "receive");
			} else {
				mav.addObject("mode", mode);
			}

		}
		mav.setViewName("message/yepsMessage");
		mav.addObject("set", "message");
		mav.addObject("key", key);// key 값 지정
		return mav;
	}

	@RequestMapping(value = "yeps_message")
	public ModelAndView yeps_message(HttpServletRequest req) throws Exception {
		ModelAndView mav = new ModelAndView();
		String msg = null, key = null;
		String lMode = req.getParameter("lMode");

		MemberDTO member = (MemberDTO) req.getSession().getAttribute("memberinfo");
		if (member == null) {
			msg = "로그인 먼저 해주세요. 로그인 페이지로 이동합니다.";
			mav.addObject("msg", msg);
			mav.setViewName("redirect:member_login?mode=login");
			return mav;
		}
		if (member.getIsmaster().equals("y") || member.getIsmanager().equals("y")) {
			key = "almighty";
		} else {
			key = "ordinary";
		}

		String email = member.getEmail();
		mav = pagingMessageList(req, lMode, email);
		mav.addObject("set", "message");
		mav.addObject("key", key);// key 값 지정
		return mav;
	}

	@RequestMapping(value = "message_delete")
	public ModelAndView message_delete(HttpServletRequest req, String[] check) {
		ModelAndView mav = new ModelAndView();
		String msgNum = req.getParameter("msgNum");
		String msg = null, lMode = null;
		MemberDTO member = (MemberDTO) req.getSession().getAttribute("memberinfo");
		lMode = req.getParameter("lMode");
		String email = member.getEmail();
		int res = 0;
		if (msgNum == null) {
			if (check == null) {
				msg = "선택된 메시지가 없습니다. 다시 확인하세요.";
				mav.addObject("msg", msg);
				mav.setViewName("historyBack");
				return mav;
			}
			for (String num : check) {
				int msgnum = Integer.parseInt(num);
				res = messageMapper.deleteMessage(msgnum);
				if (res > 0) {
					msg = "메시지가 삭제 되었습니다.";
				} else {
					msg = "메시지 삭제에 실패하였습니다.";
				}
			}
		} else {
			int msgnum = Integer.parseInt(msgNum);
			res = messageMapper.deleteMessage(msgnum);
			msg = "메시지가 삭제 되었습니다.";

		}
		mav = pagingMessageList(req, lMode, email);
		mav.addObject("msg", msg);
		return mav;
	}

	@RequestMapping(value = "message_send")
	public ModelAndView message_send(HttpServletRequest req, @ModelAttribute MessageDTO dto, HttpSession session,
			BindingResult result) throws Exception {

		if (result.hasErrors()) {
			dto.setMsgNum(0);
		}

		ModelAndView mav = new ModelAndView();
		String msg = null, lMode = null, receiver = null, email = null;
		int res = 0;
		String report = req.getParameter("report");
		MemberDTO member = (MemberDTO) req.getSession().getAttribute("memberinfo");

		if (member == null) {
			mav.setViewName("mainPage");
			return mav;
		}
		int mnum = member.getMnum();

		dto.setMnum(mnum);
		email = member.getEmail();// 로그인시 로그인한 회원의 정보로 보내는 사람을 구한다.*/
		dto.setSender(email);
		System.out.println("1=" + dto.getSender());
		List<MemberDTO> memberList = memberMapper.listMemberForMessage();

		if (report == null && dto.getReceiver() != null) {
			receiver = dto.getReceiver().trim();
			dto.setReceiver(receiver);
			dto.setIsIssue(0);

			for (int i = 0; i < memberList.size(); i++) {
				String who = memberList.get(i).getEmail();
				if (who.equals(receiver.trim())) {
					dto.setReceiver(who);
				}
			}
			res = messageMapper.writeMessage(dto);
			if (res > 0) {
				msg = "메세지를 전송하였습니다.";
				lMode = "msgBoxList";
				mav = pagingMessageList(req, lMode, email);

			} else {
				msg = "쪽지 보내기에 실패하였습니다.";
				mav = pagingMessageList(req, lMode, email);
			}
			mav.addObject("msg", msg);
			return mav;
			// 쪽지함에서 신고쪽지 보낼때 받는 부분
		} else if (report.equals("reply") || report.equals("event") || report.equals("issue")) {
			// 이벤트에서 신고보낼때 받는 부분(쪽지함 신고 부분에 포함)
			String where = req.getParameter("where");
			String rnum = req.getParameter("rnum");

			if (where.equals("rest")) {
				String reason = req.getParameter("reason_field");

				if (reason.equals("inappropriate_post")) {
					reason = "부적절한 홍보 게시물";
				} else if (reason.equals("Eroticism")) {
					reason = "음란성, 선정성 또는 부적합한 내용";
				} else if (reason.equals("swear_word")) {
					reason = "특정인 대상의 비방/욕설";
				} else if (reason.equals("Privacy_infringement")) {
					reason = "명예훼손/사생활 침해 및 저작권침해 등";
				} else if (reason.equals("personal_information")) {
					reason = "개인정보 공개";
				} else if (reason.equals("plaster")) {
					reason = "같은 내용의 반복 게시 (도배)";
				}
				RestaurantDTO restaurant = restaurantMapper.getRest(Integer.parseInt(rnum));
				dto.setTitle("restaurant report : " + restaurant.getRname() + ", (" + reason + ")");

			} else if (where.equals("event")) {

				String sEvnum = req.getParameter("evnum");
				int evnum = Integer.parseInt(sEvnum);
				String eventname = eventMapper.getEventContent(evnum).getEventname();
				String reason = req.getParameter("reason_field");

				if (reason != null) {
					if (reason.equals("inappropriate_post")) {
						reason = "부적절한 홍보 게시물";
					} else if (reason.equals("Eroticism")) {
						reason = "음란성, 선정성 또는 부적합한 내용";
					} else if (reason.equals("swear_word")) {
						reason = "특정인 대상의 비방/욕설";
					} else if (reason.equals("Privacy_infringement")) {
						reason = "명예훼손/사생활 침해 및 저작권침해 등";
					} else if (reason.equals("personal_information")) {
						reason = "개인정보 공개";
					} else if (reason.equals("plaster")) {
						reason = "같은 내용의 반복 게시 (도배)";
					}
					dto.setTitle("reply report : " + eventname + ", (" + reason + ")");
				} else {
					dto.setTitle("event report : " + eventname);
				}
				dto.setEvnum(evnum);
				mav.addObject("evnum", evnum);

			} else if (where.equals("msgbox")) {
				System.out.println("2=" + dto.getSender());
				String title = req.getParameter("title");
				String newTitle = "report : " + title;
				dto.setTitle(newTitle);
			}

			if (where.equals("rest") || where.equals("event")) {

				String reportContent = req.getParameter("flag_popup_descripte_field");
				dto.setContent(reportContent);

			} else if (where.equals("msgbox")) {

				String content = req.getParameter("content");
				dto.setContent(content);

			}

			// 여기까지 이벤트 신고 부분. 아래부터는 쪽지함 신고와 동일
			// 등록된 회원중 매니져를 찾아 매니져에게만 이슈가 되는 내용을 보낸다.
			for (int i = 0; i < memberList.size(); i++) {
				String isManager = memberList.get(i).getIsmanager();
				email = memberList.get(i).getEmail();
				if (isManager.equals("y")) {
					receiver = memberList.get(i).getEmail();
					dto.setReceiver(receiver);
					dto.setIsIssue(1);
					res = messageMapper.writeMessage(dto);
				}
			}

			if (where.equals("rest")) {
				mav.setViewName("restaurant/restaurant_content");

			} else if (where.equals("event")) {
				mav.setViewName("event/event_contentForm");
			}

		}

		mav.addObject("msg", msg);
		mav.setViewName("redirect:yeps_message");// historyback.jsp를 이용하여 이전 페이지로 이동

		return mav;
	}

	@RequestMapping(value = "message_action")
	public ModelAndView message_search(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String filterMode = req.getParameter("filter");

		MemberDTO member = (MemberDTO) req.getSession().getAttribute("memberinfo");
		if (member == null) {
			mav.setViewName("mainPage");
			return mav;
		}

		String email = member.getEmail();
		String lMode = null;
		String msg = null;
		if (filterMode.equals("allMsg")) {
			mav.setViewName("redirect:yeps_message");

		} else if (filterMode.equals("noneMsg")) {
			lMode = "noneMsg";
			mav = pagingMessageList(req, lMode, email);

		} else if (filterMode.equals("readMsg")) {
			lMode = "readMsg";
			mav = pagingMessageList(req, lMode, email);

		} else if (filterMode.equals("allLocker")) {
			lMode = "allLocker";
			mav = pagingMessageList(req, lMode, email);
		} else if (filterMode.equals("readLocker")) {
			lMode = "readLocker";
			mav = pagingMessageList(req, lMode, email);

		} else if (filterMode.equals("noneLocker")) {
			lMode = "noneLocker";
			mav = pagingMessageList(req, lMode, email);

		} else if (filterMode.equals("alertMsg")) {
			lMode = filterMode;
			mav = pagingMessageList(req, lMode, email);

		} else if (filterMode.equals("readAlert")) {
			lMode = filterMode;
			mav = pagingMessageList(req, lMode, email);

		} else if (filterMode.equals("noneAlert")) {
			lMode = filterMode;
			mav = pagingMessageList(req, lMode, email);

		} else if (filterMode.equals("sender")) {
			lMode = filterMode;
			mav = pagingMessageList(req, lMode, email);
			mav.addObject("mode", "send");

		} else if (filterMode.equals("msgBoxList")) {
			mav.setViewName("redirect:yeps_message");

		} else {
			msg = "error code:4007; 관리자에게 문의 하십시오.";
			mav.setViewName("message/yepsMessage");
			mav.addObject("msg", msg);
		}
		return mav;
	}

	@RequestMapping(value = "message_read") // 쪽지함에서 읽음 표시
	public ModelAndView message_read(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		MemberDTO member = (MemberDTO) req.getSession().getAttribute("memberinfo");
		if (member == null) {
			mav.setViewName("mainPage");
			return mav;
		}
		String email = member.getEmail();
		String lMode = req.getParameter("lMode");
		int msgNum = 0, readNum = 0;
		String sMsgnum = req.getParameter("msgnum");
		if (sMsgnum.trim().equals("") || sMsgnum == null) {
			mav.setViewName("historyBack");
			return mav;
		}
		msgNum = Integer.parseInt(sMsgnum);
		readNum = messageMapper.getContent(msgNum).getReadNum();
		if (readNum == 0) {
			messageMapper.updateReadNum1(msgNum);
			messageMapper.updateReadDate(msgNum);
			readNum = messageMapper.getContent(msgNum).getReadNum();
			mav.addObject("readNum", readNum);
			mav = pagingMessageList(req, lMode, email);
		} else {
			mav = pagingMessageList(req, lMode, email);

		}
		return mav;
	}

	@RequestMapping(value = "message_moveToLocker")
	public ModelAndView message_moveToLocker(HttpServletRequest req, String[] check) {
		ModelAndView mav = new ModelAndView();
		String msg = null, lMode = null;
		MemberDTO member = (MemberDTO) req.getSession().getAttribute("memberinfo");
		if (member == null) {
			mav.setViewName("mainPage");
			return mav;
		}
		String email = member.getEmail();
		if (check == null) {
			msg = "선택된 메시지가 없습니다. 다시 확인하세요.";
			mav.addObject("msg", msg);
			mav.setViewName("historyBack");
			return mav;
		}
		for (String num : check) {
			int msgnum = Integer.parseInt(num);
			int res = messageMapper.moveToLocker(msgnum);
			if (res > 0) {

				msg = "보관함으로 이동 되었습니다. ";
				lMode = "msgBoxList";
				mav = pagingMessageList(req, lMode, email);
				mav.addObject("msg", msg);
			} else {
				msg = "보관함 이동에 실패하였습니다.";
				mav.addObject("msg", msg);
				mav.setViewName("redirect:yeps_message");
			}
		}
		return mav;
	}

	@RequestMapping(value = "message_lockerToMsgBox")
	public ModelAndView message_moveToMsgBox(HttpServletRequest req, String[] check) {
		ModelAndView mav = new ModelAndView();
		String msg = null, lMode = null;
		MemberDTO member = (MemberDTO) req.getSession().getAttribute("memberinfo");
		if (member == null) {
			mav.setViewName("mainPage");
			return mav;
		}

		String email = member.getEmail();
		if (check == null) {
			msg = "선택된 메시지가 없습니다. 다시 확인하세요.";
			mav.setViewName("historyBack");
			return mav;
		}

		for (String num : check) {
			int msgnum = Integer.parseInt(num);
			int res = messageMapper.lockerToMsgBox(msgnum);
			if (res > 0) {
				msg = "쪽지함으로 이동 되었습니다. ";
				mav.addObject("msg", msg);
			} else {
				msg = "쪽지함 이동에 실패하였습니다.";
				mav.addObject("msg", msg);
			}
		}

		lMode = "allLocker";
		mav = pagingMessageList(req, lMode, email);
		return mav;
	}

}