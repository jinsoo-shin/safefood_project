package com.ssafy.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.dto.Detail;
import com.ssafy.dto.MarketPrice;
import com.ssafy.dto.Notice;
import com.ssafy.dto.Post;
import com.ssafy.dto.PriceInfo;
import com.ssafy.dto.Recipe;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/api")
@Api("SSAFY")
@CrossOrigin(origins = "*")
public class ParseRestController {
	@GetMapping("/notice/{page}")
	@ApiOperation(value = "test", response = Map.class)
	public ResponseEntity<Map<String, Object>> notice(@PathVariable Integer page) throws IOException {
		if (page == null) {
			page = 1;
		}
		List<Notice> list = new ArrayList<>();
		Document doc = Jsoup.connect("http://www.realfoods.co.kr/section.php?sec=green&pg=" + page).get();
		Elements img = doc.select(".s_result_i a img");
		Elements title = doc.select(".s_result_tt a");
		Elements body = doc.select(".s_result_ss a");
		for (int i = 0; i < title.size(); i++) {
			list.add(new Notice(img.get(i).attr("src"), title.get(i).text(), body.get(i).text()));
		}
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("status", "OK");
		resultMap.put("data", list);
		ResponseEntity<Map<String, Object>> ent = null;
		if (list.size() > 0) { // 200
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
		} else {// 204
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.NO_CONTENT);
		}
		return ent;

	}

	@GetMapping("/noticedetail/{page}/{index}")
	@ApiOperation(value = "test", response = Map.class)
	public ResponseEntity<Map<String, Object>> noticedetail(@PathVariable Integer page, @PathVariable Integer index)
			throws IOException {
		List<Detail> list = new ArrayList<>();
		Document doc = Jsoup.connect("http://www.realfoods.co.kr/section.php?sec=green&pg=" + page).get();
		Elements addr = doc.select(".s_result_i a");
		for (int i = 0; i < addr.size(); i++) {
			String address = "http://www.realfoods.co.kr" + addr.get(i).attr("href");
			Document doc2 = Jsoup.connect(address).get();
			Elements title = doc2.select(".viewpage_center ul li");
			String result = title.first().text();
			list.add(new Detail(result, getText(address)));

		}
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("status", "OK");
		resultMap.put("data", list.get(index));
		ResponseEntity<Map<String, Object>> ent = null;
		if (list.size() > 0) { // 200
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
		} else {// 204
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.NO_CONTENT);
		}
		return ent;

	}

	static String getText(String url) throws IOException {
		Document doc = Jsoup.connect(url).get();
		Elements body = doc.select("#view_content");
		int end = body.html().indexOf("<div class=\"view_snsbox\">");
		String result = body.html().substring(0, end);
		return result;
	}

	@GetMapping("/parse/todayrecipe")
	@ApiOperation(value = "오늘의 레시피 조회", response = Map.class)
	public ResponseEntity<Map<String, Object>> selectTodayRecipe() throws IOException {
		List<Recipe> list = new ArrayList<>();
		Document doc = Jsoup.connect("http://home.ebs.co.kr/cook/board/4/500514/list?c.page=1").get();
		Elements el = doc.select("#itemList .txtcut a");
		String title = el.get(2).text();
		int start = title.indexOf("〈");
		title = title.substring(start);
		String url = "http://home.ebs.co.kr" + el.get(2).attr("href");
		String html = doc.select(".view_con .con_txt").html();
//		System.out.println(html);

		list.add(new Recipe(title, url, html));
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("status", "OK");
		resultMap.put("data", list);
		ResponseEntity<Map<String, Object>> ent = null;
		// 상태값을 전달
		if (list.size() > 0) { // 200
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
		} else {// 204
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.NO_CONTENT);
		}
		return ent;
	}

	public int getMaxPage(String key) throws IOException {
		String selecturl = "http://home.ebs.co.kr/cook/board/4/500514/list?bbsId=500514&boardType=2&iframeOn=false&searchCondition=pstTitleSrch&searchKeyword="
				+ key + "&searchKeywordCondition=1&c.page=1";
		Document doc = Jsoup.connect(selecturl).get();

		Elements el = doc.select("#itemList tr");
		Element ee = el.get(3).selectFirst("td");
//		System.out.println(ee.text());
		int allindex = Integer.parseInt(ee.text()) / 20 + 1;
		return allindex;
	}

	@GetMapping("/parse/recipe")
	@ApiOperation(value = "검색어, 페이지수로 검색하기", response = Map.class)
	public ResponseEntity<Map<String, Object>> selectRecipe(String key, String page) throws IOException {
		List<Recipe> list = new ArrayList<>();
		if (key == null) {
			key = "";
		}
		if (page == null) {
			page = "";
		}
		String selecturl = "http://home.ebs.co.kr/cook/board/4/500514/list?bbsId=500514&boardType=2&iframeOn=false&searchCondition=pstTitleSrch&searchKeyword="
				+ key + "&searchKeywordCondition=1&c.page=" + page;
		Document doc = Jsoup.connect(selecturl).get();
		Elements el = doc.select("#itemList tr");
		Elements textpart = el.select(".txtcut a");
		for (int i = 2; i < el.size(); i++) {
			int index = Integer.parseInt(el.get(i).selectFirst("td").text());
			String title = textpart.get(i).text();
			String url = "http://home.ebs.co.kr" + textpart.get(i).attr("href");
//			System.out.println(index + " " + title+" "+url);
			list.add(new Recipe(index, title, url, ""));
		}
		int maxPage = getMaxPage(key);
		System.out.println(maxPage);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("status", "OK");
		resultMap.put("data", list);
		resultMap.put("maxpage", maxPage);
		ResponseEntity<Map<String, Object>> ent = null;
		// 상태값을 전달
		if (list.size() > 0) { // 200
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
		} else {// 204
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.NO_CONTENT);
		}
		return ent;
	}

	@GetMapping("/parse/recipehtml")
	@ApiOperation(value = "클릭한 글의 html 긁어오기", response = Map.class)
	public ResponseEntity<Map<String, Object>> getHtmlRecipe(String url) throws IOException {
		Document doc = Jsoup.connect(url).get();
		String html = doc.select(".view_con .con_txt").html();
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("status", "OK");
		resultMap.put("data", html);
		ResponseEntity<Map<String, Object>> ent = null;
		// 상태값을 전달
		if (html != null) { // 200
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
		} else {// 204
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.NO_CONTENT);
		}
		return ent;
	}

/////////////
	@GetMapping("/parse/getprice")
	@ApiOperation(value = "이번주의 가격", response = Map.class)
	public ResponseEntity<Map<String, Object>> getPrice() throws IOException {
		String selecturl = "https://www.foodnuri.go.kr/portal/main/main.do";
		Document doc = Jsoup.connect(selecturl).get();
		Elements el = doc.select(".main_con2_2");
		Elements ee = el.select(".main_con2_2_con dl");
		String title1 = ee.get(1).select(".item").text();
		String[] item1 = ee.get(1).select("dd").text().split(" ");
		String title2 = ee.get(5).select(".item").text();
		String[] item2 = ee.get(5).select("dd").text().split(" ");
//System.out.println(title2 + " " + item2);

		String title = el.select("h2>span").text();
		List<MarketPrice> traditional = new ArrayList<>();
		List<MarketPrice> bigmart = new ArrayList<>();

		for (int i = 0; i < item1.length; i = i + 2) {
			traditional.add(new MarketPrice(item1[i], item1[i + 1]));
		}
		for (int i = 0; i < item2.length; i = i + 2) {
			bigmart.add(new MarketPrice(item2[i], item2[i + 1]));
		}

		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("status", "OK");
		resultMap.put("title", title);
		resultMap.put("traditional", traditional);
		resultMap.put("bigmart", bigmart);
		ResponseEntity<Map<String, Object>> ent = null;
// 상태값을 전달
		if (title != null) { // 200
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
		} else {// 204
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.NO_CONTENT);
		}
		return ent;
	}

	@GetMapping("/parse/price")
	@ApiOperation(value = "알뜰장보기 게시판", response = Map.class)
	public ResponseEntity<Map<String, Object>> getPrice(String key, String page) throws IOException {
		List<Post> list = new ArrayList<>();
		if (key == null) {
			key = "";
		}
		if (page == null) {
			page = "";
		}
		String selecturl = "https://www.foodnuri.go.kr/portal/bbs/B0000285/list.do?menuNo=300067&searchCnd=1&searchWrd="
				+ key + "&pageIndex=" + page;
		Document doc = Jsoup.connect(selecturl).get();
		Elements el = doc.select(".col_blue");
		int maxpage = Integer.parseInt(doc.select(".col_blue").text()) / 10 + 1;
//System.out.println("페이지수 " + maxpage);
		Elements ee = doc.select(".bdLine ul li");
		for (int i = 0; i < ee.size(); i++) {
//	System.out.println(ee.get(i));
			String index = ee.get(i).select(".no").text();
			String title = ee.get(i).select(".title").text();
			String url = ee.get(i).select("a").attr("href");
//	System.out.println("index" + ee.get(i).select(".no").text());
//	System.out.println("title" + ee.get(i).select(".title").text());
//	System.out.println("url   https://www.foodnuri.go.kr" + ee.get(i).select("a").attr("href"));
//	System.out.println("----------------------");
			list.add(new Post(index, title, url));
		}
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("status", "OK");
		resultMap.put("data", list);
		resultMap.put("maxpage", maxpage);
		ResponseEntity<Map<String, Object>> ent = null;
// 상태값을 전달
		if (list.size() > 0) { // 200
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
		} else {// 204
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.NO_CONTENT);
		}
		return ent;
	}

	@GetMapping("/parse/pricehtml")
	@ApiOperation(value = "클릭한 글의 html 긁어오기", response = Map.class)
	public ResponseEntity<Map<String, Object>> getHtmlPrice(String url) throws IOException {
		String selecturl = "https://www.foodnuri.go.kr" + url + "&menuNo=300067&searchCnd=1&searchWrd=&pageIndex=1";
		System.out.println(selecturl);
		List<PriceInfo> traditional = new ArrayList<>();
		List<PriceInfo> bigmart = new ArrayList<>();
		Document doc = Jsoup.connect(selecturl).get();
		Elements el = doc.select("script");
//		System.out.println("크기크기" + el.size());
		int index = 0;
		for (int ii = 0; ii < el.size(); ii++) {
			Pattern p = Pattern.compile("(?is)data.tdtmktPrice = \'(.+?)\'");
			Matcher m1 = p.matcher(el.get(ii).html());
			if (m1.find()) {
				index = ii;
				break;
			}
		}
//		System.out.println("찾음" + index);
		Element ee = el.get(index);
		Pattern p1 = Pattern.compile("(?is)data.foodNm = \"(.+?)\"");
		Pattern p2 = Pattern.compile("(?is)data.tdtmktPrice = \'(.+?)\'");
		Pattern p3 = Pattern.compile("(?is)data.mrktPrice = \'(.+?)\'");
		Matcher m = p1.matcher(ee.html());
		String[] tmp1 = new String[8];
		String[] tmp2 = new String[8];
		String[] tmp3 = new String[8];
		int idx = 0;
		while (m.find()) {
			tmp1[idx++] = m.group(1);
//	System.out.println(m.group(1));
		}
		idx = 0;
		m = p2.matcher(ee.html());
		while (m.find()) {
			tmp2[idx++] = m.group(1);
		}
		idx = 0;
		m = p3.matcher(ee.html());
		while (m.find()) {
			tmp3[idx++] = m.group(1);
		}
		for (int i = 0; i < 4; i++) {
			traditional.add(new PriceInfo(tmp1[i], tmp2[i], tmp3[i]));
		}
		for (int i = 4; i < 8; i++) {
			bigmart.add(new PriceInfo(tmp1[i], tmp2[i], tmp3[i]));
		}
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("status", "OK");
//resultMap.put("title", title);
		resultMap.put("traditional", traditional);
		resultMap.put("bigmart", bigmart);
		ResponseEntity<Map<String, Object>> ent = null;
// 상태값을 전달
		if (traditional.size() > 0) { // 200
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
		} else {// 204
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.NO_CONTENT);
		}
		return ent;
	}

}