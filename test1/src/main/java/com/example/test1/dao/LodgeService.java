package com.example.test1.dao;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.example.test1.mapper.LodgeMapper;
import com.example.test1.model.Lodge;
import com.example.test1.model.Review;

@Service
public class LodgeService {
	@Value("${TOUR_KEY}")
	private String apiKey;

	@Autowired
	LodgeMapper LodgeMapper;
	
	public List<HashMap<String, Object>> DetailInfo(String contentId)throws Exception {
		// TODO Auto-generated method stub
		List<HashMap<String, Object>> resultMap = new ArrayList<>();
		
			String url = "https://apis.data.go.kr/B551011/KorService2/detailIntro2"
                    + "?ServiceKey=" + apiKey
                    + "&MobileOS=ETC&MobileApp=AppTest"
                    + "&contentId=" + contentId
                    + "&contentTypeId=32";  

            RestTemplate restTemplate = new RestTemplate();
            byte[] bytes = restTemplate.getForObject(url, byte[].class);
            String xmlResponse = new String(bytes); // 공공데이터가 EUC-KR인 경우

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            InputSource is = new InputSource(new StringReader(xmlResponse));

            Document doc = factory.newDocumentBuilder().parse(is);

            NodeList items = doc.getElementsByTagName("item");
          
            HashMap<String, Object> map = new HashMap<>();
            for (int i = 0; i < items.getLength(); i++) {
                Element item = (Element) items.item(i);

                map.put("accomcount", getTag(item, "accomcountlodging"));
                map.put("checkin", getTag(item, "checkintime"));
                map.put("checkout", getTag(item, "checkouttime"));
                map.put("roomcount", getTag(item, "roomcount"));
                map.put("roomtype", getTag(item, "roomtype"));
                map.put("scale", getTag(item, "scalelodging"));

                map.put("reservation", getTag(item, "reservationlodging"));
                map.put("reservationurl", getTag(item, "reservationurl"));
                map.put("refund", getTag(item, "refundregulation"));

                map.put("parking", getTag(item, "parkinglodging"));
                map.put("foodplace", getTag(item, "foodplace"));
                map.put("pickup", getTag(item, "pickup"));
                map.put("subfacility", getTag(item, "subfacility"));

                map.put("fitness", getTag(item, "fitness"));
                map.put("sauna", getTag(item, "sauna"));
                map.put("karaoke", getTag(item, "karaoke"));
                map.put("barbecue", getTag(item, "barbecue"));
                map.put("publicbath", getTag(item, "publicbath"));
                map.put("publicpc", getTag(item, "publicpc"));
                map.put("seminar", getTag(item, "seminar"));
                map.put("sports", getTag(item, "sports"));

            }
            HashMap<String, Object> paramMap = new HashMap<>();
            paramMap.put("contentId", contentId);

           resultMap.add(map);
       
        return resultMap;
    }
	private String getTag(Element element, String tagName) {
        NodeList list = element.getElementsByTagName(tagName);
        if (list != null && list.getLength() > 0) {
            return list.item(0).getTextContent();
        }
        return "";
    }
	
	public List<HashMap<String, Object>> DetailImageInfo(String contentId) throws Exception {

	    List<HashMap<String, Object>> resultMap = new ArrayList<>();

	    String url = "https://apis.data.go.kr/B551011/KorService2/detailInfo2"
	            + "?ServiceKey=" + apiKey
	            + "&MobileOS=ETC&MobileApp=AppTest"
	            + "&contentId=" + contentId
	            + "&contentTypeId=32";

	    RestTemplate restTemplate = new RestTemplate();
	    byte[] bytes = restTemplate.getForObject(url, byte[].class);
	    String xmlResponse = new String(bytes);

	    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	    InputSource is = new InputSource(new StringReader(xmlResponse));
	    Document doc = factory.newDocumentBuilder().parse(is);

	    NodeList items = doc.getElementsByTagName("item");

	    for (int i = 0; i < items.getLength(); i++) {
	        Element item = (Element) items.item(i);

	        HashMap<String, Object> map = new HashMap<>();

	        // 객실 기본 정보
	        map.put("roomtitle", getTag(item, "roomtitle"));
	        map.put("roomsize", getTag(item, "roomsize1"));
	        map.put("roomcount", getTag(item, "roomcount"));

	        // 💰 요금 (비수기 기준)
	        map.put("price", getTag(item, "roomoffseasonminfee1"));

	        // 🖼 객실 이미지 (중요)
	        map.put("roomimg1", getTag(item, "roomimg1"));
	        map.put("roomimg2", getTag(item, "roomimg2"));
	        map.put("roomimg3", getTag(item, "roomimg3"));
	        map.put("roomimg4", getTag(item, "roomimg4"));
	        map.put("roomimg5", getTag(item, "roomimg5"));

	        resultMap.add(map);
	    }

	    return resultMap;
	}

	public List<HashMap<String, Object>> Info(String contentId) throws Exception {

	    List<HashMap<String, Object>> resultMap = new ArrayList<>();

	    String url = "https://apis.data.go.kr/B551011/KorService2/detailCommon2"
	            + "?ServiceKey=" + apiKey
	            + "&MobileOS=ETC&MobileApp=AppTest"
	            + "&contentId=" + contentId;
	        

	    RestTemplate restTemplate = new RestTemplate();
	    byte[] bytes = restTemplate.getForObject(url, byte[].class);
	    String xmlResponse = new String(bytes);

	    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	    InputSource is = new InputSource(new StringReader(xmlResponse));
	    Document doc = factory.newDocumentBuilder().parse(is);

	    NodeList items = doc.getElementsByTagName("item");

	    for (int i = 0; i < items.getLength(); i++) {
	        Element item = (Element) items.item(i);

	        HashMap<String, Object> map = new HashMap<>();

	        map.put("title", getTag(item, "title"));
	        map.put("addr1", getTag(item, "addr1"));
	        map.put("firstimage", getTag(item, "firstimage"));
	        map.put("overview", getTag(item, "overview"));
	        resultMap.add(map);
	    }

	    return resultMap;
	}
	public HashMap<String, Object> payment(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int cnt = LodgeMapper.Payment(map);
			resultMap.put("result", "success");
			resultMap.put("msg", "결제되었습니다.");
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.print(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("msg", "결제 실패했습니다.");
		}
		return resultMap;
	}
	public HashMap<String, Object> AccInfo(HashMap<String , Object>map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			Lodge info = LodgeMapper.AccInfo(map);
			resultMap.put("accinfo", info);
			resultMap.put("result", "success");
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.print(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
}
