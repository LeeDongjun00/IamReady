package com.example.test1.dao;

import java.io.StringReader;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.example.test1.mapper.ShareBoardMapper;
import com.example.test1.mapper.ReviewMapper;
import com.example.test1.model.Review;
import com.example.test1.model.Share;



@Service
public class ShareBoardViewService {

	@Value("${TOUR_KEY}")
	private String apiKey;
	

	
	@Autowired
	ShareBoardMapper ShareBoardMapper;
	
	@Autowired
	TourAreaService TourAreaService ;
	
	@Autowired
	ReviewMapper reviewMapper;
	
    //디테일 정보
    public List<HashMap<String, Object>> getInfo(String contentId, String day , int dayNum)throws Exception {
		// TODO Auto-generated method stub
		List<HashMap<String, Object>> resultMap = new ArrayList<>();
		String encodedKey = URLEncoder.encode(apiKey, StandardCharsets.UTF_8);
		
		
			String url = "https://apis.data.go.kr/B551011/KorService2/detailCommon2"
                    + "?MobileOS=ETC&MobileApp=AppTest"
                    + "&ServiceKey=" + encodedKey
                    + "&contentId=" + contentId;

            RestTemplate restTemplate = new RestTemplate();
            byte[] bytes = restTemplate.getForObject(url, byte[].class);
            String xmlResponse = new String(bytes); // 공공데이터가 EUC-KR인 경우

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            InputSource is = new InputSource(new StringReader(xmlResponse));

            Document doc = factory.newDocumentBuilder().parse(is);

            NodeList items = doc.getElementsByTagName("item");

            for (int i = 0; i < items.getLength(); i++) {
                Element item = (Element) items.item(i);
                HashMap<String, Object> map = new HashMap<>();
                map.put("title", getTag(item, "title"));
                map.put("addr1", getTag(item, "addr1"));
                map.put("mapx", getTag(item, "mapx"));
                map.put("mapy", getTag(item, "mapy"));
                map.put("firstimage", getTag(item, "firstimage"));
                map.put("contentid", getTag(item, "contentid"));
                map.put("tel", getTag(item, "tel"));
                map.put("overview",getTag(item, "overview"));
                map.put("homepage",getTag(item, "homepage"));
                map.put("day", day);
                map.put("dayNum", dayNum);
                map.put("typeId", getTag(item,"contenttypeid"));
                map.put("price", TourAreaService.getPoiPrice(getTag(item, "contentid"), Integer.parseInt(getTag(item,"contenttypeid")), false));
                resultMap.add(map);
            }
       
        return resultMap;
    }

    private String getTag(Element element, String tagName) {
        NodeList list = element.getElementsByTagName(tagName);
        if (list != null && list.getLength() > 0) {
            return list.item(0).getTextContent();
        }
        return "";
    }
  //contentId 리스트
    public Map<Integer, List<HashMap<String, Object>>> fetchAllInfo(HashMap<String, Object> map) {

        Map<Integer, List<HashMap<String, Object>>> dayMap = new HashMap<>();

        // ✅ contentId 기준 캐시 (API 중복 호출 방지)
        Map<String, List<HashMap<String, Object>>> infoCache = new HashMap<>();

        // DB에서 contentId 리스트 가져오기
        List<Share> shares = ShareBoardMapper.sharInfo(map);

        for (Share share : shares) {

            String contentId = String.valueOf(share.getContentId())  != null
                    ? String.valueOf(share.getContentId())
                    : null;
            if (contentId == null || contentId.isEmpty()) continue;

            int dayNum = share.getDayNum();
            String reserveDate = share.getDay();

            List<HashMap<String, Object>> infoList;

            // ===============================
            // ✅ 캐시 확인
            // ===============================
            if (infoCache.containsKey(contentId)) {

                // 🔹 캐시된 데이터 복사 (day, dayNum 꼬임 방지)
                infoList = new ArrayList<>();
                for (HashMap<String, Object> cached : infoCache.get(contentId)) {
                    HashMap<String, Object> copy = new HashMap<>(cached);
                    copy.put("day", reserveDate);
                    copy.put("dayNum", dayNum);
                    infoList.add(copy);
                }

            } else {

                boolean success = false;
                int attempts = 0;
                int maxRetries = 2; // ✅ 5 → 2로 줄임

                infoList = new ArrayList<>();

                while (!success && attempts < maxRetries) {
                    try {
                        infoList = getInfo(contentId, reserveDate, dayNum);

                        // 🔹 캐시에 "원본" 저장
                        List<HashMap<String, Object>> cacheCopy = new ArrayList<>();
                        for (HashMap<String, Object> info : infoList) {
                            cacheCopy.add(new HashMap<>(info));
                        }
                        infoCache.put(contentId, cacheCopy);

                        success = true;
                    } catch (Exception e) {
                        attempts++;
                        try {
                            Thread.sleep(500); // 1초 → 0.5초
                        } catch (InterruptedException ie) {
                            Thread.currentThread().interrupt();
                        }
                    }
                }

                if (!success) {
                    infoList = new ArrayList<>();
                }
            }

            Double rating = share.getRating();
            String content = share.getContent();

            // ===============================
            // dayNum 기준으로 결과 저장
            // ===============================
            for (HashMap<String, Object> infoMap : infoList) {

                infoMap.put("dayNum", dayNum);

                if (rating != null) {
                    infoMap.put("rating", rating);
                    infoMap.put("content", content);
                } else {
                    infoMap.put("rating", 0);
                }

                dayMap.computeIfAbsent(dayNum, k -> new ArrayList<>()).add(infoMap);
            }
        }

        return dayMap;
    }


  //디테일 정보
    public List<HashMap<String, Object>> DetailInfo(String contentId)throws Exception {
		// TODO Auto-generated method stub
		List<HashMap<String, Object>> resultMap = new ArrayList<>();
		
		String encodedKey = URLEncoder.encode(apiKey, StandardCharsets.UTF_8);
		
			String url = "https://apis.data.go.kr/B551011/KorService2/detailCommon2"
                    + "?ServiceKey=" + encodedKey
                    + "&MobileOS=ETC&MobileApp=AppTest"
                    + "&contentId=" + contentId;

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
                map.put("title", getTag(item, "title"));
                map.put("addr1", getTag(item, "addr1"));
                map.put("mapx", getTag(item, "mapx"));
                map.put("mapy", getTag(item, "mapy"));
                map.put("firstimage", getTag(item, "firstimage"));
                map.put("contentid", getTag(item, "contentid"));
                map.put("tel", getTag(item, "tel"));
                map.put("overview",getTag(item, "overview"));
                map.put("homepage",getTag(item, "homepage"));  
                
            }
            HashMap<String, Object> paramMap = new HashMap<>();
            paramMap.put("contentId", contentId);

            List<Review> reviewList = reviewMapper.detailReviewList(paramMap);
            List<Review> reviewImgList = reviewMapper.detailReviewImgList(paramMap);
            
           map.put("list", reviewList);
           map.put("imgList", reviewImgList);
          
           resultMap.add(map);
       
        return resultMap;
    }
    
    public Map<Integer, HashMap<String, Object>> thumbnailMap(HashMap<String, Object> paramMap) {
        Map<Integer, HashMap<String, Object>> resultMap = new HashMap<>();
        List<Review> resList = reviewMapper.thumbnailWithResNum(paramMap);
        String[] randomImages = {"/img/defaultImg01.jpg", "/img/defaultImg02.jpg", "/img/defaultImg03.jpg",
                                 "/img/defaultImg04.jpg", "/img/defaultImg05.jpg", "/img/defaultImg06.jpg"};
        Random random = new Random();
        Map<String, String> imageCache = new HashMap<>();

        List<CompletableFuture<Void>> futures = new ArrayList<>();

        for (Review r : resList) {
            futures.add(CompletableFuture.runAsync(() -> {
                Integer resNum = r.getResNum();
                String contentId = (r.getContentId() != null) ? String.valueOf(r.getContentId()) : null;
                String firstImage;

                if (contentId == null || contentId.isEmpty()) {
                    firstImage = randomImages[random.nextInt(randomImages.length)];
                } else if (imageCache.containsKey(contentId)) {
                    firstImage = imageCache.get(contentId);
                } else {
                    try {
                        firstImage = getFirstImage(contentId);
                        if (firstImage == null || firstImage.isEmpty()) {
                            firstImage = randomImages[random.nextInt(randomImages.length)];
                        }
                        imageCache.put(contentId, firstImage);
                    } catch (Exception e) {
                        firstImage = randomImages[random.nextInt(randomImages.length)];
                    }
                }

                HashMap<String, Object> map = new HashMap<>();
                map.put("contentId", contentId);
                map.put("firstimage", firstImage);

                synchronized(resultMap) {
                    resultMap.put(resNum, map);
                }
            }));
        }

        futures.forEach(f -> {
            try { f.get(); } catch (InterruptedException | ExecutionException e) { e.printStackTrace(); }
        });

        return resultMap;
    }
    // API로 이미지 가져오기
    public String getFirstImage(String contentId) throws Exception {
    	String encodedKey = URLEncoder.encode(apiKey, StandardCharsets.UTF_8);
        String url = "https://apis.data.go.kr/B551011/KorService2/detailCommon2"
                + "?ServiceKey=" + apiKey
                + "&MobileOS=ETC&MobileApp=AppTest"
                + "&contentId=" + contentId
                ;
        System.out.println(url);
        RestTemplate restTemplate = new RestTemplate();
        byte[] bytes = restTemplate.getForObject(url, byte[].class);
        String xmlResponse = new String(bytes);

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        InputSource is = new InputSource(new StringReader(xmlResponse));
        Document doc = factory.newDocumentBuilder().parse(is);

        NodeList items = doc.getElementsByTagName("item");
        if (items.getLength() == 0) return null;

        Element item = (Element) items.item(0);
        return getTag(item, "firstimage");
    }   

    public HashMap<String, Object> getResActive(HashMap<String, Object> map) {
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	List<Share> List = ShareBoardMapper.shareActive(map);
    	resultMap.put("list", List);
    	
    	 Map<Integer, List<HashMap<String, Object>>> allInfoMap = fetchAllInfo(map);
    	  resultMap.put("detail", allInfoMap);
    	return resultMap;
    }    

	
}
