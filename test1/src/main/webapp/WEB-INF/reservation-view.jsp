<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>예약 상세 확인</title>

  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

  <script src="https://unpkg.com/vue@3/dist/vue.global.prod.js"></script>

  <script type="text/javascript"
          src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoAppKey}&libraries=services"></script>

  <link rel="stylesheet" href="/css/main-style.css">
  <link rel="stylesheet" href="/css/common-style.css">
  <link rel="stylesheet" href="/css/header-style.css">
  <link rel="stylesheet" href="/css/main-images.css">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/reservation.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

  <style>
    :root { --brand:#3498db; --brand-600:#2980b9; --danger:#e74c3c; --danger-600:#c0392b; --text:#333; --muted:#555; --border:#e0e0e0; --bg:#ffffff; }
    body{font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif;background:var(--bg);color:var(--text);}
    .wrap{max-width:1100px;margin:24px auto 60px;padding:0 16px;}
    .page-title{font-size:2.25rem;font-weight:700;color:#2c3e50;border-bottom:3px solid var(--brand);padding-bottom:10px;margin-bottom:20px;}
    .panel{background:#fff;border:1px solid var(--border);border-radius:12px;padding:24px;margin-bottom:25px;box-shadow:0 4px 12px rgba(0,0,0,.05);}
    .panel h2,.panel h3{margin:0 0 14px;border-bottom:1px solid #eee;padding-bottom:10px;}
    .info-list{list-style:none;margin:0;padding:0;}
    .info-list li{font-size:1.05rem;line-height:2;color:var(--muted);display:flex;align-items:center;gap:10px;flex-wrap:wrap;}
    .info-list li strong{color:#222;width:120px;flex-shrink:0;}
    .title-input{font-size:1rem;padding:8px 10px;border:1px solid #ccc;border-radius:8px;flex:0 0 260px;max-width:260px;}
    .btn{padding:10px 14px;border:none;background:#f0f0f0;cursor:pointer;border-radius:8px;font-size:.95rem;color:#555;}
    .btn.primary{background:var(--brand);color:#fff;}.btn.primary:hover{background:var(--brand-600);}
    .btn.ghost{background:#f0f0f0;color:#555;}
    .btn.danger{background:var(--danger);color:#fff;}.btn.danger:hover{background:var(--danger-600);}
    .budget-total{font-size:1.1rem;font-weight:700;color:#333;margin-bottom:14px;}
    .budget-status-wrap{display:grid;grid-template-columns:repeat(4,1fr);gap:15px;padding:15px;background:#f9f9f9;border-radius:10px;}
    .budget-status-item{background:#fff;border:1px solid var(--border);border-radius:10px;padding:12px 10px;text-align:center;box-shadow:0 2px 4px rgba(0,0,0,.03);min-height:72px;}
    .budget-status-item .label{font-size:.85rem;color:#666;display:block;margin-bottom:6px;}
    .budget-status-item .amount{font-size:1.15rem;font-weight:700;color:var(--brand);display:block;}
    #map-container{width:100%;height:440px;border:1px solid #ddd;border-radius:10px;margin-top:10px;overflow:hidden;}
    .date-tabs{display:flex;gap:6px;margin-bottom:15px;border-bottom:2px solid #ddd;flex-wrap:wrap;}
    .tab-btn{padding:10px 14px;border:none;background:#f0f0f0;cursor:pointer;border-radius:8px 8px 0 0;font-size:.95rem;color:#555;position:relative;bottom:-2px;}
    .tab-btn.active{background:#fff;border:2px solid #ddd;border-bottom:2px solid #fff;font-weight:700;color:var(--brand);}
    .route-toolbar{display:flex;gap:8px;align-items:center;margin-bottom:10px;flex-wrap:wrap;}
    .route-summary{font-size:.9rem;color:#444;padding:6px 10px;background:#f5f7fa;border:1px solid #e5e7eb;border-radius:8px;}
    .poi-item{background:#fff;border:1px solid var(--border);border-radius:10px;padding:14px;margin-bottom:10px;}
    .poi-item p{margin:0;line-height:1.6;}
    .poi-item p:first-child strong{font-size:1.05rem;color:#2c3e50;}
    .save-button-wrap{display:flex;justify-content:center;gap:8px;margin-top:26px;flex-wrap:wrap;}
    .save-button-wrap .btn{min-width:140px;}
    .memo-card{width:100%;margin-top:16px;padding:16px 18px;border:1px solid var(--border);border-radius:10px;background:#fff;box-shadow:0 2px 6px rgba(0,0,0,.03);}
    .memo-title{font-weight:700;color:#2c3e50;margin-bottom:10px;display:flex;align-items:center;font-size:1rem;}
    .memo-field{width:100%;min-width:200px;max-width:100%;min-height:160px;padding:12px 14px;border:1px solid var(--border);border-radius:10px;background:#fff;font-size:.95rem;line-height:1.6;color:var(--text);resize:both;box-sizing:border-box;outline:none;transition:border-color .12s,box-shadow .12s;}
    .memo-field::placeholder{color:#98a2b3;}
    .memo-field:focus{border-color:var(--brand);box-shadow:0 0 0 3px rgba(52,152,219,.14);}
    .memo-hint{margin-top:8px;font-size:.85rem;color:#6b7280;}
    @media (max-width:860px){.budget-status-wrap{grid-template-columns:repeat(2,1fr);}}
    @media (max-width:520px){.budget-status-wrap{grid-template-columns:1fr;}.info-list li strong{width:100%;}}
  </style>
</head>

<body>
<%@ include file="components/header.jsp" %>

<div class="wrap">
  <div id="app">
    <h1 class="page-title">예약 상세 확인</h1>

    <div class="panel">
      <h3>기본 예약 정보 확인</h3>
      <ul class="info-list">
        <li>
          <strong>여행 코스 이름</strong>
          <input type="text" class="title-input"
                 v-model="reservation.packname"
                 placeholder="코스 별칭을 입력하세요" />
        </li>
        <li>
          <strong>여행 기간</strong>
          <span>{{ formatDate(reservation.startDate) }} ~ {{ formatDate(reservation.endDate) }}</span>
        </li>
        <li>
          <strong>방문 예정 장소</strong>
          <span>총 {{ poiList ? poiList.length : 0 }}지점</span>
        </li>
        <li>
          <strong>테마</strong>
          <span>{{ displayThemes }}</span>
        </li>
      </ul>
    </div>

    <div class="panel">
      <h3>예산 현황</h3>
      <div class="budget-total"><strong>총 예산:</strong> {{ formatPrice(reservation.price) }}원</div>

      <div>
        사용 가능 포인트 : {{ info.totalPoint }}
      </div>
      <div>
        포인트 사용량 :
        <input type="number" v-model="usingPoint" :max="info.totalPoint" min="0"
               @input="limitPoint"
               style="width: 80px; text-align: right; height: 20px;">
        <br><br>
      </div>

      <div class="budget-status-wrap">
        <div class="budget-status-item"><span class="label">기타 예산</span><span class="amount">{{ formatPrice(reservation.etcBudget) }}원</span></div>
        <div class="budget-status-item"><span class="label">관광 및 활동 예산</span><span class="amount">{{ formatPrice(reservation.actBudget) }}원</span></div>
        <div class="budget-status-item"><span class="label">숙박 예산</span><span class="amount">{{ formatPrice(reservation.accomBudget) }}원</span></div>
        <div class="budget-status-item"><span class="label">식비 예산</span><span class="amount">{{ formatPrice(reservation.foodBudget) }}원</span></div>
      </div>

      <div class="memo-card" aria-label="메모 영역">
        <div class="memo-title"><i class="fa-regular fa-note-sticky" style="margin-right:6px;"></i> 메모</div>
        <textarea class="memo-field" rows="5" v-model="memo" placeholder="여행 메모를 입력하세요."></textarea>
      </div>
    </div>

    <div class="panel">
      <h2>🗺️ 여행 경로 지도</h2>
      <div class="route-toolbar">
        <button id="btnBuildRoute" @click="buildCarRoute" class="btn ghost">차량 경로 보기</button>
        <button v-if="routePolyline" @click="clearRoute" class="btn ghost">경로 지우기</button>
        <div v-if="routeSummary" class="route-summary">
          총 거리: {{ (routeSummary.distance/1000).toFixed(1) }} km ·
          예상 소요: {{ Math.round(routeSummary.duration/60) }} 분
          <span v-if="routeSummary.toll">· 톨비: {{ routeSummary.toll.toLocaleString() }}원</span>
        </div>
      </div>
      <div id="map-container">지도 로딩 중...</div>
    </div>

    <div class="panel">
      <h2>📋 상세 일정 목록</h2>
      <div class="date-tabs" v-if="Object.keys(itineraryByDate).length > 0">
        <button type="button"
                v-for="(pois, date, index) in itineraryByDate"
                :key="date"
                :class="['tab-btn', { active: activeDate === date }]"
                @click="setActiveDate(date)">
          {{ index + 1 }}일차 ({{ formatDate(date) }})
        </button>
      </div>

      <div id="detail-schedule-list">
        <p v-if="poiList.length === 0">유효한 POI 일정이 없습니다.</p>
        <div v-else
             v-for="(poi, index) in itineraryByDate[activeDate]"
             :key="poi.poiId || (poi.contentId + '_' + index)"
             class="poi-item">
          <p>[{{ index + 1 }}] <strong>{{ poi.placeName }}</strong></p>
          <p>방문 예정일: {{ formatDate(poi.reservDate) }}</p>
        </div>
      </div>
    </div>

    <div class="save-button-wrap">
      <button class="btn primary" @click="fnSave">저장 후 숙소결제로 이동</button>
      <button class="btn danger" @click="fnCancelReservation">여행 포기하기</button>
    </div>
  </div>
</div>

<%@ include file="components/footer.jsp" %>

<script>
  const app = Vue.createApp({
    data() {
      return {
        userId: "${sessionId}",

        // ✅ 숙소 contentId
        accContentId: null,

        memo: "",
        reservation: {
          resNum: 0,
          packName: "",
          packname: "",
          price: 0,
          startDate: "",
          endDate: "",
          themNum: "",
          descript: "",
          etcBudget: 0,
          accomBudget: 0,
          foodBudget: 0,
          actBudget: 0
        },
        poiList: [],
        map: null,
        itineraryByDate: {},
        activeDate: null,
        themeOptions: [
          { code: 'FAMILY', label: '가족' }, { code: 'FRIEND', label: '친구' },
          { code: 'COUPLE', label: '연인' }, { code: 'LUXURY', label: '호화스러운' },
          { code: 'BUDGET', label: '가성비' }, { code: 'HEALING', label: '힐링' },
          { code: 'UNIQUE', label: '이색적인' }, { code: 'ADVENTURE', label: '모험' },
          { code: 'QUIET', label: '조용한' }
        ],
        routePolyline: null,
        routeSummary: null,
        markers: [],
        info: {},
        usingPoint: 0
      };
    },

    computed: {
      displayThemes() {
        if (!this.reservation.themNum) return "선택 안 함";
        const codes = String(this.reservation.themNum).split(',');
        return codes.map(code => {
          const theme = this.themeOptions.find(t => t.code === code.trim());
          return theme ? theme.label : code;
        }).join(', ');
      }
    },

    methods: {
      // ✅ [수정됨 1] 날짜 포맷 함수 (강력한 자르기)
      formatDate(d) {
        if (!d || d === 'null' || d === 'undefined') return '';
        const str = String(d).trim();
        // "2026-01-22 00:00:00" 처럼 길면 앞 10자리만 자름
        if (str.length >= 10) {
            return str.substring(0, 10);
        }
        return str;
      },

      formatPrice(n) {
        const num = Number(n || 0);
        return isNaN(num) ? "0" : num.toLocaleString();
      },

      setAccContentIdFromPois() {
        const accomPoi = (this.poiList || []).find(p => String(p.typeId) === '32');
        this.accContentId = (accomPoi && accomPoi.contentId) ? Number(accomPoi.contentId) : null;
      },

      initializeMap(data) {
        if (!window.kakao || !kakao.maps) {
          const el = document.getElementById('map-container');
          if(el) el.innerText = 'Kakao Map API 로드 실패.';
          return;
        }
        const container = document.getElementById('map-container');
        const lat = data[0].mapY || 37.566826;
        const lng = data[0].mapX || 126.9786567;
        const options = { center: new kakao.maps.LatLng(lat, lng), level: 7 };
        this.map = new kakao.maps.Map(container, options);

        const bounds = new kakao.maps.LatLngBounds();
        this.clearMarkers();

        data.forEach(p => {
          if (!p.mapY || !p.mapX) return;
          const pos = new kakao.maps.LatLng(p.mapY, p.mapX);
          const marker = new kakao.maps.Marker({ position: pos });
          marker.setMap(this.map);
          this.markers.push(marker);

          const info = new kakao.maps.InfoWindow({
            content: '<div style="padding:5px; color:#000;">' + (p.placeName || p.contentId) + '</div>'
          });
          kakao.maps.event.addListener(marker, 'mouseover', () => info.open(this.map, marker));
          kakao.maps.event.addListener(marker, 'mouseout', () => info.close());
          bounds.extend(pos);
        });
        
        if (data.length > 0) this.map.setBounds(bounds);
        
        setTimeout(() => {
          if (this.map && this.map.relayout) this.map.relayout();
        }, 200);
      },

      clearMarkers() {
        if (!this.markers) return;
        this.markers.forEach(m => m.setMap(null));
        this.markers = [];
      },

      drawPolyline(points) {
        if (!this.map) return;
        if (this.routePolyline) {
          this.routePolyline.setMap(null);
          this.routePolyline = null;
        }
        if (!points || points.length === 0) return;

        const path = points.map(pt => new kakao.maps.LatLng(pt.y, pt.x));
        this.routePolyline = new kakao.maps.Polyline({
          path,
          strokeWeight: 5, strokeOpacity: 0.9, strokeColor: '#e74c3c'
        });
        this.routePolyline.setMap(this.map);

        const bounds = new kakao.maps.LatLngBounds();
        path.forEach(latlng => bounds.extend(latlng));
        this.map.setBounds(bounds);
      },

      clearRoute() {
        if (this.routePolyline) {
          this.routePolyline.setMap(null);
          this.routePolyline = null;
        }
        this.routeSummary = null;
      },

      async buildCarRoute() {
        const pois = this.itineraryByDate[this.activeDate] || [];
        const valid = pois.filter(p => p.mapX && p.mapY);
        if (valid.length < 2) {
          alert('경로를 그릴 최소 2개 지점(출발/도착)이 필요합니다.');
          return;
        }
        try {
          const payload = {
            resNum: this.reservation.resNum,
            day: this.activeDate,
            pois: valid.map(p => ({
              contentId: p.contentId, name: p.placeName || '', x: Number(p.mapX), y: Number(p.mapY)
            }))
          };
          const resp = await $.ajax({
            url: '/api/route/build', type: 'POST', contentType: 'application/json',
            data: JSON.stringify(payload)
          });
          this.drawPolyline(resp.points);
          this.routeSummary = resp.summary || null;
        } catch (e) {
          console.error(e);
          alert('경로 계산 실패 (서버 로그 확인 필요)');
        }
      },

      async fnSave() {
        try {
          const name = (this.reservation.packname || '').trim();
          if (name.length === 0 && !confirm('코스 이름이 비어 있습니다. 진행할까요?')) return;
          if (!this.accContentId) {
            alert('숙소 정보가 없어 결제를 진행할 수 없습니다.');
            return;
          }
          const payload = {
            resNum: this.reservation.resNum,
            packName: name, userId: this.userId, descript: this.memo, accContentId: this.accContentId
          };
          await $.ajax({
            url: '/api/reservation/update/packname', type: 'POST', contentType: 'application/json',
            data: JSON.stringify(payload)
          });
          window.location.href = '/lodge.do?resNum=' + encodeURIComponent(this.reservation.resNum) + '&accContentId=' + encodeURIComponent(this.accContentId);
        } catch (e) {
          alert('저장 중 오류가 발생했습니다.');
        }
      },

      fnCancelReservation() {
        if (!confirm('정말로 예약을 취소하시겠습니까?')) return;
        $.ajax({
          url: '/api/reservation/delete', type: 'POST', contentType: 'application/json',
          data: JSON.stringify({ resNum: this.reservation.resNum }),
          success: () => { alert('삭제되었습니다.'); window.location.href = '/main-list.do'; },
          error: () => alert('삭제 실패')
        });
      },

      // ✅ [수정됨 2] 날짜 그룹핑 및 자동 계산
      groupPoisByDate(list) {
        if (!list || list.length === 0) return;
        
        // 기준일(시작일) 가져오기 - 시간 정보 제거하고 처리
        let startDt = new Date();
        if (this.reservation.startDate) {
            const s = String(this.reservation.startDate).replace(' ', 'T').substring(0, 10);
            const d = new Date(s);
            if (!isNaN(d.getTime())) startDt = d;
        }

        list.forEach(p => {
            // 이미 날짜가 잘 들어있으면 패스
            if (p.reservDate && p.reservDate !== 'null' && p.reservDate.length >= 10) return;
            
            // day 값 확인 (day, dayNum, nDay 등 다양한 변수명 대응)
            const dVal = p.day || p.dayNum || p.nDay || p.jcnt;
            const dNum = parseInt(dVal);
            
            if (!isNaN(dNum)) {
                const calcDate = new Date(startDt);
                calcDate.setDate(calcDate.getDate() + (dNum - 1));
                
                const yyyy = calcDate.getFullYear();
                const mm = String(calcDate.getMonth() + 1).padStart(2, '0');
                const dd = String(calcDate.getDate()).padStart(2, '0');
                p.reservDate = `${yyyy}-${mm}-${dd}`;
            }
        });

        const sorted = list.sort((a, b) => {
            if (!a.reservDate) return 1; if (!b.reservDate) return -1;
            return a.reservDate.localeCompare(b.reservDate);
        });

        const grouped = {};
        sorted.forEach(p => {
            const d = this.formatDate(p.reservDate);
            const key = d || "날짜 미정";
            if (!grouped[key]) grouped[key] = [];
            grouped[key].push(p);
        });

        this.itineraryByDate = grouped;
        const keys = Object.keys(grouped).sort();
        if (keys.length > 0) this.activeDate = keys[0];
      },
      
      setActiveDate(d) { this.activeDate = d; this.clearRoute(); },

      fnMemberPoint() {
        const self = this;
        $.ajax({
          url: "/point/recent.dox", type: "POST", data: { userId: self.userId },
          success: (res) => { self.info = (res && res.info) ? res.info : { totalPoint: 0 }; },
          error: () => { self.info = { totalPoint: 0 }; }
        });
      },

      limitPoint() {
        let val = parseInt(this.usingPoint);
        const max = parseInt(this.info.totalPoint || 0);
        if (isNaN(val) || val < 0) val = 0;
        if (val > max) val = max;
        this.usingPoint = val;
      }
    },

    
	mounted() {
	      try {
	        const rawRes = JSON.parse('<c:out value="${reservationJson}" escapeXml="false" />' || '{}');
	        const rawPoi = JSON.parse('<c:out value="${poiListJson}" escapeXml="false" />' || '[]');

	        console.log("=== [DEBUG] 서버 데이터 확인 ===", rawRes);

	        // 1. 기본 정보 매핑
	        this.reservation.resNum = rawRes.resNum || rawRes.RES_NUM || 0;
	        this.reservation.packname = rawRes.packName || rawRes.packname || rawRes.PACK_NAME || '';
	        
	        // 날짜 처리
	        const sDate = rawRes.startDate || rawRes.sdate || rawRes.S_DATE || rawRes.start_date || '';
	        const eDate = rawRes.endDate || rawRes.edate || rawRes.E_DATE || rawRes.end_date || '';
	        this.reservation.startDate = sDate.length > 10 ? sDate.substring(0, 10) : sDate;
	        this.reservation.endDate = eDate.length > 10 ? eDate.substring(0, 10) : eDate;

	        this.reservation.themNum = rawRes.themNum || rawRes.themnum || rawRes.THEM_NUM || '';
	        this.reservation.descript = rawRes.descript || rawRes.DESCRIPT || '';

	        // 2. 총 예산
	        this.reservation.price = rawRes.price || rawRes.budget || rawRes.total_price || rawRes.total_budget || rawRes.PRICE || 0;

	        // 3. [핵심 수정] 예산 상세 매핑 (금액이 없으면 비율로 계산)
	        // 먼저 직접적인 금액(Budget)이 있는지 확인
	        this.reservation.etcBudget = rawRes.etcBudget || rawRes.etc_budget || rawRes.ETC_BUDGET || 0;
	        this.reservation.accomBudget = rawRes.accomBudget || rawRes.accom_budget || rawRes.ACCOM_BUDGET || 0;
	        this.reservation.foodBudget = rawRes.foodBudget || rawRes.food_budget || rawRes.FOOD_BUDGET || 0;
	        this.reservation.actBudget = rawRes.actBudget || rawRes.act_budget || rawRes.ACT_BUDGET || 0;

	        // 4. [여기가 중요!] 금액이 0원이고 'budgetWeights' 묶음(비율)이 있는 경우 자동 계산
	        const total = Number(this.reservation.price);
	        if (total > 0 && this.reservation.accomBudget === 0) {
	            
	            // Case A: budgetWeights 객체로 묶여서 오는 경우 (가장 유력)
	            if (rawRes.budgetWeights) {
	                console.log("=== [알림] budgetWeights 발견! 비율로 금액을 자동 계산합니다. ===");
	                const w = rawRes.budgetWeights; // { etc: 10, accom: 40... }
	                
	                this.reservation.etcBudget = Math.floor(total * ((w.etc || 0) / 100));
	                this.reservation.accomBudget = Math.floor(total * ((w.accom || 0) / 100));
	                this.reservation.foodBudget = Math.floor(total * ((w.food || 0) / 100));
	                this.reservation.actBudget = Math.floor(total * ((w.act || 0) / 100));
	            } 
	            // Case B: 풀어진 변수명으로 오는 경우 (etc_ratio 등)
	            else {
	                const etcW = rawRes.etc_ratio || rawRes.etcRatio || 0;
	                const accomW = rawRes.accom_ratio || rawRes.accomRatio || 0;
	                const foodW = rawRes.food_ratio || rawRes.foodRatio || 0;
	                const actW = rawRes.act_ratio || rawRes.actRatio || 0;

	                if (etcW || accomW || foodW || actW) {
	                    console.log("=== [알림] 비율 변수 발견! 금액을 자동 계산합니다. ===");
	                    const divider = (etcW + accomW + foodW + actW) > 1.5 ? 100 : 1; // 합이 100이면 나누기 100, 1.0이면 나누기 1
	                    
	                    this.reservation.etcBudget = Math.floor(total * (etcW / divider));
	                    this.reservation.accomBudget = Math.floor(total * (accomW / divider));
	                    this.reservation.foodBudget = Math.floor(total * (foodW / divider));
	                    this.reservation.actBudget = Math.floor(total * (actW / divider));
	                }
	            }
	        }
	        
	        if (this.reservation.descript) this.memo = this.reservation.descript;

	        this.poiList = rawPoi.filter(p => p.contentId && Number(p.contentId) > 0);
	        this.setAccContentIdFromPois();
	        this.groupPoisByDate(this.poiList);

	        const mapPois = this.poiList.filter(p => p.mapY && p.mapX);
	        if (mapPois.length > 0) this.initializeMap(mapPois);
	        else document.getElementById('map-container').innerText = '지도에 표시할 장소가 없습니다.';
	        
	        this.fnMemberPoint();

	      } catch (e) {
	        console.error("데이터 로딩 중 오류:", e);
	      }
	    }
  });

  app.mount('#app');
</script>

</body>
</html>