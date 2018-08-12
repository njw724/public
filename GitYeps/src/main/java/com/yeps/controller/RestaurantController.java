package com.yeps.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
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

import com.yeps.model.FileDTO;
import com.yeps.model.MemberDTO;
import com.yeps.model.RestaurantDTO;
import com.yeps.model.ReviewDTO;
import com.yeps.service.FileMapper;
import com.yeps.service.MemberMapper;
import com.yeps.service.RestaurantMapper;
import com.yeps.service.ReviewMapper;
import com.yeps.service.S3Connection;
import com.yeps.service.YepsPager;

@Controller
public class RestaurantController {
	@Autowired
	private RestaurantMapper restaurantMapper;
	@Autowired
	private FileMapper fileMapper;
	@Autowired
	private ReviewMapper reviewMapper;
	@Autowired
	private MemberMapper memberMapper;

	@RequestMapping(value = "/jusoPopup")
	public String jusoRest() throws Exception {
		return "jusoPopup";
	}

	@RequestMapping(value = "/restaurant_insert", method = RequestMethod.GET)
	public String insertRest() throws Exception {
		return "restaurant/restaurant_insert";
	}

	@RequestMapping(value = "/restaurant_insert", method = RequestMethod.POST)
	public ModelAndView insertRest(HttpServletRequest req, @ModelAttribute RestaurantDTO dto, BindingResult result)
			throws Exception {
		String msg = null, url = null;

		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
		MultipartFile mf = mr.getFile("rest_filename");
		String origin_fileName = mf.getOriginalFilename();
		String genId = UUID.randomUUID().toString();
		String contentType = getExtension(origin_fileName);
		String saveFileName = genId + "." + contentType;
		int fileSize = (int) mf.getSize();
		File file = new File(saveFileName);
		HttpSession session = req.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberinfo");
		if (memberDTO == null) {
			return new ModelAndView("redirect: member_login");
		}
		
		ModelAndView mav = new ModelAndView();
		
		int res = restaurantMapper.insertRest(dto);
		RestaurantDTO restaurantDTO = restaurantMapper.getNewRestaurant();
		if (res > 0) {
			msg = "레스토랑 등록 성공";
			url = "restaurant_list";
			mav.addObject("msg", msg);
			mav.addObject("url", url);
		} else {
			msg = "레스토랑 등록 실패";
			url = "restaurant_insert";
			mav.addObject("msg", msg);
			mav.addObject("url", url);
			return mav;
		}

		int imageCount = 0;
		System.out.println("파일 등록전");
		if (mf.getSize() != 0) {
			try {
				System.out.println("파일 등록중");
				mf.transferTo(file);
				S3Connection.getInstance().putObjectAsync("yepsbucket", "images/" + saveFileName, file,
						"image/" + contentType);
				imageCount++;
				FileDTO fileDTO = new FileDTO();
				fileDTO.setRnum(restaurantDTO.getRnum());
				fileDTO.setMnum(memberDTO.getMnum());
				fileDTO.setFilename(saveFileName);
				fileDTO.setOrigin_filename(origin_fileName);
				fileDTO.setFilesize(fileSize);
				boolean isExistMainPhoto = fileMapper.isExistMainPhoto(restaurantDTO.getRnum(), "restaurant");
				if (!isExistMainPhoto) {
					res = fileMapper.insertFile(fileDTO, "main");
				} else {
					res = fileMapper.insertFile(fileDTO, "not");
				}

				if (res < 0) {
					fileMapper.deleteFileToFilename(saveFileName);
					S3Connection.getInstance().deleteObject("yepsbucket", "images/" + saveFileName);
					mav.addObject("msg", "파일 등록에 실패했습니다. 잠시후 다시 시도해주세요.");
					mav.addObject("url", "restaurant_list");
					imageCount--;
					file.delete();
					mav.setViewName("message");
					return mav;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				origin_fileName = null;
				fileSize = 0;
				file = null;
				mav.addObject("msg", "파일 생성 실패, 잠시 후 다시 시도하세요.");
				mav.addObject("url", "restaurant_list");
				mav.setViewName("message");
				return mav;
			}
			
		} else {
			mav.addObject("msg", "업로드할 수 없는 파일이 존재합니다.");
			mav.addObject("url", "restaurant_list");
			mav.setViewName("message");
			return mav;
		}
		System.out.println("파일 등록완료");
		memberDTO.setImagecount(memberDTO.getImagecount() + imageCount);
		memberMapper.updateImageCount(memberDTO.getMnum(), memberDTO.getMnum());
		session.setAttribute("memberinfo", memberDTO);
		mav.setViewName("message");
		return mav;
	}

	public String getExtension(String fileName) {
		int dotPosition = fileName.lastIndexOf('.');

		if (-1 != dotPosition && fileName.length() - 1 > dotPosition) {
			return fileName.substring(dotPosition + 1);
		} else {
			return "";
		}
	}

	@RequestMapping(value = "/restaurant_list")
	public ModelAndView listRest(@RequestParam(defaultValue = "1") int curPage) {
		List<Integer>price=new ArrayList<Integer>();
		price.add(0);
		String location = "서울특별시";
		String mode="mode";
		int count = restaurantMapper.getCountBySeoul(location);
		int pageScale = 10;
		int blockScale = 10;
		// 페이지 나누기 관련 처리
		YepsPager YepsPager = new YepsPager(count, curPage, pageScale, blockScale);
		int start = YepsPager.getPageBegin();
		int end = YepsPager.getPageEnd();

		
		List<RestaurantDTO> list = restaurantMapper.listRest(start, end, mode, price, location);
		
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
		map.put("location", "서울특별시");
		map.put("list", list); // list
		map.put("count", count); // 레코드의 갯수
		map.put("YepsPager", YepsPager);
		map.put("LastReview", LastReview);
		map.put("reviewCount", reviewCount);
		map.put("StarAvg", StarAvg);

		ModelAndView mav = new ModelAndView();
		mav.addObject("map", map);
		mav.setViewName("restaurant/restaurant_list");
		return mav;
	}

	@RequestMapping(value = "/restaurant_ajax")
	@ResponseBody
	public HashMap<String, Object> listRestRefresh(@RequestParam(value = "mode") String mode,@RequestParam(value = "price[]") List<Integer> price,@RequestParam(defaultValue = "1") int curPage) {
		

		String location = "서울특별시";
//		int count = restaurantMapper.getCount();
		int count = restaurantMapper.getCountBySeoul(location);
		int pageScale = 10;
		int blockScale = 10;
		// 페이지 나누기 관련 처리
		YepsPager YepsPager = new YepsPager(count, curPage, pageScale, blockScale);
		int start = YepsPager.getPageBegin();
		int end = YepsPager.getPageEnd();
	
		
		List<RestaurantDTO> list = restaurantMapper.listRest(start, end, mode,price, location);

		List<Integer> reviewCount = new ArrayList<Integer>();
		List<Integer> StarAvg = new ArrayList<Integer>();

		List<ReviewDTO> LastReview = new ArrayList<ReviewDTO>();
		for (int i = 0; i < list.size(); i++) {
			LastReview.add(reviewMapper.getLastReview(list.get(i).getRnum()));
			reviewCount.add(reviewMapper.getRestaurantReviewCount(list.get(i).getRnum()));
			StarAvg.add(reviewMapper.getStarAvg(list.get(i).getRnum()));
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("location", "서울특별시");
		map.put("list", list); // list
		map.put("count", count); // 레코드의 갯수
		map.put("YepsPager", YepsPager);
		map.put("LastReview", LastReview);
		map.put("reviewCount", reviewCount);
		map.put("StarAvg", StarAvg);
		map.put("mode", mode);
		
		System.out.println(mode+" 레스토랑 갯수="+list.size());
		return map;
	}

	@RequestMapping(value = "/restaurant_content")
	public ModelAndView contentRest(HttpServletRequest req, @RequestParam(defaultValue = "1") int curPage) {
		String rnum = req.getParameter("rnum");
		System.out.println("레스토랑 컨텐트(rnum)" + rnum);
		if (rnum == null || rnum.trim().equals("")) {
			return new ModelAndView("redirect: restaurant_list");
		}

		int count = reviewMapper.getRestaurantReviewCount(Integer.parseInt(rnum));
		int pageScale = 10;
		int blockScale = 10;
		YepsPager YepsPager = new YepsPager(count, curPage, pageScale, blockScale);
		int start = YepsPager.getPageBegin();
		int end = YepsPager.getPageEnd();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("count", count); // 레코드의 갯수
		map.put("YepsPager", YepsPager);

		HttpSession session = req.getSession();
		MemberDTO loginMember = (MemberDTO) session.getAttribute("memberinfo");
		ModelAndView mav = new ModelAndView();

		RestaurantDTO getRest = restaurantMapper.getRest(Integer.parseInt(rnum));// 가게 1개 정보
		List<FileDTO> uploadFileList = fileMapper.getAllRestaurantFiles(Integer.parseInt(rnum));// 가게 업로드 파일

		ReviewDTO existMyReview = null;
		if (loginMember != null) {
			existMyReview = reviewMapper.findMyReview(Integer.parseInt(rnum), loginMember.getMnum());
		}

		if (existMyReview != null) {
			mav.addObject("myReview", existMyReview);
		}
		
		List<ReviewDTO> reviewList = reviewMapper.getSelectedRestaurant_Rv(Integer.parseInt(rnum), start, end);// 가게 리뷰
		List<ReviewDTO> highlightReview = reviewMapper.getRandomRestaurant_Rv(Integer.parseInt(rnum));
		int starAvg = reviewMapper.getStarAvg(Integer.parseInt(rnum));
       
		mav.addObject("map", map);
		mav.addObject("getRest", getRest);
		mav.addObject("uploadFileList", uploadFileList);
		mav.addObject("getImageCount", uploadFileList.size());
		mav.addObject("reviewCount", count);
		mav.addObject("highlightReview", highlightReview);
		mav.addObject("starAvg", starAvg);
		mav.addObject("selectedDataRV", reviewList);
		mav.setViewName("restaurant/restaurant_content");
		return mav;
	}

	@RequestMapping(value = "/restaurant_content_ajax")
	@ResponseBody
	public HashMap<String, Object> listContentRefresh(HttpServletRequest req) {
		String rnum = req.getParameter("rnum");
		System.out.println("rnum(레스토랑 컨텐트 아작스):" + rnum);
		String SearchKeyword = req.getParameter("SearchKeyword");
		int curPage = req.getParameter("curPage") != null ? Integer.parseInt(req.getParameter("curPage")) : 1;
		HashMap<String, Object> map = new HashMap<String, Object>();

		if (rnum == null || rnum.trim().equals("")) {
			map.put("error", "다시 시도해주세요.");
			return map;
		}

		int pageScale = 10;
		int blockScale = 10;
		int count = 0;
		int start = 0;
		int end = 0;
		List<ReviewDTO> targetRestaurant_reviews = null;

		YepsPager YepsPager = null;
		if (SearchKeyword == null || SearchKeyword.trim().equals("")) {
			count = reviewMapper.getRestaurantReviewCount(Integer.parseInt(rnum));
			YepsPager = new YepsPager(count, curPage, pageScale, blockScale);
			start = YepsPager.getPageBegin();
			end = YepsPager.getPageEnd();
			targetRestaurant_reviews = reviewMapper.getSelectedRestaurant_Rv(Integer.parseInt(rnum), start, end);
		} else {
			count = reviewMapper.review_keywordCount(SearchKeyword);
			YepsPager = new YepsPager(count, curPage, pageScale, blockScale);
			start = YepsPager.getPageBegin();
			end = YepsPager.getPageEnd();
			targetRestaurant_reviews = reviewMapper.review_keyword(SearchKeyword, Integer.parseInt(rnum), start, end);
			map.put("SearchKeyword", SearchKeyword);
		}

		map.put("count", count); // 레코드의 갯수
		map.put("YepsPager", YepsPager);
		map.put("rnum", rnum);
		map.put("selectedDataRV", targetRestaurant_reviews); // 한 페이지에서 변수명에 따라 다른값보여주기위해서
		return map;
	}
	
	@RequestMapping(value = "/restaurant_content_sort_ajax")
	@ResponseBody
	public HashMap<String, Object> listContentSortRefresh(HttpServletRequest req) {
		String rnum = req.getParameter("rnum");
		int curPage = req.getParameter("curPage") != null ? Integer.parseInt(req.getParameter("curPage")) : 1;
		HashMap<String, Object> map = new HashMap<String, Object>();

		if (rnum == null || rnum.trim().equals("")) {
			map.put("error", "다시 시도해주세요.");
			return map;
		}

		int pageScale = 10;
		int blockScale = 10;
		int count = 0;
		int start = 0;
		int end = 0;
		List<ReviewDTO> targetRestaurant_reviews = null;

		YepsPager YepsPager = null;
//			count = reviewMapper.review_keywordCount(SearchKeyword);
			YepsPager = new YepsPager(count, curPage, pageScale, blockScale);
			start = YepsPager.getPageBegin();
			end = YepsPager.getPageEnd();
//			targetRestaurant_reviews = reviewMapper.review_keyword(SearchKeyword, Integer.parseInt(rnum), start, end);
//			map.put("SearchKeyword", SearchKeyword);

		map.put("count", count); // 레코드의 갯수
		map.put("YepsPager", YepsPager);
		map.put("rnum", rnum);
		map.put("selectedDataRV", targetRestaurant_reviews); // 한 페이지에서 변수명에 따라 다른값보여주기위해서
		return map;
	}

	@RequestMapping(value = "/restaurant_update_photo")
	public ModelAndView updateRestaurantPhoto(HttpServletRequest req) {
		String rnum = req.getParameter("rnum");
		String mode = req.getParameter("mode");
		String filecount = req.getParameter("filecount");

		if (rnum == null || rnum.trim().equals("")) {
			return new ModelAndView("redirect: restaurant_list");
		}

		RestaurantDTO restaurantDTO = restaurantMapper.getRest(Integer.parseInt(rnum));
		ModelAndView mav = new ModelAndView();

		mav.addObject("filecount", filecount);
		mav.addObject("mode", mode);
		mav.addObject("restaurantDTO", restaurantDTO);
		mav.setViewName("restaurant/restaurant_update_photo");
		return mav;
	}

	@RequestMapping(value = "/restaurant_fileUpLoad")
	@ResponseBody
	public HashMap<String, Object> fileUpLoad_event(HttpServletRequest req) {
		String rnum = req.getParameter("rnum");
		if (rnum == null || rnum.trim().equals("")) {
			// 404페이지 띄워야함.. jsp페이지에서 처리해주자
			return null;
		}

		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
		HttpSession session = req.getSession();
		return uploadFileLoop(mr, session, Integer.parseInt(rnum));
	}

	public HashMap<String, Object> uploadFileLoop(MultipartHttpServletRequest mr, HttpSession session, int rnum) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		Iterator<String> it = mr.getFileNames();
		String origin_fileName = null;
		int fileSize = 0;
		List<FileDTO> fileList = new ArrayList<FileDTO>();
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

					FileDTO fileDTO = new FileDTO();
					fileDTO.setRnum(rnum);
					fileDTO.setMnum(memberDTO.getMnum());
					fileDTO.setFilename(saveFileName);
					fileDTO.setOrigin_filename(origin_fileName);
					fileDTO.setFilesize(fileSize);
					boolean isExistMainPhoto = fileMapper.isExistMainPhoto(rnum, "restaurant");
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
		memberDTO.setImagecount(memberDTO.getImagecount() + imageCount);
		memberMapper.updateImageCount(memberDTO.getMnum(), memberDTO.getMnum());
		session.setAttribute("memberinfo", memberDTO);
		map.put("fileList", fileList);
		String url = "restaurant_upload_check?rnum=" + rnum;
		for (int i = 0; i < fileList.size(); i++) {
			url += "&filename=" + fileList.get(i).getFilename();
		}
		map.put("url", url);
		return map;
	}

	@RequestMapping(value = "/restaurant_upload_check")
	public ModelAndView uploadCheckRestaurant(HttpServletRequest req) {
		String filename[] = req.getParameterValues("filename");
		String rnum = req.getParameter("rnum");
		if (rnum == null || rnum.trim().equals("")) {
			return new ModelAndView("redirect: restaurant_list");
		}
		RestaurantDTO dto = restaurantMapper.getRest(Integer.parseInt(rnum));
		ModelAndView mav = new ModelAndView();
		mav.addObject("filenames", filename);
		mav.addObject("filesize", filename.length);
		mav.addObject("restaurantDTO", dto);
		mav.setViewName("restaurant/restaurant_upload_check");
		return mav;
	}

	@RequestMapping(value = "/restaurant_delete")
	public ModelAndView delete_restaurant(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		int rnum = Integer.parseInt(req.getParameter("rnum"));
		int res = restaurantMapper.deleteRestaurant(rnum);
		String msg = null, url = null;
		if(res>0) {
			msg = "삭제되었습니다.";
			url = "redirect: restReview_list";
			mav.addObject("msg", msg);
			mav.addObject("url", url); 
			mav.setViewName("message");
		}else {
			msg = "삭제에 실패하였습니다.";
			url = "redirect: restReview_list";
			mav.addObject("msg", msg);
			mav.addObject("url", url); 
			mav.setViewName("message");
		}
		return mav;
	}
	
	@RequestMapping(value = "/restaurant_delete_ajax")
	@ResponseBody
	public HashMap<String, Object> deleteRestaurantPhotoToAjax(HttpServletRequest req) {
		String rnum = req.getParameter("rnum");
		String filename = req.getParameter("filename");
		HashMap<String, Object> map = new HashMap<String, Object>();
		HttpSession session = req.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberinfo");
		if (rnum == null || rnum.trim().equals("") || filename == null || filename.trim().equals("")) {
			map.put("url", "restaurant_list");
			return map;
		}

		if (memberDTO == null) {
			map.put("url", "member_login");
			return map;
		}

		FileDTO fileDTO = fileMapper.getFile(filename, 0);
		if (fileDTO == null) {
			map.put("url", "restaurant_upload_check?rnum=" + Integer.parseInt(rnum));
		}

		S3Connection.getInstance().deleteObject("yepsbucket", "images/" + filename);
		fileMapper.deleteFile(filename, Integer.parseInt(rnum), fileDTO.getIsmainphoto(), "restaurant");
		memberDTO.setImagecount(memberDTO.getImagecount() - 1);
		session.setAttribute("memberinfo", memberDTO);
		memberMapper.updateImageCount(memberDTO.getMnum(), memberDTO.getMnum());
		map.put("success", "success");
		return map;
	}

	@RequestMapping(value = "/restaurant_photoList")
	public ModelAndView photoListRest(HttpServletRequest req, @RequestParam(defaultValue = "1") int curPage) {
		int rnum = Integer.parseInt(req.getParameter("rnum"));
		String mode = req.getParameter("mode");
		String view = req.getParameter("view");
		if (rnum == 0) {
			return new ModelAndView("redirect: restaurant_list");
		}

		RestaurantDTO restaurantDTO = restaurantMapper.getRest(rnum);
		HttpSession session = req.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("memberinfo");

		int allPhotoCount = fileMapper.getAllFileCount(rnum);
		int myPhotoCount = 0;
		if (memberDTO != null) {
			myPhotoCount = fileMapper.getRest_fileCountForMe(rnum, memberDTO.getMnum());
		}

		int pageScale = 30;
		int blockScale = 10;
		YepsPager YepsPager = null;
		int start = 0;
		int end = 0;
		List<FileDTO> getFileList = null;
		if (view.equals("all")) {
			YepsPager = new YepsPager(allPhotoCount, curPage, pageScale, blockScale);
			start = YepsPager.getPageBegin();
			end = YepsPager.getPageEnd();
			getFileList = fileMapper.getPagedFileList(rnum, start, end);
		} else if (view.equals("mylist")) {
			YepsPager = new YepsPager(myPhotoCount, curPage, pageScale, blockScale);
			start = YepsPager.getPageBegin();
			end = YepsPager.getPageEnd();
			getFileList = fileMapper.getPagedFileListForMe(rnum, memberDTO.getMnum(), start, end);
		}

		int reviewCount = reviewMapper.getRestaurantReviewCount(rnum);
		int starAvg = reviewMapper.getStarAvg(rnum);

		ModelAndView mav = new ModelAndView();
		mav.addObject("view", view);
		mav.addObject("mode", mode);
		mav.addObject("getRest", restaurantDTO);
		mav.addObject("starAvg", starAvg);
		mav.addObject("curPage", curPage);
		mav.addObject("yepsPager", YepsPager);
		mav.addObject("uploadFileList", getFileList);
		mav.addObject("reviewCount", reviewCount);
		mav.addObject("allPhotoCount", allPhotoCount);
		mav.addObject("myPhotoCount", myPhotoCount);
		mav.setViewName("restaurant/restaurant_photoList");
		return mav;

	}

	@RequestMapping(value = "/restaurant_photo_update")
	public ModelAndView updateRestaurantMainPhoto(HttpServletRequest req) {
		String filenum = req.getParameter("filenum");
		String rnum = req.getParameter("rnum");
		String mnum = req.getParameter("mnum");
		String view = req.getParameter("view");

		if (filenum == null || filenum.trim().equals("") || rnum == null || rnum.trim().equals("")) {
			return new ModelAndView("redirect: restaurant_list");
		}

		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		MemberDTO loginMember = (MemberDTO) session.getAttribute("memberinfo");
		if (loginMember == null) {
			return new ModelAndView("redirect: member_login");
		}

		if (loginMember.getMnum() == Integer.parseInt(mnum) || loginMember.getIsmanager().equals("y")
				|| loginMember.getIsmaster().equals("y")) {
			fileMapper.changeMainPhoto(Integer.parseInt(rnum), Integer.parseInt(filenum), "restaurant");
		}

		mav.setViewName("redirect: restaurant_photoList?rnum=" + rnum + "&view=" + view + "&mode=update");
		return mav;
	}

	@RequestMapping(value = "/restaurant_photo_delete")
	public ModelAndView deleteRestaurantPhoto(HttpServletRequest req) {
		String filenum = req.getParameter("filenum");
		String rnum = req.getParameter("rnum");
		String filename = req.getParameter("filename");
		String ismainphoto = req.getParameter("ismainphoto");
		String view = req.getParameter("view");

		if (filenum == null || filenum.trim().equals("") || rnum == null || rnum.trim().equals("")) {
			return new ModelAndView("redirect: restaurant_list");
		}

		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		MemberDTO loginMember = (MemberDTO) session.getAttribute("memberinfo");
		if (loginMember == null) {
			return new ModelAndView("redirect: member_login");
		}

		System.out.println(ismainphoto);
		S3Connection.getInstance().deleteObject("yepsbucket", "images/" + filename);
		fileMapper.deleteFile(filename, Integer.parseInt(rnum), ismainphoto, "restaurant");
		loginMember.setImagecount(loginMember.getImagecount() - 1);
		session.setAttribute("memberinfo", loginMember);
		memberMapper.updateImageCount(loginMember.getMnum(), loginMember.getMnum());
		mav.setViewName("redirect: restaurant_photoList?rnum=" + rnum + "&view=" + view + "&mode=delete");
		return mav;
	}

}
