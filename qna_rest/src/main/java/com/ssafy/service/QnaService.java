package com.ssafy.service;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Service;

import com.ssafy.dto.Bean;
import com.ssafy.dto.Qna;

@Service
public interface QnaService {

	public List<Qna> select(Bean bean);

	public int insertPost(Qna temp);

	public int updatePost(Qna temp);

	public int deletePost(Integer num);
}
