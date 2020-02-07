package com.ssafy.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ssafy.model.dto.Food;
import com.ssafy.model.dto.FoodPageBean;
import com.ssafy.model.dto.User;
import com.ssafy.model.dto.nation;
import com.ssafy.model.repository.UserDaoImple;
import com.ssafy.model.service.FoodService;
import com.ssafy.model.service.UserService;

@Controller
public class MainController {

	@Autowired
	FoodService foodService;

//	@RequestMapping("/errorpage")
//	public String error(Model model) {
//		return "errorpage";
//	}
	@RequestMapping("/")
	public String mainIndex(Model model) {
		return "index";
	}

	@RequestMapping("/qna")
	public String qnaIndex(Model model) {
		return "qna";
	}

	@RequestMapping("/notice")
	public String noticeIndex(Model model) {
		return "notice";
	}

	@RequestMapping("/recipe")
	public String recipeIndex(Model model) {
		return "recipepage";
	}

	@RequestMapping("/price")
	public String priceIndex(Model model) {
		return "pricepage";
	}

	@RequestMapping("/userEatMoreInfo")
	public String userEatMoreInfoIndex(Model model) {
		return "userEatMoreInfo";
	}

	@GetMapping("/index") // 검색 용
	public String index(Model model, HttpSession session, HttpServletRequest request) {
		List<Food> list = foodService.selectAll();
		for (int i = 0; i < list.size(); i++) {
			List<String> allergy = foodService.selectAllergy(list.get(i));
			list.get(i).setAllergy(allergy);
		}
		model.addAttribute("foodList", list);

		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser != null) {
			List<String> foodname = foodService.seleteHit(loginUser);

			model.addAttribute("rank", foodname);
		

		}

		return "index";
	}

	@GetMapping("/foodinfo") // 상품정보페이지
	public String foodinfo(Model model) {
		List<Food> list = foodService.selectAll();
		for (int i = 0; i < list.size(); i++) {
			List<String> allergy = foodService.selectAllergy(list.get(i));
			list.get(i).setAllergy(allergy);
		}
		
		model.addAttribute("foodList", list);
		
		return "food_info";
	}

	@GetMapping("/indexsearch") // 검색 용
	public String indexsearch(Model model, String key, String word) {
		System.out.println("키" + key + " word" + word);
		List<Food> list = foodService.selectFoodBean(new FoodPageBean(key, word));
		for (int i = 0; i < list.size(); i++) {
			List<String> allergy = foodService.selectAllergy(list.get(i));
			list.get(i).setAllergy(allergy);
		}
		model.addAttribute("foodList", list);
		return "index";
	}

	@GetMapping("/infosearch") // 검색 용
	public String infosearch(Model model, String key, String word) {

		List<Food> list = foodService.selectFoodBean(new FoodPageBean(key, word));
		for (int i = 0; i < list.size(); i++) {
			List<String> allergy = foodService.selectAllergy(list.get(i));
			list.get(i).setAllergy(allergy);
		}
		model.addAttribute("foodList", list);
		return "food_info";
	}

	@GetMapping("/detail") // 상세페이지
	public String detail(Model model, String code, User user, HttpSession session) {
		Food food = foodService.select(code);
		food.setAllergy(foodService.selectAllergy(food));
		model.addAttribute("food", food);

		String findnation = food.getMaterial();
		nation nat = new nation();
		int ncnt[] = new int[153];
		for (int i = 0; i < nat.nations.length; i++) {
			if (findnation.indexOf(nat.nations[i]) > 0) {
				ncnt[i]++;
			}
		}
		int cnt = 0;
		for (int i = 0; i < ncnt.length; i++) {
			if (ncnt[i] != 0) {
				cnt++;
			}
		}
		int idx = 0;
		String[] con = new String[cnt];
		int[] num = new int[cnt];
		for (int i = 0; i < ncnt.length; i++) {
			if (ncnt[i] != 0) {
				con[idx] = nat.nations[i];
				num[idx] = ncnt[i];
				idx++;
			}
		}
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser != null) {
			List<String> list = foodService.selectUserHit(loginUser,food.getName());
			if (list.size() == 0) {
				foodService.insertHit(loginUser, food.getName());

			} else {
				foodService.updateHit(loginUser, food.getName());
			}

		}

		model.addAttribute("cont", con);
		model.addAttribute("numb", num);

		return "food_detail";
	}

	@GetMapping("/eat") // 섭취정보추가
	public String eat(Model model, String code, HttpSession session, HttpServletRequest request,
			RedirectAttributes redir) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			redir.addFlashAttribute("alarm", "로그인 해주세용");
			String referer = request.getHeader("Referer");
			return "redirect:" + referer;
		} else {
			List<String> result = foodService.selectIsUserEat(loginUser, code);
			if (result.size() == 0) {
				foodService.insertUserEat(code, loginUser);
				redir.addFlashAttribute("alarm", "추가 성공성공");
				String referer = request.getHeader("Referer");
				return "redirect:" + referer;
			} else {
				redir.addFlashAttribute("alarm", "이미 들어가있어용");
				String referer = request.getHeader("Referer");
				return "redirect:" + referer;
			}
		}
	}

	@GetMapping("/userEat") // 페이ㄴ
	public String userEat(Model model, HttpSession session, RedirectAttributes redir, HttpServletRequest request) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			redir.addFlashAttribute("alarm", "로그인 후 이용가능 페이지!!!!!");
			String referer = request.getHeader("Referer");
			return "redirect:" + referer;
		} else {
			List<String> foodCode = foodService.selectUserEat(loginUser);
//			System.out.println("코드코드" + foodCode);
			List<Food> food = new ArrayList<>();
			int cal = 0, car = 0, prot = 0, fat = 0, sug = 0, nat = 0, chol = 0, fatty = 0, transf = 0;
			for (int i = 0; i < foodCode.size(); i++) {
				Food tmp = foodService.select(foodCode.get(i));
				cal += tmp.getCalory();
				car += tmp.getCarbo();
				prot += tmp.getProtein();
				fat += tmp.getFat();
				sug += tmp.getSugar();
				nat += tmp.getNatrium();
				chol += tmp.getChole();
				fatty += tmp.getFattyacid();
				transf += tmp.getTransfat();
				List<String> allergy = foodService.selectAllergy(tmp);
				tmp.setAllergy(allergy);
				food.add(tmp);
			}
			Food eatFood = new Food(cal, car, prot, fat, sug, nat, chol, fatty, transf);
//			System.out.println("먹은거" + food);
			model.addAttribute("eatfoods", food);
			model.addAttribute("eatnum", eatFood);

			return "userEatInfo";
		}

	}

	@GetMapping("/deleteEat") // 섭취정보삭제
	public String deleteEat(Model model, String code, HttpSession session, RedirectAttributes redir,
			HttpServletRequest request) {
		User loginUser = (User) session.getAttribute("loginUser");
		foodService.deleteUserEat(code, loginUser);
		redir.addFlashAttribute("alarm", "삭제되었습니당");
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}

///////////////////////////////////////////////////////////////
	@Autowired
	UserService service;
	@Autowired
	UserDaoImple dao;

	@GetMapping("/register") // 회원가입누르면 가는 페이지
	public String registerGet(Model model) {
		return "register";
	}

	@PostMapping("/register")
	// 회원가입
	public String login(Model model, User user, RedirectAttributes redir) {
		int result = dao.insert(user);
		if(user.getAllergy()!=null) {
			int result2 = dao.insertAllergy(user);
		}
		if (result != -1) {
			redir.addFlashAttribute("alarm", "회원가입을 축하합니다.");
			return "redirect:/index";
		} else {
			return "redirect:/register";
		}
	}

	// 회원인지아닌지
	@GetMapping("/login")
	public String doLogin(Model model, String username, String password, HttpSession session,
			RedirectAttributes redir) {
		User result = service.ulogin(username, password);
		if (result != null) {
			result.setAllergy(dao.selectAllergy(username));

			session.setAttribute("loginUser", result);
			redir.addFlashAttribute("alarm", result.getName() + "님 로그인 되었습니다.");
//			foodService.insertHit(user, foodname, hit)
			return "redirect:/index";
		} else {
			redir.addFlashAttribute("alarm", "회원정보가 없습니다.");
			return "redirect:/index";
		}

	}

	// 회원정보누르면 그 페이지
	@GetMapping("/mypage")
	public String doUserUpdate(Model model) {
		return "mypage";
	}

	// 회원정보업데이트
	@PostMapping("/mypage")
	public String userUpdate(Model model, User user, HttpSession session, RedirectAttributes redir) {
		dao.deleteAllergy(user.getId());

		int result = dao.update(user);
		int result2 = dao.updateAllergy(user);
		if (result != -1 && result2 != -1) {
			User tmp = dao.select(user.getId());
			tmp.setAllergy(dao.selectAllergy(user.getId()));
			session.setAttribute("loginUser", tmp);
			redir.addFlashAttribute("alarm", "수정되었습니다.");
			return "redirect:/index";
		} else {
			return "redirect:/mypage";
		}
	}

	// 탈퇴하기
	@GetMapping("/bye")
	public String doBye(Model model, HttpSession session, RedirectAttributes redir) {
		User user = (User) session.getAttribute("loginUser");
		foodService.deleteUserEatAll(user);
		dao.deleteAllergy(user.getId());

		int result = dao.delete(user.getId());
		if (result != -1) {
			session.invalidate();
			redir.addFlashAttribute("alarm", "흑흑ㅠㅠ 다음에 또 봐요.");
			return "redirect:/index";
		} else {
			return "redirect:/mypage";

		}
	}

	@GetMapping("logout")
	public String logout(Model model, HttpSession session, RedirectAttributes redir) {
		redir.addFlashAttribute("alarm", "로그아웃되었습니다.");
		session.invalidate();
		return "redirect:/index";
	}

	// 비밀번호찾기페이지가기
	@GetMapping("/findpass")
	public String findGo(Model model, String id, String phone, HttpSession session) {
		return "findpass";

	}

	// 비밀번호찾기
	@GetMapping("/getpass")
	public String doFine(Model model, String id, String phone, HttpSession session) {
		User user = dao.select(id);
		String pass = user.getPassword();
		session.setAttribute("pass", pass);
		return "findpass";

	}

	// 섭취섭취//////////////////////////////////
	@GetMapping("/moreeat") // 섭취정보추가
	public String moreEat(Model model, String code, int count, HttpSession session, HttpServletRequest request,
			RedirectAttributes redir) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			redir.addFlashAttribute("alarm", "로그인 해주세용");
			String referer = request.getHeader("Referer");
			return "redirect:" + referer;
		} else {
			// 먹은적 있는지 체크하기
			List<Food> result = foodService.selectUserMoreEat(loginUser, code);
			System.out.println("섭취하나" + result);
			if (result.size() == 0) {
				foodService.insertUserMoreEat(code, loginUser, count);
				redir.addFlashAttribute("alarm", "insert 성공성공");
				String referer = request.getHeader("Referer");
				return "redirect:" + referer;
			} else {
				int updatecount = result.get(0).getCount();
				System.out.println("합결과" + "count " + count + " " + updatecount + count);
				if ((updatecount + count) == 0) {
					foodService.deleteUserMoreEat(code, loginUser);
				} else {
					foodService.updateUserMoreEat(code, loginUser, updatecount + count);
				}
				redir.addFlashAttribute("alarm", "update 성공성공");
				String referer = request.getHeader("Referer");
				return "redirect:" + referer;
			}
		}
	}

	@GetMapping("/userMoreEat") // 페이지입니당
	public String userMoreEat(Model model, HttpSession session, RedirectAttributes redir, HttpServletRequest request) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			redir.addFlashAttribute("alarm", "로그인 후 이용가능 페이지!!!!!");
			String referer = request.getHeader("Referer");
			return "redirect:" + referer;
		} else {
			List<Food> foodCode = foodService.selectUserMoreEatByUser(loginUser);
			List<Food> food = new ArrayList<>();
			int cal = 0, car = 0, prot = 0, fat = 0, sug = 0, nat = 0, chol = 0, fatty = 0, transf = 0;
			for (int i = 0; i < foodCode.size(); i++) {
				Food tmp = foodService.select(foodCode.get(i).getCode() + "");
				cal += tmp.getCalory();
				car += tmp.getCarbo();
				prot += tmp.getProtein();
				fat += tmp.getFat();
				sug += tmp.getSugar();
				nat += tmp.getNatrium();
				chol += tmp.getChole();
				fatty += tmp.getFattyacid();
				transf += tmp.getTransfat();
				List<String> allergy = foodService.selectAllergy(tmp);
				tmp.setAllergy(allergy);
				tmp.setCount(foodCode.get(i).getCount());
				food.add(tmp);
			}
			Food eatFood = new Food(cal, car, prot, fat, sug, nat, chol, fatty, transf);
//			System.out.println("먹은거" + food);
			model.addAttribute("eatmorefoods", food);
			model.addAttribute("eatmorenum", eatFood);

			return "userEatMoreInfo";
		}

	}

	@GetMapping("/deleteMoreEat") // 섭취정보삭제
	public String deleteMoreEat(Model model, String code, HttpSession session, RedirectAttributes redir,
			HttpServletRequest request) {
		User loginUser = (User) session.getAttribute("loginUser");
		foodService.deleteUserMoreEat(code, loginUser);
		redir.addFlashAttribute("alarm", "삭제되었습니당");
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}

}
