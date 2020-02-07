package com.ssafy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.dto.Bean;
import com.ssafy.dto.Qna;
import com.ssafy.repository.QnaMapper;

@Service
@Transactional
public class QnaServiceImpl implements QnaService {

	@Autowired
	QnaMapper mapper;

	@Override
	public List<Qna> select(Bean bean) {
		return mapper.select(bean);
	}

	@Override
	public int insertPost(Qna temp) {
		return mapper.insertPost(temp);
	}

	@Override
	public int updatePost(Qna temp) {
		return mapper.updatePost(temp);
	}

	@Override
	public int deletePost(Integer num) {
		return mapper.deletePost(num);
	}

}
