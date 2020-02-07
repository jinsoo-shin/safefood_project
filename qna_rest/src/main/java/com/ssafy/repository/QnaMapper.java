package com.ssafy.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.dto.Bean;
import com.ssafy.dto.Qna;

@Mapper // repository 대체 => mapper.xml과 바로 연결
public interface QnaMapper {
	// 전체 직원 조회

	public List<Qna> select(Bean bean);
	public int insertPost(Qna temp);
	public int updatePost(Qna temp);
	public int deletePost(Integer num);
}
