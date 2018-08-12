package com.yeps.controller;

import java.io.File;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.yeps.model.EventDTO;
import com.yeps.model.EventReviewDTO;
import com.yeps.model.FileDTO;
import com.yeps.model.MemberDTO;
import com.yeps.model.RestaurantDTO;
import com.yeps.service.EventMapper;
import com.yeps.service.EventReviewMapper;
import com.yeps.service.FileMapper;
import com.yeps.service.MemberMapper;
import com.yeps.service.RestaurantMapper;
import com.yeps.service.ReviewMapper;
import com.yeps.service.S3Connection;
import com.yeps.service.YepsPager;

@Controller
public class EventController {

	@Autowired
	private EventMapper eventMapper;
	@Autowired
	private FileMapper fileMapper;
	@Autowired
	private EventReviewMapper eventReviewMapper;
	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private RestaurantMapper restaurantMapper;
	@Autowired
	private ReviewMapper reviewMapper;

	@RequestMapping(value = "/event_list")
	public ModelAndView listEvent(HttpServletRequest req) {
		String mode = req.getParameter("mode");
		int curPage = req.getParameter("curPage") != null ? Integer.parseInt(req.getParameter("curPage")) : 1;

		int count = 0;
		YepsPager yepsPager = null;
		int start = 0;
		int end = 0;
		int pageScale = 15;
		int blockScale = 10;

		String search = req.getParameter("search");
		if(search == null || search.trim().equals("")) {
			search = "서울특별시";
		}

		if (mode == null || mode.trim().equals("") || mode.trim().equals("recently")) { 
			count = eventMapper.getEventCount("normal", search);
			yepsPager = new YepsPager(count, curPage, pageScale, blockScale);
			start = yepsPager.getPageBegin();
			end = yepsPager.getPageEnd();
		} else if (mode.equals("free")) {
			count = eventMapper.getEventCount("free", search);
			yepsPager = new YepsPager(count, curPage, pageScale, blockScale);
			start = yepsPager.getPageBegin();
			end = yepsPager.getPageEnd();
		} else if (mode.equals("date")) {
			count = eventMapper.getEventCount("normal", search);
			yepsPager = new YepsPager(count, curPage, pageScale, blockScale);
			start = yepsPager.getPageBegin();
			end = yepsPager.getPageEnd();
		} else {
			count = eventMapper.getEventCount(mode, search);
			yepsPager = new YepsPager(count, curPage, pageScale, blockScale);
			start = yepsPager.getPageBegin();
			end = yepsPager.getPageEnd();
		}

		List<EventDTO> eventList = eventMapper.listEvent(mode, start, end, search);
		List<FileDTO> fileList = new ArrayList<FileDTO>();
		for (int i = 0; i < eventList.size(); i++) {
			FileDTO dto = fileMapper.getFYIEventFile(eventList.get(i).getEvnum());
			if (dto == null) {
				FileDTO dtoForNull = new FileDTO();
				dtoForNull.setFilename("nothing");
				dtoForNull.setEvnum(eventList.get(i).getEvnum());
				fileList.add(dtoForNull);
			} else {
				fileList.add(dto);
			}
		}

		List<EventDTO> thisWeek_random_eventList = eventMapper.getRandom_EventList();
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
						if(j == 10) {
							break;
						}
					}
				}catch(Exception e) {
					System.out.println("불러오기 실패");
				}
			}
		}

		ModelAndView mav = new ModelAndView();
		mav.addObject("locationList", locationList);
		mav.addObject("search", search);  
		mav.addObject("mode", mode);
		mav.addObject("set", "events");
		mav.addObject("fileList", fileList);
		mav.addObject("eventList", eventList);
		mav.addObject("thisWeek_random_eventList", thisWeek_random_eventList);
		mav.addObject("curPage", curPage);
		mav.addObject("count", count);
		mav.addObject("yepsPager", yepsPager);
		mav.setViewName("event/event_list");
		return mav;
	}

	@RequestMapping(value = "/event_write")
	public ModelAndView writeEvent(HttpServletRequest req) {
		return new ModelAndView("event/event_writeForm", "set", "events");
	}

	@RequestMapping(value = "/event_jusoPopup")
	public String jusoPopup() {
		return "jusoPopup";
	}

	@RequestMapping(value = "/event_insert")
	public ModelAndView insertEvent(HttpServletRequest req, @ModelAttribute EventDTO dto, BindingResult result) {
		dto.setIp(req.getRemoteAddr());
		dto.setStart_date(dto.getStart_date() + ", " + getDateDay(dto.getStart_date()));
		if (dto.getEnd_date() != null) {
			dto.setEnd_date(dto.getEnd_date() + ", " + getDateDay(dto.getEnd_date()));
		}
		HttpSession session = req.getSession();
		MemberDTO loginMember = (MemberDTO) session.getAttribute("memberinfo");
		dto.setMnum(loginMember.getMnum());
		
		if (dto.getEventname() == null || dto.getEventname().trim().equals("") || dto.getEvent_content() == null
				|| dto.getEvent_content().trim().equals("") || dto.getDiscount() == null
				|| dto.getDiscount().trim().equals("")) {
			return new ModelAndView("redirect: event_list");
		}

		ModelAndView mav = new ModelAndView();
		boolean check = eventMapper.RedundancyCheck(dto.getEventname());
		if (check) {
			int res = eventMapper.insertEvent(dto);
			if (res > 0) {
				int evnum = eventMapper.getEvnum(dto.getEventname(), dto.getStore_address());
				mav.addObject("set", "events");
				mav.addObject("url", "event_update_photo?evnum=" + evnum);
				mav.setViewName("usingOnlyURL");
			} else {
				mav.addObject("msg", "이벤트 등록에 실패했습니다.");
				mav.addObject("url", "event_list");
				mav.addObject("set", "events");
				mav.setViewName("message");
			}
		} else {
			mav.addObject("msg", "이미 등록된 이벤트입니다.");
			mav.setViewName("historyBack");
		}
		return mav;
	}

	public String getDateDay(String date) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

		Date parsingDate = null;
		try {
			parsingDate = formatter.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		} // 날짜 입력하는곳 .
		parsingDate = new Date(parsingDate.getTime() + (1000 * 60 * 60 * 24 - 1)); // 날짜에 하루를 더한 값
		// 하루를 뺄려면 (1000*60*60*24*-1) 해주시면 됩니다.

		Calendar cal = Calendar.getInstance();
		cal.setTime(parsingDate); // 하루더한 날자 값을 Calendar 넣는다.

		int dayNum = cal.get(Calendar.DAY_OF_WEEK); // 요일을 구해온다.

		String convertedString = "";

		switch (dayNum) {
		case 1:
			convertedString = "일요일";
			break;
		case 2:
			convertedString = "월요일";
			break;
		case 3:
			convertedString = "화요일";
			break;
		case 4:
			convertedString = "수요일";
			break;
		case 5:
			convertedString = "목요일";
			break;
		case 6:
			convertedString = "금요일";
			break;
		case 7:
			convertedString = "토요일";
			break;
		}
		return convertedString;
	}

	@RequestMapping(value = "/event_delete")
	public ModelAndView deleteEvent(HttpServletRequest req) {
		String evnum = req.getParameter("evnum");
		if (evnum == null || evnum.trim().equals("")) {
			return new ModelAndView("redirect: event_list");
		}

		ModelAndView mav = new ModelAndView();
		List<FileDTO> fileList = fileMapper.getAllEventFiles(Integer.parseInt(evnum));
		int imageCount = 0;
		for (int i = 0; i < fileList.size(); i++) {
			S3Connection.getInstance().deleteObject("yepsbucket", "images/" + fileList.get(i).getFilename());
			imageCount++;
		}
		HttpSession session = req.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberinfo");
		if (memberDTO == null) {			
			return new ModelAndView("redirect: member_login");
		}
		memberDTO.setImagecount(memberDTO.getImagecount()-imageCount);
		session.setAttribute("memberinfo", memberDTO);
		memberMapper.updateImageCount(memberDTO.getMnum(), memberDTO.getMnum());
		int fileDelete_result = fileMapper.deleteAllFile(Integer.parseInt(evnum));
		int eventReviewDelete_result = eventReviewMapper.deleteAllEventReivew(Integer.parseInt(evnum));
		if (fileDelete_result >= 0 && eventReviewDelete_result >= 0) {
			int result = eventMapper.deleteEvent(Integer.parseInt(evnum));
			if (result > 0) {
				mav.addObject("url", "event_list");
				mav.setViewName("usingOnlyURL");
			}
		} else {
			mav.addObject("msg", "파일삭제에 문제가 발생하였습니다. 같은 문제가 지속된다면 관리자에게 문의하십시오.");
			mav.addObject("url", "event_list");
			mav.setViewName("message");
		}
		mav.addObject("set", "events");
		return mav;
	}

	@RequestMapping(value = "/event_edit", method = RequestMethod.GET)
	public ModelAndView EditEvent(HttpServletRequest req) {
		String evnum = req.getParameter("evnum");
		if (evnum == null || evnum.trim().equals("")) {
			return new ModelAndView("redirect: event_list");
		}

		ModelAndView mav = new ModelAndView();
		EventDTO getEventDTO = eventMapper.getEventContent(Integer.parseInt(evnum));
		String[] start_date = getEventDTO.getStart_date().split(",");

		getEventDTO.setStart_date(start_date[0]);
		if (getEventDTO.getEnd_date() != null) {
			String[] end_date = getEventDTO.getEnd_date().split(",");
			getEventDTO.setEnd_date(end_date[0]);
		}
		mav.addObject("getEventDTO", getEventDTO);
		mav.addObject("set", "events");
		mav.setViewName("event/event_editForm");
		return mav;
	}

	@RequestMapping(value = "/event_edit", method = RequestMethod.POST)
	public ModelAndView EditProEvent(HttpServletRequest req, @ModelAttribute EventDTO dto, BindingResult result) {
		dto.setStart_date(dto.getStart_date() + ", " + getDateDay(dto.getStart_date()));

		if(dto.getEnd_date() == null || dto.getEnd_date().trim().equals("")) {
			dto.setEnd_date(null);
		} else {
			dto.setEnd_date(dto.getEnd_date() + ", " + getDateDay(dto.getEnd_date()));
		}

		HttpSession session = req.getSession();
		MemberDTO loginMember = (MemberDTO) session.getAttribute("memberinfo");
		if (loginMember == null) {			
			return new ModelAndView("redirect: member_login");
		}
		dto.setMnum(loginMember.getMnum());

		if (dto.getEventname() == null || dto.getEventname().trim().equals("") || dto.getEvent_content() == null
				|| dto.getEvent_content().trim().equals("") || dto.getDiscount() == null
				|| dto.getDiscount().trim().equals("")) {
			return new ModelAndView("redirect: event_list");
		}

		ModelAndView mav = new ModelAndView();
		int res = eventMapper.updateEvent(dto);
		if (res > 0) {
			int evnum = eventMapper.getEvnum(dto.getEventname(), dto.getStore_address());
			mav.addObject("url", "event_update_photo?evnum=" + evnum);
			mav.setViewName("usingOnlyURL");
			return mav;
		} else {
			mav.addObject("set", "events");
			mav.addObject("msg", "이벤트 수정을 실패하였습니다.");
			mav.addObject("url", "event_list");
			mav.setViewName("message");
			return mav;
		}

	}

	@RequestMapping(value = "/event_update_photo")
	public ModelAndView insertPhoto_Event(HttpServletRequest req) {
		String evnum = req.getParameter("evnum");
		String mode = req.getParameter("mode");

		if (evnum == null || evnum.trim().equals("")) {
			return new ModelAndView("redirect: event_list");
		}

		HttpSession session = req.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberinfo");
		if (memberDTO == null) {			
			return new ModelAndView("redirect: member_login");
		}

		EventDTO eventDTO = eventMapper.getEventContentNoPhoto(Integer.parseInt(evnum));
		ModelAndView mav = new ModelAndView();

		if (eventDTO == null) {
			mav.setViewName("redirect: event_write");
			return mav;
		}

		if (memberDTO.getIsmanager().equals("y") || memberDTO.getIsmaster().equals("y")
				|| eventDTO.getMnum() == memberDTO.getMnum()) {
			List<FileDTO> allUploadFileList = fileMapper.getAllEventFiles(eventDTO.getEvnum());
			List<MemberDTO> registMemberList = new ArrayList<MemberDTO>();
			for (int i = 0; i < allUploadFileList.size(); i++) {
				registMemberList.add(memberMapper.getMemberProfile(allUploadFileList.get(i).getMnum()));
			}
			mav.addObject("registMemberList", registMemberList);
			mav.addObject("uploadFileList", allUploadFileList);
		} else {
			List<FileDTO> myUploadFileList = fileMapper.getfileListForMe(eventDTO.getEvnum(), memberDTO.getMnum());
			mav.addObject("uploadFileList", myUploadFileList);
		}

		mav.addObject("mode", mode);
		mav.addObject("eventDTO", eventDTO);
		mav.addObject("set", "events");
		mav.setViewName("event/event_update_photo");
		return mav;
	}

	@RequestMapping(value = "/event_fileUpLoad")
	@ResponseBody
	public HashMap<String, Object> fileUpLoad_event(HttpServletRequest req) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String evnum = req.getParameter("evnum");
		if (evnum == null || evnum.trim().equals("")) {
			map.put("url", "404Page");
			return null;
		}

		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
		HttpSession session = req.getSession();
		return uploadFileLoop(mr, session, Integer.parseInt(evnum), map);
	}

	public HashMap<String, Object> uploadFileLoop(MultipartHttpServletRequest mr, HttpSession session, int evnum, HashMap<String, Object> map) {
		Iterator<String> it = mr.getFileNames();
		String origin_fileName = null;
		int fileSize = 0;
		List<FileDTO> fileList = new ArrayList<FileDTO>();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberinfo");
		if (memberDTO == null) {			
			map.put("url", "member_login");
			return map;
		}

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

					FileDTO fileDTO = new FileDTO();
					fileDTO.setEvnum(evnum);
					fileDTO.setMnum(memberDTO.getMnum());
					fileDTO.setFilename(saveFileName);
					fileDTO.setOrigin_filename(origin_fileName);
					fileDTO.setFilesize(fileSize);
					boolean isExistMainPhoto = fileMapper.isExistMainPhoto(evnum, "event");
					int result = 0;
					if (!isExistMainPhoto) {
						result = fileMapper.insertFile(fileDTO, "main");
					} else {
						result = fileMapper.insertFile(fileDTO, "not");
					}

					if (result > 0) {
						FileDTO insert_after_getFileDTO = fileMapper.getFile(saveFileName, 0);
						fileList.add(insert_after_getFileDTO);
					} else {
						fileMapper.deleteFileToFilename(saveFileName);
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
		memberDTO.setImagecount(memberDTO.getImagecount()+imageCount);
		memberMapper.updateImageCount(memberDTO.getMnum(), memberDTO.getMnum());
		session.setAttribute("memberinfo", memberDTO);

		map.put("update", "사진을 등록하였습니다.");
		map.put("evnum", evnum);
		map.put("fileList", fileList);
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

	@RequestMapping(value = "/event_delete_photo")
	public ModelAndView DeletePhoto_Event(HttpServletRequest req) {
		String filename = req.getParameter("filename");
		String evnum = req.getParameter("evnum");
		String isMainPhoto = req.getParameter("ismainphoto");

		HttpSession session = req.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberinfo");
		if (memberDTO == null) {
			return new ModelAndView("redirect: member_login");
		}
		if (filename == null || filename.trim().equals("") || evnum == null || evnum.trim().equals("")
				|| isMainPhoto == null || isMainPhoto.trim().equals("")) {
			return new ModelAndView("redirect: event_update_photo");
		}

		ModelAndView mav = new ModelAndView();
		EventDTO eventDTO = eventMapper.getEventContent(Integer.parseInt(evnum));
		if (eventDTO == null) {
			mav.setViewName("redirect: event_write");
			return mav;
		}

		S3Connection.getInstance().deleteObject("yepsbucket", "images/" + filename);
		fileMapper.deleteFile(filename, Integer.parseInt(evnum), isMainPhoto, "event");
		memberDTO.setImagecount(memberDTO.getImagecount()-1);
		session.setAttribute("memberinfo", memberDTO);
		memberMapper.updateImageCount(memberDTO.getMnum(), memberDTO.getMnum());
		mav.setViewName("redirect: event_update_photo?evnum=" + Integer.parseInt(evnum) + "&mode=delete");
		return mav;
	}

	@RequestMapping(value = "/event_content")
	public ModelAndView contentEvent(HttpServletRequest req) {
		String evnum = req.getParameter("evnum");
		if (evnum == null || evnum.trim().equals("")) {
			return new ModelAndView("redirect: event_list");
		}

		ModelAndView mav = new ModelAndView();
		EventDTO eventDTO = eventMapper.getEventContent(Integer.parseInt(evnum));
		List<FileDTO> fileList = fileMapper.getAllEventFiles(Integer.parseInt(evnum));
		RestaurantDTO restaurantDTO = restaurantMapper.findRestaurant(eventDTO.getZipNo(), eventDTO.getRoadAddrPart1(),
				eventDTO.getRoadAddrPart2(), eventDTO.getAddrDetail());

		if (restaurantDTO != null) {
			int reviewCount = reviewMapper.getRestaurantReviewCount(restaurantDTO.getRnum());
			int starAVG = reviewMapper.getStarAvg(restaurantDTO.getRnum());
			mav.addObject("starAVG", starAVG);
			mav.addObject("reviewCount", reviewCount);
		}

		List<EventDTO> thisWeek_EventList = eventMapper.getThisWeek_EventList();
		List<EventReviewDTO> eventReview_list = eventReviewMapper.listEventReview(Integer.parseInt(evnum));

		mav.addObject("restaurantDTO", restaurantDTO);
		mav.addObject("eventReview_list", eventReview_list);
		mav.addObject("fileList", fileList);
		mav.addObject("eventDTO", eventDTO);
		mav.addObject("thisWeek_EventList", thisWeek_EventList);
		mav.addObject("set", "events");
		mav.setViewName("event/event_contentForm");
		return mav;
	}

	@RequestMapping(value = "/event_main_photo")
	public ModelAndView eventMainPhoto(HttpServletRequest req, HttpSession session) {
		String evnum = req.getParameter("evnum");
		String filenum = req.getParameter("filenum");
		String mnum = req.getParameter("mnum");

		if (evnum == null || evnum.trim().equals("") || filenum == null || filenum.trim().equals("") || mnum == null
				|| mnum.trim().equals("")) {
			return new ModelAndView("redirect: event_update_photo?evnum=" + evnum);
		}

		ModelAndView mav = new ModelAndView();
		MemberDTO loginMember = (MemberDTO) session.getAttribute("memberinfo");
		if (loginMember == null) {
			return new ModelAndView("redirect: member_login");
		}

		EventDTO eventDTO = eventMapper.getEventContent(Integer.parseInt(evnum));
		if (loginMember.getMnum() == Integer.parseInt(mnum) || loginMember.getIsmanager().equals("y")
				|| loginMember.getIsmaster().equals("y")) {
			fileMapper.changeMainPhoto(Integer.parseInt(evnum), Integer.parseInt(filenum), "event");
			mav.addObject("mode", "update");
		}

		mav.addObject("set", "events");
		mav.addObject("eventDTO", eventDTO);
		mav.setViewName("redirect: event_update_photo?evnum=" + Integer.parseInt(evnum) + "&mode=update");
		return mav;
	}

	@RequestMapping(value = "/event_browseAll_photo")
	public ModelAndView eventBrowseAll(HttpServletRequest req) {
		String evnum = req.getParameter("evnum");
		int curPage = req.getParameter("curPage") != null ? Integer.parseInt(req.getParameter("curPage")) : 1;
		int count = 0;
		YepsPager yepsPager = null;
		int start = 0;
		int end = 0;

		if (evnum == null || evnum.trim().equals("")) {
			return new ModelAndView("redirect: event_list");
		}

		yepsPager = new YepsPager(count, curPage, 30, 5);
		start = yepsPager.getPageBegin();
		end = yepsPager.getPageEnd();

		List<FileDTO> fileList = fileMapper.getPagedEventFiles(Integer.parseInt(evnum), start, end);
		MemberDTO loginMemberDTO = (MemberDTO) req.getSession().getAttribute("memberinfo");
		boolean find = false;
		if (loginMemberDTO != null) {
			for (int i = 0; i < fileList.size(); i++) {
				if (fileList.get(i).getMnum() == loginMemberDTO.getMnum()) {
					find = true;
				}
			}
		}
		EventDTO eventDTO = eventMapper.getEventContent(Integer.parseInt(evnum));
		ModelAndView mav = new ModelAndView();

		mav.addObject("set", "events");
		mav.addObject("curPage", curPage);
		mav.addObject("count", count);
		mav.addObject("yepsPager", yepsPager);
		mav.addObject("find", find);
		mav.addObject("fileCount", fileList.size());
		mav.addObject("fileList", fileList);
		mav.addObject("eventDTO", eventDTO);
		mav.setViewName("event/event_browseAll");
		return mav;
	}

	@RequestMapping(value = "/event_report")
	public ModelAndView eventReport() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("historyBack");
		return mav;
	}


	@RequestMapping(value = "/event_photo_manage")
	public ModelAndView event_photo_manage(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		MemberDTO loginMember = (MemberDTO) session.getAttribute("memberinfo");
		if(loginMember == null || !loginMember.getIsmanager().equals("y") || !loginMember.getIsmaster().equals("y")) {
			mav.addObject("msg", "권한이 없습니다.");
			mav.addObject("url", "main");
			mav.setViewName("message");
			return mav;
		}
		
		
		int curPage = req.getParameter("curPage") != null ? Integer.parseInt(req.getParameter("curPage")) : 1;
		int count = eventMapper.eventCount();
		YepsPager yepsPager = null;
		int start = 0;
		int end = 0;

		yepsPager = new YepsPager(count, curPage, 5, 5);
		start = yepsPager.getPageBegin();
		end = yepsPager.getPageEnd();
		List<EventDTO> event = eventMapper.manage_eventList(start, end);
		mav.addObject("eventList", event);
		mav.addObject("set", "events");
		mav.addObject("curPage", curPage);
		mav.addObject("count", count);
		mav.addObject("yepsPager", yepsPager);
		mav.setViewName("manager/event_photoManage");
		return mav;
	}
	
//	@RequestMapping(value = "/event_photo_manage_ajax")
//	@ResponseBody
//	public HashMap<String, Object> managePhoto_Event(HttpServletRequest req) {
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		String evnum = req.getParameter("evnum");
//		String mode = req.getParameter("mode");
//        String url = null;
//		if (evnum == null || evnum.trim().equals("")) {
//			url = "redirect: manager_managerPage";
//			map.put("url", url);
//		}
//
//		HttpSession session = req.getSession();
//		MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberinfo");
//		if (memberDTO == null) {			
//			url = "redirect: member_login";
//			map.put("url",url);
//		}
//
//		EventDTO eventDTO = eventMapper.getEventContent(Integer.parseInt(evnum));
//		ModelAndView mav = new ModelAndView();
//
//		if (eventDTO == null) {
//	         url = "redirect: event_photo_manage";
//			 map.put("url",url);
//		}
//
//		if (memberDTO.getIsmanager().equals("y") || memberDTO.getIsmaster().equals("y")
//				|| eventDTO.getMnum() == memberDTO.getMnum()) {
//			List<FileDTO> allUploadFileList = fileMapper.getAllEventFiles(eventDTO.getEvnum());
//			List<MemberDTO> registMemberList = new ArrayList<MemberDTO>();
//			for (int i = 0; i < allUploadFileList.size(); i++) {
//				registMemberList.add(memberMapper.getMemberProfile(allUploadFileList.get(i).getMnum()));
//			}
//			map.put("registMemberList", registMemberList);
//			map.put("uploadFileList", allUploadFileList);
//		} else {
//			List<FileDTO> myUploadFileList = fileMapper.getfileListForMe(eventDTO.getEvnum(), memberDTO.getMnum());
//			map.put("uploadFileList", myUploadFileList);
//		}
//		
//		int curPage = req.getParameter("curPage") != null ? Integer.parseInt(req.getParameter("curPage")) : 1;
//		int count =  0;//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//		YepsPager yepsPager = null;
//		int start = 0;
//		int end = 0;
//
//		yepsPager = new YepsPager(count, curPage, 5, 5);
//		start = yepsPager.getPageBegin();
//		end = yepsPager.getPageEnd();
//
//		map.put("mode", mode);
//		map.put("eventDTO", eventDTO);
//		map.put("curPage", curPage);
//		map.put("count", count);
//		map.put("photoPager", yepsPager);
//		map.put("set", "events");
//		return map;
//	}
	
}
