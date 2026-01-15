<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script
      src="https://code.jquery.com/jquery-3.7.1.js"
      integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
      crossorigin="anonymous"
    ></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
      rel="stylesheet"
    />
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoAppKey}&libraries=services"
    ></script>
    <script src="https://cdn.jsdelivr.net/npm/html2canvas@1.4.1/dist/html2canvas.min.js"></script>
    <script src="/js/page-change.js"></script>
    <link rel="stylesheet" href="/css/main-style.css" />
    <link rel="stylesheet" href="/css/common-style.css" />
    <link rel="stylesheet" href="/css/header-style.css" />
    <link rel="stylesheet" href="/css/main-images.css" />

    <style>
      .page-title {
        display: flex;
        align-items: center;
        justify-content: center; /* 중앙 정렬 기준 */
        position: relative; /* 뒤로가기 버튼 절대 위치 가능하게 */
        max-width: 80%;
        margin: 0 auto 28px;
        text-align: center;
      }
      /* 뒤로가기 버튼 */
      .back-btn {
        position: absolute;
        left: 0; /* 맨 왼쪽으로 이동 */
      }

      .back {
        background: none;
        border: none;
        display: flex;
        align-items: center;
        gap: 4px;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s;
      }

      .material-symbols-outlined {
        font-size: 32px;
        vertical-align: middle;
      }
      .card-container {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: center;
      }

      .card {
        display: flex;
        justify-content: space-between;
        background-color: #fff;
        width: 80%;
        border-radius: 15px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
        transition: all 0.3s ease;
        margin-bottom: 20px;
      }

      .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
      }

      .card-header {
        font-size: 1.4em;
        font-weight: 600;
        color: #333;
        margin-bottom: 10px;
      }

      .card-theme {
        display: inline-block;
        background-color: #e3f2fd;
        color: #1976d2;
        padding: 4px 12px;
        border-radius: 12px;
        font-size: 0.8em;
        font-weight: 500;
        margin: 0 6px 6px 0;
      }

      .card-content p {
        margin: 5px 0;
        color: #555;
      }

      .card-content strong {
        color: #333;
      }

      .card-footer {
        margin-top: 15px;
        text-align: right;
      }

      .card-footer span {
        font-size: 0.9em;
        color: #999;
      }
      .card-btn {
        display: flex;
        flex-direction: column;
        justify-content: space-between;
      }
      .card-btn button {
        background-color: #1976d2;
        color: white;
        border: none;
        border-radius: 10px;
        padding: 10px 16px;
        font-size: 0.95em;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      }

      .card-btn button:hover {
        background-color: #045abd;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        transform: translateY(-2px);
      }

      .card-btn button:active {
        transform: translateY(0);
        box-shadow: 0 2px 5px rgba(0s, 0, 0, 0.1);
      }
      /* ===============================
            ✅ 페이징 디자인
=============================== */
      .pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 40px 0px;
        gap: 8px;
        font-family: "Noto Sans KR", sans-serif;
      }

      .pagination a {
        text-decoration: none;
      }

      .pagination span {
        display: inline-block;
        min-width: 32px;
        height: 32px;
        line-height: 32px;
        border-radius: 6px;
        text-align: center;
        font-size: 0.95em;
        color: #444;
        cursor: pointer;
        transition: all 0.25s ease;
        background-color: #fff;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
      }

      .pagination span:hover {
        background-color: #1976d2;
        color: #fff;
      }

      /* 현재 선택된 페이지 */
      .pagination span.active {
        background-color: #1976d2;
        color: #fff;
        font-weight: bold;
        box-shadow: 0 3px 8px rgba(25, 118, 210, 0.3);
      }

      /* 화살표 스타일 */
      .pagination span:first-child,
      .pagination span:last-child {
        font-weight: bold;
        font-size: 1.1em;
        /* color: #1976d2; */
      }
      #map-container {
        width: 80%;
        height: 500px;
        margin: 0 auto 30px;
        border-radius: 12px;
        overflow: hidden;
      }
      .modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 999;
      }
      .panel {
        background: #fff;
        padding: 20px;
        border-radius: 12px;
        width: 80%;
        max-width: 900px;
        max-height: 90%;
        overflow-y: auto;
      }
      .modal-close-btn {
        background: none;
        border: none;
        font-size: 24px;
        font-weight: bold;
        cursor: pointer;
        color: #555;
        transition: 0.3s;
      }

      .modal-close-btn:hover {
        color: #1976d2;
      }
      .panel-btn {
        display: flex;
        justify-content: space-between;
      }
      .route-toolbar {
        display: flex;
        align-items: center;
        gap: 12px;
        margin-bottom: 15px;
        flex-wrap: wrap;
      }

      .route-toolbar .btn {
        background-color: #1976d2;
        color: #fff;
        border: none;
        border-radius: 8px;
        padding: 8px 16px;
        font-size: 0.95em;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      }

      .route-toolbar .btn:hover {
        background-color: #045abd;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        transform: translateY(-2px);
      }

      .route-toolbar .btn:active {
        transform: translateY(0);
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      }

      .route-toolbar .route-summary {
        font-size: 0.9em;
        color: #333;
        margin-left: 10px;
      }
    </style>
  </head>
  <body>
    <%@ include file="components/header.jsp" %>
    <div id="app">
      <div class="page-title">
        <div class="back-btn">
          <button class="back" @click="fnbck">
            <span class="material-symbols-outlined">arrow_back</span>
            뒤로가기
          </button>
        </div>
        <h2>📋 내 예약 목록</h2>
      </div>

      <div class="card-container">
        <div class="card" v-for="item in list">
          <div class="item-box">
            <div class="card-header">{{ item.packname }}</div>
            <div class="card-theme" v-for="tag in item.themNum.split(',')" :key="tag">
              {{ tag }}
            </div>
            <div class="card-content">
              <p><strong>예약번호:</strong> {{ item.resNum }}</p>
              <p><strong>설명:</strong> {{ item.descript }}</p>
              <p><strong>가격:</strong> {{ Number(item.price).toLocaleString() }}원</p>
              <p><strong>예약자 ID:</strong> {{ item.userId }}</p>
            </div>
          </div>
          <div class="card-btn">
            <button @click="fnadd(item.resNum)">후기작성하기</button>

            <button v-if="status == 'S'" @click="fninfo(item)">지도보기</button>
            <button v-if="item.contentId != null" @click="fnResAcc(item.res)">숙소예약확인하기</button>
            <div class="card-footer">
              <span>{{ item.rdatetime }}</span>
            </div>
          </div>
        </div>
      </div>

      <div v-if="modalFlg" class="modal-overlay" @click.self="closeModal">
        <div class="panel">
          <div class="panel-btn">
            <h2>🗺️ 여행 경로 지도</h2>
            <button class="modal-close-btn" @click="closeModal">✖</button>
          </div>
          <div class="route-toolbar">
            <button id="btnBuildRoute" @click="buildCarRoute" class="btn ghost">차량 경로 보기</button>
            <button v-if="routePolyline" @click="clearRoute" class="btn ghost">경로 지우기</button>
            <div v-if="routeSummary" class="route-summary">
              총 거리: {{ (routeSummary.distance / 1000).toFixed(1) }} km · 예상 소요:
              {{ Math.round(routeSummary.duration / 60) }} 분
              <span v-if="routeSummary.toll">· 톨비: {{ routeSummary.toll.toLocaleString() }}원</span>
            </div>
          </div>
          <div id="map-container">지도 로딩 중...</div>
        </div>
      </div>

      <!-- 페이지네이션 -->
      <div class="pagination">
        <!-- 이전 그룹 -->
        <a href="javascript:;" v-if="page > 1" @click="fnMove(-1)">
          <span v-if="page > 1">◀</span>
        </a>

        <!-- 페이지 번호 -->
        <a
          href="javascript:;"
          v-for="num in pageGroupEnd - pageGroupStart + 1"
          :key="num"
          @click="fnchange(pageGroupStart + num - 1)"
        >
          <span :class="{ active: page == (pageGroupStart + num - 1) }">{{ pageGroupStart + num - 1 }}</span>
        </a>

        <!-- 다음 그룹 -->
        <a href="javascript:;" v-if="page < totalPages" @click="fnMove(1)">
          <span>▶</span>
        </a>
      </div>
    </div>
    <%@ include file="components/footer.jsp" %>
  </body>
</html>

<script>
  const app = Vue.createApp({
    data() {
      return {
        // 변수 - (key : value)
        sessionId: "${sessionId}",
        status: window.sessionData.status,
        list: {},
        page: 1,
        pageSize: 5,
        pageGroupSize: 10,
        totalPages: 0,
        pageGroupStart: 1,
        pageGroupEnd: 10,
        modalFlg: false,

        routePolyline: null,
        routeSummary: null,
        markers: [],
        poiList: [],
        kakaoAppKey: "${kakaoAppKey}",

        info: [],
        positionsByDay: {},
        selectedItem: {},
        selectedDay: 1,
      };
    },
    methods: {
      // 함수(메소드) - (key : function())
      fnList: function () {
        let self = this;
        let param = {
          userId: self.sessionId,
          pageSize: self.pageSize,
          page: (self.page - 1) * self.pageSize,
        };
        $.ajax({
          url: "/reservation-list.dox",
          dataType: "json",
          type: "POST",
          data: param,
          success: function (data) {
            console.log(data);
            self.list = data.list;
            self.totalPages = Math.ceil(data.cnt / self.pageSize);
            let group = Math.floor((self.page - 1) / self.pageGroupSize);
            //console.log(self.page, self.pageGroupSize);

            self.pageGroupStart = group * self.pageGroupSize + 1;
            self.pageGroupEnd = Math.min(self.pageGroupStart + self.pageGroupSize - 1, self.totalPages);
          },
        });
      },
      fnadd(resNum) {
        pageChange("review-add.do", { resNum: resNum });
      },
      fnbck() {
        history.back();
      },
      fnchange(num) {
        let self = this;
        self.page = num;
        self.fnList();
      },
      fnMove(num) {
        let self = this;
        self.page += num;
        if (self.page < 1) self.page = 1;
        if (self.page > self.totalPages) self.page = self.totalPages;
        self.fnList();
      },
      fnResAcc(item) {
        let self = this;
        $.ajax({
          url: "/Acc-info.dox",
          type: "GET",
          data: { resNum: item.resNum },
          success: function (data) {},
        });
      },
      fninfo(item) {
        let self = this;
        $.ajax({
          url: "/share.dox",
          type: "GET",
          data: { resNum: item.resNum },
          success: function (data) {
            self.info = data;
            const days = Object.keys(data)
              .map((k) => parseInt(k))
              .sort((a, b) => a - b);
            for (let i = 0; i < days.length; i++) {
              const day = days[i];
              const dayList = data[day];
              self.positionsByDay[day] = [];
              for (let j = 0; j < dayList.length; j++) {
                const item = dayList[j];
                self.positionsByDay[day].push({
                  title: item.title,
                  lat: parseFloat(item.mapy),
                  lng: parseFloat(item.mapx),
                  addr1: item.addr1,
                  contentId: item.contentid,
                });
              }
            }
            self.selectedDay = days[0];
            const firstDayPois = self.positionsByDay[self.selectedDay];
            self.openModal(firstDayPois);
          },
        });
      },
      openModal(item) {
        this.modalFlg = true;
        //console.log(item);

        setTimeout(() => this.initializeMap(item), 300);
      },
      closeModal() {
        this.modalFlg = false;
        this.clearMarkers();
        this.clearRoute();
      },
      initializeMap(pois) {
        if (!window.kakao || !kakao.maps) {
          document.getElementById("map-container").innerText = "Kakao Map API 로드 실패.";
          return;
        }
        const container = document.getElementById("map-container");

        if (!pois || pois.length === 0) {
          container.innerText = "지도에 표시할 장소가 없습니다.";
          return;
        }

        const options = {
          center: new kakao.maps.LatLng(pois[0].lat, pois[0].lng),
          level: 7,
        };
        this.map = new kakao.maps.Map(container, options);

        const bounds = new kakao.maps.LatLngBounds();
        this.clearMarkers();

        pois.forEach((p) => {
          const pos = new kakao.maps.LatLng(p.lat, p.lng);
          const marker = new kakao.maps.Marker({ position: pos });
          marker.setMap(this.map);
          this.markers.push(marker);
          //console.log(p.title);

          const info = new kakao.maps.InfoWindow({
            content: '<div style="padding:25px;">' + (p.title || p.contentId) + "</div>",
          });
          kakao.maps.event.addListener(marker, "mouseover", () => info.open(this.map, marker));
          kakao.maps.event.addListener(marker, "mouseout", () => info.close());

          bounds.extend(pos);
        });

        this.map.setBounds(bounds);

        // Vue 렌더링 후 지도 리사이즈
        setTimeout(() => {
          kakao.maps.event.trigger(this.map, "resize");
          this.map.setBounds(bounds);
        }, 500);
      },
      clearMarkers() {
        if (!this.markers) return;
        this.markers.forEach((m) => m.setMap(null));
        this.markers = [];
      },
      groupPoisByDate(pois) {
        this.positionsByDay = {};
        pois.forEach((p) => {
          const day = p.day || 1;
          if (!this.positionsByDay[day]) this.positionsByDay[day] = [];
          this.positionsByDay[day].push(p);
        });
      },
      async buildCarRoute() {
        const pois = this.positionsByDay[this.selectedDay] || [];
        const valid = pois.filter((p) => p.lat && p.lng);
        if (valid.length < 2) {
          alert("경로를 그릴 최소 2개 지점이 필요합니다.");
          return;
        }
        try {
          const payload = {
            resNum: this.resNum,
            day: this.selectedDay,
            pois: valid.map((p) => ({
              contentId: p.contentId,
              name: p.title || "",
              x: Number(p.lng),
              y: Number(p.lat),
            })),
          };
          const resp = await $.ajax({
            url: "/api/route/build",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(payload),
          });
          if (resp.points) this.drawPolyline(resp.points);
          this.routeSummary = resp.summary || null;
        } catch (e) {
          console.error(e);
          alert("경로 계산에 실패했습니다.");
        }
      },
      drawPolyline(points) {
        if (!this.map) return;
        if (this.routePolyline) {
          this.routePolyline.setMap(null);
          this.routePolyline = null;
        }
        if (!points || points.length === 0) return;
        const path = points.map((pt) => new kakao.maps.LatLng(pt.y, pt.x));
        this.routePolyline = new kakao.maps.Polyline({ path, strokeWeight: 5, strokeOpacity: 0.9 });
        this.routePolyline.setMap(this.map);
        const bounds = new kakao.maps.LatLngBounds();
        path.forEach((latlng) => bounds.extend(latlng));
        this.map.setBounds(bounds);
      },
      clearRoute() {
        if (this.routePolyline) {
          this.routePolyline.setMap(null);
          this.routePolyline = null;
        }
        this.routeSummary = null;
      },
    },
    mounted() {
      // 처음 시작할 때 실행되는 부분
      let self = this;
      if (self.sessionId == "") {
        alert("로그인 후 이용해 주세요");
        location.href = "/member/login.do";
        return;
      }
      self.fnList();

      window.addEventListener("popstate", () => {
        self.fnList();
      });
      window.addEventListener("pageshow", (event) => {
        if (event.persisted) {
          self.fnList();
        }
      });
    },
  });

  app.mount("#app");
</script>
