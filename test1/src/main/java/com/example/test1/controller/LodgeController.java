package com.example.test1.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.LodgeService;
import com.google.gson.Gson;

@Controller
public class LodgeController {
	@Autowired
	LodgeService LodgeService;
	
//  --------------- 숙박결제	
	@RequestMapping("/lodge.do") 
	public String lodgeDetail(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{ 
		request.setAttribute("resNum", map.get("resNum"));
		request.setAttribute("contentId", map.get("accContentId"));
        return "/lodge";
    }

	@RequestMapping("/payment.do") 
	public String payment(HttpServletRequest request, HttpSession session, @RequestParam HashMap<String, Object> map) throws Exception{ 
		request.setAttribute("title", map.get("title"));
		request.setAttribute("resNum", map.get("resNum"));
		request.setAttribute("contentId", map.get("contentId"));
		request.setAttribute("roomTitle", map.get("roomTitle"));
		request.setAttribute("checkIn", map.get("checkInDate"));
		request.setAttribute("checkOut", map.get("checkOutDate"));
		request.setAttribute("people", map.get("adults"));
		request.setAttribute("price", map.get("roomPrice"));
		request.setAttribute("resperson", session.getAttribute("sessionId"));
        return "/payment";
    }
	
	@GetMapping(value = "/lodge-detail.dox", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String Detail(@RequestParam HashMap<String, Object> map) throws Exception {
        String contentId = String.valueOf(map.get("contentId"));
        List<HashMap<String, Object>> resultList = LodgeService.DetailInfo(contentId);
        return new Gson().toJson(resultList);
    }
	
	@GetMapping(value = "/lodge-detailImg.dox", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String DetailImg(@RequestParam HashMap<String, Object> map) throws Exception {
        String contentId = String.valueOf(map.get("contentId"));
        List<HashMap<String, Object>> resultList = LodgeService.DetailImageInfo(contentId);
        return new Gson().toJson(resultList);
    }
	
	@GetMapping(value = "/lodge-info.dox", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String info(@RequestParam HashMap<String, Object> map) throws Exception {
        String contentId = String.valueOf(map.get("contentId"));
        List<HashMap<String, Object>> resultList = LodgeService.Info(contentId);
        return new Gson().toJson(resultList);
    }
	
	@GetMapping(value = "/Acc-info.dox", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String Accinfo(@RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultList = LodgeService.AccInfo(map);
        return new Gson().toJson(resultList);
    }
	
	
	@RequestMapping(value = "/payment.dox",  method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String payment(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = LodgeService.payment(map);
		
		return new Gson().toJson(resultMap);
	}
}
