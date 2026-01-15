package com.example.test1.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Lodge;

@Mapper
public interface LodgeMapper {

	int Payment(HashMap<String, Object> map);

	Lodge AccInfo(HashMap<String, Object> map);
}
