package com.example.test1.dao;

import com.example.test1.mapper.AdminMapper;
import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Comment;
import com.example.test1.model.Lodge;
import com.example.test1.model.MainBoard;
import com.example.test1.model.Member;
import com.example.test1.model.Report;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.kafka.KafkaProperties.Admin;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdminService {
	@Autowired
	AdminMapper adminMapper;
	
//    private final AdminMapper adminMapper;
	
	public HashMap<String, Object> getReportedBC(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		System.out.println(map);
//		String hashPwd = passwordEncoder.encode((String) map.get("pwd"));
//		map.put("hashPwd", hashPwd);
//		
//		int cnt = memberMapper.memberAdd(map);
//
//		if(cnt<1) {
//			resultMap.put("result", "fail");
//		} else {
//			resultMap.put("result", "success");
//		}
		List<MainBoard> admin = adminMapper .getReportedBoardComment(map);
		String message = ""; 
		String result = "";
		
		try {
			resultMap.put("info", admin);
			message = "확인.";
			result = "success";
			
			resultMap.put("msg", message);
			resultMap.put("result", result);
			
			System.out.println(admin);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		
		return resultMap;
	}

    public AdminService(AdminMapper adminMapper) {
        this.adminMapper = adminMapper;
    }

    //문의글 목록 조회
    public List<MainBoard> getInquiryBoards() {
        return adminMapper.selectInquiryBoards();
    }

    //댓글 등록
    public void insertComment(MainBoard mainboard) {
        adminMapper.insertComment(mainboard);
    }

    //특정 게시글의 목록 조회
    public List<MainBoard> getCommentsByBoardNo(String boardNo) {
        return adminMapper.selectCommentsByBoardNo(boardNo);
    }
    public HashMap<String, Object> deleteComment(HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> result = new HashMap<>();
        adminMapper.deleteComment(map);
        result.put("result", "success");
        return result;
    }
    
    public void blockUser(HashMap<String, Object> map) throws Exception {
    	adminMapper.updateUserStatus(map);
    }


    public List<HashMap<String, Object>> getBadUsers() throws Exception {
        return adminMapper.selectBadUsers();
    }
    
    //유저 정지
    public HashMap<String, Object> changeUserStatus(HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int cnt = adminMapper.changeUserStatus(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.print(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
    }

    public List<HashMap<String, Object>> selectReportList(HashMap<String, Object> param) throws Exception {
        return adminMapper.selectReportList(param);
    }
    
//    public List<HashMap<String, Object>> getReportList(HashMap<String, Object> map) {
//		return adminMapper.selectReportList(map);
//	}
    
    // ✅ 내 게시글 조회
    public List<HashMap<String, Object>> getMyPosts(Map<String, Object> param) {
        return adminMapper.selectMyPosts(param);
    }

    // ✅ 내 댓글 조회
    public List<HashMap<String, Object>> getMyComments(String userId) {
        return adminMapper.selectMyComments(userId);
    }

    // 댓글 리스트 조회
    public List<MainBoard> getCommentsByBoardNo1(String boardNo) {
        return adminMapper.selectCommentsByBoardNo(boardNo);
    }
    
    // 수정 삭제
    public void deletePost(String boardNo) {
        adminMapper.deletePost(boardNo);
    }

    //  댓글 삭제
    public void deleteCommentById(String commentNo) {
        adminMapper.deleteCommentById(commentNo);
    }
 
    public void updateComment(String commentNo, String contents) {
        Map<String, Object> map = new HashMap<>();
        map.put("commentNo", commentNo);
        map.put("contents", contents);
        adminMapper.updateComment(map);
    }

    public void updatePost(MainBoard post) {
        adminMapper.updatePost(post);
    }
    // 신고된 게시글 번호
    public HashMap<String, Object> getBoardDetail(String boardNo) {
        return adminMapper.selectBoardDetail(boardNo);
    }

    public List<MainBoard> selectByBoardNo(String boardNo) {
        return adminMapper.selectCommentsByBoardNo(boardNo);
    }
    public String getUserStatus(String userId) {
        return adminMapper.selectUserStatus(userId);
    }
    public void updateUserStatus(HashMap<String, Object> param) throws Exception {
        adminMapper.updateUserStatusDirect(param);
    }
    public HashMap<String, Object> getAllUsers(HashMap<String , Object>map)  {
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Admin> List = adminMapper.selectAllUsers(map);
			int cnt = adminMapper.selectAllUsersCnt(map);
			resultMap.put("user", List);
			resultMap.put("cnt", cnt);
			resultMap.put("result", "success");
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.print(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
    }


}