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
	
	public HashMap<String, Object> reportProcessY(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		System.out.println(map);
//		String message = "";
		try {
			int cnt = adminMapper.updateProcessY(map);
			System.out.println(cnt);
			
			if(cnt > 0) {
				resultMap.put("msg", "처리되었습니다.");
				resultMap.put("result", "success");
			} else {
				resultMap.put("msg", "실패했습니다.");
				resultMap.put("result", "fail");
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			resultMap.put("msg", "오류가 발생했습니다.");
			System.out.println(e.getMessage()); // e에 어떤 오류인지 담겨져 있음 -> 개발자가 오류를 확인하기 위해 사용하는 코드
		}
		
		return resultMap;
	}
	
	public HashMap<String, Object> userBan(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		System.out.println(map);
//		String message = "";
		try {
			int cnt = adminMapper.userBan(map);
			System.out.println(cnt);
			
			if(cnt > 0) {
				resultMap.put("msg", "처리되었습니다.");
				resultMap.put("result", "success");
			} else {
				resultMap.put("msg", "실패했습니다.");
				resultMap.put("result", "fail");
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			resultMap.put("msg", "오류가 발생했습니다.");
			System.out.println(e.getMessage()); // e에 어떤 오류인지 담겨져 있음 -> 개발자가 오류를 확인하기 위해 사용하는 코드
		}
		
		return resultMap;
	}
	
	public HashMap<String, Object> reportCnt(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		System.out.println(map);
//		String message = "";
		try {
			int cnt = adminMapper.selectAllReportCnt(map);
			System.out.println(cnt);
			
			if (map.get("processedFilter") == null) {
			    map.put("processedFilter", "all");
			}
			
			resultMap.put("result", "success");
			resultMap.put("CNT", cnt);
			resultMap.put("msg", "성공");
			
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			resultMap.put("msg", "오류가 발생했습니다.");
			System.out.println(e.getMessage()); // e에 어떤 오류인지 담겨져 있음 -> 개발자가 오류를 확인하기 위해 사용하는 코드
		}
		
		return resultMap;
	}
	
	public HashMap<String, Object> getCNT(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		System.out.println(map);
//		String message = "";
		try {
			int userCnt = adminMapper.selectUserCnt(map);
			int reportCnt = adminMapper.selectReportNPCnt(map);
			int inquiryCnt = adminMapper.selectInquiryNPCnt(map);
			
			resultMap.put("userCnt", userCnt);
			resultMap.put("reportCnt", reportCnt);
			resultMap.put("inquiryCnt", inquiryCnt);
			
			resultMap.put("result", "success");
			resultMap.put("msg", "성공");
			
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			resultMap.put("msg", "오류가 발생했습니다.");
			System.out.println(e.getMessage()); // e에 어떤 오류인지 담겨져 있음 -> 개발자가 오류를 확인하기 위해 사용하는 코드
		}
		
		return resultMap;
	}
	
	public HashMap<String, Object> getBestTheme(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		System.out.println(map);
//		String message = "";
		try {
			List<Admin> theme = adminMapper.getTopThemes(map);

			System.out.println(theme);
			
			resultMap.put("topTheme", theme);
			
			resultMap.put("result", "success");
			resultMap.put("msg", "성공");
			
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			resultMap.put("msg", "오류가 발생했습니다.");
			System.out.println(e.getMessage()); // e에 어떤 오류인지 담겨져 있음 -> 개발자가 오류를 확인하기 위해 사용하는 코드
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

    //신고목록 가져오기
    public List<HashMap<String, Object>> selectReportList(HashMap<String, Object> param) throws Exception {
    	int page = 1;
        int pageSize = 5;

        if (param.get("page") != null) {
            page = Integer.parseInt(param.get("page").toString());
        }

        if (param.get("pageSize") != null) {
            pageSize = Integer.parseInt(param.get("pageSize").toString());
        }
        
        if (param.get("processedFilter") == null) {
            param.put("processedFilter", "all"); // 기본값
        }

        int offset = (page - 1) * pageSize;

        param.put("offset", offset);
        param.put("pageSize", pageSize);

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
    
    public HashMap<String, Object> resetUserCnt(HashMap<String , Object>map)  {
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int cnt = adminMapper.resetLoginCnt(map);
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