package com.ssafy.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.dto.Bean;
import com.ssafy.dto.Detail;
import com.ssafy.dto.Notice;
import com.ssafy.dto.Qna;
import com.ssafy.service.QnaService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/api")
@Api("SSAFY")
@CrossOrigin(origins="*")
public class QnaRestController {

	@Autowired
	QnaService service;

	@GetMapping("/search")
	@ApiOperation(value="모든 포스트 조회",response=Map.class)
	public ResponseEntity<Map<String, Object>> select(Bean bean) {
		List<Qna> list = service.select(bean);
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
//		return resultMap;
		return ent;
	}

	@PostMapping("/insert")
	@ApiOperation(value="포스트 추가",response=Map.class)
	public ResponseEntity<Map<String, Object>> insert(@RequestBody Qna temp) {
		int result = service.insertPost(temp);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("status", "OK");
		resultMap.put("data", result);
		ResponseEntity<Map<String, Object>> ent = null;
		if (result > 0) {
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);// 200
		} else {
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.NO_CONTENT);// 204
		}
		return ent;
	}
	@PutMapping("/update")
	@ApiOperation(value="포스트 수정",response=Map.class)
	public ResponseEntity<Map<String, Object>> update(@RequestBody Qna temp) {
		int result = service.updatePost(temp);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("status", "OK");
		resultMap.put("data", result);
		ResponseEntity<Map<String, Object>> ent = null;
		if (result ==1) {
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);// 200
		} else {
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.NO_CONTENT);// 204
		}
		return ent;
	}
	@DeleteMapping("/delete/{num}")
	@ApiOperation(value="포스트 삭제",response=Map.class)
	public ResponseEntity<Map<String, Object>> delete(@PathVariable Integer num) {
		int result = service.deletePost(num);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("status", "OK");
		resultMap.put("data", result);
		ResponseEntity<Map<String, Object>> ent = null;
		if (result > 0) {
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);// 200
		} else {
			ent = new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.NO_CONTENT);// 204
		}
		return ent;
	}

}
