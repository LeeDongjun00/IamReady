package com.example.test1.mapper;

import java.util.HashMap;
import org.apache.ibatis.annotations.Mapper;
import com.example.test1.model.Member;

@Mapper
public interface MemberMapper {
	// 아이디 중복 확인
	Member memberIdCheck(HashMap<String, Object> map);
	
	// 회원 가입
	int memberAdd(HashMap<String, Object> map);
	
	// 로그인
	Member memberLogin(HashMap<String, Object> map);
	
	// id 찾기
	Member memberIdFind(HashMap<String, Object> map);
	
	// 비밀번호 재설정 전에 회원 확인
	Member memberPwdCheck(HashMap<String, Object> map);
	
	// 비밀번호 변경
	int memberPwdChange(HashMap<String, Object> map);
	
	// 로그인 실패 카운트 (기존 로그인용 CNT)
	int loginCntUp(HashMap<String, Object> map);
	
	// 로그인 시도 횟수 초기화 (기존 로그인용 CNT)
	int loginCntReset(HashMap<String, Object> map);
	
	// 카카오 최초 로그인 시, 자동 가입
	int kakaoMemberAdd(HashMap<String, Object> map);
	
	// 프로필 사진 업로드
	int insertProfileImg(HashMap<String, Object> map);
	
	// 프로필 사진 업데이트
	int updateProfileImg(HashMap<String, Object> map);
	
	// 프로필 사진 경로 가져오기
	Member profileImgPath(HashMap<String, Object> map);

	// ==========================================
	// ✅ [추가] 구독 및 추천 생성 제한 관련 메서드
	// ==========================================

	// 1. 유저 정보 단건 조회 (구독여부 STATUS, 생성횟수 GEN_CNT 확인용)
	Member selectUserById(String userId);

	// 2. 추천 생성 횟수(GEN_CNT) 1 증가
	void updateGenCount(String userId);

	// 3. (스케줄러용) 모든 유저의 GEN_CNT를 0으로 초기화
	void resetAllGenCounts();
}